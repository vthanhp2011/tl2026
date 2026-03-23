local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_yanbaicao = class("oluoyang_yanbaicao", script_base)
oluoyang_yanbaicao.script_id = 000103
oluoyang_yanbaicao.g_shoptableindex = 73
oluoyang_yanbaicao.g_eventList = {713509, 713568, 250501}

function oluoyang_yanbaicao:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  想学习和提高采药技能就经常来我这里看看，要得到更多稀有的药草，目前这样是不行的。")
    self:AddText(
        "  采药镰是每个草药人必备的物品，等你收集了足够的药草，就知道该从什么地方去找到他们了。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:AddNumText("购买工具", 7, define.ABILITY_TEACHER_SHOP)
    self:AddNumText("采药介绍", 11, 100)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_yanbaicao:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_yanbaicao:OnEventRequest(selfId, targetId, arg, index)
    if index == 100 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_006}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == define.ABILITY_TEACHER_SHOP then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,
                                    index, self.script_id)
            return
        end
    end
end

function oluoyang_yanbaicao:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oluoyang_yanbaicao:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_yanbaicao:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_yanbaicao:OnMissionSubmit(selfId, targetId, missionScriptId,
                                            selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_yanbaicao:OnDie(selfId, killerId) end

return oluoyang_yanbaicao
