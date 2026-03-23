local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zongkada = class("oluoyang_zongkada", script_base)
function oluoyang_zongkada:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  洛阳城的空气，远比逻些城的空气稠密。真不适应……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_zongkada
