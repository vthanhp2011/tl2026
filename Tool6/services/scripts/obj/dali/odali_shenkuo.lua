local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_shenkuo = class("odali_shenkuo", script_base)
odali_shenkuo.script_id = 002001
odali_shenkuo.g_eventList = {212128, 212131}

function odali_shenkuo:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  大理国有很多植物和矿藏极为罕见，也不枉我从汴京千里迢迢而来，真是不虚此行啊。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    if (self:IsMissionHaveDone(selfId, 253)) then
        self:AddNumText("领取称号", 6, 999)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_shenkuo:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_shenkuo:OnEventRequest(selfId, targetId, arg, index)
    if index == 999 then
        self:LuaFnAwardTitle(selfId, 9, 302)
        self:SetCurTitle(selfId, 9, 302)
        self:LuaFnAddNewAgname(selfId, 9, 302)
        self:LuaFnDispatchAllTitle(selfId)
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function odali_shenkuo:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odali_shenkuo:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_shenkuo:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_shenkuo:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_shenkuo:OnDie(selfId, killerId)
end

return odali_shenkuo
