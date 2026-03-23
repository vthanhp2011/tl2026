local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zhoutianshi = class("oluoyang_zhoutianshi", script_base)
oluoyang_zhoutianshi.script_id = 000148
oluoyang_zhoutianshi.g_eventList = {
    500600, 500601,500602, 500603, 500604, 500605,500606,500607,500608,
    500612, 500613, 500614, 500615, 500616, 500619,1018700,1018701,
    1018702,1018706,1018707,1018708,1018712,1018715,1018723,1018726

}
--[[1018709,1018713,1018716,1018717,1018718  有问题得后续修复]]

function oluoyang_zhoutianshi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  江山辈有人才出，各领风骚数百年。鄙人和大理赵天师乃同门兄弟。如今江湖新人辈出，我是欢喜的紧啊。不过武学之路绝无一帆风顺之理。阁下有空可常来找老朽聊聊，若有不明之事，老朽不才，愿意指点一二。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId,"OnEnumerate",self,selfId,targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_zhoutianshi:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end

function oluoyang_zhoutianshi:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept",selfId, targetId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,targetId, missionScriptId)
            end
            return
        end
    end
end

function oluoyang_zhoutianshi:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:OnDefaultEvent(selfId, targetId)
            return
        end
    end
end

function oluoyang_zhoutianshi:OnMissionContinue(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,targetId)
            return
        end
    end
end

function oluoyang_zhoutianshi:OnMissionSubmit(selfId, targetId, missionScriptId,selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_zhoutianshi:OnDie(selfId, killerId) end

return oluoyang_zhoutianshi
