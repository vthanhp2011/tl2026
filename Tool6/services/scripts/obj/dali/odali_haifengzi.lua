local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_haifengzi = class("odali_haifengzi", script_base)
odali_haifengzi.script_id = 002043
odali_haifengzi.g_eventList = {210209, 210287}

function odali_haifengzi:UpdateEventList(selfId, targetId)
    local Menpai = self:LuaFnGetMenPai(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "师妹"
    else
        PlayerSex = "师弟"
    end
    self:BeginEvent(self.script_id)
    if Menpai == 9 then
        self:AddText("#{OBJ_dali_0022}")
    elseif Menpai == 5 then
        self:AddText("  " .. PlayerSex .. "，你的武功进步好快啊。#r#r  我也很想回到星宿海，享受专心修行的日子。")
    else
        self:AddText("  好久没有见到你了，以你这样的天资，可惜不在我星宿，终究是没有前途。")
    end
    if self:GetLevel(selfId) >= 10 then
        self:AddNumText("去星宿海看看", 9, 0)
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_haifengzi:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_haifengzi:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:IsHaveMission(selfId, 4021) then
            self:BeginEvent(self.script_id)
            self:AddText("你有漕运货舱在身，我们驿站不能为你提供传送服务。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 16, 96, 147)
        end
    elseif index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_xingxiu_1}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_xingxiu_2}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_xingxiu_3}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 13 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_xingxiu_4}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 14 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XSRW_200909_11}")
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

function odali_haifengzi:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odali_haifengzi:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_haifengzi:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_haifengzi:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_haifengzi:OnDie(selfId, killerId)
end

return odali_haifengzi
