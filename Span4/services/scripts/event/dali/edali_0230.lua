local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0230 = class("edali_0230", script_base)
edali_0230.script_id = 210230
edali_0230.g_Position_X = 275.2234
edali_0230.g_Position_Z = 49.2906
edali_0230.g_SceneID = 2
edali_0230.g_AccomplishNPC_Name = "黄眉僧"
edali_0230.g_MissionId = 710
edali_0230.g_Name = "黄眉僧"
edali_0230.g_MissionKind = 13
edali_0230.g_MissionLevel = 9
edali_0230.g_IfMissionElite = 0
edali_0230.g_MissionName = "打木人巷啦"
edali_0230.g_MissionInfo = "#{event_dali_0043}"
edali_0230.g_MissionTarget = "去#G大理城东北角的拈花寺#W找到#R黄眉僧#W#{_INFOAIM275,49,2,黄眉僧}。#b#G（请用左键点选带下划线的坐标，帮助您找到该NPC）#l"
edali_0230.g_MissionComplete = "  施主，我们又见面了。请施主准备好修炼用的装备和药品，进入#G小木人巷#W。"
edali_0230.g_MoneyBonus = 135000
edali_0230.g_SignPost = { ["x"] = 275, ["z"] = 50, ["tip"] = "黄眉僧" }
edali_0230.g_Custom = { { ["id"] = "已找到黄眉僧", ["num"] = 1 }}
edali_0230.g_IsMissionOkFail = 1

function edali_0230:OnDefaultEvent(selfId, targetId)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        if self:GetName(targetId) == self.g_Name then
            self:OnContinue(selfId, targetId)
        end
    elseif self:CheckAccept(selfId) > 0 then
        if self:GetName(targetId) ~= self.g_Name then
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
end

function edali_0230:OnEnumerate(caller, selfId, targetId, arg, index)
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

function edali_0230:CheckAccept(selfId)
    if self:GetLevel(selfId) >= 9 then
        return 1
    else
        return 0
    end
end

function edali_0230:OnAccept(selfId)
    self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    self:Msg2Player(selfId, "#Y接受任务：打小木人巷啦", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "AskTheWay", selfId, self.g_SignPost["x"], self.g_SignPost["z"],self.g_SignPost["tip"])
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 1)
    self:SetMissionByIndex(selfId, misIndex, 1, 1)
end

function edali_0230:OnAbandon(selfId)
    self:DelMission(selfId, self.g_MissionId)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "DelSignpost", selfId, self.g_SignPost["tip"])
end

function edali_0230:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    self:AddMoneyBonus(self.g_MoneyBonus)
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_0230:CheckSubmit(selfId)
    local bRet = self:CallScriptFunction(define.SCENE_SCRIPT_ID, "CheckSubmit", selfId, self.g_MissionId)
    if bRet ~= 1 then
        return 0
    end

    return 1
end

function edali_0230:OnSubmit(selfId, targetId, selectRadioId)
    if self:CheckSubmit(selfId) == 1 then
        self:AddMoneyJZ(selfId, self.g_MoneyBonus)
        self:LuaFnAddExp(selfId, 300)
        self:DelMission(selfId, self.g_MissionId)
        self:MissionCom(selfId, self.g_MissionId)
        self:Msg2Player(selfId, "#Y完成任务：打小木人巷啦", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:CallScriptFunction(210231, "OnDefaultEvent", selfId, targetId)
    end
end

function edali_0230:OnKillObject(selfId, objdataId)

end

function edali_0230:OnEnterZone(selfId, zoneId)

end

function edali_0230:OnItemChanged(selfId, itemdataId)

end

return edali_0230
