local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oliaoxi_cunmin = class("oliaoxi_cunmin", script_base)
function oliaoxi_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我们现在被马匪攻击，主要是因为现在我们蒙古人太少，而且不团结。总有一天，一位伟大的汗会领导蒙古人走向胜利的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oliaoxi_cunmin
