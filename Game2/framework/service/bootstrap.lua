local skynet = require "skynet"
local harbor = require "skynet.harbor"
local service = require "skynet.service"
require "skynet.manager"	-- import skynet.launch, ...

skynet.start(function()
    skynet.error("=== BOOTSTRAP START - harbor = " .. tostring(skynet.getenv("harbor")) .. 
                 ", standalone = " .. tostring(skynet.getenv("standalone")) .. " ===")

    local harbor_id = tonumber(skynet.getenv "harbor" or 0)
    local standalone = skynet.getenv "standalone"
	local launcher = assert(skynet.launch("snlua","launcher"))
	skynet.name(".launcher", launcher)

    if harbor_id == 0 then
        print("=== harbor_id = 0 ===")
        skynet.setenv("standalone", "true")

        -- Launch cdummy + harbor bằng fork
        skynet.fork(function()
            local ok, s = pcall(skynet.newservice, "cdummy")
            if not ok then
                skynet.error("CDUMMY FAILED: " .. tostring(s))
                skynet.abort()
            end
            skynet.name(".cslave", s)
        end)

        skynet.sleep(300)

        -- Launch service_mgr bằng direct launch
        skynet.error("=== BẮT ĐẦU LAUNCH SERVICE_MGR (direct) ===")
        local mgr = assert(skynet.launch("snlua", "service_mgr"))
        -- KHÔNG gọi skynet.name(".service", mgr) nữa, để service_mgr tự register
        skynet.error("=== SERVICE_MGR LAUNCHED SUCCESSFULLY ===")

        -- datacenterd
        skynet.error("=== LAUNCH DATACENTERD ===")
        local dc = skynet.newservice "datacenterd"
        skynet.name(".datacenterd", dc)

    else
        skynet.error("=== HARBOR != 0 not fully supported yet ===")
    end

    skynet.error("=== TOÀN BỘ BOOTSTRAP OK, BẮT ĐẦU MAIN.LUA ===")

    -- Launch main.lua BẰNG DIRECT LAUNCH (bypass uniqueservice)
    local start_name = skynet.getenv("start") or "main"
    skynet.error("=== LAUNCHING " .. start_name .. " bằng direct launch ===")
    local main_srv = assert(skynet.launch("snlua", start_name))
    skynet.error("=== MAIN.LUA ĐÃ ĐƯỢC LAUNCH THÀNH CÔNG ===")

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