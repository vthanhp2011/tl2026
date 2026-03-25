local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    local processid = ... or 0
    skynet.error(string.format("=== cluster_mgr STARTED (process_id = %d) ===", processid))
    skynet.name(".cluster_mgr", skynet.self())

    local nodes = {}

    skynet.dispatch("lua", function(_, _, cmd, ...)
        if cmd == "register" or cmd == "node" then
            local node = ...
            nodes[node] = true
            skynet.error("cluster_mgr registered node: " .. tostring(node))
            skynet.ret(skynet.pack(true))
        elseif cmd == "get_nodes" then
            skynet.ret(skynet.pack(nodes))
        else
            skynet.ret()
        end
    end)

    skynet.error("=== cluster_mgr READY (full) ===")
    skynet.sleep(0)
end)
