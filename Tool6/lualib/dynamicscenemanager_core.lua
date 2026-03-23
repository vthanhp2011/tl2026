local skynet = require "skynet"
require "skynet.manager"
local configenginer = require "configenginer":getinstance()
local define = require "define"
local class = require "class"
local dynamicscenemanager_core = class("dynamicscenemanager_core")
function dynamicscenemanager_core:getinstance()
    if dynamicscenemanager_core.instance == nil then
        dynamicscenemanager_core.instance = dynamicscenemanager_core.new()
    end
    return dynamicscenemanager_core.instance
end

function dynamicscenemanager_core:ctor()

end

function dynamicscenemanager_core:init(conf)
    self.scenes = {}
    self.world_id = conf.world_id
    configenginer:loadall()
    self:loadcitys()
    self:createScenes()
end

function dynamicscenemanager_core:reload_scripts()
    print("scriptenginer:reload_scripts")
    for _, scene in ipairs(self.scenes) do
        print("scriptenginer:reload_scripts scene =", scene)
        local r, err = xpcall(skynet.call, debug.traceback, scene, "lua", "reload_scripts")
        if not r then
            print("reload_scripts error =", err)
        end
    end
end

function dynamicscenemanager_core:loadcitys()
    local response = skynet.call(".db", "lua", "findAll",  {collection = "city",query = nil, selector = nil, skip = 0, sorter = { {["id"] = 1} }})
    print("load citys =", table.tostr(response))
    self.citys = response or {}
    local need_reload = false
    for _, city in ipairs(self.citys) do
        if city.buildings == nil then
            self:gen_default_buildings(city)
            need_reload = true
        end
    end
    if need_reload then
        self:reload_citys()
    end
end

function dynamicscenemanager_core:gen_default_buildings(city)
    local id = city.id
    local sceneid = self:get_city_scene_id(id)
    local city_building = configenginer:get_config("city_building")
    local scene_buildings = {}
    for _, building in pairs(city_building) do
        if building["CityID"] == sceneid then
            scene_buildings[building["BuildingType"]] = building
        end
    end
    local buildings = {}
    for building_type, build_index in pairs(define.CITY_INIT_BUILDINGS) do
        local scene_building = scene_buildings[building_type]
        local building = { id = scene_building["ID"], level = 1}
        buildings[tostring(build_index)] = building
    end
    self:db_update_city_buildings(city, buildings)
end

function dynamicscenemanager_core:reload_citys()
    self:loadcitys()
end

function dynamicscenemanager_core:is_city_scene_apply(sceneid)
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            return true
        end
    end
    return false
end

function dynamicscenemanager_core:get_scene_city_buildings(sceneid)
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            return city.buildings
        end
    end
end

function dynamicscenemanager_core:get_city_name(sceneid)
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            return city.name
        end
    end
end

function dynamicscenemanager_core:get_scene_city_name(sceneid)
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            return city.name
        end
    end
end

function dynamicscenemanager_core:get_scene_guild_id(sceneid)
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            return city.guild_id
        end
    end
end

function dynamicscenemanager_core:get_scene_city_id(sceneid)
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            return city.id
        end
    end
end

function dynamicscenemanager_core:get_scene_city_level(sceneid)
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            return city.level
        end
    end
end

function dynamicscenemanager_core:get_scene_city_client_res(sceneid)
    local this_city
    for _, city in ipairs(self.citys) do
        if self:get_city_scene_id(city.id) == sceneid then
            this_city = city
        end
    end
    local city_info = configenginer:get_config("city_info")
    city_info = city_info[this_city.id]
    local key = string.format("%d级城市", this_city.level)
    return city_info[key]
end

function dynamicscenemanager_core:get_city_scene_id(city_id)
    local city_info = configenginer:get_config("city_info")
    city_info = city_info[city_id]
    return city_info["场景ID"]
end

function dynamicscenemanager_core:get_city_list()
    return self.citys
end

function dynamicscenemanager_core:is_city_occupied(city_id)
    for _, city in ipairs(self.citys) do
        if city.id == city_id then
            return true
        end
    end
    return false
end

function dynamicscenemanager_core:get_empty_city_by_city_enter_group(city_enter_group)
    local city_info = configenginer:get_config("city_info")
    for i = 1, define.MAX_CITY_SCENE do
        local this_city_info = city_info[i]
        if this_city_info["入口组"] == city_enter_group then
            if not self:is_city_occupied(i) then
                return i
            end
        end
    end
end

function dynamicscenemanager_core:occupie_city(guild_id, city_enter_group, city_name)
    local city_id = self:get_empty_city_by_city_enter_group(city_enter_group)
    if city_id == nil then
        return
    end
    local new_city = { id = city_id, name = city_name, guild_id = guild_id, level = 1}
    self:db_insert_city(new_city)
    self:reload_citys()
    return city_id
end

function dynamicscenemanager_core:get_port_scene_id_by_guild_id(guild_id)
    for _, city in ipairs(self.citys) do
        if city.guild_id == guild_id then
            return self:get_city_port_scene_id(city)
        end
    end
end

function dynamicscenemanager_core:get_city_port_scene_id(city)
    local city_info = configenginer:get_config("city_info")
    city_info = city_info[city.id]
    return city_info["入口场景ID"]
end

function dynamicscenemanager_core:db_insert_city(city)
    skynet.call(".db", "lua", "safe_insert", { collection = "city", doc = city })
end

function dynamicscenemanager_core:db_update_city_buildings(city, buildings)
    local selector = {["id"] = city.id }
    local updater = {}
    updater["$set"] = { buildings = buildings }
    local sql = { collection = "city", selector = selector,update = updater,upsert = false,multi = false}
    print("db_update_city_buildings sql =", table.tostr(sql))
    local ret = skynet.call(".db", "lua", "update", sql)
    print("db_update_city_buildings city.id =", city.id, ";ret =", table.tostr(ret))
end

function dynamicscenemanager_core:createScenes()
    local sceneInfo = skynet.call(".CfgDB", "lua", "get_scene_info")
    for key, info in pairs(sceneInfo) do
        if info.active == 1 and info.type == 4 then
            local id = string.match(key, "scene(%d+)")
            id = tonumber(id)
            local is_apply = self:is_city_scene_apply(id)
            if is_apply then
                info = table.clone(info)
                info.city_name = self:get_scene_city_name(id)
                info.city_level = self:get_scene_city_level(id)
                info.clientres = self:get_scene_city_client_res(id)
                info.id = id
                info.buildings = self:get_scene_city_buildings(id)
                local scene = skynet.newservice("dynamicscene")
                info.world_id = self.world_id
                info.guild_id = self:get_scene_guild_id(id)
                info.city_id = self:get_scene_city_id(id)
                skynet.call(scene, "lua", "load", info)
                table.insert(self.scenes, { scene = scene, scene_id = id})
            end
        end
    end
    collectgarbage("collect")
end

function dynamicscenemanager_core:is_city_scene_running(city_id)
    for _, scene in ipairs(self.scenes) do
        if self:get_city_scene_id(city_id) == scene.scene_id then
            return true
        end
    end
    return false
end

function dynamicscenemanager_core:run_city_scene(city_id)
    local id = self:get_city_scene_id(city_id)
    local sceneInfo = skynet.call(".CfgDB", "lua", "get_scene_info")
    local key = string.format("scene%d", id)
    local info = sceneInfo[key]
    info = table.clone(info)
    info.city_name = self:get_scene_city_name(id)
    info.city_level = self:get_scene_city_level(id)
    info.clientres = self:get_scene_city_client_res(id)
    info.id = id
    info.buildings = self:get_scene_city_buildings(id)
    local scene = skynet.newservice("dynamicscene")
    info.world_id = self.world_id
    info.guild_id = self:get_scene_guild_id(id)
    info.city_id = self:get_scene_city_id(id)
    skynet.call(scene, "lua", "load", info)
end

function dynamicscenemanager_core:check_city_running(city_id)
    if not self:is_city_scene_running(city_id) then
        self:run_city_scene(city_id)
    end
    return self:get_city_scene_id(city_id)
end

function dynamicscenemanager_core:world_timer_update(timer)
    for _, scene in ipairs(self.scenes) do
        skynet.send(scene, "lua", "world_timer_update", timer)
    end
end

return dynamicscenemanager_core