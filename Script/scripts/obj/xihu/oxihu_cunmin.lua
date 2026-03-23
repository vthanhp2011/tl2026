local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxihu_cunmin = class("oxihu_cunmin", script_base)
function oxihu_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  虎跑村现在可不平静啊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxihu_cunmin
