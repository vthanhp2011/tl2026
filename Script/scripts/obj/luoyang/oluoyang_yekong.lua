local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_yekong = class("oluoyang_yekong", script_base)
function oluoyang_yekong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  施主，你终于来了。我师父正在等你呢。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_yekong
