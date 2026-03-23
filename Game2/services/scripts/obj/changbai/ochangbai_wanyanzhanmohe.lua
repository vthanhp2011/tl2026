local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ochangbai_wanyanzhanmohe = class("ochangbai_wanyanzhanmohe", script_base)
ochangbai_wanyanzhanmohe.script_id = 022004
ochangbai_wanyanzhanmohe.g_eventList = {212110}
function ochangbai_wanyanzhanmohe:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  兀术这小子，居然会把那麽重要的东西弄丢，我以前一直以为他很聪明呢，看来和我也差不多啊。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ochangbai_wanyanzhanmohe:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ochangbai_wanyanzhanmohe:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ochangbai_wanyanzhanmohe:OnMissionAccept(selfId, targetId, missionScriptId)
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

function ochangbai_wanyanzhanmohe:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanzhanmohe:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanzhanmohe:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ochangbai_wanyanzhanmohe:OnDie(selfId, killerId) end

return ochangbai_wanyanzhanmohe
