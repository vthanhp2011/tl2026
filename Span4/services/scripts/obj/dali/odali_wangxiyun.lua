local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_jianning = class("odali_jianning", script_base)
odali_jianning.script_id = 002094
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
        self:AddText("#{OBJ_dali_0056}")
    elseif Menpai == 10 then
        self:AddText("  " .. PlayerSex .. "，你的武功进步好快啊。#r#r  我曼陀山庄真是长江后浪推前浪，人才辈出啊。#r#r  呵呵，看来我是真的老了。")
    else
        self:AddText("#{MPXR_220623_05}")
    end
    if self:GetLevel(selfId) >= 10 then
        self:AddNumText("去曼陀山庄看看", 9, 0)
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
            self:CallScriptFunction((400900), "TransferFunc", selfId, 184, 139, 162)
        end
    elseif index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MPXR_220623_30}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{OBJ_mantuo_0002}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MPXR_220623_48}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 13 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MPXR_220623_43}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 14 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MPXR_220623_36}")
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
