local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_shangdui = class("omeiling_shangdui", script_base)
function omeiling_shangdui:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  商队在梅岭已经停了好多天了，货物差不多已经卖光了，这一趟下来大家都能分到不少吧。#r  沈老板真的是个商业天才啊，跟着他做事真是前世积德了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_shangdui
