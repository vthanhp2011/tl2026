local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local ItemInfo = 
{
	[38002949] = {30505079,30509012,38002283},
	[38002967] = {30008034},
	[38002968] = {10125250,30008217,20307231},
}
function common_item:OnDefaultEvent(selfId, bagIndex)

end

function common_item:IsSkillLikeScript(selfId)
    return 1
end

function common_item:CancelImpacts(selfId)
    return 0
end

function common_item:OnConditionCheck(selfId)
	if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end
	local ItemTable = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local CurItem = ItemInfo[ItemTable]
	if CurItem == nil then
		self:notify_tips(selfId,"未开放道具")
		return 0
	end
	self:BeginAddItem()
	if ItemTable ~= 38002967 then
		for i = 1,#CurItem do
			self:AddItem(CurItem[i],1)
		end
		else
		self:AddItem(30008034,1)
		self:AddItem(20310168,10)
		if math.random() <= 10 then
			self:AddItem(10141247,1)
		end
	end
	local ret = self:EndAddItem(selfId)
	if not ret then
		self:notify_tips(selfId,"背包空间不足")
		return 0
	end
    return self:LuaFnVerifyUsedItem(selfId)
end

function common_item:OnDeplete(selfId)
    return 1
end

function common_item:OnActivateOnce(selfId)
	local ItemTable = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local CurItem = ItemInfo[ItemTable]
	if CurItem == nil then
		self:notify_tips(selfId,"未开放道具")
		return 0
	end
	self:BeginAddItem()
	if ItemTable ~= 38002967 then
		for i = 1,#CurItem do
			self:AddItem(CurItem[i],1,true)
		end
		else
		self:AddItem(30008034,1,true)
		self:AddItem(20310168,10)
		if math.random() <= 10 then
			self:AddItem(10141247,1,true)
		end
	end
	local ret = self:EndAddItem(selfId)
	if not ret then
		self:notify_tips(selfId,"背包空间不足")
		return 0
	end
    if ret then
        self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,string.format("恭喜您，成功打开%s。",self:GetItemName(ItemTable)))
		if ItemTable ~= 38002967 then
			self:notify_tips(selfId,string.format("获得1个%s。",self:GetItemName(CurItem[1])))
			self:notify_tips(selfId,string.format("获得1个%s。",self:GetItemName(CurItem[2])))
			self:notify_tips(selfId,string.format("获得1个%s。",self:GetItemName(CurItem[3])))
			else
			self:notify_tips(selfId,string.format("获得1个%s。",self:GetItemName(30008034)))
			self:notify_tips(selfId,string.format("获得10个%s。",self:GetItemName(20310168)))
		end
        local bag_index = self:LuaFnGetBagIndexOfUsedItem(selfId)
        self:LuaFnDecItemLayCount(selfId, bag_index, 1)
    end
    return 1
end

function common_item:OnActivateEachTick(selfId)
    return 1
end

return common_item
