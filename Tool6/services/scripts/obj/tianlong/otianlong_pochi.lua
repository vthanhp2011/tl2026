local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_pochi = class("otianlong_pochi", script_base)
function otianlong_pochi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  小僧法号破痴，在大理城拈花寺出家，是来天龙寺挂单的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_pochi
