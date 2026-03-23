local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ocaoyuan_xiaoqiang = class("ocaoyuan_xiaoqiang", script_base)
ocaoyuan_xiaoqiang.script_id = 020003
ocaoyuan_xiaoqiang.g_eventList = {212125}
function ocaoyuan_xiaoqiang:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    local IsStepDone1 = self:IsHaveMission(selfId, 542)
    local IsStepDone2 = self:IsHaveMission(selfId, 543)
    local IsStepDone3 = self:IsHaveMission(selfId, 544)
    local IsStepDone4 = self:IsHaveMission(selfId, 548)
    if IsStepDone4 then
        self:AddText("  " .. PlayerName .. "#{OBJ_caoyuan_0004}")
    elseif IsStepDone1 == 0 and IsStepDone2 == 0 and IsStepDone3 == 0 then
        self:AddText("  你就是" .. PlayerName .. " ？#r  哥哥从#G雁北#W来信说你是个英雄，让我好好招待。我看你也不是很像个英雄嘛。")
    else
        self:AddText("  我可不是别人说什么我就信什么的人哦，你如果真的是英雄，我自然会好好的款待你。")
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ocaoyuan_xiaoqiang:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ocaoyuan_xiaoqiang:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ocaoyuan_xiaoqiang:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId, targetId)
            end
            return
        end
    end
end

function ocaoyuan_xiaoqiang:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ocaoyuan_xiaoqiang:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ocaoyuan_xiaoqiang:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ocaoyuan_xiaoqiang:OnDie(selfId, killerId) end

return ocaoyuan_xiaoqiang
