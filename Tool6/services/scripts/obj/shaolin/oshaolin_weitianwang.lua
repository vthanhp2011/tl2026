local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_weitianwang = class("oshaolin_weitianwang", script_base)
oshaolin_weitianwang.g_MissionId = 1060
oshaolin_weitianwang.script_id = 009017
function oshaolin_weitianwang:OnDefaultEvent(selfId, targetId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:BeginEvent(self.script_id)
    self:AddText("  最近总感觉诸事不爽。")
    if self:IsHaveMission(selfId, self.g_MissionId) then
        if self:GetMissionParam(selfId, misIndex, 0) < 1 and self:GetMissionParam(selfId, misIndex, 3) == 3 then
            self:AddNumText("给你小佛舍利", 8, 0)
        end
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshaolin_weitianwang:OnEventRequest(selfId, targetId, arg, index)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    if index == 0 then
        if self:HaveItemInBag(selfId, 30202049) then
            self:DelItem(selfId, 30202049, 1)
            self:SetMissionByIndex(selfId, misIndex, 0, 1)
            self:BeginEvent(self.script_id)
            self:AddText("谢谢你的小佛舍利")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            self:BeginEvent(self.script_id)
            self:AddText("任务完成！")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("佛光舍利？在哪里？")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    end
end

return oshaolin_weitianwang
