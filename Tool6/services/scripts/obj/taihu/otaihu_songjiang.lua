local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otaihu_songjiang = class("otaihu_songjiang", script_base)
function otaihu_songjiang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  区区一个明教对我们呼延将军而言，都是小意思了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otaihu_songjiang
