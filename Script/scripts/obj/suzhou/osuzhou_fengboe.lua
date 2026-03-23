local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_fengboe = class("osuzhou_fengboe", script_base)
function osuzhou_fengboe:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  想打架吗？那边有个擂台，我们去比试一下，怎么？不敢吗？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_fengboe
