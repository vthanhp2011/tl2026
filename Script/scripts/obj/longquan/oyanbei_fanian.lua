local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyanbei_fanian = class("oyanbei_fanian", script_base)
oyanbei_fanian.script_id = 031004
oyanbei_fanian.g_eventList = {212119}
function oyanbei_fanian:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  爱欲于人，犹如执炬逆风而行，必有烧手之患。 #r  由爱故生忧，由爱故生怖，若离与爱，何忧何怖…… #r  施主你可明白？")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oyanbei_fanian:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oyanbei_fanian:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oyanbei_fanian:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oyanbei_fanian:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oyanbei_fanian:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oyanbei_fanian:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oyanbei_fanian:OnDie(selfId, killerId) end

return oyanbei_fanian
