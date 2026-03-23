local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ojiange_cunmin = class("ojiange_cunmin", script_base)
function ojiange_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  ½ª¼Ò¼¯ÔÚÄÖµÁÔôÄØ£¡")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ojiange_cunmin
