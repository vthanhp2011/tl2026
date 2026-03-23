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
    local item_index = self:GetItemTableIndexByIndex(selfId,BagPos)
	if item_index ~= 38002834 then
		self:notify_tips(selfId, "非法物品。")
	end
	if not self:LuaFnHaveAgname(selfId, 1277) then
		self:LuaFnAddNewAgname(selfId, 1277)
		self:LuaFnDecItemLayCount(selfId,BagPos,1)
		self:notify_tips(selfId, "称号激活成功。")
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	else
		self:notify_tips(selfId, "该称号已经拥有。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
    end
end

return common_item