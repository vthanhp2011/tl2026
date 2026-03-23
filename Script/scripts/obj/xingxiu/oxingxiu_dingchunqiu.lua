local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxingxiu_dingchunqiu = class("oxingxiu_dingchunqiu", script_base)
oxingxiu_dingchunqiu.script_id = 016000
oxingxiu_dingchunqiu.g_eventList = {229009, 229012, 808092}

function oxingxiu_dingchunqiu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  老夫一直觉得，武林中人以刀斧枪棒相互搏杀，实在是残忍无比的事情。如果用毒功伤人，才能让人在平静、安逸、幸福、快乐之中死亡。所以这毒功真是功德无量的武功啊。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxingxiu_dingchunqiu:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(
                arg,
                "OnDefaultEvent",
                selfId,
                targetId,
                define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU
            )
            return
        end
    end
end

return oxingxiu_dingchunqiu
