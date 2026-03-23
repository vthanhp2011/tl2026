local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_wuzhong = class("otianlong_wuzhong", script_base)
function otianlong_wuzhong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  下官名叫伍忠，是奉当今圣上之命，来看望老皇爷的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_wuzhong
