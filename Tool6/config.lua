local env = ... or "debug"
local script_root = ... or "./Script"

return {
root = "./",
env_conf_root = "./confs/" .. env .. "/",
framework_root = "./framework/",

luaservice = "./?.lua;" 
.. "./services/?.lua;"
.. "./?.lua;"
.. "./services/login/?.lua;"
.. "./services/game/?.lua;"
.. "./services/scene/?.lua;"
.. "./services/world/?.lua;"
.. "./services/activity/?.lua;"
.. "./services/robot/?.lua;"
.. "./services/guild/?.lua;"
.. "./services/ybexchange/?.lua;"
.. "./services/msgagent/?.lua;"
.. "./services/web/?.lua;"
.. "./cluster/service/?.lua;"
.. "./framework/service/?.lua;",

lualoader = "./framework/lualib/loader.lua",

lua_path = "./framework/lualib/?.lua;"
.. "./framework/lualib/?/init.lua;"
.. script_root .. "/?.lua;"
.. "./services/?.lua;"
.. "./cluster/?.lua;"
.. "./lualib/?.lua;"
.. "./lualib/web/?.lua;"
.. "./msgagent_module/?.lua;"
.. "./confs/" .. env .. "/?.lua;",

lua_cpath = "./framework/luaclib/?.so;" 
.. "./luaclib/?.so;",

snax = "./services/?.lua;"
.. "./?.lua;",

cpath = "./framework/cservice/?.so;"
.. "./cservice/?.so;",

preload = "./lualib/preloader.lua"
}