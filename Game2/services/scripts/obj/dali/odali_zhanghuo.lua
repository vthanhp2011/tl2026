local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_zhanghuo = class("odali_zhanghuo", script_base)
odali_zhanghuo.script_id = 002041
odali_zhanghuo.g_eventList = {210209, 210287}

function odali_zhanghuo:UpdateEventList(selfId, targetId)
    local Menpai = self:LuaFnGetMenPai(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "师妹"
    else
        PlayerSex = "师弟"
    end
    self:BeginEvent(self.script_id)
    if Menpai == 9 then
        self:AddText("#{OBJ_dali_0020}")
    elseif Menpai == 3 then
        self:AddText("  " .. PlayerSex .. "，你的武功进步好快啊。#r#r  看来真人教你不遗余力，恭喜恭喜。")
    else
        self:AddText("  好久没有见到你了，以你这样的天资，真可惜没有在武当以正道修行，打好基础。")
    end
    if self:GetLevel(selfId) >= 10 then
        self:AddNumText("去武当山看看", 9, 0)
    end
    local misIndex = self:GetMissionIndexByID(selfId, 1060)
    if self:IsHaveMission(selfId, 1060) then
        if self:GetMissionParam(selfId, misIndex, 0) < 1 and self:GetMissionParam(selfId, misIndex, 2) == 3 then
            self:AddNumText("这是我师兄给你的信", 4, 1)
        end
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_zhanghuo:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_zhanghuo:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:IsHaveMission(selfId, 4021) then
            self:BeginEvent(self.script_id)
            self:AddText("你有漕运货舱在身，我们驿站不能为你提供传送服务。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 12, 93, 182)
        end
    elseif index == 1 then
        local misIndex = self:GetMissionIndexByID(selfId, 1060)
        self:DelItem(selfId, 40002115, 1)
        self:SetMissionByIndex(selfId, misIndex, 0, 1)
        self:BeginEvent(self.script_id)
        self:AddText("请回去告诉慧方师兄，他的信我已经收到了，谢谢你")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        self:BeginEvent(self.script_id)
        self:AddText("任务完成！")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    elseif index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_wudang_1}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_wudang_2}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_wudang_3}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 13 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_wudang_4}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 14 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XSRW_200909_26}")
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

function odali_zhanghuo:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odali_zhanghuo:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_zhanghuo:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_zhanghuo:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_zhanghuo:OnDie(selfId, killerId)
end

return odali_zhanghuo
