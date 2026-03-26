local skynet = require "skynet"
local service = require "skynet.service"

skynet.start(function()
    skynet.name(".service", skynet.self())
    skynet.error("=== .service REGISTERED SUCCESSFULLY ===")

    skynet.dispatch("lua", function(session, source, command, ...)
        if command == "LAUNCH" then
            local ok, addr = pcall(service.new, ...)
            if ok then
                skynet.ret(skynet.pack(addr))
            else
                skynet.ret()
                skynet.error("service LAUNCH failed:", ...)
            end
        elseif command == "KILL" then
            skynet.kill(...)
        else
            -- Handle uniqueservice call (command is nil)
            skynet.ret(skynet.pack(skynet.self()))
        end
    end)
end)
