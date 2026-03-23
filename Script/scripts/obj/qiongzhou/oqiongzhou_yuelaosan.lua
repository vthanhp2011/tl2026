local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqiongzhou_yuelaosan = class("oqiongzhou_yuelaosan", script_base)
function oqiongzhou_yuelaosan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  最近我在大理新拜了一位师父，本事非同小可。不说别的，单是这位师父的“淩波微步”绝技，相信世上便无第二人会得。#r  这次回琼州，主要就是来接我老婆的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oqiongzhou_yuelaosan
