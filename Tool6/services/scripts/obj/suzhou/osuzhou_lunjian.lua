local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_lunjian = class("osuzhou_lunjian", script_base)
osuzhou_lunjian.script_id = 001064
osuzhou_lunjian.g_eventList = {001230}

function osuzhou_lunjian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  俗话说得好，文无第一，武无第二，武林人士都是要在华山论剑中争一个天下第一的名号。如果你也想参加华山论剑，我可以为你报名并送你去华山。    参加华山论剑的玩家如果积分在本门派排名前三，就可以在我这里领取朝廷颁发的薄礼一份，各位努力啊！"
    )
    self:AddNumText("华山论剑介绍", 11, 10)
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_lunjian:OnEventRequest(selfId, targetId, arg, index)
    if index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_064}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if arg== findId then
            self:CallScriptFunction(findId, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
end

return osuzhou_lunjian
