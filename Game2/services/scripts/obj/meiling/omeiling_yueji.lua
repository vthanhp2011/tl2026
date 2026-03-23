local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_yueji = class("omeiling_yueji", script_base)
omeiling_yueji.script_id = 033009
omeiling_yueji.g_eventList = {212113}
function omeiling_yueji:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  最近太阳花姐姐总是莫明其妙的发脾气，好奇怪啊！也不知道紫薇妹妹那边有没有什麽事情，好久没她们的消息了。#r  也不知道荆棘在做什麽，这几天感觉很压抑，像是要有什麽事情发生似的。唉，可能是我又多心了吧。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function omeiling_yueji:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function omeiling_yueji:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function omeiling_yueji:OnMissionAccept(selfId, targetId, missionScriptId)
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

function omeiling_yueji:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function omeiling_yueji:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function omeiling_yueji:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function omeiling_yueji:OnDie(selfId, killerId) end

return omeiling_yueji
