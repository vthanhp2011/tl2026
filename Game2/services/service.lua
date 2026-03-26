local skynet = require "skynet"
require "skynet.manager"

skynet.start(function()
    skynet.error("=== SERVICE PROVIDER STARTED SUCCESSFULLY ===")
    skynet.name(".service", skynet.self())

    skynet.dispatch("lua", function(_, _, cmd, ...)
        skynet.error("service provider received:", cmd)
        skynet.retpack(true)
    end)
end)
