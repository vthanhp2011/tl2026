local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_kurong = class("otianlong_kurong", script_base)
function otianlong_kurong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  阿弥陀佛！有常无常，双树枯荣，南北西东，非假非空！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_kurong
