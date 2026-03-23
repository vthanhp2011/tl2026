local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_lidazui = class("oluoyang_lidazui", script_base)
oluoyang_lidazui.script_id = 000107
oluoyang_lidazui.g_eventList = {713561, 250505}

function oluoyang_lidazui:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  要想学习和提高烹饪的技能就经常来我这里看看，只有不断的练习，你的烹饪技能熟练度才能提高了。")
    self:AddText(
        "  点击升级烹饪技能，你就能够学习到更高级别的烹饪技术了。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:AddNumText("烹饪介绍", 11, 100)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_lidazui:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_lidazui:OnEventRequest(selfId, targetId, arg, index)
    if index == 100 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_001}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,
                                    index, self.script_id)
            return
        end
    end
end

function oluoyang_lidazui:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oluoyang_lidazui:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_lidazui:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_lidazui:OnMissionSubmit(selfId, targetId, missionScriptId,
                                          selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_lidazui:OnDie(selfId, killerId) end

return oluoyang_lidazui
