local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_jianning = class("odali_jianning", script_base)
odali_jianning.script_id = 002095
odali_jianning.g_eventList = {210209}

function odali_jianning:UpdateEventList(selfId, targetId)
    local Menpai = self:LuaFnGetMenPai(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "丫头"
    else
        PlayerSex = "兄弟"
    end
    self:BeginEvent(self.script_id)
    if Menpai == 9 then
        self:AddText("#{XKDRZ_240619_01}")
    elseif Menpai == 11 then
        self:AddText("  " .. PlayerSex .. "，许久不见，你的武功又精进不少。怎样，俗话说云雀亦有归巢日，偶尔也回恶人谷露个面吧。")
    else
        self:AddText("#{XKDRZ_240619_05}")
    end
    if self:GetLevel(selfId) >= 10 then
        self:AddNumText("去恶人谷看看", 9, 0)
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_jianning:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_jianning:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:IsHaveMission(selfId, 4021) then
            self:BeginEvent(self.script_id)
            self:AddText("你有漕运货舱在身，我们驿站不能为你提供传送服务。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 1063, 123, 151)
        end
    elseif index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XKDRZ_240619_47}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XKDRZ_240619_48}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XKDRZ_240619_49}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 13 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XKDRZ_240619_50}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 14 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XKDRZ_240626_1}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    else
        for i, findId in pairs(self.g_eventList) do
            if arg == findId then
                self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
                return
            end
        end
    end
end

function odali_jianning:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odali_jianning:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_jianning:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_jianning:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_jianning:OnDie(selfId, killerId)
end

return odali_jianning
