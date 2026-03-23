local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_100019_38000958 = class("item_100019_38000958", script_base)
item_100019_38000958.script_id = 100019

item_100019_38000958.EquipMaxSlot = 0			--0-4孔  即打上0-4个宝石

item_100019_38000958.Equip = 
{
	10100001,-- 武器
	10114001,-- 护腕
	10122002,-- 戒指
	10122002,-- 戒指
	10123002,-- 护符1
	10123002,-- 护符2
}
item_100019_38000958.MenPaiGem = 
{
	[1 ] = {50402005,50403001,50404002,50402005},
	[2 ] = {50402007,50403001,50404002,50402007},
	[3 ] = {50402008,50403001,50404002,50402008},
	[4 ] = {50402006,50403001,50404002,50402006},
	[5 ] = {50402005,50403001,50404002,50402005},
	[6 ] = {50402008,50403001,50404002,50402008},
	[7 ] = {50402005,50403001,50404002,50402005},
	[8 ] = {50402006,50403001,50404002,50402006},
	[9 ] = {50402008,50403001,50404002,50402008},
	-- [10] = {0,0,0,0},
	[11] = {50402008,50403001,50404002,50402008},
}
item_100019_38000958.FangJu = 
{
	{equipid = 10115001,gem = {50412005,50413004,50414001,50412005}},		-- 肩膀
	{equipid = 10110004,gem = {50412006,50413004,50414001,50412006}},       -- 无忧之盔
	{equipid = 10111056,gem = {50412007,50413004,50414001,50412007}},       -- 无忧之鞋
	{equipid = 10112056,gem = {50412008,50413004,50414001,50412008}},       -- 无忧之手
	{equipid = 10113056,gem = {50412005,50413004,50414001,50412006}},       -- 无忧之甲
	{equipid = 10121016,gem = {50412007,50413004,50414001,50412008}},       -- 无忧之带
}
item_100019_38000958.Special = 10420012		--无忧项链
item_100019_38000958.SpecialGem = {50402005,50403001,50413004,50402005}



-- 护腕： 10414054
-- 戒指： 10422152
-- 护符1： 10423060
-- 护符2： 10423061


-- 肩膀： 10415054
-- 10553090  1  2  10  12  1  -1  3  -1  -1  无忧之盔  1  -1
-- 10553091  1  2  11  12  4  -1  3  -1  -1  无忧之鞋  1  -1
-- 10553092  1  2  12  12  3  -1  3  -1  -1  无忧之手  1  -1
-- 10553093  1  2  13  12  2  -1  3  -1  -1  无忧之甲  1  -1
-- 10553094  1  2  21  16  5  -1  3  -1  -1  无忧之带  1  -1
-- 10553095  1  2  20  16  7  -1  3  -1  -1  无忧项链  1  -1



function item_100019_38000958:OnDefaultEvent(selfId, bagIndex)
end

function item_100019_38000958:IsSkillLikeScript(selfId)
    return 1
end

function item_100019_38000958:CancelImpacts(selfId)
    return 0
end

function item_100019_38000958:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId )
	if useid ~= 38000958 then
		return 0
	end
	local havemenpai = self:GetMenPai(selfId)
	if not havemenpai or havemenpai < 0 or havemenpai > 11 or havemenpai == 9 then
		self:notify_tips(selfId, "加入门派后方可打开该道具。")
		return 0
	end
    return 1
end

function item_100019_38000958:OnDeplete(selfId)
    -- if (self:LuaFnDepletingUsedItem(selfId)) then
        -- return 1
    -- end
    return 1
end

function item_100019_38000958:OnActivateOnce(selfId)
    local obj = self.scene:get_obj_by_id(selfId)
	if not obj then
		return 1
	end
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId )
	if useid ~= 38000958 then
		return 1
	end
	local usepos = self:LuaFnGetBagIndexOfUsedItem(selfId)
	if self:LuaFnGetItemTableIndexByIndex(selfId,usepos) ~= useid then
		return 1
	end
	local havemenpai = self:GetMenPai(selfId)
	if not havemenpai or havemenpai < 0 or havemenpai > 11 or havemenpai == 9 then
		self:notify_tips(selfId, "加入门派后方可打开该道具。")
		return 1
	end
	havemenpai = havemenpai + 1
	local mpgem = self.MenPaiGem[havemenpai]
	if not mpgem then
		return 1
	end
	self:BeginAddItem()
	for i,j in ipairs(self.FangJu) do
		self:AddItem(j.equipid,1,true);
	end
	for i,j in ipairs(self.Equip) do
		self:AddItem(j,1,true);
	end
	self:AddItem(self.Special,1,true);
	if not self:EndAddItem(selfId) then
		self:notify_tips(selfId,"背包空间不足")
		return 1
	end
	self:BeginAddItem()
	local human_item_logic = require "human_item_logic"
    local logparam = {}
    local del = human_item_logic:dec_item_lay_count(logparam, obj, usepos, 1)
	if del then
		local packet_def = require "game.packet"
		local logparam = { reason = "新手装备礼盒", user_name = obj:get_name(), user_guid = obj:get_guid(), func_name = "TryRecieveItem", script_id = self.script_id }
		for i,j in ipairs(self.Equip) do
			local _,newpos = human_item_logic:create_multi_item_to_bag(logparam, obj, j, 1, true)
			if newpos ~= define.INVAILD_ID then
				local equip = self:GetBagItem(selfId,newpos)
				if equip then
					for k = 1,self.EquipMaxSlot do
						equip:get_equip_data():add_slot()
						equip:get_equip_data():gem_embed(k,mpgem[k])
					end
					local msg = packet_def.GCItemInfo.new()
					msg.bagIndex = newpos
					msg.item = equip:copy_raw_data()
					self.scene:send2client(obj,msg)
				end
			end
		end
		for i,j in ipairs(self.FangJu) do
			local _,newpos = human_item_logic:create_multi_item_to_bag(logparam, obj, j.equipid, 1, true)
			if newpos ~= define.INVAILD_ID then
				local equip = self:GetBagItem(selfId,newpos)
				if equip then
					for k = 1,self.EquipMaxSlot do
						equip:get_equip_data():add_slot()
						equip:get_equip_data():gem_embed(k,j.gem[k])
					end
					local msg = packet_def.GCItemInfo.new()
					msg.bagIndex = newpos
					msg.item = equip:copy_raw_data()
					self.scene:send2client(obj,msg)
				end
			end
		end
		local _,newpos = human_item_logic:create_multi_item_to_bag(logparam, obj, self.Special, 1, true)
		if newpos ~= define.INVAILD_ID then
			local equip = self:GetBagItem(selfId,newpos)
			if equip then
				for k = 1,self.EquipMaxSlot do
					equip:get_equip_data():add_slot()
					equip:get_equip_data():gem_embed(k,self.SpecialGem[k])
				end
				local msg = packet_def.GCItemInfo.new()
				msg.bagIndex = newpos
				msg.item = equip:copy_raw_data()
				self.scene:send2client(obj,msg)
			end
		end
		self:notify_tips(selfId,"您得到一套新手装备，祝您游戏愉快。")
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
	end
	return 1
end

function item_100019_38000958:OnActivateEachTick(selfId)
    return 1
end

return item_100019_38000958
