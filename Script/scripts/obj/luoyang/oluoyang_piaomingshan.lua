local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_piaomingshan = class("oluoyang_piaomingshan", script_base)
function oluoyang_piaomingshan:OnDefaultEvent(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText(
        "  洛阳的牡丹真是名不虚传啊，和我们高丽的山茶花有的一比。听说宋王朝的苏州城也漂亮的很，" ..
            PlayerName .. PlayerSex .. "，可曾去过？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_piaomingshan
