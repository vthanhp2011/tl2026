local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_zhidao_0203 = class("edali_zhidao_0203", script_base)
edali_zhidao_0203.script_id = 210203
edali_zhidao_0203.g_Position_X = 102.8806
edali_zhidao_0203.g_Position_Z = 131.8685
edali_zhidao_0203.g_SceneID = 2
edali_zhidao_0203.g_AccomplishNPC_Name = "卢三七"
edali_zhidao_0203.g_MissionId = 443
edali_zhidao_0203.g_MissionIdPre = 442
edali_zhidao_0203.g_Name = "卢三七"
edali_zhidao_0203.g_MissionKind = 13
edali_zhidao_0203.g_MissionLevel = 1
edali_zhidao_0203.g_IfMissionElite = 0
edali_zhidao_0203.g_MissionName = "第一份药品"
edali_zhidao_0203.g_MissionInfo = "#{event_dali_0005}"
edali_zhidao_0203.g_MissionTarget =
    "在#G大理城西大街#W的#Y药店#W里找到#R卢三七#W#{_INFOAIM103,132,2,卢三七}。#b#G（请用左键点选带下划线的坐标，帮助您找到该NPC）#l"
edali_zhidao_0203.g_MissionComplete =
    "  想不到你对医道有这样浓厚的兴趣，和你聊天真是畅快。这些#Y药品#W你选一样吧，就当是我送你的见面礼。"
edali_zhidao_0203.g_MoneyBonus = 250000
edali_zhidao_0203.g_SignPost = {["x"] = 103, ["z"] = 133, ["tip"] = "卢三七"}

edali_zhidao_0203.g_RadioItemBonus = {
    {["id"] = 30001001, ["num"] = 5}, {["id"] = 30003001, ["num"] = 5},
    {["id"] = 30002001, ["num"] = 5}
}

edali_zhidao_0203.g_Custom = {{["id"] = "已找到卢三七", ["num"] = 1}}

edali_zhidao_0203.g_IsMissionOkFail = 1
function edali_zhidao_0203:OnDefaultEvent(selfId, targetId)
    if (self:IsMissionHaveDone(selfId, self.g_MissionId)) then
        return
    elseif (self:IsHaveMission(selfId, self.g_MissionId)) then
        if self:GetName(targetId) == self.g_Name then
            self:OnContinue(selfId, targetId)
        end
    elseif self:CheckAccept(selfId) then
        if self:GetName(targetId) ~= self.g_Name then
            self:BeginEvent(self.script_id)
            self:AddText(self.g_MissionName)
            self:AddText(self.g_MissionInfo)
            self:AddText("#{M_MUBIAO}")
            self:AddText(self.g_MissionTarget)
            for i, item in pairs(self.g_RadioItemBonus) do
                self:AddRadioItemBonus(item["id"], item["num"])
            end
            self:AddMoneyBonus(self.g_MoneyBonus)
            self:EndEvent()
            self:DispatchMissionInfo(selfId, targetId, self.script_id, self.g_MissionId)
        end
    end
end

function edali_zhidao_0203:OnEnumerate(caller, selfId, targetId, arg, index)
    if not self:IsMissionHaveDone(selfId, self.g_MissionIdPre) then return end
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        if self:GetName(targetId) == self.g_Name then
            caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 2, -1)
        end
    elseif self:CheckAccept(selfId) > 0 then
        if self:GetName(targetId) ~= self.g_Name then
            caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 1, -1)
        end
    end
end

function edali_zhidao_0203:CheckAccept(selfId)
    if self:GetLevel(selfId) >= 1 then
        return 1
    else
        return 0
    end
end

function edali_zhidao_0203:OnAccept(selfId)
    self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    self:Msg2Player(selfId, "#Y接受任务：第一份药品", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "AskTheWay", selfId,
                            self.g_SignPost["x"], self.g_SignPost["z"],
                            self.g_SignPost["tip"])
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 1)
    self:SetMissionByIndex(selfId, misIndex, 1, 1)
end

function edali_zhidao_0203:OnAbandon(selfId)
    self:DelMission(selfId, self.g_MissionId)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "DelSignpost", selfId,
                            self.g_SignPost["tip"])
end

function edali_zhidao_0203:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    self:AddMoneyBonus(self.g_MoneyBonus)
    for i, item in pairs(self.g_RadioItemBonus) do
        self:AddRadioItemBonus(item["id"], item["num"])
    end
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id,
                                     self.g_MissionId)
end

function edali_zhidao_0203:CheckSubmit(selfId)
    local bRet = self:CallScriptFunction(define.SCENE_SCRIPT_ID, "CheckSubmit", selfId,
                                         self.g_MissionId)
    if bRet ~= 1 then return 0 end
    return 1
end

function edali_zhidao_0203:OnSubmit(selfId, targetId, selectRadioId)
    if self:CheckSubmit(selfId, selectRadioId) == 1 then
        self:BeginAddItem()
        for i, item in pairs(self.g_RadioItemBonus) do
            if item["id"] == selectRadioId then
                self:AddItem(item["id"], item["num"])
            end
        end
        local ret = self:EndAddItem(selfId)
        if ret then
            self:AddMoneyJZ(selfId, self.g_MoneyBonus)
            self:LuaFnAddExp(selfId, 25)
            self:DelMission(selfId, self.g_MissionId)
            self:MissionCom(selfId, self.g_MissionId)
            self:AddItemListToHuman(selfId)
            self:Msg2Player(selfId, "#Y完成任务：第一份药品",
            define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            self:CallScriptFunction(210204, "OnDefaultEvent", selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            local strText = "背包已满,无法完成任务"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        end
    end
end

function edali_zhidao_0203:OnKillObject(selfId, objdataId) end

function edali_zhidao_0203:OnEnterZone(selfId, zoneId) end

function edali_zhidao_0203:OnItemChanged(selfId, itemdataId) end

return edali_zhidao_0203
