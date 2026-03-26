local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("=== CLUSTER_DB_MGR STARTED SUCCESSFULLY ===")
    skynet.name(".cluster_db_mgr", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        skynet.error("cluster_db_mgr received command:", cmd)
        skynet.retpack(true)   -- trả về thành công để main.lua không crash
    end)
end)