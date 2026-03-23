local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_xiahouren = class("oluoyang_xiahouren", script_base)
oluoyang_xiahouren.script_id = 000144
oluoyang_xiahouren.g_eventList = {125020,1018726}

function oluoyang_xiahouren:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  #G$N#W英雄！来嵩山封禅台竞技场展示一下你的实力吧！#r  #G你在进入封禅台之前必须加入一支队伍，这支队伍中的所有人在进入封禅台后都和你属于同一个阵营，除了他们以外，在封禅台上的其他所有人都是你的对手。#W #r  怎么样，想来试试看吗？")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_xiahouren:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_xiahouren:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end

function oluoyang_xiahouren:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret =
                self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function oluoyang_xiahouren:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_xiahouren:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_xiahouren:OnMissionSubmit(selfId, targetId, missionScriptId,
                                            selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_xiahouren:OnDie(selfId, killerId) end

return oluoyang_xiahouren
