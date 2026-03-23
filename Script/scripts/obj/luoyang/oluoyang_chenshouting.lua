local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_chenshouting = class("oluoyang_chenshouting", script_base)
function oluoyang_chenshouting:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  现在商会缺货，你等些日子再来吧。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_chenshouting
