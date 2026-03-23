local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ochangbai_wanyaneguda = class("ochangbai_wanyaneguda", script_base)
ochangbai_wanyaneguda.script_id = 022001
ochangbai_wanyaneguda.g_eventList = {}
function ochangbai_wanyaneguda:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  辽国人都传说，女真兵不可满一万，满一万则天下无敌。完颜部一定要统一女真，率领一万铁骑，推翻辽国的统治。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ochangbai_wanyaneguda:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ochangbai_wanyaneguda:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ochangbai_wanyaneguda:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId, targetId)
            end
            return
        end
    end
end

function ochangbai_wanyaneguda:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyaneguda:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyaneguda:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ochangbai_wanyaneguda:OnDie(selfId, killerId) end

return ochangbai_wanyaneguda
