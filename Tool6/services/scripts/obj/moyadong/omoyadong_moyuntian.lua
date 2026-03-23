local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omoyadong_moyuntian = class("omoyadong_moyuntian", script_base)
omoyadong_moyuntian.g_eventList = {1018706}
function omoyadong_moyuntian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  这摩崖洞乃是秦家寨匪聚集之所，如果功力不够，最好多找几个同伴一同进入比较安全。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end
function omoyadong_moyuntian:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end

function omoyadong_moyuntian:OnMissionAccept(selfId, targetId, missionScriptId)
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

function omoyadong_moyuntian:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:OnDefaultEvent(selfId, targetId)
            return
        end
    end
end

function omoyadong_moyuntian:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function omoyadong_moyuntian:OnMissionSubmit(selfId, targetId, missionScriptId,
                                          selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function omoyadong_moyuntian:OnDie(selfId, killerId) 
end

return omoyadong_moyuntian
