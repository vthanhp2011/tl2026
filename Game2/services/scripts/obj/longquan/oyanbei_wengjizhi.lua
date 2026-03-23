local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyanbei_wengjizhi = class("oyanbei_wengjizhi", script_base)
oyanbei_wengjizhi.script_id = 031003
oyanbei_wengjizhi.g_eventList = {212119}
function oyanbei_wengjizhi:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  以前年少不懂事，以为只要喜欢就可以去争取，却不曾想铸下大错。#r  二哥为了成全我出家为僧，阿青为了二哥终身不嫁，我，我，我真是个罪人啊！")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oyanbei_wengjizhi:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oyanbei_wengjizhi:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oyanbei_wengjizhi:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oyanbei_wengjizhi:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oyanbei_wengjizhi:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oyanbei_wengjizhi:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oyanbei_wengjizhi:OnDie(selfId, killerId) end

return oyanbei_wengjizhi
