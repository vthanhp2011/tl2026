local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("=== CLUSTER_MGR STARTED SUCCESSFULLY ===")
    skynet.name(".cluster_mgr", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        skynet.error("cluster_mgr received:", cmd)
        skynet.retpack(true)
    end)
end)