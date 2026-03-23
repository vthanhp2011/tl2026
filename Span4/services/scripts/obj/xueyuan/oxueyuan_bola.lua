local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxueyuan_bola = class("oxueyuan_bola", script_base)
function oxueyuan_bola:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("银皑雪原到处危机重重，在这里活动可得小心啊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxueyuan_bola
