local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("=== DATACENTERD STARTED SUCCESSFULLY (single node) ===")
    skynet.name(".datacenterd", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        skynet.error("datacenterd received:", cmd)
        skynet.retpack(true)   -- trả về true để bootstrap không crash
    end)
end)
