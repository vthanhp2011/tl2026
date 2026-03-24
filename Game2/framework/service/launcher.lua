local skynet = require "skynet"
local service = require "skynet.service"
require "skynet.manager"	-- import skynet.launch, ...

skynet.start(function()
	skynet.register(".launcher")
	skynet.dispatch("lua", function(session, source, command, ...)
		if command == "LAUNCH" then
			local ok, addr = pcall(service.new, ...)
			if ok then
				skynet.ret(skynet.pack(addr))
			else
				skynet.ret()
				skynet.error("LAUNCH failed:", ...)
			end
		elseif command == "KILL" then
			skynet.kill(...)
		end
	end)
end)