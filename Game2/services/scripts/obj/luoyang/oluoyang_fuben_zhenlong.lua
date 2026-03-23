local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_fuben_zhenlong = class("oluoyang_fuben_zhenlong", script_base)
oluoyang_fuben_zhenlong.script_id = 000090
oluoyang_fuben_zhenlong.g_eventList = {401001,1018702,1018703,1018704,1018705}

function oluoyang_fuben_zhenlong:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddNumText("棋局介绍", 11, 10)
    self:AddNumText("如何在刷棋中获得更多的经验", 11, 519)
    for i, findId in pairs(self.g_eventList) do
        self:CallScriptFunction(self.g_eventList[i], "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_fuben_zhenlong:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_fuben_zhenlong:OnEventRequest(selfId, targetId, arg, index)
    if index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_063}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 519 then
        self:BeginEvent(self.script_id)
        self:AddText("#{QJ_20080522_03}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local NumText = index
    if NumText == 20 then
        self:CheckCanEnterRest(selfId, targetId, 418, 32, 16)
        return
    elseif NumText == 21 then
        self:CheckCanEnterRest(selfId, targetId, 419, 32, 16)
        return
    elseif NumText == 22 then
        self:CheckCanEnterRest(selfId, targetId, 518, 32, 16)
        return
    elseif NumText == 23 then
        self:CheckCanEnterRest(selfId, targetId, 193, 32, 16)
        return
    elseif NumText == 30 then
        self:BeginEvent(self.script_id)
        self:AddText("#{QJXXS_1105_1}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif NumText == 31 then
        self:BeginEvent(self.script_id)
        self:AddText("#{QJXXS_1105_2}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif NumText == 32 then
        self:BeginEvent(self.script_id)
        self:AddText("#{QJXXS_1105_3}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end

function oluoyang_fuben_zhenlong:OnDie(selfId, killerId) end

function oluoyang_fuben_zhenlong:CheckCanEnterRest(selfId, targetId, s, x, y)
    if self:LuaFnHasTeam(selfId) then
        if not self:LuaFnIsTeamLeader(selfId) then
            self:BeginEvent(self.script_id)
            self:AddText("  只有队长才能带领队友进入休息室。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local teamMemberCount = self:GetTeamMemberCount(selfId)
        local nearMemberCount = self:GetNearTeamCount(selfId)
        if teamMemberCount ~= nearMemberCount then
            self:BeginEvent(self.script_id)
            self:AddText("  你的队伍中有人不在附近。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local memId
        for i = 1, nearMemberCount do
            memId = self:GetNearTeamMember(selfId, i)
            self:NewWorld(memId, s, nil, x, y)
        end
    else
        self:CallScriptFunction((400900), "TransferFunc", selfId, s, x, y)
    end
end

function oluoyang_fuben_zhenlong:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept",selfId, targetId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,targetId, missionScriptId)
            end
            return
        end
    end
end

function oluoyang_fuben_zhenlong:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:OnDefaultEvent(selfId, targetId)
            return
        end
    end
end

function oluoyang_fuben_zhenlong:OnMissionContinue(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,targetId)
            return
        end
    end
end

function oluoyang_fuben_zhenlong:OnMissionSubmit(selfId, targetId, missionScriptId,selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,targetId, selectRadioId)
            return
        end
    end
end
return oluoyang_fuben_zhenlong
