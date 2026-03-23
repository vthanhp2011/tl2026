local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_shumi = class("oluoyang_shumi", script_base)
oluoyang_shumi.script_id = 311000
oluoyang_shumi.g_eventList = {311004, 311005}

function oluoyang_shumi:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    self:AddText("  " .. PlayerName ..
                     "，朝廷现在正是用人之际，年轻人应该来报效国家啊。我已经通知刘健明，给你这样江湖上的英雄们提供双倍经验，以提升你们的效率。你可以去府前广场找他领取。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_shumi:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_shumi:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oluoyang_shumi:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            return
        end
    end
end

function oluoyang_shumi:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_shumi:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_shumi:OnMissionSubmit(selfId, targetId, missionScriptId,
                                        selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_shumi:OnDie(selfId, killerId) end

return oluoyang_shumi
