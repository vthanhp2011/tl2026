local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ochangbai_wanyanyingge = class("ochangbai_wanyanyingge", script_base)
ochangbai_wanyanyingge.script_id = 022002
ochangbai_wanyanyingge.g_eventList = {}
function ochangbai_wanyanyingge:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  现在辽国在北方的势力这麽大，我们怎麽可以和他们硬碰硬呢？凡事都要从长计议啊……")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ochangbai_wanyanyingge:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ochangbai_wanyanyingge:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ochangbai_wanyanyingge:OnMissionAccept(selfId, targetId, missionScriptId)
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

function ochangbai_wanyanyingge:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanyingge:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanyingge:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ochangbai_wanyanyingge:OnDie(selfId, killerId) end

return ochangbai_wanyanyingge
