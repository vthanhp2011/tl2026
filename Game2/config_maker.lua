local env          = arg[1] or "debug"
local script_root  = arg[2] or "./Script"
local processid    = tonumber(arg[3]) or 2
local svrtype      = arg[4] or "Game"
local scene_config = arg[5] or "./Scene"
local loglevel 	   = "1"

local config = string.format([[
    env = "%s"
    script_root = "%s"
    include "config.lua"
    thread = 64
    harbor = 0
    standalone  = nil          -- hoặc để trống, không set = true
    master      = nil
    address     = nil
    start = "main" -- main script
    bootstrap = "snlua bootstrap"	-- The service for bootstrap
    enablessl = true --Enable SSL
    enablecipher = true --Enable Cipher
    loglevel = %s
    process_id = %d
    scene_config_env = "%s"
    sensitive_words_path = "./sensitive_words.txt"
    --Kích hoạt hai tùy chọn sau để gỡ lỗi cục bộ và vô hiệu hóa các tham số gỡ lỗi của VS Code bằng cách thêm dấu chú thích.
    daemon = nil		--"./skynet_%d.pid"
    logger = nil		--"%s%d"
    logpath = nil		--"../log"
    svrtype = "%s"
    __nowaiting = true

    --Trong VS Code, hãy bật hai trình gỡ lỗi sau và vô hiệu hóa dòng lệnh "daemon" và "logger".
    --vscdbg_open = "$vscdbg_open"
    --vscdbg_workdir = "$vscdbg_workdir"
]], env, script_root, loglevel, processid,scene_config, processid, svrtype, processid, svrtype)
print(config)
