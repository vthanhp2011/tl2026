local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_sunshan = class("osuzhou_sunshan", script_base)
function osuzhou_sunshan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  哈哈，解名尽处是孙山，贤郎更在孙山外！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_sunshan
