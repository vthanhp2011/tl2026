local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("=== SERVICE_MGR STARTED SUCCESSFULLY ===")
    skynet.name(".service_mgr", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        skynet.error("service_mgr received command:", cmd)
        -- Quản lý service, có thể mở rộng sau
        skynet.retpack(true)
    end)
end)