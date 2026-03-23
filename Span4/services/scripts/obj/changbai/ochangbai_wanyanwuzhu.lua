local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ochangbai_wanyanwuzhu = class("ochangbai_wanyanwuzhu", script_base)
ochangbai_wanyanwuzhu.script_id = 022003
ochangbai_wanyanwuzhu.g_eventList = {212110}
function ochangbai_wanyanwuzhu:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  英勇、伟大、善良、热血的大英雄！你又来完颜部了啊，快坐下喝杯羊奶吧。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ochangbai_wanyanwuzhu:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ochangbai_wanyanwuzhu:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ochangbai_wanyanwuzhu:OnMissionAccept(selfId, targetId, missionScriptId)
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

function ochangbai_wanyanwuzhu:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanwuzhu:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ochangbai_wanyanwuzhu:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ochangbai_wanyanwuzhu:OnDie(selfId, killerId) end

return ochangbai_wanyanwuzhu
