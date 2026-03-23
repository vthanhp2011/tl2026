local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxingxiu_zhikeshi = class("oxingxiu_zhikeshi", script_base)
oxingxiu_zhikeshi.script_id = 016034
oxingxiu_zhikeshi.g_eventList = {500067}

function oxingxiu_zhikeshi:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:AddText("我来为你指路。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxingxiu_zhikeshi:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oxingxiu_zhikeshi:OnEventRequest(selfId, targetId, arg, index)
    self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
    return
end

function oxingxiu_zhikeshi:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function oxingxiu_zhikeshi:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oxingxiu_zhikeshi:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oxingxiu_zhikeshi:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oxingxiu_zhikeshi:OnDie(selfId, killerId)
end

return oxingxiu_zhikeshi
