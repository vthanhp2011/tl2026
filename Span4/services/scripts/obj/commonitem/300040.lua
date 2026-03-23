-- 宠物双倍经验时间药水
-- 消耗一个药水，为宠物提供一个小时双倍经验时间

local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local g_ItemId_1 = 30008003
local g_ItemId_2 = 30008028

local g_BuffId = 53
local g_BuffPet_25 = 61
local g_BuffPet_2 = 53

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

function common_item:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function common_item:OnActivateOnce(selfId)
    return 1
end

function common_item:OnDefaultEvent(selfId, BagPos)
	-- 如果身上有2.5的，就不让吃
	if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, g_BuffPet_25) then
        self:notify_tips(selfId, "您身上已经存在了更高效率的多倍经验时间！")
		return 0
	end
	-- 有相同的，也不让再吃
	if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, g_BuffPet_2) then
        self:notify_tips(selfId, "  你已经使用了多倍经验药物，请在效果消失后再使用。")
		return 0
	end
	return self:UseItem(selfId, BagPos)
end

function common_item:EatMe(selfId, BagPos)
    self:UseItem(selfId, BagPos)
end

function common_item:UseItem(selfId, BagPos)
	-- 先检测这个 nItemIndex 的物品是不是和当前的对应，
	local nItemId = self:GetItemTableIndexByIndex(selfId, BagPos)
	if nItemId ~= g_ItemId_1 and nItemId ~= g_ItemId_2 then
        self:notify_tips(selfId, "  背包内部错误")
		return 0
	end
	--1，看玩家是不是当前的身上的双倍经验时间是多少，如果达到上限，就不能使用
	local nCurHaveTime = self:DEGetMoneyTime(selfId)
	if nCurHaveTime >= 99*60*60   then
        self:notify_tips(selfId, "  您当前使用“天灵丹”获得的双倍经验时间已经到达上限。")
		return 0
    end
	--符合使用这个物品的条件，
	local ret = self:EraseItem(selfId, BagPos)
	if ret then
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, g_BuffId, 100 )
        self:notify_tips(selfId, "您增加了一个小时的宠物双倍经验时间。")
	else
        self:notify_tips(selfId, "物品不能使用")
        return 0
	end
	-- 同步数据到客户端
    self:LuaFnRefreshItemInfo(selfId, BagPos)
	self:SendDoubleExpToClient(selfId)
    self:LuaFnRefreshItemInfo(selfId, BagPos)
    return define.USEITEM_RESULT.USEITEM_SUCCESS
end

return common_item