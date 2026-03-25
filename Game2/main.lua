local skynet = require "skynet"
require "skynet.manager"

skynet.error("=== MAIN.LUA STARTED - svrtype = " .. tostring(skynet.getenv("svrtype")))

local function init_manager_server(processid)
    skynet.error("=== init_manager_server BẮT ĐẦU (process_id = " .. tostring(processid) .. ") ===")

    -- 1. cluster_db_mgr
    local ok, s = pcall(skynet.newservice, "cluster_db_mgr")
    if ok then
        skynet.name(".cluster_db_mgr", s)
        skynet.error("✅ cluster_db_mgr LAUNCHED OK")
    else
        skynet.error("⚠️  cluster_db_mgr KHÔNG TỒN TẠI → BỎ QUA (" .. tostring(s) .. ")")
    end

    -- 2. cluster_mgr
    local ok, s = pcall(skynet.newservice, "cluster_mgr", processid)
    if ok then
        skynet.name(".cluster_mgr", s)
        skynet.error("✅ cluster_mgr LAUNCHED OK")
    else
        skynet.error("⚠️  cluster_mgr KHÔNG TỒN TẠI → BỎ QUA (" .. tostring(s) .. ")")
    end

    -- 3. cfgdb
    local ok, s = pcall(skynet.newservice, "cfgdb")
    if ok then
        skynet.name(".CfgDB", s)
        skynet.send(".CfgDB", "lua", "init")
        skynet.error("✅ cfgdb LAUNCHED + INIT OK")
    else
        skynet.error("⚠️  cfgdb KHÔNG TỒN TẠI → BỎ QUA (" .. tostring(s) .. ")")
    end

    skynet.error("=== init_manager_server HOÀN TẤT (các service thiếu đã bỏ qua) ===")
end

local function init_common_server(processid)
    skynet.error("=== init_common_server BẮT ĐẦU (process_id = " .. tostring(processid) .. ") ===")

    local ok, s = pcall(skynet.newservice, "clusteragent", processid)  -- tên file thực trong repo là clusteragent.lua
    if ok then
        skynet.name(".cluster_agent", s)
        skynet.send(".cluster_agent", "lua", "init")
        skynet.error("✅ cluster_agent LAUNCHED + INIT OK")
    else
        skynet.error("⚠️  cluster_agent KHÔNG TỒN TẠI → BỎ QUA (" .. tostring(s) .. ")")
    end

    skynet.error("=== init_common_server HOÀN TẤT ===")
end

skynet.start(function()

skynet.error("=== MAIN.LUA skynet.start() BẮT ĐẦU ===")

	local process_id = tonumber(skynet.getenv "process_id")
	local svrtype = skynet.getenv("svrtype")
	

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
