local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
function common_item:IsSkillLikeScript()
    return 0
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end
    return 1
end

function common_item:OnDefaultEvent(selfId, BagPos)
    local visual = self:LuaFnGetEquipVisual(selfId, BagPos)
    local index = self:LuaFnGetExteriorRideIDByVisual(visual)
    local add = self:GetEquipCanAddRxpirationTime(selfId, BagPos)
    local ret = self:LuaFnAddRideRxpirationTime(selfId, index, add)
    if not ret then
        return 1
    end
    self:ChangePlayerRide(selfId, index)
	self:EraseItem(selfId, BagPos )
    self:LuaFnRefreshItemInfo(selfId, BagPos)
    return define.USEITEM_RESULT.USEITEM_SUCCESS
end

return common_item