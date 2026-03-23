local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_fuben_shuilao = class("oluoyang_fuben_shuilao", script_base)
oluoyang_fuben_shuilao.script_id = 000090
oluoyang_fuben_shuilao.g_eventList = {231000}

function oluoyang_fuben_shuilao:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  " .. PlayerName .. " ，来吧。")
    for i, findId in pairs(oluoyang_fuben_shuilao.g_eventList) do
        self:CallScriptFunction(oluoyang_fuben_shuilao.g_eventList[i],
                                "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_fuben_shuilao:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  你快去白马寺吧，智清大师一定迫不及待的想见你呢！我这几日公务缠身，等我平定水牢的叛乱之后，一定去白马寺帮助智清大师赈济灾民。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_fuben_shuilao:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(oluoyang_fuben_shuilao.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
end

function oluoyang_fuben_shuilao:OnMissionAccept(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(oluoyang_fuben_shuilao.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            return
        end
    end
end

function oluoyang_fuben_shuilao:OnMissionRefuse(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(oluoyang_fuben_shuilao.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_fuben_shuilao:OnMissionContinue(selfId, targetId,
                                                  missionScriptId)
    for i, findId in pairs(oluoyang_fuben_shuilao.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_fuben_shuilao:OnMissionSubmit(selfId, targetId,
                                                missionScriptId, selectRadioId)
    for i, findId in pairs(oluoyang_fuben_shuilao.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_fuben_shuilao:OnDie(selfId, killerId) end

return oluoyang_fuben_shuilao
