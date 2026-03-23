local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0228 = class("edali_0228", script_base)
edali_0228.script_id = 210228
edali_0228.g_MissionId = 708
edali_0228.g_MissionIdPre = 707
edali_0228.g_Name = "段延庆"
edali_0228.g_MissionKind = 13
edali_0228.g_MissionLevel = 8
edali_0228.g_IfMissionElite = 0
edali_0228.g_IsMissionOkFail = 0
edali_0228.g_MissionName = "送矿锄"
edali_0228.g_MissionInfo =
    "  [有吃的，有穿的，那个#R小乞丐#W还是不能生活啊。去找一把#Y矿锄#W送给他吧，让他以後能够自食其力。]#r  #e00f000小提示：#e000000你可以找边上的 #gfff0f0养雕人 #g000000直接飞到杂货铺附近。#r"
edali_0228.g_MissionTarget = "#{event_dali_0040}"
edali_0228.g_ContinueInfo =
    "  [你已经把#Y矿锄#W送到#R小乞丐#W手中了吗？]"
edali_0228.g_MissionComplete = "#{event_dali_0041}"
edali_0228.g_SignPost = {["x"] = 199, ["z"] = 256, ["tip"] = "小乞丐"}
edali_0228.g_Custom = {{["id"] = "给小乞丐送矿锄！", ["num"] = 1}}
edali_0228.g_MoneyBonus = 1250000
function edali_0228:OnDefaultEvent(selfId, targetId)
    if self:IsHaveMission(selfId, self.g_MissionId) then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_ContinueInfo)
        self:AddMoneyBonus(self.g_MoneyBonus)
        self:EndEvent()
        local bDone = self:CheckSubmit(selfId)
        self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, self.g_MissionId, bDone)
    elseif self:CheckAccept(selfId) > 0 then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionInfo)
        self:AddText("#{M_MUBIAO}")
        self:AddText(self.g_MissionTarget)
        self:AddMoneyBonus(self.g_MoneyBonus)
        self:EndEvent()
        self:DispatchMissionInfo(selfId, targetId, self.script_id, self.g_MissionId)
    end
end

function edali_0228:OnEnumerate(caller, selfId, targetId, arg, index)
    if not self:IsMissionHaveDone(selfId, self.g_MissionIdPre) then return end
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then return end
    if self:IsHaveMission(selfId, self.g_MissionId) then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 2, -1)
    elseif self:CheckAccept(selfId) > 0 then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 1, -1)
    end
end

function edali_0228:CheckAccept(selfId)
    if self:GetLevel(selfId) >= 8 then
        return 1
    else
        return 0
    end
end

function edali_0228:OnAccept(selfId)
    self:AddMission(selfId, self.g_MissionId, self.script_id, 1, 0, 0)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, 0)
    self:Msg2Player(selfId, "#Y接受任务：送矿锄", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "AskTheWay", selfId, 2, self.g_SignPost["x"], self.g_SignPost["z"], self.g_SignPost["tip"])

end

function edali_0228:OnAbandon(selfId)
    self:DelMission(selfId, self.g_MissionId)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "DelSignpost", selfId,  self.g_SignPost["tip"])
end

function edali_0228:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    self:AddMoneyBonus(self.g_MoneyBonus)
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_0228:CheckSubmit(selfId)
    local bRet = self:CallScriptFunction(define.SCENE_SCRIPT_ID, "CheckSubmit", selfId, self.g_MissionId)
    if bRet ~= 1 then return 0 end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local num = self:GetMissionParam(selfId, misIndex, 0)
    if num == 1 then return 1 end
    return 0
end

function edali_0228:OnSubmit(selfId, targetId, selectRadioId)
    if self:CheckSubmit(selfId, selectRadioId) == 1 then
        self:AddMoneyJZ(selfId, self.g_MoneyBonus)
        self:LuaFnAddExp(selfId, 500)
        local ret = self:DelMission(selfId, self.g_MissionId)
        if ret  then
            self:MissionCom(selfId, self.g_MissionId)
            self:Msg2Player(selfId, "#Y完成任务：送矿锄", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            self:CallScriptFunction(210229, "OnDefaultEvent", selfId, targetId)
        end
    end
end

function edali_0228:OnKillObject(selfId, objdataId) end

function edali_0228:OnEnterArea(selfId, zoneId) end

function edali_0228:OnItemChanged(selfId, itemdataId) end

return edali_0228
