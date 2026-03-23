local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_qiguidie = class("otianlong_qiguidie", script_base)
function otianlong_qiguidie:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  近日给本因大师做了一件新的袈裟，也不知他合身不合身。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_qiguidie
