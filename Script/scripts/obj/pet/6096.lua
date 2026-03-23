local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local g_petCommonId = define.PETCOMMON
function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
    --检测Item是否有效
    if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end
	--检测使用对象有效性
	local petGUID_H = self:LuaFnGetHighSectionOfTargetPetGuid(selfId)
	local petGUID_L = self:LuaFnGetLowSectionOfTargetPetGuid(selfId)
	local checkAvailable = self:LuaFnIsPetAvailableByGUIDNoPW(selfId, petGUID_H, petGUID_L)
	if not checkAvailable then
		return 0
	end
    return 1
end

function common_item:OnDeplete(selfId)
    return 1
end

function common_item:GetPetBookId(selfId)
	local ItemIndexInBag, PetBookId
	ItemIndexInBag = self:LuaFnGetBagIndexOfUsedItem(selfId)	--获取宠物技能书在背包中Index
	PetBookId = self:LuaFnGetItemTableIndexByIndex(selfId, ItemIndexInBag) --获取宠物技能书ID
	return PetBookId
end

function common_item:OnActivateOnce(selfId)
	local PetBookId = self:GetPetBookId(selfId) --获取宠物技能书ID
	local SkillId = self:GetPetBookSkillID(PetBookId)	--获取宠物技能书对应技能ID
	if -1 == SkillId then
		return 0
	end
	local PetGuidH = self:LuaFnGetHighSectionOfTargetPetGuid(selfId )
	local PetGuidL = self:LuaFnGetLowSectionOfTargetPetGuid(selfId )
	local pgH, pgL = self:LuaFnGetCurrentPetGUID(selfId)
	--是否出战
	if (PetGuidH == pgH) and (PetGuidL == pgL) then
		return 0
	end
	if self:LuaFnDepletingUsedItem(selfId) then
		self:CallScriptFunction(g_petCommonId, "PetStudy", selfId, SkillId)
		return 1
	end
	return 0
end


return common_item