local skynet = require "skynet"
local harbor = require "skynet.harbor"
local service = require "skynet.service"
require "skynet.manager"	-- import skynet.launch, ...

skynet.start(function()
	local standalone = skynet.getenv "standalone"

	local launcher = assert(skynet.launch("snlua","launcher"))
	skynet.name(".launcher", launcher)
	
skynet.error("=== BOOTSTRAP START - harbor = " .. tostring(skynet.getenv("harbor")) ..
             ", standalone = " .. tostring(skynet.getenv("standalone")) .. " ===")
	local harbor_id = tonumber(skynet.getenv "harbor" or 0)
    if harbor_id == 0 then
        assert(standalone == nil)
        standalone = nil
        skynet.setenv("standalone", "true")
        print("=== harbor_id = 0 ===")

        skynet.error("=== BẮT ĐẦU LAUNCH CDUMMY (fork để tránh hang) ===")
        
        -- Dùng fork + sleep để bỏ blocking pcall
        local slave
        skynet.fork(function()
            local ok, s = pcall(skynet.newservice, "cdummy")
            if not ok then
                skynet.error("=== CDUMMY FAILED: " .. tostring(s))
                skynet.abort()
            end
            slave = s
            skynet.name(".cslave", slave)
            skynet.error("=== CDUMMY LAUNCHED SUCCESSFULLY IN FORK ===")
        end)

        skynet.sleep(200)   -- chờ 2 giây cho cdummy + harbor khởi tạo xong

        skynet.error("=== CDUMMY OK, tiếp tục launch datacenterd ===")

        -- Launch service_mgr TRƯỚC TIÊN (rất quan trọng)
        skynet.error("=== LAUNCH SERVICE_MGR ===")
        local mgr = skynet.newservice "service_mgr"
        skynet.name(".service", mgr)        -- register tên .service ngay lập tức
        skynet.error("=== SERVICE_MGR LAUNCHED OK ===")

        -- Sau đó mới launch datacenterd (nếu có)
        if standalone then
            skynet.error("=== LAUNCH DATACENTERD ===")
            local dc = skynet.newservice "datacenterd"
            skynet.name(".datacenterd", dc)
        end

        -- Các service khác nếu có
    else  -- harbor ~= 0
        skynet.error("=== LAUNCH CMASTER OK ===")
        
        -- Fork để cmaster không block bootstrap
        skynet.fork(function()
            local master = skynet.newservice("cmaster")
            skynet.error("=== CMASTER SERVICE STARTED IN FORK ===")
        end)
        
        skynet.sleep(100)  -- chờ cmaster listen (khoảng 1 giây)
        
        skynet.error("=== BẮT ĐẦU LAUNCH CSLAVE ===")
        local slave_ok, slave = pcall(skynet.newservice, "cslave", skynet.getenv("master"))
        if slave_ok then
            skynet.error("=== CSLAVE LAUNCHED SUCCESSFULLY ===")
        else
            skynet.error("=== CSLAVE FAILED: " .. tostring(slave) .. " ===")
        end
		
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
