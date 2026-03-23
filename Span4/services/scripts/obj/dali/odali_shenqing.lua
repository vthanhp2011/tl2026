local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_shenqing = class("odali_shenqing", script_base)
odali_shenqing.script_id = 002069
odali_shenqing.g_eventList = {210265}

function odali_shenqing:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText("  " .. PlayerName .. PlayerSex .. "，要好好对待自己的珍兽哦。操作上有什么不明白的地方，我可以帮你解答哦。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:AddNumText("宠物生命值不足怎么办", 11, 0)
    self:AddNumText("珍兽快乐度不足怎么办", 11, 1)
    self:AddNumText("怎样提升宠物等级", 11, 2)
    self:AddNumText("怎样捕捉宠物", 11, 3)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_shenqing:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
    if index == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("#{OBJ_dali_0041}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{OBJ_dali_0042}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{OBJ_dali_0043}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 3 then
        self:BeginEvent(self.script_id)
        self:AddText("#{OBJ_dali_0044}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function odali_shenqing:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId, targetId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId, targetId, missionScriptId)
            end
            return
        end
    end
end

function odali_shenqing:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:OnDefaultEvent(selfId, targetId)
            return
        end
    end
end

function odali_shenqing:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_shenqing:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_shenqing:OnDie(selfId, killerId)
end

return odali_shenqing
