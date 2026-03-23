local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ocangshan_shashang = class("ocangshan_shashang", script_base)
ocangshan_shashang.script_id = 025002
ocangshan_shashang.g_eventList = {}
function ocangshan_shashang:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  这里是苍山的观月亭，前面就是洱海，每当月夜，洱海风停水静，皎洁的月色溶入湖面，犹如万点星光，泛起万顷银波。#r  对面的山崖是望雪崖，从那山崖上可以看到点苍山峰白雪皑皑，素裹银装，在阳光照耀下，洁白晶莹。#r  可是这麽美丽的景色现在已经没有人敢来观赏了……")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ocangshan_shashang:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ocangshan_shashang:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ocangshan_shashang:OnMissionAccept(selfId, targetId, missionScriptId)
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

function ocangshan_shashang:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ocangshan_shashang:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ocangshan_shashang:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ocangshan_shashang:OnDie(selfId, killerId) end

return ocangshan_shashang
