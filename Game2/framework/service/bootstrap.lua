local skynet = require "skynet"
local harbor = require "skynet.harbor"
local service = require "skynet.service"
require "skynet.manager"	-- import skynet.launch, ...

skynet.start(function()
    skynet.error("=== BOOTSTRAP START - harbor = " .. tostring(skynet.getenv("harbor")) .. ", standalone = " .. tostring(skynet.getenv("standalone")) .. " ===")

    local harbor_id = tonumber(skynet.getenv "harbor" or 0)

    -- Launcher + register (theo yêu cầu của bạn)
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

        -- datacenterd với try-catch
        skynet.error("=== LAUNCH DATACENTERD ===")
        local ok, dc = pcall(skynet.newservice, "datacenterd")
        if ok then
            skynet.name(".datacenterd", dc)
            skynet.error("=== DATACENTERD LAUNCHED SUCCESSFULLY ===")
        else
            skynet.error("=== DATACENTERD FAILED (bỏ qua): " .. tostring(dc))
            -- Không abort, tiếp tục vì harbor=0 có thể không cần datacenterd
        end

        skynet.error("=== TOÀN BỘ BOOTSTRAP OK, BẮT ĐẦU MAIN.LUA ===")

    else
        skynet.error("=== HARBOR != 0 not supported yet ===")
    end

    -- Launch main bằng direct + delay để main chạy trước khi bootstrap exit
    local start_name = skynet.getenv("start") or "main"
    skynet.error("=== LAUNCHING " .. start_name .. " bằng direct launch ===")
    local main_srv = assert(skynet.launch("snlua", start_name))
    skynet.error("=== MAIN.LUA ĐÃ ĐƯỢC LAUNCH THÀNH CÔNG ===")

    skynet.sleep(100)   -- chờ main khởi tạo một chút
    skynet.exit()
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