local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oliaoxi_liaobing = class("oliaoxi_liaobing", script_base)
function oliaoxi_liaobing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我大辽集中了大量精锐，对雁门关施加压力；辽西就只剩下我们这些老弱，应付那些神龙见首不见尾的马匪。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oliaoxi_liaobing
