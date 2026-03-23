local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oemei_dizi_4 = class("oemei_dizi_4", script_base)
function oemei_dizi_4:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("<花枝招展，妩媚动人>")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oemei_dizi_4
