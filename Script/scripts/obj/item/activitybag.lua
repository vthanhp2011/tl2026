local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
	--rate  必级是概率100   机率给则是 rate / 100
	--bind  true >> 给予绑定   false >> 给予不绑定
	--num_max  存在该键时  则随机数量给予 num - num_max中随机
local ItemInfo = 
{
	[38002949] = {
		{id = 30505079,num = 1,bind = true,rate = 100},
		{id = 30509012,num = 1,bind = true,rate = 100},
		{id = 38002283,num = 1,bind = true,rate = 100},
	  },
	[38002967] = {
		{id = 30008034,num = 1,bind = true,rate = 100},
		{id = 20310168,num = 10,bind = true,rate = 100},
		{id = 10141247,num = 1,bind = true,rate = 10},
	},
	[38002968] = {
		{id = 10125250,num = 1,bind = true,rate = 100},
		{id = 30008217,num = 1,bind = true,rate = 100},
		{id = 20307231,num = 1,bind = true,rate = 100},
	},
  
	[38008179] = {
		{id = 38008161,num = 30,num_max = 50,bind = false,rate = 100},
	},	




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
	if not CurItem then
		self:notify_tips(selfId,"未开放道具")
		return 0
	end
    return 1
end

function common_item:OnDeplete(selfId)
    return 1
end

function common_item:OnActivateOnce(selfId)
	local ItemTable = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local CurItem = ItemInfo[ItemTable]
	if not CurItem then
		self:notify_tips(selfId,"未开放道具")
		return 0
	end
	local usepos = self:LuaFnGetBagIndexOfUsedItem(selfId)
	if self:LuaFnGetItemTableIndexByIndex(selfId,usepos) ~= ItemTable then
		return 0
	end
	local give = {}
	self:BeginAddItem()
	for _,item in ipairs(CurItem) do
		if item.rate >= 100 then
			if not item.num_max then
				self:AddItem(item.id,item.num,item.bind)
				table.insert(give,{item.id,item.num})
			else
				local num = math.random(item.num,item.num_max)
				self:AddItem(item.id,num,item.bind)
				table.insert(give,{item.id,num})
			end
		elseif math.random(100) <= item.rate then
			if not item.num_max then
				self:AddItem(item.id,item.num,item.bind)
				table.insert(give,{item.id,item.num})
			else
				local num = math.random(item.num,item.num_max)
				self:AddItem(item.id,num,item.bind)
				table.insert(give,{item.id,num})
			end
		end
	end
	if not self:EndAddItem(selfId) then
		return 0
	end
	self:LuaFnDecItemLayCount(selfId,usepos,1)
	self:AddItemListToHuman(selfId)
	for _,item in ipairs(give) do
		self:GiveItemTip(selfId,item[1],item[2])
	end
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
    return 1
end

function common_item:OnActivateEachTick(selfId)
    return 1
end

return common_item
