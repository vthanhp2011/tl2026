local skynet = require "skynet"
local datacenter = require "skynet.datacenter"
local mc = require "skynet.multicast"
require "skynet.manager"
local gbk = require "gbk"
local packet_def = require "game.packet"
local define = require "define"
local class = require "class"
local configenginer = require "configenginer":getinstance()
local activitycore = class("activitycore")

function activitycore:getinstance()
    if activitycore.instance == nil then
        activitycore.instance = activitycore.new()
    end
    return activitycore.instance
end

function activitycore:init()
    self.open_activitys = {}
    self.delta_time = 100
    self:load_config()
    skynet.timeout(self.delta_time, function()
        self:safe_message_update()
    end)
end

function activitycore:load_config()
    configenginer:loadall()
    self.activity_notice = configenginer:get_config("activity_notice")
    self.activity_ruler = configenginer:get_config("activity_ruler")
end

function activitycore:message_update()
    for _, activity in pairs(self.activity_notice) do
        self:check_activity(activity)
    end
end

function activitycore:check_activity(activity)
    local is_active = self:is_active(activity)
    local id = activity.id
    if is_active and self.open_activitys[id] == nil then
        self:activity_open(activity)
    end
    if not is_active and self.open_activitys[id] then
        self:activity_close(activity)
    end
end

function activitycore:send_broad_msg(activity)
    local NotifyMsg = activity.slow_broad
    if NotifyMsg and tonumber(NotifyMsg) ~= define.INVAILD_ID and tonumber(NotifyMsg) ~= 0 then
        NotifyMsg = "@*;SrvMsg;SCA:" .. NotifyMsg
        local msg = packet_def.GCChat.new()
        msg.ChatType = define.ENUM_CHAT_TYPE.CHAT_TYPE_SYSTEM
        NotifyMsg = gbk.fromutf8(NotifyMsg)
        msg:set_content(NotifyMsg)
        skynet.send(".world", "lua", "multicast", msg)
    end
end

function activitycore:activity_open(activity)
    local id = activity.id
    local sceneids = self:get_trigger_scenes(activity)
    self.open_activitys[id] = sceneids or {}
    self:send_broad_msg(activity)
    self:send_all_scenes_activity_open(activity)
end

function activitycore:activity_close(activity)
    self:send_all_scenes_activity_close(activity)
    local id = activity.id
    self.open_activitys[id] = nil
end

function activitycore:is_active(activity)
    if activity.time_type == 0 then
        return self:is_active_type_0(activity)
    elseif activity.time_type == 1 then
        return self:is_active_type_1(activity)
    elseif activity.time_type == 2 then
        return self:is_active_type_2(activity)
    elseif activity.time_type == 3 then
        return self:is_active_type_3(activity)
    end
end

function activitycore:is_active_type_0(activity)
    local date = os.date("*t")
    local yday = date.yday
    local ke = (date.hour * 60 + date.min) // 15
    local num = yday * 100 + ke
    return (activity.opt_type == 1 or num == activity.time_start) and num >= activity.time_start and num < activity.time_invalid
end

function activitycore:is_active_type_1(activity)
    local date = os.date("*t")
    local ke = (date.hour * 60 + date.min) // 15
    --print("activitycore:is_active_type_1 id =", activity.id, ";ke =", ke)
    return (activity.opt_type == 1 or ke == activity.time_start) and ke >= activity.time_start and ke < activity.time_invalid
end

function activitycore:is_active_type_2(activity)
    local date = os.date("*t")
    local wday = date.wday - 1
    local ke = (date.hour * 60 + date.min) // 15
    local num = wday * 100 + ke
    return num >= activity.time_start and num < activity.time_invalid
end

function activitycore:is_active_type_3(activity)
    local date = os.date("*t")
    local mday = date.day - 1
    local ke = (date.hour * 60 + date.min) // 15
    local num = mday * 100 + ke
    return num >= activity.time_start and num < activity.time_invalid
end

function activitycore:get_trigger_scenes(activity)
    local ruler = self.activity_ruler[activity.id]
    if activity.ruler == -1 then
        return { activity.sceneid }
    else
        if ruler then
            local sceneids = ruler.sceneids
            if activity.ruler == 0 then
                return sceneids
            else
                return self:get_random_scene(sceneids, activity.ruler)
            end
        end
    end
end

function activitycore:get_random_scene(sceneids, count)
    local scene_with_randoms = {}
    for _, sceneid in ipairs(sceneids) do
        if sceneid ~= define.INVAILD_ID then
            table.insert(scene_with_randoms, { scene = sceneid, random = math.random(100)})
        end
    end
    table.sort(scene_with_randoms, function(s1, s2) return s1.random < s2.random end)
    local ret_scene = {}
    for i, sr in ipairs(scene_with_randoms) do
        if i <= count then
            table.insert(ret_scene, sr.scene)
        end
    end
    return ret_scene
end

function activitycore:send_all_scenes_activity_open(activity)
    local sceneids = self.open_activitys[activity.id]
    for _, scene in ipairs(sceneids) do
        local name = string.format(".SCENE_%d", scene)
        skynet.send(name, "lua", "activity_open", activity)
    end
end

function activitycore:send_all_scenes_activity_close(activity)
    local sceneids = self.open_activitys[activity.id]
    for _, scene in ipairs(sceneids) do
        local name = string.format(".SCENE_%d", scene)
        skynet.send(name, "lua", "activity_close", activity)
    end
end

function activitycore:safe_message_update()
    local r, err = xpcall(self.message_update, debug.traceback, self, self.delta_time * 10)
    if not r then
        skynet.logw("activitycore:safe_message_update error =", err)
    end
    skynet.timeout(self.delta_time, function() self:safe_message_update() end)
end

return activitycore