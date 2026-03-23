local env = arg[1]
local script_root = arg[2]
local processid = arg[3]
local svrtype = arg[4]
local scene_config = arg[5]
local loglevel = "2"
local config = string.format([[
    env = "%s"
    script_root = "%s"
    include "config.path"
    thread = 64
    harbor = 0
    start = "main" -- main script
    bootstrap = "snlua bootstrap"	-- The service for bootstrap
    enablessl = true
    enablecipher = true
    loglevel = %s
    process_id = %d
    scene_config_env = "%s"
    sensitive_words_path = "./sensitive_words.txt"
    --本地调试打开下面2个,注释vscode调试相关参数
    daemon = "./skynet_%d.pid"
    logger = "%s%d"
    logpath = "../log"
    svrtype = "%s"
    __nowaiting = true

    --vscode 调试打开下面2个,注释daemon 和 logger
    --vscdbg_open = "$vscdbg_open"
    --vscdbg_workdir = "$vscdbg_workdir"
]], env, script_root, loglevel, processid,scene_config, processid, svrtype, processid, svrtype)
print(config)
