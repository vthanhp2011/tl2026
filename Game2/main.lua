local skynet = require "skynet"
require "skynet.manager"

skynet.error("=== MAIN.LUA STARTED - svrtype = " .. tostring(skynet.getenv("svrtype")))

local function init_manager_server(processid)
	skynet.error("=== init_manager_server bắt đầu ===")
	
	skynet.name(".cluster_db_mgr", skynet.newservice("cluster_db_mgr"))
	skynet.name(".cluster_mgr", skynet.newservice("cluster_mgr", processid))
	skynet.name(".CfgDB", skynet.newservice("cfgdb"))
	skynet.send(".CfgDB", "lua", "init")
	
	skynet.error("=== init_manager_server ĐÃ XONG ===")

end

local function init_common_server(processid)
	skynet.name(".cluster_agent", skynet.newservice("cluster_agent", processid))
	skynet.send(".cluster_agent", "lua", "init")
end

skynet.start(function()

	skynet.error("=== MAIN.LUA skynet.start() BẮT ĐẦU ===")
-- Thêm try-catch quanh toàn bộ code gốc của main.lua
    local ok, err = pcall(function()
        print("=== MAIN.LUA: Đang launch các service cluster... ===")
	local process_id = tonumber(skynet.getenv "process_id")
	local svrtype = skynet.getenv("svrtype")

	if svrtype == "Game" then
		init_manager_server(process_id)
	else
		init_common_server(process_id)
	end
	
	skynet.error("=== MAIN.LUA: TẤT CẢ SERVICE ĐÃ LAUNCH XONG ===")
    end)

    if not ok then
        skynet.error("=== MAIN.LUA CRASH: " .. tostring(err))
        skynet.error(debug.traceback())
    end

    skynet.error("=== MAIN.LUA HOÀN TẤT skynet.start() ===")
	skynet.sleep(0)     -- sleep vô hạn = giữ process sống
end)

--[[
skynet.start(function()
	local service = skynet.newservice("test_service")
	skynet.call(service, "lua", "init")
end)
]]
