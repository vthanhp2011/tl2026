local skynet = require "skynet"
require "skynet.manager"

local function init_manager_server(processid)
	skynet.name(".cluster_db_mgr", skynet.newservice("cluster_db_mgr"))
	skynet.name(".cluster_mgr", skynet.newservice("cluster_mgr", processid))
	skynet.name(".CfgDB", skynet.newservice("cfgdb"))
	skynet.send(".CfgDB", "lua", "init")
end

local function init_common_server(processid)
	skynet.name(".cluster_agent", skynet.newservice("cluster_agent", processid))
	skynet.send(".cluster_agent", "lua", "init")
end

skynet.start(function()
	local process_id = tonumber(skynet.getenv "process_id")
	local svrtype = skynet.getenv("svrtype")
	
print("=== MAIN.LUA ĐANG ĐƯỢC LOAD /home/tlbb_spug/Game2 ===")
skynet.error("=== MAIN.LUA STARTED - svrtype = " .. tostring(skynet.getenv("svrtype")))

	if svrtype == "Game" then
		init_manager_server(process_id)
	else
		init_common_server(process_id)
	end
	skynet.exit()
end)

--[[
skynet.start(function()
	local service = skynet.newservice("test_service")
	skynet.call(service, "lua", "init")
end)
]]
