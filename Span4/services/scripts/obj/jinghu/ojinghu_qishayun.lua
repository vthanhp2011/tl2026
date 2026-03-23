local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oJingHu_Qishayun = class("oJingHu_Qishayun", script_base)
oJingHu_Qishayun.script_id = 005113
oJingHu_Qishayun.g_eventList = {402030}

function oJingHu_Qishayun:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我从朝廷哪里接下来了剿灭镜湖水贼的任务，特招募天下各帮派的有志之士进行剿匪。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oJingHu_Qishayun:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oJingHu_Qishayun:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oJingHu_Qishayun:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oJingHu_Qishayun:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oJingHu_Qishayun:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oJingHu_Qishayun:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oJingHu_Qishayun:OnDie(selfId, killerId)
end

return oJingHu_Qishayun
