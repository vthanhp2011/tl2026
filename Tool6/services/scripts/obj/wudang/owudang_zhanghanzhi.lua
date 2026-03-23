local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owudang_zhanghanzhi = class("owudang_zhanghanzhi", script_base)
function owudang_zhanghanzhi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("看你的样子，好像有点不大开心。要不要一起出去玩玩？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return owudang_zhanghanzhi
