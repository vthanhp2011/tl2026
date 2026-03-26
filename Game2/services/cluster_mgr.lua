local skynet = require "skynet"
require "skynet.manager"

local nodes = {}   -- lưu thông tin các node trong cluster

skynet.start(function()
    skynet.error("=== CLUSTER_MGR STARTED SUCCESSFULLY ===")
    skynet.name(".cluster_mgr", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, nodeid, addr, ...)
        if cmd == "register" then
            nodes[nodeid] = addr
            skynet.error("Cluster node registered:", nodeid, addr)
            skynet.retpack(true)
        elseif cmd == "getnode" then
            skynet.retpack(nodes[nodeid])
        elseif cmd == "getall" then
            skynet.retpack(nodes)
        else
            skynet.retpack(nil)
        end
    end)
end)
