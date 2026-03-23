local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ePetIsland_MonsterPatrol = class("ePetIsland_MonsterPatrol", script_base)
ePetIsland_MonsterPatrol.script_id = 808068
ePetIsland_MonsterPatrol.g_MonsterNumber = 5
ePetIsland_MonsterPatrol.g_MonsterLifeTime = 3000000
ePetIsland_MonsterPatrol.g_ActivitySceneId = 39
ePetIsland_MonsterPatrol.g_ActivityScendName = "玄武岛"
ePetIsland_MonsterPatrol.g_BookThiefID = {13400, 13401}
ePetIsland_MonsterPatrol.g_BookThiefExtAI = {286, 287}
ePetIsland_MonsterPatrol.g_BookThiefNPCID = 807003
ePetIsland_MonsterPatrol.g_BookThiefLifeTime = 40 * 60000
ePetIsland_MonsterPatrol.g_ExistBookThief = 5
function ePetIsland_MonsterPatrol:BroadcastLocation(level, x, z)
    local noticeMsg =string.format("#P这支战队首领#{_BOSS3}#P等级高达#G%d级#P，据说有人在#G玄武岛(%d,%d)#P附近看到过他们。", level, x, z)
    if nil ~= noticeMsg then self:AddGlobalCountNews(noticeMsg) end
end

function ePetIsland_MonsterPatrol:BroadcastNotice()
    local index = math.random(3)
    local Notices = {
        "#G玄武岛#P上宠物好，各路英雄本领高。高手之中谁最强，第一#{_BOSS3}#P。横行玄武宠物怕，作威作福常发彪。谁是好汉快来打，名利双收在今朝！",
        "#G玄武岛#P一级警报，一级警报，#{_BOSS3}#P已经在岛上出现，在岛上出现，请各路英雄注意安全，注意安全！",
        "#{_BOSS3}#P战斗小组已经在#G玄武岛#P着陆，该部队装备精良，训练有素，战斗力强悍。请天下英雄打得过就打，打不过就跑。"
    }
    local noticeMsg = Notices[index]
    if nil ~= noticeMsg then self:AddGlobalCountNews(noticeMsg) end
end

function ePetIsland_MonsterPatrol:CreateMonstersByGroup(groupId)
    local Group25 = {
        {
            ["DataId"] = 3830,
            ["x"] = 212.517,
            ["z"] = 181.2889,
            ["aiType"] = 20,
            ["aiScript"] = 211,
            ["aiLuaExtend"] = 808068,
            ["patrolId"] = 5
        }, {
            ["DataId"] = 3833,
            ["x"] = 213.217,
            ["z"] = 180.5889,
            ["aiType"] = 20,
            ["aiScript"] = 212,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 6
        }, {
            ["DataId"] = 3836,
            ["x"] = 213.917,
            ["z"] = 179.8889,
            ["aiType"] = 20,
            ["aiScript"] = 213,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 7
        }, {
            ["DataId"] = 3839,
            ["x"] = 211.817,
            ["z"] = 180.5889,
            ["aiType"] = 20,
            ["aiScript"] = 214,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 8
        }, {
            ["DataId"] = 3842,
            ["x"] = 211.117,
            ["z"] = 179.8889,
            ["aiType"] = 20,
            ["aiScript"] = 215,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 9
        }
    }
    local Group45 = {
        {
            ["DataId"] = 3831,
            ["x"] = 113.6972,
            ["z"] = 219.7326,
            ["aiType"] = 20,
            ["aiScript"] = 211,
            ["aiLuaExtend"] = 808068,
            ["patrolId"] = 10
        }, {
            ["DataId"] = 3834,
            ["x"] = 114.3972,
            ["z"] = 219.0326,
            ["aiType"] = 20,
            ["aiScript"] = 212,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 11
        }, {
            ["DataId"] = 3837,
            ["x"] = 115.0972,
            ["z"] = 218.3326,
            ["aiType"] = 20,
            ["aiScript"] = 213,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 12
        }, {
            ["DataId"] = 3840,
            ["x"] = 112.9972,
            ["z"] = 219.0326,
            ["aiType"] = 20,
            ["aiScript"] = 214,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 13
        }, {
            ["DataId"] = 3843,
            ["x"] = 112.2972,
            ["z"] = 218.3326,
            ["aiType"] = 20,
            ["aiScript"] = 215,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 14
        }
    }
    local Group65 = {
        {
            ["DataId"] = 3832,
            ["x"] = 271.3059,
            ["z"] = 63.2789,
            ["aiType"] = 20,
            ["aiScript"] = 211,
            ["aiLuaExtend"] = 808068,
            ["patrolId"] = 15
        }, {
            ["DataId"] = 3835,
            ["x"] = 272.0059,
            ["z"] = 62.5789,
            ["aiType"] = 20,
            ["aiScript"] = 212,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 16
        }, {
            ["DataId"] = 3838,
            ["x"] = 272.7059,
            ["z"] = 61.8789,
            ["aiType"] = 20,
            ["aiScript"] = 213,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 17
        }, {
            ["DataId"] = 3841,
            ["x"] = 270.6059,
            ["z"] = 62.5789,
            ["aiType"] = 20,
            ["aiScript"] = 214,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 18
        }, {
            ["DataId"] = 3844,
            ["x"] = 269.9059,
            ["z"] = 61.8789,
            ["aiType"] = 20,
            ["aiScript"] = 215,
            ["aiLuaExtend"] = -1,
            ["patrolId"] = 19
        }
    }
    local MonsterGroup = {Group25, Group45, Group65}
    local LocationInfo = {
        {["level"] = 25, ["x"] = 212, ["z"] = 181},
        {["level"] = 45, ["x"] = 113, ["z"] = 219},
        {["level"] = 65, ["x"] = 271, ["z"] = 63}
    }

    local group = MonsterGroup[groupId]
    if nil ~= group then
        local locationInfo = LocationInfo[groupId]
        for index = 1, self.g_MonsterNumber do
            local monster = group[index]
            if nil ~= monster then
                local monsterId = self:LuaFnCreateMonster(monster["DataId"],
                                                          monster["x"],
                                                          monster["z"],
                                                          monster["aiType"],
                                                          monster["aiScript"],
                                                          monster["aiLuaExtend"])
                self:SetMonsterGroupID(monsterId, groupId)
                self:SetPatrolId(monsterId, monster["patrolId"])
                self:SetCharacterDieTime(monsterId, self.g_MonsterLifeTime)
                if (self:GetName(monsterId) == "无敌飞天猫") then
                    self:SetCharacterTitle(monsterId, "玄武岛侦缉队长")
                end
            else
                break
            end
        end
        self:BroadcastNotice()
        if nil ~= locationInfo then
            self:BroadcastLocation(locationInfo["level"], locationInfo["x"], locationInfo["z"])
        end
    end
end

function ePetIsland_MonsterPatrol:OnDefaultEvent(actId, param1, param2, param3, param4, param5)
    local sceneId = self:get_scene_id()
    if self.g_ActivitySceneId == sceneId then
        self:StartOneActivity(actId, math.floor(300000))
    end
end

function ePetIsland_MonsterPatrol:OnTimer(actId, uTime)
    local sceneId = self:get_scene_id()
    if self.g_ActivitySceneId == sceneId then
        local RegenesisTime = {
            {["groupId"] = 3}, {["groupId"] = 1}, {["groupId"] = 2},
            {["groupId"] = 3}, {["groupId"] = 1}, {["groupId"] = 2},
            {["groupId"] = 3}, {["groupId"] = nil}, {["groupId"] = nil},
            {["groupId"] = nil}, {["groupId"] = 1}, {["groupId"] = 2},
            {["groupId"] = 3}, {["groupId"] = 1}, {["groupId"] = 2},
            {["groupId"] = 3}, {["groupId"] = 1}, {["groupId"] = 2},
            {["groupId"] = 3}, {["groupId"] = 1}, {["groupId"] = 2},
            {["groupId"] = 3}, {["groupId"] = 1}, {["groupId"] = 2}
        }
        if 5 > math.floor(self:GetMinute()) then
            local index = math.floor(self:GetHour() + 1)
            local groupId = nil
            local regenesisTime = RegenesisTime[index]
            if nil ~= regenesisTime then
                groupId = regenesisTime["groupId"]
            end
            if nil ~= groupId then
                self:CreateMonstersByGroup(groupId)
                self:StopOneActivity(actId)
            end
        end
    end
end

function ePetIsland_MonsterPatrol:OnDie(objId, selfId)
    local killerID = selfId
    local objType = self:GetCharacterType(selfId)
    if objType == 3 then killerID = self:GetPetCreator(selfId) end
    local postable = {
        {87, 108}, {173, 58}, {234, 53}, {259, 80}, {243, 150}, {152, 145},
        {75, 191}, {136, 206}, {184, 209}, {256, 215}, {219, 252}, {176, 231},
        {129, 274}, {74, 275}, {127, 199}, {44, 90}, {46, 126}, {45, 167},
        {39, 219}, {75, 279}, {103, 74}, {110, 126}, {112, 170}, {116, 216},
        {145, 235}, {182, 278}, {180, 238}, {159, 136}, {222, 98}, {283, 176}
    }
    local size = #(postable)
    for i = 1, self.g_ExistBookThief do
        local ram = math.random(size)
        local ThisPos = postable[ram]
        for j = ram, size do
            if j + 1 <= size then postable[j] = postable[j + 1] end
        end
        size = size - 1
        local monsterType = math.random(#(self.g_BookThiefID))
        local MonsterId = self:LuaFnCreateMonster(
                              self.g_BookThiefID[monsterType], ThisPos[1],
                              ThisPos[2], 0, self.g_BookThiefExtAI[monsterType],
                              self.g_BookThiefNPCID)
        self:SetCharacterDieTime(MonsterId, self.g_BookThiefLifeTime)
        self:SetCharacterTitle(MonsterId, "宝书窃贼")
        self:SetUnitReputationID(killerID, MonsterId, 0)
    end
    local strText = "#{ZSSFC_090211_05}"
    self:BroadMsgByChatPipe(killerID, strText, 4)
end

return ePetIsland_MonsterPatrol
