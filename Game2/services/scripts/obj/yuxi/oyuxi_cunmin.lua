local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyuxi_cunmin = class("oyuxi_cunmin", script_base)
function oyuxi_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  古鲁拉婆婆是个神医啊，吃了她做的药，什麽怪病都能好……虽然经常有些奇怪的副作用……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyuxi_cunmin
