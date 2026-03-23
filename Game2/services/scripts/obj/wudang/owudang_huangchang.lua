local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owudang_huangchang = class("owudang_huangchang", script_base)
function owudang_huangchang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("武当山最近道教发展兴隆，大有超过龙虎山，成为中华第一道教名山之势。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return owudang_huangchang
