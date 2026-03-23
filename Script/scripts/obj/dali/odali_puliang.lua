local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_puliang = class("odali_puliang", script_base)
odali_puliang.script_id = 002023
odali_puliang.g_shoptableindex = 1
odali_puliang.g_eventList = {210200, 210201,210256}

function odali_puliang:UpdateEventList(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText("  兵器这东西，要的就是锋利，要的就是合适，" .. PlayerName .. PlayerSex .. "，看看我这里的兵器，肯定会有你合手的。")
    self:AddNumText("看看你卖的东西", 7, 0)
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_puliang:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_puliang:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function odali_puliang:OnMissionAccept(selfId, targetId, missionScriptId)
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

function odali_puliang:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_puliang:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_puliang:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_puliang:OnDie(selfId, killerId)
end

return odali_puliang
