local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_zhidao_0201 = class("edali_zhidao_0201", script_base)
edali_zhidao_0201.script_id = 210201
edali_zhidao_0201.g_Position_X = 110.0841
edali_zhidao_0201.g_Position_Z = 158.7671
edali_zhidao_0201.g_SceneID = 2
edali_zhidao_0201.g_AccomplishNPC_Name = "杜子腾"
edali_zhidao_0201.g_MissionId = 441
edali_zhidao_0201.g_MissionIdPre = 440
edali_zhidao_0201.g_Name = "杜子腾"
edali_zhidao_0201.g_ItemId = 40002110
edali_zhidao_0201.g_ItemNeedNum = 1
edali_zhidao_0201.g_MissionKind = 13
edali_zhidao_0201.g_MissionLevel = 1
edali_zhidao_0201.g_IfMissionElite = 0
edali_zhidao_0201.g_IsMissionOkFail = 0
edali_zhidao_0201.g_MissionName = "第一次送货"
edali_zhidao_0201.g_MissionInfo = "#{event_dali_0003}"
edali_zhidao_0201.g_MissionTarget =
    "把#Y一箱厨具#W送给#G大理城西边西大街#Y酒店#W的老板#R杜子腾#W#{_INFOAIM110,159,2,杜子腾}。#b#G（请用左键点选带下划线的坐标，帮助您找到该NPC）#l"
edali_zhidao_0201.g_MissionComplete =
    "  你真是解了我的燃眉之急啊，我正急需这箱#Y厨具#W呢！"
edali_zhidao_0201.g_MoneyBonus = 150000
edali_zhidao_0201.g_SignPost = {["x"] = 110, ["z"] = 159, ["tip"] = "杜子腾"}

edali_zhidao_0201.g_DemandItem = {{["id"] = 40002110, ["num"] = 1}}

edali_zhidao_0201.g_IsMissionOkFail = 1
function edali_zhidao_0201:OnDefaultEvent(selfId, targetId)
    if (self:IsMissionHaveDone(selfId, self.g_MissionId)) then
        return
    elseif (self:IsHaveMission(selfId, self.g_MissionId)) then
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
            self:DispatchMissionInfo(selfId, targetId, self.script_id,
                                     self.g_MissionId)
        end
    end
end

function edali_zhidao_0201:OnEnumerate(caller, selfId, targetId, arg, index)
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

function edali_zhidao_0201:CheckAccept(selfId)
    if self:GetLevel(selfId) >= 1 then
        return 1
    else
        return 0
    end
end

function edali_zhidao_0201:OnAccept(selfId)
    self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    self:BeginAddItem()
    self:AddItem(self.g_ItemId, self.g_ItemNeedNum)
    local ret = self:EndAddItem(selfId)
    if ret then
        self:AddItemListToHuman(selfId)
        self:Msg2Player(selfId, "#Y接受任务：第一次送货", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:CallScriptFunction(define.SCENE_SCRIPT_ID, "AskTheWay", selfId,
                                self.g_SignPost["x"], self.g_SignPost["z"],
                                self.g_SignPost["tip"])
        local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
        self:SetMissionByIndex(selfId, misIndex, 0, 1)
        self:SetMissionByIndex(selfId, misIndex, 1, 1)
    else
        self:BeginEvent(self.script_id)
        local strText = "背包已满,无法接受任务"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    end
end

function edali_zhidao_0201:OnAbandon(selfId)
    local res = self:DelMission(selfId, self.g_MissionId)
    if res > 0 then
        for i, item in pairs(self.g_DemandItem) do
            self:DelItem(selfId, item["id"], item["num"])
        end
        self:CallScriptFunction(define.SCENE_SCRIPT_ID, "DelSignpost", selfId, self.g_SignPost["tip"])
    end
end

function edali_zhidao_0201:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    self:AddMoneyBonus(self.g_MoneyBonus)
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_zhidao_0201:CheckSubmit(selfId)
    local bRet = self:CallScriptFunction(define.SCENE_SCRIPT_ID, "CheckSubmit", selfId, self.g_MissionId)
    if bRet ~= 1 then return 0 end
    for i, item in pairs(self.g_DemandItem) do
        local itemCount = self:GetItemCount(selfId, item["id"])
        if itemCount < item["num"] then return 0 end
    end
    return 1
end

function edali_zhidao_0201:OnSubmit(selfId, targetId, selectRadioId)
    if self:CheckSubmit(selfId, selectRadioId) == 1 then
        for i, item in pairs(self.g_DemandItem) do
            self:DelItem(selfId, item["id"], item["num"])
        end
        self:DelMission(selfId, self.g_MissionId)
        self:MissionCom(selfId, self.g_MissionId)
        self:AddMoneyJZ(selfId, self.g_MoneyBonus)
        self:LuaFnAddExp(selfId, 15)
        self:Msg2Player(selfId, "#Y完成任务：第一次送货", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:CallScriptFunction(210202, "OnDefaultEvent", selfId, targetId)
    end
end

function edali_zhidao_0201:OnKillObject(selfId, objdataId) end

function edali_zhidao_0201:OnEnterZone(selfId, zoneId) end

function edali_zhidao_0201:OnItemChanged(selfId, itemdataId) end

return edali_zhidao_0201
