local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odunhuang_zhoudexing = class("odunhuang_zhoudexing", script_base)

odunhuang_zhoudexing.g_eventList = { 1010236, 1010237 }

function odunhuang_zhoudexing:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText( "  不要和我说废话，老老实实完成你的试炼吧。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odunhuang_zhoudexing:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odunhuang_zhoudexing:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function odunhuang_zhoudexing:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,targetId)
            end
            return
        end
    end
end

function odunhuang_zhoudexing:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odunhuang_zhoudexing:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odunhuang_zhoudexing:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odunhuang_zhoudexing:OnDie(selfId, killerId) end

return odunhuang_zhoudexing
