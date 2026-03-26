local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("=== CLUSTER_DB_MGR STARTED (placeholder) ===")
    skynet.name(".cluster_db_mgr", skynet.self())
    skynet.dispatch("lua", function(_, _, cmd, ...)
        skynet.error("cluster_db_mgr received:", cmd)
        skynet.retpack(true)
    end)
end)
