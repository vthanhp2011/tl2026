local class = require "class"
local define = require "define"
local script_base = require "script_base"
local custom_gift_box = class("custom_gift_box", script_base)
custom_gift_box.script_id = 999261
custom_gift_box.max_count = 27
--自选盒配置   盒子容量最多27 选 1  超出不读取处理
custom_gift_box.item = 
{
	[38008202] = {
		max_select = 1,		--可以选择1种奖励  最少填1  最大填5  5 = 27选5
		{id = 30302573,num = 1,bind = true},--高级宝石合成符
		{id = 30302584,num = 1,bind = true},--金蚕丝
		{id = 30302400,num = 1,bind = true},--灵蚕丝
		{id = 30302401,num = 1,bind = true},--武道玄元丹
		{id = 30302402,num = 1,bind = true},--属性称号凭证
		{id = 30302403,num = 1,bind = true},--聚神功力丹
	},
	[38008203] = {
		max_select = 1,		--可以选择1种奖励  最少填1  最大填5  5 = 27选5
		{id = 10302000,num = 1,bind = true},
		{id = 10300000,num = 1,bind = true},
		{id = 10304000,num = 1,bind = true},
		{id = 10305000,num = 1,bind = true},
		{id = 10306000,num = 1,bind = true},
		{id = 10307000,num = 1,bind = true},
	},
	[38008206] = {
		max_select = 1,		--可以选择1种奖励  最少填1  最大填5  5 = 27选5
		{id = 20310228,num = 1,bind = true},
		{id = 20310230,num = 1,bind = true},
		{id = 30505837,num = 1,bind = true},
	},
	[38008204] = {
		max_select = 1,		--可以选择1种奖励  最少填1  最大填5  5 = 27选5
		{id = 30700226,num = 1,bind = true},
		{id = 30700227,num = 1,bind = true},
		{id = 30700228,num = 1,bind = true},
		{id = 30700229,num = 1,bind = true},
	},
	[38008208] = {
		max_select = 1,		--可以选择1种奖励  最少填1  最大填5  5 = 27选5
		{id = 10422149,num = 1,bind = true},
		{id = 10423025,num = 1,bind = true},
	},
}


function custom_gift_box:OnDefaultEvent(selfId, bagIndex)
end

function custom_gift_box:IsSkillLikeScript(selfId)
    return 1
end

function custom_gift_box:CancelImpacts(selfId)
    return 0
end

function custom_gift_box:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
		self:notify_tips(selfId,"请重试。")
        return 0
    end
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId )
	if not self.item[useid] then
		self:notify_tips(selfId,"未开放道具。")
		return 0
	end
    return 1
end

function custom_gift_box:OnDeplete(selfId)
    -- if (self:LuaFnDepletingUsedItem(selfId)) then
        -- return 1
    -- end
    return 1
end
function custom_gift_box:OnActivateOnce(selfId)
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local usepos = self:LuaFnGetBagIndexOfUsedItem(selfId)
	if self:LuaFnGetItemTableIndexByIndex(selfId,usepos) ~= useid then
		self:notify_tips(selfId,"道具使用出错。")
		return 0
	end
	local item = self.item[useid]
	if not item then
		self:notify_tips(selfId,"未开放道具。")
		return 0
	elseif item.max_select < 1 or item.max_select > 5 then
		self:notify_tips(selfId,"可选取道具数量出错。")
		return 0
	end
	local max_count = #item
	if max_count > self.max_count then
		max_count = self.max_count
	end
	max_count = max_count * 10 + item.max_select
	-- 16 - 3
	--13  14 * 8 = 112 
	--27 * 5 = 135
	local item_strs = {}
	local item_nums = {}
	self:BeginUICommand()
	self:UICommand_AddInt(usepos)
	self:UICommand_AddInt(max_count)
	self:UICommand_AddInt(self.script_id)
	for i,info in ipairs(item) do
		table.insert(item_nums,info.num)
		if i <= 12 then
			self:UICommand_AddInt(info.id)
		elseif i > self.max_count then
			break
		else
			table.insert(item_strs,info.id)
		end
	end
	table.insert(item_nums,1)
	self:UICommand_AddStr("SelectItem")
	local item_string = table.concat(item_strs)
	self:UICommand_AddStr(item_string)
	item_string = table.concat(item_nums,";")
	self:UICommand_AddStr(item_string)
	self:EndUICommand()
	self:DispatchUICommand(selfId,614052021)
	return 1
end


function custom_gift_box:SelectItem(selfId,bagpos,...)
	if not bagpos then
		return
	end
	local select_idx = { ... }
	local itemid = self:LuaFnGetItemTableIndexByIndex(selfId,bagpos)
	local item = self.item[itemid]
	if not item then
		self:notify_tips(selfId, "未开放道具。")
		return
	end
	if #select_idx ~= item.max_select then
		return
	end
	for i,j in ipairs(select_idx) do
		if j < 1 then
			local msg = string.format("第%d个选择道具异常，请重新进行选择。",i)
			self:notify_tips(selfId,msg)
			return
		end
		if not item[j] then
			local msg = string.format("第%d个选择道具异常，请重新进行选择。。",i)
			self:notify_tips(selfId,msg)
			return
		end
		for k,l in ipairs(select_idx) do
			if i ~= k and j == l then
				local msg = string.format("第%d个与第%d个选择的位置相同，请重新进行选择。。",i,k)
				self:notify_tips(selfId,msg)
				return
			end
		end
	end
	self:BeginAddItem()
	for i,j in ipairs(select_idx) do
		self:AddItem(item[j].id,item[j].num,item[j].bind)
	end
	if not self:EndAddItem(selfId) then
		return
	end
	self:LuaFnDecItemLayCount(selfId,bagpos,1)
	self:AddItemListToHuman(selfId)
	for i,j in ipairs(select_idx) do
		self:GiveItemTip(selfId,item[j].id,item[j].num,18)
	end
end

function custom_gift_box:OnActivateEachTick(selfId)
    return 1
end

return custom_gift_box
