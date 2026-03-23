local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ochangbai_wanyanhelibo = class("ochangbai_wanyanhelibo", script_base)
ochangbai_wanyanhelibo.script_id = 022008
ochangbai_wanyanhelibo.g_eventList = {}
function ochangbai_wanyanhelibo:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  特使大人，完颜部落进贡的皮子都是最好的，比纥石烈部落的好多了。另外这些上等虎骨是给特使大人的，请您在大王面前多多美言，说完颜部落永远是辽国最忠诚的属国。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ochangbai_wanyanhelibo:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ochangbai_wanyanhelibo:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ochangbai_wanyanhelibo:OnMissionAccept(selfId, targetId, missionScriptId)
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

function ochangbai_wanyanhelibo:OnMissionRefuse(selfId, targetId,missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanhelibo:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanhelibo:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ochangbai_wanyanhelibo:OnDie(selfId, killerId) end

return ochangbai_wanyanhelibo
