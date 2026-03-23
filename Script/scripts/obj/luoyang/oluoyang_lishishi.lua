local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_lishishi = class("oluoyang_lishishi", script_base)
function oluoyang_lishishi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  无可奈何花落去，似曾相识燕归来。小园香径独徘徊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_lishishi
