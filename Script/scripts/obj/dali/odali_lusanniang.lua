local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_lusanniang = class("odali_lusanniang", script_base)
odali_lusanniang.script_id = 002042
odali_lusanniang.g_eventList = {210209, 210287}

function odali_lusanniang:UpdateEventList(selfId, targetId)
    local Menpai = self:LuaFnGetMenPai(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "师妹"
    else
        PlayerSex = "师弟"
    end
    self:BeginEvent(self.script_id)
    if Menpai == 9 then
        self:AddText("#{OBJ_dali_0021}")
    elseif Menpai == 4 then
        self:AddText("  " .. PlayerSex .. "，让三娘看看。呵呵，你的武功进步好快，人也愈发俊俏，还是峨嵋山的水养人啊。")
    else
        self:AddText("  好久没有见到你了，以你这样的天资，可惜不在峨嵋修行，终究周身戾气，可叹可惜。")
    end
    if self:GetLevel(selfId) >= 10 then
        self:AddNumText("去峨嵋山看看", 9, 0)
    end
    local misIndex = self:GetMissionIndexByID(selfId, 1060)
    if self:IsHaveMission(selfId, 1060) then
        if self:GetMissionParam(selfId, misIndex, 0) < 1 and self:GetMissionParam(selfId, misIndex, 2) == 2 then
            self:AddNumText("这是我师兄给你的信", 4, 1)
        end
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_lusanniang:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_lusanniang:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:IsHaveMission(selfId, 4021) then
            self:BeginEvent(self.script_id)
            self:AddText("你有漕运货舱在身，我们驿站不能为你提供传送服务。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 15, 89, 144)
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
        self:AddText("#{MnepaiDesc_emei_1}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_emei_2}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_emei_3}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 13 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MnepaiDesc_emei_4}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 14 then
        self:BeginEvent(self.script_id)
        self:AddText("#{XSRW_200909_20}")
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

function odali_lusanniang:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odali_lusanniang:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_lusanniang:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_lusanniang:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_lusanniang:OnDie(selfId, killerId)
end

return odali_lusanniang
