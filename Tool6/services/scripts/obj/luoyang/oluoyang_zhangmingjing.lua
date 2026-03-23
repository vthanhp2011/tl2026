local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zhangmingjing = class("oluoyang_zhangmingjing", script_base)
oluoyang_zhangmingjing.script_id = 000108
oluoyang_zhangmingjing.g_eventList = {713503, 713562, 250502}

function oluoyang_zhangmingjing:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  要想学习和提高练药的技能就经常来我这里看看，想要在江湖中生活下去，一些必备良药是必不可少的。")
    self:AddText(
        "  点击学习制药，你就能够自己做些应急的药品了，多做些尝试，你可以发现更多炼制丹药的方法。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:AddNumText("制药介绍", 11, 100)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_zhangmingjing:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_zhangmingjing:OnEventRequest(selfId, targetId, arg, index)
    if index == 100 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_007}")
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

function oluoyang_zhangmingjing:OnMissionAccept(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            ret =
                self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function oluoyang_zhangmingjing:OnMissionRefuse(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_zhangmingjing:OnMissionContinue(selfId, targetId,
                                                  missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_zhangmingjing:OnMissionSubmit(selfId, targetId,
                                                missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_zhangmingjing:OnDie(selfId, killerId) end

return oluoyang_zhangmingjing
