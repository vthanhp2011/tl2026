local skynet = require "skynet"
local harbor = require "skynet.harbor"
local service = require "skynet.service"
require "skynet.manager"	-- import skynet.launch, ...

skynet.start(function()
	local standalone = skynet.getenv "standalone"

	local launcher = assert(skynet.launch("snlua","launcher"))
	skynet.name(".launcher", launcher)

	local harbor_id = tonumber(skynet.getenv "harbor" or 0)
	if harbor_id == 0 then
		assert(standalone ==  nil)
		standalone = true
		skynet.setenv("standalone", "true")
		print("=== harbor_id = 0 ===")

		local ok, slave = pcall(skynet.newservice, "cdummy")
		print("=== CDUMMY OK, tiếp tục launch datacenterd ===")
		
		if not ok then
			skynet.abort()
		end
		skynet.name(".cslave", slave)

    else  -- harbor ~= 0
        skynet.error("=== LAUNCH CMASTER OK ===")
        local master_srv = skynet.newservice("cmaster")

        -- === THÊM ĐOẠN NÀY ===
        skynet.error("=== BẮT ĐẦU LAUNCH CSLAVE ===")
        local slave = skynet.newservice("cslave", skynet.getenv("master"))
        skynet.error("=== CSLAVE LAUNCHED SUCCESSFULLY ===")
        -- ======================

        skynet.error("=== LAUNCH HARBOR SERVICE ===")
        -- harbor C service sẽ được launch tự động qua cslave hoặc bạn có thể thêm thủ công nếu cần
		
		if standalone then
			if not pcall(skynet.newservice,"cmaster") then

				skynet.abort()
			end
		end

		local ok, slave = pcall(skynet.newservice, "cslave")
		if not ok then
			skynet.abort()
		end
		skynet.name(".cslave", slave)
	end

	if standalone then
		local datacenter = skynet.newservice "datacenterd"
		skynet.name("DATACENTER", datacenter)
	end
	skynet.newservice "service_mgr"

	local enablessl = skynet.getenv "enablessl"
	if enablessl then
		service.new("ltls_holder", function ()
			local c = require "ltls.init.c"
			c.constructor()
		end)
	end

	local enablecipher = skynet.getenv "enablecipher"
	if enablecipher then
		service.new("lcipher_holder", function ()
			local c = require "lcipher.init.c"
			c.constructor()
		end)
	end

	pcall(skynet.newservice,skynet.getenv "start" or "main")
	skynet.exit()
end)
