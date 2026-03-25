local env          = arg[1] or "debug"
local script_root  = arg[2] or "/home/tlbb_spug/Script"
local processid    = tonumber(arg[3]) or 2
local svrtype      = arg[4] or "Game2"
local scene_config = arg[5] or "/home/tlbb_spug/Scene"
local loglevel 	   = "1"
local config = string.format([[
    env = "%s"
    script_root = "%s"
    include "config.path"
    thread = 64
    harbor = 0
standalone  = nil          -- hoặc để trống, không set = true
master      = nil
address     = nil
    start = "main" -- main script
    bootstrap = "snlua bootstrap"	-- The service for bootstrap
    enablessl = false
    enablecipher = false
    loglevel = %s
    process_id = %d
    scene_config_env = "%s"
    sensitive_words_path = "./sensitive_words.txt"
    --本地调试打开下面2个,注释vscode调试相关参数
    daemon = nil--"./skynet_%d.pid"
    logger = nil--"%s%d"
    logpath = nil--"../log"
    svrtype = "%s"
    __nowaiting = true

    --vscode 调试打开下面2个,注释daemon 和 logger
    --vscdbg_open = "$vscdbg_open"
    --vscdbg_workdir = "$vscdbg_workdir"
]], env, script_root, loglevel, processid,scene_config, processid, svrtype, processid, svrtype)
print(config)
