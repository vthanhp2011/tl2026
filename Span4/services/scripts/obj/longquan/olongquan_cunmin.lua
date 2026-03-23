local class = require "class"
local define = require "define"
local script_base = require "script_base"
local olongquan_cunmin = class("olongquan_cunmin", script_base)
function olongquan_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  龙井村的茶叶，配上虎跑村的泉水，就是闻名天下的龙井茶。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return olongquan_cunmin
