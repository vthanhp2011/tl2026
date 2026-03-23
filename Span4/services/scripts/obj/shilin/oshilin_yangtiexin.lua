local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshilin_yangtiexin = class("oshilin_yangtiexin", script_base)
oshilin_yangtiexin.script_id = 026007
oshilin_yangtiexin.g_eventList = {212124}
function oshilin_yangtiexin:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    不要怕，我不会伤害你的。不过，你也要承诺不伤害我……")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshilin_yangtiexin:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oshilin_yangtiexin:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oshilin_yangtiexin:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oshilin_yangtiexin:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oshilin_yangtiexin:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oshilin_yangtiexin:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oshilin_yangtiexin:OnDie(selfId, killerId) end

return oshilin_yangtiexin
