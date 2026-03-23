local class = require "class"
local define = require "define"
local script_base = require "script_base"
local songbing = class("songbing", script_base)
songbing.script_id = 402262
songbing.g_eventList = {}

function songbing:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local nRand = math.random(4)
    local str
    if nRand == 1 then
        str = "  听说这次反贼请来了四大恶人前去刺杀呼延豹将军！"
    elseif nRand == 2 then
        str = "  呼延豹将军有危险，请你们赶快到旗舰上去保护他！"
    elseif nRand == 3 then
        str = "  呼延豹将军是我们大宋不可多得的虎将，尤其擅长水战，有他在，大宋水军必胜！"
    else
        str = "  如果我也会轻功，一定会踩着荷叶飞到旗舰上去保护呼延豹将军！"
    end
    self:AddText(str)
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function songbing:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function songbing:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function songbing:OnMissionAccept(selfId, targetId, missionScriptId)
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

function songbing:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function songbing:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function songbing:OnMissionSubmit(selfId, targetId, missionScriptId,  selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function songbing:OnDie(selfId, killerId) end

return songbing
