local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oerhai_shaning = class("oerhai_shaning", script_base)
oerhai_shaning.script_id = 024004
oerhai_shaning.g_eventList = { 1030111, 1010111 }
function oerhai_shaning:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我是个孤儿，从来没有见过阿爸和阿妈，是叔叔把我从小抚养长大的，叔叔对我就象亲生儿子一样，我一定要找到他。#r  我曾经在叔叔的卧房里见过一个姑姑的画像，那个姑姑好漂亮啊，叔叔每次喝醉了就会一直看着那幅画像，一直看。#r  叔叔会不会去找那个姑姑了？")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oerhai_shaning:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oerhai_shaning:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oerhai_shaning:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oerhai_shaning:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oerhai_shaning:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oerhai_shaning:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oerhai_shaning:OnDie(selfId, killerId) end

return oerhai_shaning
