local class = require "class"
local define = require "define"
local script_base = require "script_base"
local onanhai_cunmin = class("onanhai_cunmin", script_base)
function onanhai_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  鳄鱼帮的小夥子们越来越不像话了，比比人家李老太太的儿子，简直一个天上，一个地下。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return onanhai_cunmin
