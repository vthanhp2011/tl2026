local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_wuciren = class("oluoyang_wuciren", script_base)
oluoyang_wuciren.script_id = 000149
oluoyang_wuciren.g_eventList = {500600,1018701}

function oluoyang_wuciren:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  在家靠父母，出门靠朋友。行走江湖个人修为自然重要，但有几个关系亲密的朋友却是必不可少的。或是志趣相投的好友，或是义结金兰的兄弟，或是同门同派的熟人。莫大的江湖，你总能找到几个可以携手同游、共同进退的知己。刀剑齐鸣，共赴江湖恩仇，岂非人生第一大快事！")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_wuciren:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end

function oluoyang_wuciren:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept",
                                          selfId, targetId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,
                                        targetId, missionScriptId)
            end
            return
        end
    end
end

function oluoyang_wuciren:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:OnDefaultEvent(selfId, targetId)
            return
        end
    end
end

function oluoyang_wuciren:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_wuciren:OnMissionSubmit(selfId, targetId, missionScriptId,
                                          selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_wuciren:OnDie(selfId, killerId) end

return oluoyang_wuciren
