local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_diwenyuan = class("oluoyang_diwenyuan", script_base)
oluoyang_diwenyuan.script_id = 000083
oluoyang_diwenyuan.g_missionName = "更改阵营"
oluoyang_diwenyuan.g_eventList = {250503}

function oluoyang_diwenyuan:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText(
        "  比武场上，生死由命，签了这生死状，就不能反悔了，你可考虑清楚了！")
    if self:GetCurCamp(selfId) == 1 then
        self:AddNumText("回复初始阵营", 6, 0)
    else
        self:AddNumText("设置PK阵营", 6, 1)
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_diwenyuan:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_diwenyuan:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:SetCurCamp(selfId, 0)
        self:BeginEvent(self.script_id)
        self:AddText("你已经回复到初始阵营。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    elseif index == 1 then
        self:SetCurCamp(selfId, 1)
        self:BeginEvent(self.script_id)
        self:AddText("你已经设置为PK阵营。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
end

function oluoyang_diwenyuan:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret =
                self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function oluoyang_diwenyuan:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_diwenyuan:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_diwenyuan:OnMissionSubmit(selfId, targetId, missionScriptId,
                                            selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_diwenyuan:OnDie(selfId, killerId) end

return oluoyang_diwenyuan
