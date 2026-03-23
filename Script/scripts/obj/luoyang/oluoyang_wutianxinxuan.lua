local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_wutianxinxuan = class("oluoyang_wutianxinxuan", script_base)
function oluoyang_wutianxinxuan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  大宋国有很多值得我们学习的东西，特别是《孙子兵法》，趁这次蹴鞠大会希望我们两国可以好好交流一下。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_wutianxinxuan
