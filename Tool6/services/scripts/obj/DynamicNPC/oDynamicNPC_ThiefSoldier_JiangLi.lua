local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oDynamicNPC_ThiefSoldier_JiangLi = class(
                                             "oDynamicNPC_ThiefSoldier_JiangLi",
                                             script_base)
oDynamicNPC_ThiefSoldier_JiangLi.script_id = 050014
oDynamicNPC_ThiefSoldier_JiangLi.g_EventList = {050015}

oDynamicNPC_ThiefSoldier_JiangLi.g_minLevel = 20
function oDynamicNPC_ThiefSoldier_JiangLi:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "如今天下动乱，贼兵四起，朝廷为了迅速平息混乱，特号召各位帮助平叛。平叛有功者，将给予一定的称号奖励。")
    self:CallScriptFunction(self.g_EventList[1], "OnEnumerate", self, selfId, targetId)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oDynamicNPC_ThiefSoldier_JiangLi:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oDynamicNPC_ThiefSoldier_JiangLi:OnEventRequest(selfId, targetId, arg,
                                                         index)
    for i, findId in pairs(self.g_EventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
end

function oDynamicNPC_ThiefSoldier_JiangLi:OnMissionAccept(selfId, targetId,
                                                          missionScriptId)
    for i, findId in pairs(self.g_EventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            return
        end
    end
end

function oDynamicNPC_ThiefSoldier_JiangLi:OnMissionRefuse(selfId, targetId,
                                                          missionScriptId)
    for i, findId in pairs(self.g_EventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oDynamicNPC_ThiefSoldier_JiangLi:OnMissionContinue(selfId, targetId,
                                                            missionScriptId)
    for i, findId in pairs(self.g_EventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oDynamicNPC_ThiefSoldier_JiangLi:OnMissionSubmit(selfId, targetId,
                                                          missionScriptId,
                                                          selectRadioId)
    for i, findId in pairs(self.g_EventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oDynamicNPC_ThiefSoldier_JiangLi:OnDie(selfId, killerId) end

return oDynamicNPC_ThiefSoldier_JiangLi
