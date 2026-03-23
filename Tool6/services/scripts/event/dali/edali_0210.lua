local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0210 = class("edali_0210", script_base)
edali_0210.script_id = 210210
edali_0210.g_Position_X = 172.7304
edali_0210.g_Position_Z = 146.4640
edali_0210.g_SceneID = 2
edali_0210.g_AccomplishNPC_Name = "孙八爷"
edali_0210.g_MissionId = 450
edali_0210.g_Name = "孙八爷"
edali_0210.g_MissionKind = 13
edali_0210.g_MissionLevel = 3
edali_0210.g_IfMissionElite = 0
edali_0210.g_MissionName = "做一次大侠"
edali_0210.g_MissionInfo_1 = "#{event_dali_0012}"
edali_0210.g_MissionInfo_2 = "#W，难道你不应该去帮帮他吗？"
edali_0210.g_MissionTarget = "在#G大理城五华坛#W找到四大善人之一的#R孙八爷#W#{_INFOAIM173,146,2,孙八爷}。#b#G（请用左键点选带下划线的坐标，帮助您找到该NPC）#l"
edali_0210.g_MissionComplete = "  哎呀，我的老朋友，我就知道你会来帮我的。"
edali_0210.g_MoneyBonus = 50000
edali_0210.g_SignPost = { ["x"] = 173, ["z"] = 147, ["tip"] = "孙八爷" }
edali_0210.g_Custom = { { ["id"] = "已找到孙八爷", ["num"] = 1 }}
function edali_0210:OnDefaultEvent(selfId, targetId)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        if self:GetName(targetId) == self.g_Name then
            self:OnContinue(selfId, targetId)
        end
    elseif self:CheckAccept(selfId) > 0 then
        if self:GetName(targetId) ~= self.g_Name then
            local PlayerName = self:GetName(selfId)
            self:BeginEvent(self.script_id)
                self:AddText(self.g_MissionName)
                self:AddText(self.g_MissionInfo_1 .. PlayerName .. self.g_MissionInfo_2)
                self:AddText("#{M_MUBIAO}")
                self:AddText(self.g_MissionTarget)
                self:AddMoneyBonus(self.g_MoneyBonus)
            self:EndEvent()
            self:DispatchMissionInfo(selfId, targetId, self.script_id, self.g_MissionId)
        end
    end
end

function edali_0210:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        if self:GetName(targetId) == self.g_Name then
            caller:AddNumTextWithTarget(self.script_id,self.g_MissionName, 2, -1)
        end
    elseif self:CheckAccept(selfId) > 0 then
        if self:GetName(targetId) ~= self.g_Name then
            caller:AddNumTextWithTarget(self.script_id,self.g_MissionName, 1, -1)
        end
    end
end

function edali_0210:CheckAccept(selfId)
    if self:GetLevel(selfId) >= 3 then
        return 1
    else
        return 0
    end
end

function edali_0210:OnAccept(selfId)
    self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    self:Msg2Player(selfId, "#Y接受任务：做一次大侠", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "AskTheWay", selfId, 0, self.g_SignPost["x"], self.g_SignPost["z"],
        self.g_SignPost["tip"])
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 1)
end

function edali_0210:OnAbandon(selfId)
    self:DelMission(selfId, self.g_MissionId)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "DelSignpost", selfId, self.g_SignPost["tip"])
end

function edali_0210:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionComplete)
        self:AddMoneyBonus(self.g_MoneyBonus)
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_0210:CheckSubmit(selfId)
    local bRet = self:CallScriptFunction(define.SCENE_SCRIPT_ID, "CheckSubmit", selfId, self.g_MissionId)

    if bRet ~= 1 then
        return 0
    end

    return 1
end

function edali_0210:OnSubmit(selfId, targetId, selectRadioId)
    if self:CheckSubmit(selfId) == 1 then
        self:AddMoneyJZ(selfId, self.g_MoneyBonus)
        self:LuaFnAddExp(selfId, 100)
        self:DelMission(selfId, self.g_MissionId)
        self:MissionCom(selfId, self.g_MissionId)
        self:Msg2Player(selfId, "#Y完成任务：做一次大侠", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:CallScriptFunction(210211, "OnDefaultEvent", selfId, targetId)
    end
end

function edali_0210:OnKillObject(selfId, objdataId)

end

function edali_0210:OnEnterZone(selfId, zoneId)

end

function edali_0210:OnItemChanged(selfId, itemdataId)

end

return edali_0210
