local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyuxi_ashima = class("oyuxi_ashima", script_base)

function oyuxi_ashima:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  是你救了我吗？阿黑，阿黑哥他在哪里？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyuxi_ashima
