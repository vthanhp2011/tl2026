local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_yuzhuzhi = class("odali_yuzhuzhi", script_base)
odali_yuzhuzhi.script_id = 002088
odali_yuzhuzhi.g_Key = {["mis"] = 100, ["itm"] = 101, ["do"] = 102}

odali_yuzhuzhi.g_MisItemList = {
    40004000,
    40004451,
    40004452,
    40004461,
    40004453,
    40004456,
    40004459,
    40004458,
    40004455,
    40004457,
    30505062,
    40004465,
    40004462,
    40004463,
    40004464
}

function odali_yuzhuzhi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我是奉大理国皇帝陛下之命，在此帮助天下英雄清理任务的。如果您想删除任务列表中所有的任务，或者删除某个特定任务道具，都可以来找我帮忙。您想做什么呢？")
    self:AddNumText("我想删除所有的任务", -1, self.g_Key["mis"])
    self:AddNumText("我想删除任务道具", -1, self.g_Key["itm"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_yuzhuzhi:CheckCanDelMission_OverTime(selfId, targetId, eventId)
    local DayTime = self:GetDayTime()
    local LastTime = self:GetMissionData(selfId, define.MD_ENUM.MD_NPC_DELMISSION)
    if DayTime > LastTime then
        self:SetMissionData(selfId, define.MD_ENUM.MD_NPC_DELMISSION, DayTime)
        return 1
    end
    return -1
end

function odali_yuzhuzhi:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    if key == self.g_Key["mis"] then
        if not self:GetMissionCount(selfId) then
            self:BeginEvent(self.script_id)
            self:AddText("  你的身上根本没有任务啊！")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("  删除任务将会删除身上所有的任务，是否确认要删除？")
            self:AddNumText("确认", -1, self.g_Key["do"])
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif key == self.g_Key["itm"] then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 42)
    elseif key == self.g_Key["do"] then
        if self:IsHaveMission(selfId, 1258) then
            self:DelItem(selfId, 40004454, 1)
        end
        self:DelAllMission(selfId)
        for i, nItemId in pairs(self.g_MisItemList) do
            local nItemCount = self:GetItemCount(selfId, nItemId)
            if nItemCount > 0 then
                self:DelItem(selfId, nItemId, nItemCount)
            end
        end
        self:notify_tips(selfId, "删除所有任务成功！")
        self:BeginEvent(self.script_id)
        self:AddText("  删除所有任务成功！")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function odali_yuzhuzhi:OnDestroy(selfId, posItem)
    if posItem < 0 then
        return
    end
    self:EraseItem(selfId, posItem)
end

return odali_yuzhuzhi
