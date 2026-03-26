local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("=== CLUSTER_AGENT STARTED SUCCESSFULLY ===")
    skynet.name(".cluster_agent", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        if cmd == "init" then
            skynet.error("cluster_agent initialized")
            skynet.retpack(true)
        else
            skynet.retpack(nil)
        end
    end)
end)