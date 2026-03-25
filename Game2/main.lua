local skynet = require "skynet"
require "skynet.manager"

skynet.error("=== MAIN.LUA STARTED - svrtype = " .. tostring(skynet.getenv("svrtype")))

local function init_manager_server(processid)
    skynet.error("=== init_manager_server BẮT ĐẦU (process_id = " .. processid .. ") ===")

    local services = {
        {name = "cluster_db_mgr", register = ".cluster_db_mgr"},
        {name = "cluster_mgr",    register = ".cluster_mgr", arg = processid},
        {name = "cfgdb",          register = ".CfgDB"}
    }

    for _, svc in ipairs(services) do
        local ok, s = pcall(skynet.newservice, svc.name, svc.arg or "")
        if ok and s then
            if svc.register then skynet.name(svc.register, s) end
            skynet.error("✅ " .. svc.name .. " LAUNCHED SUCCESSFULLY")
        else
            skynet.error("❌ " .. svc.name .. " FAILED: " .. tostring(s))
        end
    end

    skynet.error("=== init_manager_server HOÀN TẤT ===")
end

local function init_common_server(processid)
    skynet.error("=== init_common_server BẮT ĐẦU ===")
    skynet.error("=== init_common_server HOÀN TẤT (chưa cần cluster_agent) ===")
end

skynet.start(function()
    skynet.error("=== MAIN.LUA skynet.start() BẮT ĐẦU ===")

    local process_id = tonumber(skynet.getenv("process_id")) or 1
    local svrtype = skynet.getenv("svrtype") or "Game"

    if svrtype == "Game" then
        init_manager_server(process_id)
    else
        init_common_server(process_id)
    end

    skynet.error("=== MAIN.LUA: TẤT CẢ SERVICE ĐÃ XỬ LÝ XONG ===")
    skynet.error("=== SERVER GAME ĐÃ KHỞI ĐỘNG THÀNH CÔNG - CHẠY VÔ HẠN ===")

    skynet.sleep(0)   -- giữ server sống mãi
end)

--[[
skynet.start(function()
	local service = skynet.newservice("test_service")
	skynet.call(service, "lua", "init")
end)
]]
