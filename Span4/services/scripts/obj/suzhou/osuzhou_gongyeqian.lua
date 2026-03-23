local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_gongyeqian = class("osuzhou_gongyeqian", script_base)
function osuzhou_gongyeqian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  公子爷一向泰山崩于前而面不改色，这次一筹莫展，一定是遇上了什么非常重要的事情。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_gongyeqian
