local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxueyuan_ninglingge = class("oxueyuan_ninglingge", script_base)
function oxueyuan_ninglingge:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("你听说过得企鹅者得幸福这个传说吗？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxueyuan_ninglingge
