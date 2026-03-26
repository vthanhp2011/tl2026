local skynet = require "skynet"
require "skynet.manager"

local db = {}

skynet.start(function()
    skynet.error("=== CFGDB STARTED SUCCESSFULLY ===")
    skynet.name(".CfgDB", skynet.self())

    skynet.dispatch("lua", function(session, source, cmd, key, value)
        if cmd == "set" or cmd == nil then
            if key then
                db[key] = value
                skynet.retpack(true)
            end
        elseif cmd == "get" then
            skynet.retpack(db[key])
        else
            skynet.retpack(nil)
        end
    end)
end)

--[[
local skynet = require "skynet"
local class = require "class"
local CfgHelper = require "cfghelper":getinstance()
local CMD = setmetatable({}, {
    __index = function(_, k)
        local method = CfgHelper[k]
        assert(method, k)
        return function(...) return method(CfgHelper, ...) end
    end
})

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        print(...)
        local f = assert(CMD[command], command)
        skynet.ret(skynet.pack(f(...)))
    end)
end)
]]
