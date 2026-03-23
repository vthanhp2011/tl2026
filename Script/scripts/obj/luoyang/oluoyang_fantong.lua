local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_fantong = class("oluoyang_fantong", script_base)
oluoyang_fantong.g_ShopTabId = 15
oluoyang_fantong.script_id = 000059
function oluoyang_fantong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  来尝尝茗珍楼的洛阳水席吧，包你吃了之后再也不想离开洛阳。")
    --self:AddNumText("购买食物", 7, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_fantong:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    local ene = self:GetHumanEnergy(selfId)
    local vig = self:GetHumanVigor(selfId)
    if key == 0 then
        self:DispatchShopItem(selfId, targetId, self.g_ShopTabId)
    elseif key == 1 then
        if ene >= 40 then
            self:SetHumanEnergy(selfId, ene - 40)
            self:AddMoney(selfId, 3000)
            self:MsgBox(selfId, "你打工消耗40精力,获得30个银币")
        else
            self:MsgBox(selfId,
                        "你的精力不足40点,老板不需要你打工")
        end
    elseif key == 2 then
        if vig >= 40 then
            self:SetHumanVigor(selfId, vig - 40)
            self:AddMoney(selfId, 3000)
            self:MsgBox(selfId, "你打工消耗40活力,获得30个银币")
        else
            self:MsgBox(selfId,
                        "你的活力不足40点,老板不需要你打工")
        end
    end
end

function oluoyang_fantong:MsgBox(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return oluoyang_fantong
