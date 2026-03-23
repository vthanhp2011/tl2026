local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_renfeiyan = class("otianlong_renfeiyan", script_base)
function otianlong_renfeiyan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我陪着老皇爷们来到天龙寺已有两年了，但我还一直记得两年前在洛阳城里见到的那个年轻人。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_renfeiyan
