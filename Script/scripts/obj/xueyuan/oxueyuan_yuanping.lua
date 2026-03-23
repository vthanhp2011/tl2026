local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxueyuan_yuanping = class("oxueyuan_yuanping", script_base)
function oxueyuan_yuanping:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("你见过被封在冰块里的巨人吗？真想知道他是怎麽来的……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxueyuan_yuanping
