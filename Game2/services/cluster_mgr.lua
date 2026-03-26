local skynet = require "skynet"
require "skynet.manager"

local CMD = {}

function CMD.start(processid)
    skynet.error("=== CLUSTER_MGR STARTED with processid =", processid, "===")
    skynet.name(".cluster_mgr", skynet.self())
end

skynet.start(function()
    skynet.dispatch("lua", function(session, source, cmd, ...)
        local f = CMD[cmd]
        if f then
            skynet.retpack(f(...))
        else
            skynet.ret()
        end
    end)
end)
