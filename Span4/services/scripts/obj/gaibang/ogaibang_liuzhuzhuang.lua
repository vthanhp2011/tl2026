local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ogaibang_liuzhuzhuang = class("ogaibang_liuzhuzhuang", script_base)
function ogaibang_liuzhuzhuang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("全舵主在帮内的位置升得很快，我也要向他学习！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ogaibang_liuzhuzhuang
