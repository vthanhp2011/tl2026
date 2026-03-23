local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyannan_yelvmoge = class("oyannan_yelvmoge", script_base)
oyannan_yelvmoge.script_id = 018004
oyannan_yelvmoge.g_eventList = {200030, 200034, 212120}
function oyannan_yelvmoge:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  萧大王此去南朝，凶多吉少啊……可为什么太后坚持要他去呢？")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oyannan_yelvmoge:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oyannan_yelvmoge:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, index)
            return
        end
    end
end

function oyannan_yelvmoge:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oyannan_yelvmoge:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oyannan_yelvmoge:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oyannan_yelvmoge:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oyannan_yelvmoge:OnDie(selfId, killerId) end

return oyannan_yelvmoge
