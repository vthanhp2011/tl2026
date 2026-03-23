local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osongshan_dingmian = class("osongshan_dingmian", script_base)
function osongshan_dingmian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  自从发生那件事情后，我们家公子的精神一直不太好，可他倒底看到什么了呀？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osongshan_dingmian
