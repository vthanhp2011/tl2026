local skynet = require "skynet"
require "skynet.manager"

local nodes = {}

skynet.start(function()
    skynet.error("=== CLUSTER_MGR STARTED SUCCESSFULLY ===")
    skynet.name(".cluster_mgr", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        local f = {
            register = function(nodeid, addr)
                nodes[nodeid] = addr
                skynet.error("Cluster node registered:", nodeid, addr)
                skynet.retpack(true)
            end,
            getnode = function(nodeid)
                skynet.retpack(nodes[nodeid])
            end,
        }
        local func = f[cmd]
        if func then
            skynet.retpack(func(...))
        else
            skynet.retpack(nil)
        end
    end)
end)