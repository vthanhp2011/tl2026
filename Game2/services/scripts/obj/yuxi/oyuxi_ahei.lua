local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyuxi_ahei = class("oyuxi_ahei", script_base)
oyuxi_ahei.script_id = 027004
oyuxi_ahei.g_eventList = {212111}
function oyuxi_ahei:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  为什麽从小青梅竹马，长大后就一定要在一起呢？#r  我很难理解，为什麽大家都这样以为……是的，我是应该救出阿诗玛，她是我最好的朋友，但是……#r  为什麽？为什麽？为什麽连阿依娜都觉得我和阿诗玛是金童玉女呢？")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oyuxi_ahei:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oyuxi_ahei:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oyuxi_ahei:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oyuxi_ahei:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oyuxi_ahei:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if 212111 == findId then
            self:CallScriptFunction(212111, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oyuxi_ahei:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if 212111 == findId then
            self:CallScriptFunction(212111, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oyuxi_ahei:OnDie(selfId, killerId) end

return oyuxi_ahei
