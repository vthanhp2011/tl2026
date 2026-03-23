local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0231 = class("edali_0231", script_base)
edali_0231.script_id = 210231
edali_0231.g_MissionIdPre = 710
edali_0231.g_MissionId = 711
edali_0231.g_Name = "黄眉僧"
edali_0231.g_MissionKind = 13
edali_0231.g_MissionLevel = 9
edali_0231.g_IfMissionElite = 0
edali_0231.g_IsMissionOkFail = 0
edali_0231.g_DemandKill = {{
    ["id"] = 703,
    ["num"] = 5
}}
edali_0231.g_MissionName = "小木人巷"
edali_0231.g_MissionInfo =
    "  施主，这小木人巷虽然比不得少林寺木人巷，但里边的怪物也是骁勇异常。请施主修炼时量力而行。#r  施主只要杀死5只木头人，就完成了这次修炼。一次没有打完也不要紧，施主可以反复出入木人巷，直到完成为止。"
edali_0231.g_MissionTarget =
    "在#G小木人巷#W中杀死5只#R木头人#W，然后回到#R黄眉僧#W#{_INFOAIM275,49,2,黄眉僧}那里。#b#G（请用左键点选带下划线的坐标，帮助您找到该NPC）#l"
edali_0231.g_ContinueInfo = "你已经杀死了5个木头人了吗？"
edali_0231.g_MissionComplete = "  施主的修炼非常成功，片刻不见，武功精进了不少啊。"
edali_0231.g_SignPost = {
    ["x"] = 275,
    ["z"] = 50,
    ["tip"] = "黄眉僧"
}
edali_0231.g_MoneyBonus = 1400000
edali_0231.g_DemandTrueKill = {{
    ["name"] = "木头人",
    ["num"] = 5
}}
function edali_0231:OnDefaultEvent(selfId, targetId)
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

function edali_0231:OnEnumerate(caller, selfId, targetId, arg, index)
    if not self:IsMissionHaveDone(selfId, self.g_MissionIdPre) then
        return
    end
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    end
    if self:IsHaveMission(selfId, self.g_MissionId) then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 2, -1)
    elseif self:CheckAccept(selfId) > 0 then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 1, -1)
    end
end

function edali_0231:CheckAccept(selfId)
    if self:GetLevel(selfId) >= 9 then
        return 1
    else
        return 0
    end
end

function edali_0231:OnAccept(selfId)
    self:AddMission(selfId, self.g_MissionId, self.script_id, 1, 0, 0)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, 0)
    self:Msg2Player(selfId, "#Y接受任务：小木人巷", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "AskTheWay", selfId, 2, self.g_SignPost["x"], self.g_SignPost["z"], self.g_SignPost["tip"])
end

function edali_0231:OnAbandon(selfId)
    self:DelMission(selfId, self.g_MissionId)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "DelSignpost", selfId, self.g_SignPost["tip"])
end

function edali_0231:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    self:AddMoneyBonus(self.g_MoneyBonus)
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_0231:CheckSubmit(selfId)
    local bRet = self:CallScriptFunction(define.SCENE_SCRIPT_ID, "CheckSubmit", selfId, self.g_MissionId)
    if bRet ~= 1 then
        return 0
    end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local num = self:GetMissionParam(selfId, misIndex, 1)
    if num == self.g_DemandTrueKill[1]["num"] then
        return 1
    end
    return 0
end

function edali_0231:OnSubmit(selfId, targetId, selectRadioId)
    if self:CheckSubmit(selfId, selectRadioId) == 1 then
        local ret = 1
        if ret > 0 then
            self:AddMoneyJZ(selfId, self.g_MoneyBonus)
            self:LuaFnAddExp(selfId, 1620)
            ret = self:DelMission(selfId, self.g_MissionId)
            if ret then
                self:MissionCom(selfId, self.g_MissionId)
                self:Msg2Player(selfId, "#Y完成任务：小木人巷", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
                self:CallScriptFunction(210232, "OnDefaultEvent", selfId, targetId)
            end
        else
            self:BeginEvent(self.script_id)
            local strText = "背包已满,无法完成任务"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        end
    end
end

function edali_0231:OnKillObject(selfId, objdataId, objId)
    if self:GetName(objId) == self.g_DemandTrueKill[1]["name"] then
        local num = self:GetNearHumanCount(objId)
        for j = 1, num do
            local humanObjId = self:GetNearHuman(objId, j)
            if self:IsHaveMission(humanObjId, self.g_MissionId) then
                local misIndex = self:GetMissionIndexByID(humanObjId, self.g_MissionId)
                local nNum = self:GetMissionParam(humanObjId, misIndex, 1)
                if nNum < self.g_DemandTrueKill[1]["num"] then
                    if nNum == self.g_DemandTrueKill[1]["num"] - 1 then
                        self:SetMissionByIndex(humanObjId, misIndex, 0, 1)
                    end
                    self:SetMissionByIndex(humanObjId, misIndex, 1, nNum + 1)
                    self:BeginEvent(self.script_id)
                    local strText = string.format("已杀死木头人%d/5", self:GetMissionParam(humanObjId, misIndex, 1))
                    self:AddText(strText)
                    self:EndEvent()
                    self:DispatchMissionTips(humanObjId)
                end
            end
        end
    end
end

function edali_0231:OnEnterArea(selfId, zoneId)

end

function edali_0231:OnItemChanged(selfId, itemdataId)

end

return edali_0231