local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odunhuang_caoyanshou = class("odunhuang_caoyanshou", script_base)
odunhuang_caoyanshou.g_eventList = {1010229}
function odunhuang_caoyanshou:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  这#G玉门关#W一向是兵家必争之地，我哥哥这#G敦煌#W太守做的也很不容易啊！")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odunhuang_caoyanshou:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odunhuang_caoyanshou:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function odunhuang_caoyanshou:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odunhuang_caoyanshou:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odunhuang_caoyanshou:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odunhuang_caoyanshou:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odunhuang_caoyanshou:OnDie(selfId, killerId) end

return odunhuang_caoyanshou
