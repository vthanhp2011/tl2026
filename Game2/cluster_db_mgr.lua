local skynet = require "skynet"
require "skynet.manager"

local database = {}
local wait_queue = {}
local mode = {}

local function query(db, key, ...)
    if key == nil then return db else return query(db[key], ...) end
end

local function update(db, key, value, ...)
    if select("#", ...) == 0 then
        local ret = db[key]
        db[key] = value
        return ret, value
    else
        if db[key] == nil then db[key] = {} end
        return update(db[key], value, ...)
    end
end

local function wakeup(db, key1, ...)
    if key1 == nil then return end
    local q = db[key1]
    if q == nil then return end
    if q[mode] == "queue" then
        db[key1] = nil
        for _, response in ipairs(q) do response(true) end
    else
        return wakeup(q, ...)
    end
end

skynet.start(function()
    skynet.error("=== cluster_db_mgr STARTED (full functional) ===")
    skynet.name(".cluster_db_mgr", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        if cmd == "QUERY" then
            local d = database[...]
            skynet.ret(skynet.pack(query(d or {}, ...)))
        elseif cmd == "UPDATE" then
            local ret, value = update(database, ...)
            if ret or value == nil then
                skynet.ret(skynet.pack(ret))
            else
                local q = wakeup(wait_queue, ...)
                if q then
                    for _, response in ipairs(q) do response(true, value) end
                end
                skynet.ret(skynet.pack(true))
            end
        else
            skynet.ret()
        end
    end)

    skynet.error("=== cluster_db_mgr READY (full) ===")
    skynet.sleep(0)
end)
