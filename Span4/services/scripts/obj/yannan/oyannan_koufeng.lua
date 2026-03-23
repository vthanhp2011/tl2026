local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyannan_koufeng = class("oyannan_koufeng", script_base)
oyannan_koufeng.script_id = 018001
oyannan_koufeng.g_eventList = {}
function oyannan_koufeng:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  宦官监军马承倩总是在雁门集市上抢夺百姓的东西，他手下的宦官将军骆奉先还经常带兵去抢劫契丹平民百姓，管这叫“打草谷”，有时候，还打汉族百姓的草谷。时间一长，我们的军队在百姓心目中有如恶鬼。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oyannan_koufeng:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oyannan_koufeng:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function oyannan_koufeng:OnMissionAccept(selfId, targetId, missionScriptId)
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

function oyannan_koufeng:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oyannan_koufeng:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oyannan_koufeng:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oyannan_koufeng:OnDie(selfId, killerId) end

return oyannan_koufeng
