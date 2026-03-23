local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_nanpu = class("oluoyang_nanpu", script_base)
function oluoyang_nanpu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  老爷正在休息，任何人不得打扰。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_nanpu
