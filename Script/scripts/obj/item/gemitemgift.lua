local class = require "class"
local define = require "define"
local script_base = require "script_base"
local gemitemgift = class("gemitemgift", script_base)
local g_itemids = {50302002,50302001,50302003,50302004}

function gemitemgift:OnDefaultEvent(selfId, bagIndex)

end

function gemitemgift:IsSkillLikeScript(selfId)
    return 1
end

function gemitemgift:CancelImpacts(selfId)
    return 0
end

function gemitemgift:OnSelectItem(selfId,nSelect)
    local bag_index = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local nItemId = self:LuaFnGetItemTableIndexByIndex(selfId,bag_index)
    if nItemId ~= 38002221 then
        self:notify_tips(selfId,"未开放道具")
        return
    end
	if nSelect < 1 or nSelect > 4 or not nSelect or nSelect == nil then
		self:notify_tips(selfId,"nSelect_error")
		return
	end
	local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
	if nBagMaterial < 1 then
		self:notify_tips(selfId,"请保证材料栏有一个空位。")
		return
	end
    self:BeginAddItem()
        self:AddItem(g_itemids[nSelect],1,true)
    local ret = self:EndAddItem(selfId)
    if ret then
        self:AddItemListToHuman(selfId)
        self:LuaFnDelAvailableItem(selfId,nItemId,1)
        self:notify_tips(selfId,string.format("获得一个%s。",self:GetItemName(g_itemids[nSelect])))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
    else
        self:notify_tips(selfId,"请保证材料栏有一个空位。")
        return
    end
end

function gemitemgift:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
        return 0
    end
    local bag_index = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local nItemId = self:LuaFnGetItemTableIndexByIndex(selfId,bag_index)
    if nItemId ~= 38002221 then
        self:notify_tips(selfId,"未开放道具")
        return 0
    end
	local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
	if nBagMaterial < 1 then
		self:notify_tips(selfId,"请保证材料栏有一个空位。")
		return 0
	end
    self:BeginUICommand()
	self:UICommand_AddInt(1)
    self:EndUICommand()
	self:DispatchUICommand(selfId,89112301)
    return 0
end

function gemitemgift:OnDeplete(selfId)
    return 1
end

function gemitemgift:OnActivateOnce(selfId)
    return 0
end

function gemitemgift:OnActivateEachTick(selfId)
    return 1
end

return gemitemgift
