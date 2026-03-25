local skynet = require "skynet"
require "skynet.manager"

local config_data = {}

skynet.start(function()
    skynet.error("=== cfgdb STARTED ===")
    skynet.name(".CfgDB", skynet.self())

    -- Load config từ scene_config_env (nếu có)
    local env = skynet.getenv("scene_config_env") or "./confs/debug"
    local ok, conf = pcall(require, "cluster_db_conf")  -- load file confs/debug/cluster_db_conf.lua
    if ok then
        config_data = conf or {}
        skynet.error("✅ cfgdb loaded cluster_db_conf.lua")
    end

    skynet.dispatch("lua", function(_, _, cmd, ...)
        if cmd == "init" then
            skynet.error("✅ cfgdb init OK")
            skynet.ret(skynet.pack(true))
        elseif cmd == "QUERY" then
            local key = ...
            skynet.ret(skynet.pack(config_data[key] or {}))
        elseif cmd == "UPDATE" then
            local key, value = ...
            config_data[key] = value
            skynet.ret(skynet.pack(true))
        else
            skynet.ret()
        end
    end)

    skynet.error("=== cfgdb READY (full - loaded config) ===")
    skynet.sleep(0)
end)