local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local item_2_weapon_visual = {
    [38002608] = 1,
    [38002609] = 2,
    [38002610] = 3,
    [38002611] = 4,
    [38002612] = 5,
    [38002613] = 6,
    [38002614] = 7,
    [38002615] = 9,
    [38002616] = 8,
    [38002617] = 10,
    [38002618] = 11,
    [38002619] = 12,
    [38002620] = 13,
    [38002621] = 14,
    [38002626] = 15,
    [38002627] = 16,
    [38002628] = 17,
    [38002629] = 18,
    [38002630] = 19,
    [38002963] = 20,
    [38003019] = 23,
    [38003020] = 24,
    [38003021] = 25,
    [38003022] = 26,
}

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
    local item_index = self:GetItemTableIndexByIndex(selfId, BagPos)
    local visual = item_2_weapon_visual[item_index]
    assert(visual, item_index)
    self:ActiveWeaponVisual(selfId, visual)
	self:EraseItem(selfId, BagPos )
    self:LuaFnRefreshItemInfo(selfId, BagPos)
    self:notify_tips(selfId, "激活幻饰成功")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    return define.USEITEM_RESULT.USEITEM_SUCCESS
end

return common_item