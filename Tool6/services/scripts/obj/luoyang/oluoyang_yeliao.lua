local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_yeliao = class("oluoyang_yeliao", script_base)
function oluoyang_yeliao:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText("  " .. PlayerName .. PlayerSex ..
                     "，雁门关在打仗吗？怎么那么多难民呀？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_yeliao
