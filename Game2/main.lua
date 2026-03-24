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
	print("=== MAIN.LUA ĐANG ĐƯỢC LOAD /home/tlbb_spug/Game2===")

    skynet.error("=== TLBB SERVER STARTED SUCCESSFULLY ===")
    skynet.error("Node: " .. (skynet.getenv("svrtype") or "Unknown") .. 
                 " | Process: " .. (skynet.getenv("process_id") or "?"))

    -- Cluster (giữ nguyên)
    local process_id = tonumber(skynet.getenv "process_id")
    local svrtype = skynet.getenv("svrtype")
    if svrtype == "Game" then
        skynet.name(".cluster_db_mgr", skynet.newservice("cluster_db_mgr"))
        skynet.name(".cluster_mgr", skynet.newservice("cluster_mgr", process_id))
        skynet.name(".CfgDB", skynet.newservice("cfgdb"))
        skynet.send(".CfgDB", "lua", "init")
    else
        skynet.name(".cluster_agent", skynet.newservice("cluster_agent", process_id))
        skynet.send(".cluster_agent", "lua", "init")
    end

    -- TODO: Thêm các service game ở đây (bạn sẽ bổ sung dần)
    -- skynet.newservice("gate")
    -- skynet.newservice("login")
    -- skynet.newservice("scene")
    -- ...

    skynet.error("=== ALL BASIC SERVICES LAUNCHED ===")
    -- skynet.exit()   -- comment tạm để giữ process alive
end)

--[[
skynet.start(function()
	local service = skynet.newservice("test_service")
	skynet.call(service, "lua", "init")
end)
]]
