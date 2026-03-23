local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_baiyingzhong = class("oluoyang_baiyingzhong", script_base)
oluoyang_baiyingzhong.g_shoptableindex = 29
function oluoyang_baiyingzhong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  我正在在师傅的指导下研制补药，等哪一天研制成功了，我可以以成本价卖给你。嘘——一般人我不告诉他。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_baiyingzhong
