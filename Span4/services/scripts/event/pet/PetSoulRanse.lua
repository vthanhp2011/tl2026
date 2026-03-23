local class = require "class"
local script_base = require "script_base"
local PetSoulRanse = class("PetSoulRanse", script_base)

function PetSoulRanse:OnPossPaint(selfId, targetId, Index, PetSoulId)
    local CostMaterialID = 30503154
    local item_count = self:LuaFnGetAvailableItemCount(selfId, CostMaterialID)
    if item_count < 1 then
        self:notify_tips(selfId, "需要兽魂彩砂")
        return
    end
    if not (Index == 1 or Index == 2 or Index == 3) then
        self:notify_tips(selfId, "选择要存放的位置")
        return
    end
    local configs = self:GetPetSoulPossPaintConfig(PetSoulId)
    local num = math.random(1000)
    local value = 0
    local result
    for _, c in ipairs(configs) do
        value = value + c.Odds
        result = c
        if value >= num then
            break
        end
    end
    if result == nil then
        self:notify_tips(selfId, "染色失败，配置异常")
        return
    end
    self:LuaFnDelAvailableItem(selfId, CostMaterialID, 1)
    self:UnlockExteriorRanSe(selfId, PetSoulId, Index, result.ColorValue)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
end

return PetSoulRanse