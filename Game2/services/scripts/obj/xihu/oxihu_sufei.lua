local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxihu_sufei = class("oxihu_sufei", script_base)
oxihu_sufei.script_id = 030003
oxihu_sufei.g_eventList = {
    212100, 808095, 808096, 808097, 808094, 1010233, 1010040, 1010041, 1010042, 1030040, 1030041, 1030042, 1010235,
    1018800, 1018730, 1018740, 1018750, 1018760, 1018770, 1018780, 1018790, 1018810
}
function oxihu_sufei:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  我们#R水鬼#W虽然不是人类，但是我们和人类一样有自己的思想有自己的生活，我们并不是凶猛好战的种族。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxihu_sufei:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oxihu_sufei:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oxihu_sufei:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oxihu_sufei:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oxihu_sufei:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oxihu_sufei:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oxihu_sufei:OnDie(selfId, killerId) end

return oxihu_sufei
