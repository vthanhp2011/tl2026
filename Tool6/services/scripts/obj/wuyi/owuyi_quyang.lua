local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owuyi_quyang = class("owuyi_quyang", script_base)
owuyi_quyang.script_id = 032001
owuyi_quyang.g_eventList = {212123}
function owuyi_quyang:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  山越族的姐妹们都很优秀。#r  紫薇温柔善良，讨人喜欢。水仙清静雅致，沉稳聪颖，而芙蓉姐姐……")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function owuyi_quyang:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function owuyi_quyang:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function owuyi_quyang:OnMissionAccept(selfId, targetId, missionScriptId)
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

function owuyi_quyang:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function owuyi_quyang:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function owuyi_quyang:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,  targetId, selectRadioId)
            return
        end
    end
end

function owuyi_quyang:OnDie(selfId, killerId) end

return owuyi_quyang
