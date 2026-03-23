local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_lanlan = class("odali_lanlan", script_base)
function odali_lanlan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  王妃每天吃不下，睡不好的，这样下去身子骨会垮掉的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_lanlan
