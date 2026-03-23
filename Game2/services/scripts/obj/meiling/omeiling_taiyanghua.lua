local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_taiyanghua = class("omeiling_taiyanghua", script_base)
function omeiling_taiyanghua:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  男人？在山越部族，男人就是奴仆，男人生来就只能做护法，是被我们祭司使唤的。这个风俗从几千年前开始就是这样的，这是神的旨意，不可以违抗的！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_taiyanghua
