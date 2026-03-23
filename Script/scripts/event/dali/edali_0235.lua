local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0235 = class("edali_0235", script_base)
edali_0235.script_id = 210235
edali_0235.g_Position_X = 160.4355
edali_0235.g_Position_Z = 127.9695
edali_0235.g_SceneID = 2
edali_0235.g_AccomplishNPC_Name = "李工部"
edali_0235.g_MissionId = 715
edali_0235.g_Name = "李工部"
edali_0235.g_MissionKind = 13
edali_0235.g_MissionLevel = 6
edali_0235.g_IfMissionElite = 0
edali_0235.g_IsMissionOkFail = 0
edali_0235.g_DemandItem = {
    { ["id"] = 20309003, ["num"] = 1 }, { ["id"] = 20309007, ["num"] = 1 }

}
edali_0235.g_MissionName = "御赐精纺护手"
edali_0235.g_MissionInfo = "#{event_dali_0048}"
edali_0235.g_MissionTarget ="找到一品银耳和一品芋头，然后回#G大理城五华坛#W找四大善人之一的#R李工部#W#{_INFOAIM160,128,2,李工部}。"
edali_0235.g_ContinueInfo = "  一品银耳和一品芋头你已经找到了？"
edali_0235.g_MissionComplete = "  年轻人，做的不错。"
edali_0235.g_ItemBonus = { { ["id"] = 10412047, ["num"] = 1 } }
edali_0235.g_MoneyBonus = 0

function edali_0235:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionInfo)
    for i, item in pairs(self.g_DemandItem) do
        self:AddItemDemand(item["id"], item["num"])
    end
    self:EndEvent()
    local bDone = self:CheckSubmit(selfId)
    self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, self.g_MissionId, bDone)
end

function edali_0235:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:CheckAccept(selfId) > 0 then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 1, -1)
    end
end

function edali_0235:CheckAccept(selfId) return 1 end

function edali_0235:OnAccept(selfId) end

function edali_0235:OnAbandon(selfId) self:DelMission(selfId, self.g_MissionId) end

function edali_0235:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    for i, item in pairs(self.g_ItemBonus) do
        self:AddItemBonus(item["id"], item["num"])
    end
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_0235:CheckSubmit(selfId)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then return 0 end
    for i, item in pairs(self.g_DemandItem) do
        itemCount = self:GetItemCount(selfId, item["id"])
        if itemCount < item["num"] then return 0 end
    end
    return 1
end

function edali_0235:OnSubmit(selfId, targetId, selectRadioId)
    if self:CheckSubmit(selfId) == 1 then
        self:BeginAddItem()
        for i, item in pairs(self.g_ItemBonus) do
            self:AddItem(item["id"], item["num"])
        end
        local ret = self:EndAddItem(selfId)
        if ret then
            for i, item in pairs(self.g_DemandItem) do
                ret = self:DelItem(selfId, item["id"], item["num"])
            end
            if ret then
                ret = self:DelMission(selfId, self.g_MissionId)
                if ret then
                    self:MissionCom(selfId, self.g_MissionId)
                    self:AddItemListToHuman(selfId)
                    self:Msg2Player(selfId, "#Y完成任务：御赐精纺护手", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
                end
            else
                self:BeginEvent(self.script_id)
                local strText = "无法完成任务"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
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

function edali_0235:OnKillObject(selfId, objdataId, objId) end

function edali_0235:OnEnterArea(selfId, zoneId) end

function edali_0235:OnItemChanged(selfId, itemdataId) end

return edali_0235
