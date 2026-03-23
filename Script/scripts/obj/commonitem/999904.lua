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
    [38002994] = 27,
    [38003023] = 28,
    [38003024] = 29,
    [38003214] = 30,
    [38003215] = 31,
    [38003216] = 32,
    [38003217] = 33,
    [38003323] = 34,
	[38003322] = 35,
	[38003327] = 36,
	[38003377] = 37,
	[38003378] = 38,
	[38003448] = 39,
	[38003449] = 40,
	[38003450] = 41,
	[38003582] = 45,
	[38003587] = 42,
	[38003588] = 42,
	[38003589] = 42,
	[38003604] = 46,
	[38003609] = 47,
	[38003663] = 48,
	[38003664] = 48,
	[38003670] = 50,
	[38003671] = 51,
	[38003672] = 52,
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
    local item_index = self:GetItemTableIndexByIndex(selfId,BagPos)
    local visual = item_2_weapon_visual[item_index]
	if not visual then
		self:notify_tips(selfId, "请使用激活幻饰的道具。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	end
	if self:GetWeaponVisualLevel(selfId,visual) >= 0 then
		self:notify_tips(selfId, "该幻饰已经激活。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	end
	self:LuaFnDecItemLayCount(selfId,BagPos,1)
	self:ActiveWeaponVisual(selfId,visual)
    self:notify_tips(selfId, "激活幻饰成功")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    return define.USEITEM_RESULT.USEITEM_SUCCESS
    -- assert(visual, item_index)
    -- self:ActiveWeaponVisual(selfId, visual)
	-- self:EraseItem(selfId, BagPos )
    -- self:LuaFnRefreshItemInfo(selfId, BagPos)
    -- self:notify_tips(selfId, "激活幻饰成功")
    -- self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    -- return define.USEITEM_RESULT.USEITEM_SUCCESS
end

return common_item