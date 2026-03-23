local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_shibing = class("osuzhou_shibing", script_base)
osuzhou_shibing.script_id = 001054
osuzhou_shibing.g_eventList = {500020}

function osuzhou_shibing:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:AddText("  " .. PlayerName .. PlayerSex .. "，为了大宋朝的安危，为了亲人们能够安心的生活,我们每天都认真操练。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_shibing:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function osuzhou_shibing:OnEventRequest(selfId, targetId, arg, index)
    self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, index)
    return
end

function osuzhou_shibing:OnMissionAccept(selfId, targetId, missionScriptId)
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

function osuzhou_shibing:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function osuzhou_shibing:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function osuzhou_shibing:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function osuzhou_shibing:OnDie(selfId, killerId)
end

return osuzhou_shibing
