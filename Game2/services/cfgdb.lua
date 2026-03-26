local skynet = require "skynet"
require "skynet.manager"

local database = {}

skynet.start(function()
    skynet.error("=== CFGDB STARTED SUCCESSFULLY ===")
    skynet.name(".CfgDB", skynet.self())

    skynet.dispatch("lua", function(_, _, op, key, value)
        if op == "set" or op == nil then
            if key then
                database[key] = value
                skynet.retpack(true)
            end
        elseif op == "get" then
            skynet.retpack(database[key])
        else
            skynet.retpack(nil)
        end
    end)
end)