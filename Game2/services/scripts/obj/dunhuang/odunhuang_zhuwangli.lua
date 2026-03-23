local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odunhuang_zhuwangli = class("odunhuang_zhuwangli", script_base)
odunhuang_zhuwangli.g_eventList = { 1010021, 1010022, 1010023, 1009400, 1010322 }
function odunhuang_zhuwangli:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  好久不见了，身为一个汉人，我知道自己现在的处境有多麽尴尬。但是这麽多的汉人弟兄，我要保护他们啊！是非对错……谁又能说的明白呢？！")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odunhuang_zhuwangli:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odunhuang_zhuwangli:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function odunhuang_zhuwangli:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odunhuang_zhuwangli:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odunhuang_zhuwangli:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odunhuang_zhuwangli:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odunhuang_zhuwangli:OnDie(selfId, killerId) end

return odunhuang_zhuwangli
