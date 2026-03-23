local class = require "class"
local define = require "define"
local script_base = require "script_base"
local huodong_yezhu_3 = class("huodong_yezhu_3", script_base)
huodong_yezhu_3.script_id = 402104
huodong_yezhu_3.g_eventList = {402105}

function huodong_yezhu_3:UpdateEventList(selfId, targetId)
	if not self:LuaFnIsActivityMonster(selfId,targetId,true) then return end
    self:BeginEvent(self.script_id)
    self:AddText("  可恶的野猪王逃走了！不知你们有没有得到一些可以找到野猪王的线索呢？")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function huodong_yezhu_3:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function huodong_yezhu_3:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, index)
            return
        end
    end
end

return huodong_yezhu_3
