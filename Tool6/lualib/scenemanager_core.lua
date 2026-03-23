local skynet = require "skynet"
require "skynet.manager"
local configenginer = require "configenginer":getinstance()
local class = require "class"
local scenemanager_core = class("scenemanager_core")

function scenemanager_core:getinstance()
    if scenemanager_core.instance == nil then
        scenemanager_core.instance = scenemanager_core.new()
    end
    return scenemanager_core.instance
end

function scenemanager_core:ctor()

end

function scenemanager_core:init(conf)
    self.scenes = {}
    self.world_id = conf.world_id
    configenginer:loadall()
    self:createScenes()
end

function scenemanager_core:get_all_scenes()
    return self.scenes
end

function scenemanager_core:reload_scripts()
    print("scriptenginer:reload_scripts")
    for _, scene in ipairs(self.scenes) do
        print("scriptenginer:reload_scripts scene =", scene)
        local r, err = xpcall(skynet.call, debug.traceback, scene, "lua", "reload_scripts")
        if not r then
            print("reload_scripts error =", err)
        end
    end
end

function scenemanager_core:world_timer_update(timer)
    for _, scene in ipairs(self.scenes) do
        skynet.send(scene, "lua", "world_timer_update", timer)
    end
end

function scenemanager_core:createScenes()
    local sceneInfo = skynet.call(".CfgDB", "lua", "get_scene_info")
    for key, info in pairs(sceneInfo) do
        if info.active == 1 and info.type == 0 then
            local id = string.match(key, "scene(%d+)")
            id = tonumber(id)
            info.id = id
            info.world_id = self.world_id
            local scene = skynet.newservice("scene", info.name)
            skynet.call(scene, "lua", "load", info)
            table.insert(self.scenes, scene)
        end
    end
    collectgarbage("collect")
end
function scenemanager_core:span_close()

end
return scenemanager_core