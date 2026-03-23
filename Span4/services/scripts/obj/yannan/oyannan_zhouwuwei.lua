local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyannan_zhouwuwei = class("oyannan_zhouwuwei", script_base)
oyannan_zhouwuwei.script_id = 018005
oyannan_zhouwuwei.g_eventList = {808103, 808104, 808105, 808094}
function oyannan_zhouwuwei:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  雁门关防务现在主要分为三部分：种世衡大帅负责对付雁门关以南的秦家寨盗匪；曲端副帅负责对付雁门关以北的辽兵；马承倩监军负责监督二位元帅的工作。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oyannan_zhouwuwei:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oyannan_zhouwuwei:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
end

function oyannan_zhouwuwei:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId, targetId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId, targetId, missionScriptId)
            end
            return
        end
    end
end

function oyannan_zhouwuwei:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oyannan_zhouwuwei:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oyannan_zhouwuwei:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oyannan_zhouwuwei:OnDie(selfId, killerId) end

return oyannan_zhouwuwei
