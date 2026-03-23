local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ogaibang_quanguanqing = class("ogaibang_quanguanqing", script_base)
function ogaibang_quanguanqing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("马副帮主的大仇一定要报，谁反对谁就是杀害马副帮主的帮凶。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ogaibang_quanguanqing
