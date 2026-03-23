local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otaihu_dicheng = class("otaihu_dicheng", script_base)
function otaihu_dicheng:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  怎么来了那么多官兵，我都不敢出去抢东西了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otaihu_dicheng
