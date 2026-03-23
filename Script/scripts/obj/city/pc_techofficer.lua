local class = require "class"
local define = require "define"
local script_base = require "script_base"
local pc_techofficer = class("pc_techofficer", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
pc_techofficer.script_id = 805015
pc_techofficer.g_BuildingID9 = 13
pc_techofficer.g_eventList = {600012}
pc_techofficer.g_eventSetList = {600012}
pc_techofficer.g_MingTieNeedBangGong = 50
pc_techofficer.g_TangJinMingTieID = 30505205
pc_techofficer.g_TangJinMingTieCount = 1

function pc_techofficer:UpdateEventList(selfId, targetId)
    local i = 1
    local eventId = 0
    local Humanguildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    self:BeginEvent(self.script_id)
    if Humanguildid == cityguildid then
        self:AddText("    满城之兴，无不在高深之技，咱们同帮兄弟，有什麽我能帮你的，尽管开口。")
        for i, eventId in pairs(self.g_eventList) do
            self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
        end
        self:AddNumText("科技任务介绍", 11, 1)
        self:AddNumText("研究新的商品", 6, 4)
        self:AddNumText("城市雕像", 6, 5)
        self:AddNumText("制作帮会徽章", 6, 6)
        self:AddNumText("书房介绍", 11, 2)
        self:AddNumText("领取烫金名帖", 6, 20)
        self:AddNumText("关於领取帮会自订称号", 11, 22)
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "AddCityLifeAbilityOpt", selfId, self.script_id, self.g_BuildingID9, 888)
    else
        local PlayerGender = self:GetSex(selfId)
        local rank
        if PlayerGender == 0 then
            rank = "姑娘"
        elseif PlayerGender == 1 then
            rank = "先生"
        else
            rank = "请问"
        end
        self:AddText("    啊呀！" .. rank ..  "不像是本帮中人，小生不便多言则个。")
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function pc_techofficer:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function pc_techofficer:IsValidEvent(selfId, eventId)
    local i = 1
    local findId = 0
    local bValid = 0
    for i, findId in pairs(self.g_eventList) do
        if eventId == findId then
            bValid = 1
            break
        end
    end
    if bValid == 0 then
        for i, findId in pairs(self.g_eventSetList) do
            if self:CallScriptFunction(findId, "IsInEventList", selfId, eventId) == 1 then
                bValid = 1
                break
            end
        end
    end
    return bValid
end

function pc_techofficer:OnEventRequest(selfId, targetId, arg, index)
    if self:IsValidEvent(selfId, arg) == 1 then
        self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
        return
    elseif arg ~= self.script_id then
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnDefaultEvent", selfId, targetId, arg, self.script_id, self.g_BuildingID9)
        return
    end
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Tec_Mission_Help}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_ShuFang}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 4 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 5 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 6 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 20 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TJMT_090213_01}")
        self:AddNumText("是，我确定。", 6, 201)
        self:AddNumText("不，我还是不要了。", 6, 202)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 201 then
        self:GetTangJinMinTie(selfId, targetId)
    elseif index == 202 then
        self:BeginEvent(self.script_id)
        self:OnDefaultEvent(selfId, targetId)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 22 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TangJinMingTie_Help}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 888 then
        self:BeginEvent(self.script_id)
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnEnumerate", self, selfId, targetId, self.g_BuildingID9)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function pc_techofficer:OnMissionAccept(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
        if ret > 0 then
            self:CallScriptFunction(missionScriptId, "OnAccept", selfId, targetId)
        elseif ret == -1 then
            self:NotifyFailTips(selfId, "你现在不能领取这个任务")
        elseif ret == -2 then
            self:NotifyFailTips(selfId, "无法接受更多任务")
        end
        return
    end
end

function pc_techofficer:OnMissionRefuse(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:UpdateEventList(selfId, targetId)
        return
    end
end

function pc_techofficer:OnMissionContinue(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
        return
    end
end

function pc_techofficer:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
        return
    end
end

function pc_techofficer:OnDie(selfId, killerId) end

function pc_techofficer:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function pc_techofficer:GetTangJinMinTie(selfId, targetId)
    local szMsg = nil
    local nBangGongPoint = self:CityGetAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT)
    if nBangGongPoint < self.g_MingTieNeedBangGong then
        szMsg = string.format("    阁下的帮会贡献不足#G%d#W，无法兑换自订职位名称。", self.g_MingTieNeedBangGong)
        self:NotifyFailTips(selfId, szMsg)
        return
    end
    if (self:LuaFnGetPropertyBagSpace(selfId) < self.g_TangJinMingTieCount) then
        self:NotifyFailTips(selfId, "#{YRJ_BagFullTip}")
        return
    end
    local ret = self:CityChangeAttr(selfId, 6, -self.g_MingTieNeedBangGong)
    if not ret then
        self:NotifyFailTips(selfId, "    无法扣除帮贡，请重试！")
        return
    end
    self:BeginAddItem()
    self:AddItem(self.g_TangJinMingTieID, self.g_TangJinMingTieCount)
    self:EndAddItem(selfId)
    self:AddItemListToHuman(selfId)
    self:BeginEvent(self.script_id)
    self:AddText("    这是一张#G烫金名帖#W，拿去，好好使用！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return pc_techofficer
