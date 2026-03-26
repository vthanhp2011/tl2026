local skynet = require "skynet"
local harbor = require "skynet.harbor"
local service = require "skynet.service"
require "skynet.manager"	-- import skynet.launch, ...
--skynet.error("=== LUASERVICE PATH: " .. (skynet.getenv("luaservice") or "NIL") .. " ===")


skynet.start(function()

	local standalone = skynet.getenv "standalone"
    local harbor_id = tonumber(skynet.getenv "harbor" or 0)

    -- Launcher + register (theo yêu cầu)
    local launcher = assert(skynet.launch("snlua","launcher"))
    skynet.name(".launcher", launcher)

    if harbor_id == 0 then
        print("=== harbor_id = 0 ===")
        skynet.setenv("standalone", "true")

        -- cdummy + harbor
        skynet.fork(function()
            local ok, s = pcall(skynet.newservice, "cdummy")
            if not ok then
                skynet.error("=== CDUMMY FAILED: " .. tostring(s))
                skynet.abort()
            end
            skynet.name(".cslave", s)
            skynet.error("=== CDUMMY LAUNCHED SUCCESSFULLY ===")
        end)

        skynet.sleep(300)

        -- service_mgr
        skynet.error("=== BẮT ĐẦU LAUNCH SERVICE_MGR (direct) ===")
        local mgr = assert(skynet.launch("snlua", "service_mgr"))
        skynet.error("=== SERVICE_MGR LAUNCHED SUCCESSFULLY ===")
	else
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
	-- 2. Khởi tạo .service (bắt buộc cho service.new)
	local service_addr = skynet.newservice("service")
	if not service_addr then
		skynet.error("=== FAILED TO LAUNCH .service (service provider) ===")
		skynet.abort()
	end
	skynet.sleep(200)   -- chờ .service register xong

	-- ================== SSL/Cipher Holder ==================
	local enablessl = skynet.getenv "enablessl"
	if enablessl and enablessl ~= "false" and enablessl ~= "0" then
		skynet.error("=== ENABLE SSL MODE - CHECKING LTLS ===")
		local ok, ltls = pcall(require, "ltls.init.c")
		if ok and ltls and ltls.constructor then
			skynet.error("=== LTLS AVAILABLE - STARTING LTLS HOLDER ===")
			local succ, addr = pcall(service.new, "ltls_holder", function()
				ltls.constructor()
				skynet.register(".ltls_holder")
				skynet.error("=== LTLS HOLDER REGISTERED ===")
			end)
			if not succ then
				skynet.error("=== LTLS_HOLDER LAUNCH FAILED:", tostring(addr))
			end
		else
			skynet.error("=== LTLS NOT AVAILABLE - SKIPPING SSL ===")
		end
	end

	local enablecipher = skynet.getenv "enablecipher"
	if enablecipher and enablecipher ~= "false" and enablecipher ~= "0" then
		skynet.error("=== ENABLE CIPHER MODE - CHECKING LCIPHER ===")
		local ok, lcipher = pcall(require, "lcipher.init.c")
		if ok and lcipher and lcipher.constructor then
			skynet.error("=== LCIPHER AVAILABLE - STARTING LCIPHER HOLDER ===")
			local succ, addr = pcall(service.new, "lcipher_holder", function()
				lcipher.constructor()
				skynet.register(".lcipher_holder")
				skynet.error("=== LCIPHER HOLDER REGISTERED ===")
			end)
			if not succ then
				skynet.error("=== LCIPHER_HOLDER LAUNCH FAILED:", tostring(addr))
			end
		else
			skynet.error("=== LCIPHER NOT AVAILABLE - SKIPPING CIPHER ===")
		end
	end


	pcall(skynet.newservice,skynet.getenv "start" or "main")

    -- Launch main bằng direct launch + delay
    --local start_name = skynet.getenv("start") or "main"
    --skynet.error("=== LAUNCHING " .. start_name .. " bằng direct launch ===")
    --local main_srv = assert(skynet.launch("snlua", start_name))

	skynet.error("=== MAIN.LUA ĐÃ ĐƯỢC LAUNCH THÀNH CÔNG ===")

	skynet.sleep(0)     -- sleep vô hạn = giữ process sống
    --skynet.exit()
end)



--[[
skynet.start(function()
	local standalone = skynet.getenv "standalone"

	local launcher = assert(skynet.launch("snlua","launcher"))
	skynet.name(".launcher", launcher)

	local harbor_id = tonumber(skynet.getenv "harbor" or 0)
	if harbor_id == 0 then
		assert(standalone ==  nil)
		standalone = true
		skynet.setenv("standalone", "true")

		local ok, slave = pcall(skynet.newservice, "cdummy")
		if not ok then
			skynet.abort()
		end
		skynet.name(".cslave", slave)

	else
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
]]