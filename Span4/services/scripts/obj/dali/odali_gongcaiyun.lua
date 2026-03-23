local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local gbk = require "gbk"
local odali_gongcaiyun = class("odali_gongcaiyun", script_base)
odali_gongcaiyun.script_id = 002089
local MDEX_PRE_RECHAGE_GETD = 408
local MDEX_PRE_RECHAGE_UPGRADE = 409
odali_gongcaiyun.g_eventList = {
    808036,
    808035,
    808058,
    808059,
    808060,
    210242,
    760712,
    808063,
    210243,
    050022,
    808074,
    808075,
    808077,
    808079,
    808038,
    889052,
    889053,
    808129
}
local TopChongZhiData = {127,128,129}
local PetIteminfodata = {30309095,30310018,30309083,30310061,30310084}
local PetIteminfodataEx = {30309098,30310021,30309088,30310065,30310088}
local PrizeTable =
{
	{
		point = 3000000,
		prize = {
			{itemid = 20501004,num = 20},{itemid = 20502004,num = 20},{itemid = 38002397,num = 100},
			{itemid = 38002499,num = 100},{itemid = 30900057,num = 2}
		}
	},
	{
		point = 4800000,
		prize = {
			{itemid = 20501004,num = 20},{itemid = 20502004,num = 20},{itemid = 38002397,num = 100},
			{itemid = 38002499,num = 100},{itemid = 30900057,num = 2}
		}
	},
	{
		point = 6000000,
		prize = {
			{itemid = 20501004,num = 20},{itemid = 20502004,num = 20},{itemid = 38002397,num = 100},
			{itemid = 38002499,num = 100},{itemid = 30900057,num = 2}
		}
	},
	{
		point = 9000000,
		prize = {
			{itemid = 20501004,num = 20},{itemid = 20502004,num = 20},{itemid = 38002397,num = 100},
			{itemid = 38002499,num = 100},{itemid = 30900057,num = 2}
		}
	},
	{
		point = 12000000,
		prize = {
			{itemid = 20501004,num = 25},{itemid = 20502004,num = 25},{itemid = 38002397,num = 100},
			{itemid = 38002499,num = 100},{itemid = 38002943,num = 1}
		}
	},
	{
		point = 15000000,
		prize = {
			{itemid = 20501004,num = 25},{itemid = 20502004,num = 25},{itemid = 38002397,num = 150},
			{itemid = 38002499,num = 150}
		}
	},
	{
		point = 18000000,
		prize = {
			{itemid = 20501004,num = 25},{itemid = 20502004,num = 25},{itemid = 38002397,num = 150 },
			{itemid = 38002499,num = 150}
		}
	},
	{
		point = 21000000,
		prize = {
			{itemid = 20501004,num = 25},{itemid = 20502004,num = 25},{itemid = 38002397,num = 150},
			{itemid = 38002499,num = 150}
		}
	},
	{
		point = 24000000,
		prize = {
			{itemid = 20501004,num = 30},{itemid = 20502004,num = 30},{itemid = 38002397,num = 200},
			{itemid = 38002499,num = 200}
		}
	},
	{
		point = 27000000,
		prize = {
			{itemid = 20501004,num = 30},{itemid = 20502004,num = 30},{itemid = 38002397,num = 200},
			{itemid = 38002499,num = 200}
		}
	},
	{
		point = 30000000,
		prize = {
			{itemid = 20501004,num = 30},{itemid = 20502004,num = 30},{itemid = 38002397,num = 200},
			{itemid = 38002499,num = 200},{itemid = 38002943,num = 1}
		}
	},
	{
		point = 48000000,
		prize = {
			{itemid = 38002943,num = 1}
		}
	},
	{
		point = 60000000,
		prize = {
			{itemid = 38002943,num = 1},{itemid = 70600015, num = 1, soul_level = 5},{title_id = 1240}
		}
	}
}

local PreRecharge_Gift = {
	{
		money = 500,
		prize = {
		}
	},
	{
		money = 1000,
		prize = {
			{itemid = 38000083,num = 1}
		}
	},
	{
		money = 3000,
		prize = {
			{itemid = 38000084,num = 1}
		}
	},
	{
		money = 5000,
		prize = {
			{itemid = 38000085, num = 1}
		}
	}
}

local RechargeGiveLevel = {
	{
		money = 1000,
		give_level = 89,
	},
	{
		money = 2000,
		give_level = 98,
	},
	{
		money = 2000,
		give_level = 98,
	}
}

local PreRechage_NameList = {

}

local PreRecharge_UpGrade_NameList = {
}

local RechargeGiveLevel_NameList = {
}
local AwardPet8000 = {
	{id = 24741, name = "变异安琪儿·辉光"},
	{id = 24821, name = "变异巧巧·锦霞"},
	{id = 24661, name = "变异狭路逢·九幽"},
	{id = 27561, name = "变异七彩辉骏·璇星"},
	{id = 27741, name = "变异鸾凤和鸣·灵犀"},
	{id = 27891, name = "变异飓风圣兽·琉彩"},
}

odali_gongcaiyun.giftdata = {38000087,38000082,38000083,38000084}
function odali_gongcaiyun:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    local strNpcDefault = "#{OBJ_DALI_GONGCAIYUN_DEFAULT}"
	local nExYuanBao = self:GetMissionData(selfId,388)
    local nCurPrize = self:GetMissionData(selfId,390)
	local CostYuanBao = self:GetMissionData(selfId,389)
    local tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
    local Isopen = 0
    for i = 1,8 do
        if tPirzeFlag[i] == 2 then
        else
            Isopen = i
            break
        end
    end
    if Isopen == 0 then
		self:AddNumText("#G领取隐藏回馈",6,1)
    end
	if nExYuanBao >= 250000 and self:GetMissionDataEx(selfId,220) == 0 then
		self:AddNumText("领取珍兽蛋", 6, 30000)
	end
	if nExYuanBao >= 2500000 and self:GetMissionDataEx(selfId,221) == 0 then
		self:AddNumText("领取尚品珍兽蛋", 6, 40000)
	end
	if self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_GETD) == 1 then
		if PreRecharge_UpGrade_NameList[PlayerName] then
			if self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_UPGRADE) == 0 then
				self:AddNumText("领取预充礼包升级",6,50004)
			end
		end
	else
		self:AddNumText("领取预充礼包", 6, 50002)
	end
	if RechargeGiveLevel_NameList[PlayerName] then
		self:AddNumText("充值领等级", 6, 50006)
	end
	if nExYuanBao >= 48000000 then
		if self:GetMissionDataEx(selfId, ScriptGlobal.MDEX_8000_HUIKUI_PET) == 0 then
			self:AddNumText("八万宠物自选", 6, 60000)
		end
	end
	self:AddNumText("角色当前名下可领取奖励", 6, 80000)
    self:AddText(strNpcDefault)
	self:AddText("当前累计消耗元宝数：#G"..CostYuanBao)
	self:AddText(string.format("当前累计领取元宝数：#G%s",self:GetMissionData(selfId,388)))
	self:AddNumText("领取门派高级时装",6,3000)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_gongcaiyun:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_gongcaiyun:OnEventRequest(selfId, targetId, arg, index)
    local nOperation = index
	local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
	local Isok = 0
	local PlayerName = self:GetName(selfId)
	local nIdx = 0;
	local nIdex = 1
	local nPirzeIdx = 1000
	local Idx = 200
	local nExchYuanBao = self:GetMissionData(selfId,388)
	if nOperation == 50001 then
		if nExchYuanBao < 88 * 500 then
			self:NotifyTips(selfId,"累计兑换元宝数不足88元。")
			return
		end
		if self:GetMissionDataEx(selfId,222) > 0 then
			self:NotifyTips(selfId,"无法重复领取此奖励。")
			return
		end
		--判断背包格子
		if nBagsPos < 1 then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:BeginAddItem()
			self:AddItem(20501003,50,true)
			self:AddItem(20502003,50,true)
			self:AddItem(30505076,3,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"背包空间不足")
			return
		end
		self:AddItemListToHuman(selfId)
		self:NotifyTips(selfId,"恭喜少侠，成功领取88元首充礼包成功")
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,222,self:GetDayTime()) --领取记录进去
		self:BeginUICommand()
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1000)
	end
	if nOperation == 60000 then
		self:BeginEvent(self.script_id)
		for i, v in ipairs(AwardPet8000) do
			self:AddNumText(v.name, 6, 60000 + i)
		end
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	end
	if nOperation == 70000 then
		self:BeginEvent(self.script_id)
		self:AddNumText("领取手工材料", 6, 700001)
		self:AddNumText("领取武魂材料", 6, 700002)
		self:AddNumText("领取残篇", 6, 700003)
		self:AddNumText("领取绘金尘", 6, 700004)
		self:AddNumText("领取神魂檀箱", 6, 700005)
		self:AddNumText("领取超级长春玉", 6, 700006)
		self:AddNumText("寒冰星屑", 6, 700007)
		self:AddNumText("102神器材料", 6, 700008)
		self:AddNumText("领取10万点数", 6, 700009)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	end
	if nOperation == 700001 then
		self:BeginAddItem()
		self:AddItem(20501003, 250)
		self:AddItem(20502003, 250)
		self:AddItem(20501004, 250)
		self:AddItem(20502004, 250)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700002 then
		self:BeginAddItem()
		self:AddItem(10156002, 32)
		self:AddItem(10156003, 32)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700003 then
		self:BeginAddItem()
		self:AddItem(20800000, 250)
		self:AddItem(20800002, 250)
		self:AddItem(20800006, 250)
		self:AddItem(20800008, 250)
		self:AddItem(20800010, 250)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700004 then
		self:BeginAddItem()
		self:AddItem(20800012, 250)
		self:AddItem(20800014, 250)
		self:AddItem(20800016, 250)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700005 then
		self:BeginAddItem()
		self:AddItem(38002499, 1000)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700006 then
		self:BeginAddItem()
		self:AddItem(20600003, 250)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700007 then
		self:BeginAddItem()
		self:AddItem(20310113, 250)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700008 then
		self:BeginAddItem()
		self:AddItem(30505706, 1)
		self:AddItem(30505806, 20)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 700009 then
		self:BeginAddItem()
		self:AddItem(38008155, 10)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		return
	end
	if nOperation == 80000 then
		self:ShowCharacterCanGetAward(selfId)
		return
	end
	if nOperation >= 80001 and nOperation < 80015 then
		self:SeeCharacterCanGetAward(selfId, nOperation)
		return
	end
	if nOperation >= 80101 and nOperation < 80115 then
		self:GetCharacterCanGetAward(selfId, nOperation, targetId)
		return
	end
	if nOperation >= 60001 and nOperation <= (60000 + #AwardPet8000) then
		if self:GetMissionDataEx(selfId, ScriptGlobal.MDEX_8000_HUIKUI_PET) == 1 then
			self:notify_tips(selfId, "已领取过80000回馈宝宝")
			return
		end
		if nExchYuanBao < 48000000 then
			self:notify_tips(selfId, "兑换元宝不足")
			return
		end
		self:SetMissionDataEx(selfId, ScriptGlobal.MDEX_8000_HUIKUI_PET, 1)
		local selectOper = nOperation - 60000
		local selectItem = AwardPet8000[selectOper]
		local ret, petGUID_H, petGUID_L = self:CallScriptFunction(800105, "CreateRMBPetToHuman34534", selfId, selectItem.id, 1)
		if ret then
			local dataAttr = math.random(4000, 5000)
			local oriData = self:LuaFnGetPetData(selfId, petGUID_H, petGUID_L, "con_perception")
			local rate = dataAttr / oriData
			for _, key in ipairs({"str_perception", "spr_perception", "con_perception", "dex_perception", "int_perception"}) do
				local ori = self:LuaFnGetPetData(selfId, petGUID_H, petGUID_L, key)
				self:LuaFnSetPetData(selfId, petGUID_H, petGUID_L, key, math.ceil(ori * rate))
			end
			self:LuaFnSetPetData(selfId, petGUID_H, petGUID_L, "growth_rate",2.188)
			self:BeginEvent(self.script_id)
			self:AddText("领取八万自选宠物成功")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		else
			self:BeginEvent(self.script_id)
			self:AddText("领取失败，请联系客服")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		end
		return
	end
	if nOperation == 30000 then
		self:BeginEvent(self.script_id)
		self:AddNumText("领取珍兽蛋：安琪儿",6,30001)
		self:AddNumText("领取珍兽蛋：巧巧",6,30002)
		self:AddNumText("领取珍兽蛋：狭路逢",6,30003)
		self:AddNumText("领取珍兽蛋：七彩辉骏",6,30004)
		self:AddNumText("领取珍兽蛋：鸾凤和鸣",6,30005)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	end
	if nOperation == 40000 then
		self:BeginEvent(self.script_id)
		self:AddNumText("领取尚品珍兽蛋：安琪儿",6,40001)
		self:AddNumText("领取尚品珍兽蛋：巧巧",6,40002)
		self:AddNumText("领取尚品珍兽蛋：狭路逢",6,40003)
		self:AddNumText("领取尚品珍兽蛋：七彩辉骏",6,40004)
		self:AddNumText("领取尚品珍兽蛋：鸾凤和鸣",6,40005)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	end
	if nOperation == 50002 then
		local PreRechageMoney = nExchYuanBao // 600--PreRechage_NameList[PlayerName] or 0--self:LuaFnGetPreRechargeMoney(selfId, PreRecharge_Date, PreRecharge_Date)
		PreRechageMoney = PreRechageMoney >= 1000 and PreRechageMoney or 0
		if PreRechage_NameList[PlayerName] then
			PreRechageMoney = PreRechage_NameList[PlayerName]
		end
		self:ShowPreRechageGiftContent(selfId, PreRechageMoney, targetId)
		return
	end
	if nOperation == 50003 then
		local PreRechageMoney = nExchYuanBao // 600 --PreRechage_NameList[PlayerName] or 0--self:LuaFnGetPreRechargeMoney(selfId, PreRecharge_Date, PreRecharge_Date)
		PreRechageMoney = PreRechageMoney >= 1000 and PreRechageMoney or 0
		if PreRechage_NameList[PlayerName] then
			PreRechageMoney = PreRechage_NameList[PlayerName]
		end
		self:GetPreRechargeGiftAward(selfId, PreRechageMoney, targetId)
		return
	end
	if nOperation == 50004 then
		local PreRechageMoney = PreRechage_NameList[PlayerName] or 0--self:LuaFnGetPreRechargeMoney(selfId, PreRecharge_Date, PreRecharge_Date)
		local PreRechageUpgradeMoney = PreRecharge_UpGrade_NameList[PlayerName] or PreRechageMoney
		self:ShowPreRechageGiftUpgradeContent(selfId, PreRechageMoney, PreRechageUpgradeMoney, targetId)
		return
	end
	if nOperation == 50005 then
		local PreRechageMoney = PreRechage_NameList[PlayerName] or 0--self:LuaFnGetPreRechargeMoney(selfId, PreRecharge_Date, PreRecharge_Date)
		local PreRechageUpgradeMoney = PreRecharge_UpGrade_NameList[PlayerName] or PreRechageMoney
		self:GetPreRechargeGiftUpgradeAward(selfId, PreRechageMoney, PreRechageUpgradeMoney, targetId)
	end
	if nOperation == 50006 then
		local RechargeGiveLevel_Money = RechargeGiveLevel_NameList[PlayerName]
		self:ShowRechargeGiveLevel(selfId, RechargeGiveLevel_Money)
	end
	if nOperation == 50007 then
		local RechargeGiveLevel_Money = RechargeGiveLevel_NameList[PlayerName]
		local give_level = self:GetRechargeGiveLevel(RechargeGiveLevel_Money)
		if give_level then
			local level = self:GetLevel(selfId)
			if level >= give_level then
				self:BeginEvent(self.script_id)
				local content = "您当前等级已超过可领取等级"
				self:AddText(content)
				self:EndEvent()
				self:DispatchEventList(selfId,targetId)
			else
				self:BeginEvent(self.script_id)
				local content = "开始领取等级"
				self:AddText(content)
				self:EndEvent()
				self:DispatchEventList(selfId,targetId)
				local obj_me = self:get_scene():get_obj_by_id(selfId)
				for i = level + 1, give_level do
					obj_me:set_level(i)
					obj_me:on_level_up(i)
				end
			end
		else
			self:BeginEvent(self.script_id)
			local content = "您当前无法直接升级"
			self:AddText(content)
			self:EndEvent()
			self:DispatchEventList(selfId,targetId)
		end
	end
	if nOperation >= 30001 and nOperation <= 30005 then
		local nSelect = (nOperation % 10)
		if nExchYuanBao < 250000 then
			self:NotifyTips(selfId,"累计兑换点数不足500点。")
			return
		end
		if self:GetMissionDataEx(selfId,220) > 0 then
			self:NotifyTips(selfId,"无法重复领取此奖励。")
			return
		end
		--判断背包格子
		if nBagsPos < 1 then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:BeginAddItem()
			self:AddItem(PetIteminfodata[nSelect],1)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:NotifyTips(selfId,"恭喜少侠，成功领取一个"..self:GetItemName(PetIteminfodata[nSelect]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,220,self:GetDayTime()) --领取记录进去
		self:BeginUICommand()
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1000)
	end
	if nOperation >= 40001 and nOperation <= 40005 then
		local nSelect = (nOperation % 10)
		if nExchYuanBao < 2500000 then
			self:NotifyTips(selfId,"累计兑换点数不足5000点。")
			return
		end
		if self:GetMissionDataEx(selfId,221) > 0 then
			self:NotifyTips(selfId,"无法重复领取此奖励。")
			return
		end
		--判断背包格子
		if nBagsPos < 1 then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:BeginAddItem()
			self:AddItem(PetIteminfodataEx[nSelect],1)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏拥有一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:NotifyTips(selfId,"恭喜少侠，成功领取一个"..self:GetItemName(PetIteminfodataEx[nSelect]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,221,self:GetDayTime()) --领取记录进去
		self:BeginUICommand()
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1000)
	end
	--领取门派高级时装
	if nOperation == 3000 then
		self:BeginEvent(self.script_id)
		self:AddText("#Y领取门派高级时装")
		self:AddText("  有一位旅行家曾经惊奇的发现，银皑雪原上的一些怪物身上可能携带神秘的#Y怪物日记本#W。如果你能帮他找来20本#Y怪物日记本#W，就可以得到他赠予的一件门派高级时装。")
		self:AddText("    怎么样，你打算交换吗？")
		self:AddNumText("确定",8,3001)
		self:AddNumText("取消",8,3002)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	end
	if nOperation == 3001 then
		if self:GetMenPai(selfId) == 9 then
			self:BeginEvent(self.script_id)
			self:AddText("  你还没有加入一个门派，只有九大门派的弟子才能兑换门派高级时装啊。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
			return
		end
		-- 1，检测玩家身上是不是有足够的石头
		local HaveAllItem = 1
		if (self:GetItemCount(selfId, self.guaiwuriji[1]) + self:GetItemCount(selfId,self.guaiwuriji[2])) < self.guaiwurijicount then
			HaveAllItem = 0
		end
		if HaveAllItem == 0 then
			self:BeginEvent(self.script_id)
			self:AddText("  你需要拿20个怪物日记本才能兑换门派高级时装。" );
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
			return
		end
		-- 2，检测玩家的这套碎片是不是都能够删除
		local AllItemCanDelete = 1
		local Stone1_Num = self:LuaFnGetAvailableItemCount(selfId,self.guaiwuriji[1])
		local Stone2_Num = self:LuaFnGetAvailableItemCount(selfId,self.guaiwuriji[2])

		if Stone1_Num+Stone2_Num < self.guaiwurijicount   then
			AllItemCanDelete = 0
		end
		if AllItemCanDelete == 0 then
			self:BeginEvent(self.script_id)
			self:AddText("    扣除你身上的物品失败，请检测你是否对物品加锁，或者物品处于交易状态。" );
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
			return
		end
		--扣除物品前获得物品
		local bagpos = -1
		if Stone1_Num > 0 then
		  bagpos = self:GetBagPosByItemSn(selfId,self.guaiwuriji[1])
		elseif Stone1_Num == 0 and Stone2_Num > 0 then
		  bagpos = self:GetBagPosByItemSn(selfId,self.guaiwuriji[2])
		end
		self:NotifyTips(selfId,bagpos)
		local GemItemInfo
		if bagpos ~= -1 then
		  GemItemInfo = self:GetBagItemTransfer(selfId, bagpos )
		end
		-- 3，检测玩家身上是不是有空间放奖励
		local nItemId = 0
		local nMenpaiName = ""
		for i=1, 11 do
			if self:GetMenPai(selfId) == self.MenPaiDress[i].mp  then
				nItemId = self.MenPaiDress[i].Item
				nMenpaiName = self.MenPaiDress[i].mpname
			end
		end
		if nItemId==0  then
			return
		end

	 	self:BeginAddItem()
			self:AddItem(nItemId, 1 )
		local ret = self:EndAddItem(selfId)
		local delret = 1
		if ret then
		--开始扣除物品
			local DeleteNum = self:LuaFnGetAvailableItemCount(selfId,self.guaiwuriji[1]);
			if(DeleteNum >= self.guaiwurijicount) then
			--扣除绑定的
				if not self:LuaFnDelAvailableItem(selfId,self.guaiwuriji[1],self.guaiwurijicount) then
					delret = 0
				end
			elseif(DeleteNum == 0) then
			--扣除没有绑定的
				if not self:LuaFnDelAvailableItem(selfId,self.guaiwuriji[2],self.guaiwurijicount) then
					delret = 0
				end
			else
			--先扣除没绑定的再扣除绑定的
				if not self:LuaFnDelAvailableItem(selfId,self.guaiwuriji[1], DeleteNum)   then
					delret = 0
				end
				
				DeleteNum = self.guaiwurijicount - DeleteNum;  --还要删除的
				if not self:LuaFnDelAvailableItem(selfId,self.guaiwuriji[2], DeleteNum)   then
					delret = 0
				end
				
			end
			
			if delret == 1  then
				self:AddItemListToHuman(selfId)
				self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,1000)
				-- 提示玩家
				self:BeginEvent(self.script_id)
					self:AddText( "您获得了" .. nMenpaiName .. "的高级门派套装一件。" );
				self:EndEvent()
				self:DispatchMissionTips(selfId)
				
				-- 发世界公告
				local str = ""
				local rand = math.random(3)
				
				if rand == 1  then
					str = string.format("#P突然！天昏地暗，众人皆不知所措，原来是#{_INFOUSR%s}使用#G20本怪物日记本#P换取到了无出其右羡煞旁人的#G %s高级门派时装#P！",self:GetName(selfId), nMenpaiName)
				elseif rand == 2  then
					str = string.format("#P哇呀！#{_INFOUSR%s}使用#G20本怪物日记本#P换到了#G %s高级门派时装#P，穿上后真是惊人的耀眼！", self:GetName(selfId), nMenpaiName)
				else
					str = string.format("#P#{_INFOUSR%s}使用#G20本怪物日记本#P换到了#G %s高级门派时装#P！恭喜！恭喜！再恭喜！", self:GetName(selfId), nMenpaiName)
				end
				
				self:BroadMsgByChatPipe(selfId,gbk.fromutf8(str), 4)
				
				-- 关闭窗口
				self:BeginUICommand()
				self:EndUICommand()
				self:DispatchUICommand(selfId, 1000)
				return
			end
		end
		return
	end
	if nOperation == 3002 then
		self:BeginUICommand()
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1000)
		return
	end
	if nOperation == 1 then
		self:BeginEvent(self.script_id)
			for i = 1,13 do
				if nExchYuanBao >= PrizeTable[i].point then
					nIdx = i;
				end
			end
			if nIdx > 0 then
				for j = nIdex,nIdx do
					self:AddNumText("领取兑换"..tostring(PrizeTable[j].point).."元宝奖励", 6, Idx + j);
				end
				else
				self:AddText(string.format("下一重数达成要求领取元宝：#G%s。",tostring(PrizeTable[nIdx+1].point)))
			end
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
	end
	if nOperation >= 200 and nOperation < 300 then
		local nSelect = nOperation - 200
		self:BeginEvent(self.script_id)
			self:AddText("当前重数奖励：")
			for i = 1,#(PrizeTable[nSelect].prize) do
				if PrizeTable[nSelect].prize[i].itemid then
					self:AddText(string.format("%s *%s个",
					self:GetItemName(PrizeTable[nSelect].prize[i].itemid),
					tostring(PrizeTable[nSelect].prize[i].num)))
				end
			end
			self:AddText("当前充值点数：#G"..nExchYuanBao)
			self:AddNumText("确认领取",6,nSelect + nPirzeIdx);
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
	end
	if nOperation >= 1000 then
		if #(PrizeTable) > 20 then
			self:NotifyTips(selfId, "表太大了！！！！联系客服解决吧" )
			return
		end
		local nSelect = nOperation - 1000
		if PrizeTable[nSelect] == nil then
			return
		end
		local nExchYuanBao = self:GetMissionData(selfId,388)
		if nExchYuanBao < PrizeTable[nSelect].point then
			self:NotifyTips( selfId, "累计充值元宝数不足"..PrizeTable[nSelect].point.."点，无法领取。" )
			return
		end
		local nStateIdx = (nSelect % 10)
		local nMdExIdx = math.floor(nSelect / 10)
		
		local nStateData = self:GetMissionDataEx(selfId,TopChongZhiData[nMdExIdx + 1]);
		local tState = self:MathCilCompute_1_InEx(nStateData);
		if tState[nStateIdx + 1] == 1 then
			self:NotifyTips( selfId, "该奖励已经领取" )
			return
		end
		--检测背包够不够
		self:BeginAddItem()
		local pet_soul_level
		for i,item in pairs(PrizeTable[nSelect].prize) do
			if item.title_id then
				if not self:LuaFnHaveAgname(selfId, item.title_id) then
					self:LuaFnAddNewAgname(selfId, item.title_id)
				end
			else
				self:AddItem(item.itemid,item.num,true)
				if item.soul_level then
					pet_soul_level = item.soul_level
				end
			end
		end
		if not self:EndAddItem(selfId) then
			self:NotifyTips( selfId, "背包空间不足" )
			return
		end
		local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
		local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
		if nBagsPos < 3 or nBagMaterial < 2 then
			self:NotifyTips(selfId,"背包空间不足。")
			return
		end
		self:AddItemListToHuman(selfId)
		if pet_soul_level then
			local BagPos = self:GetBagPosByItemSn(selfId, 70600015)
			self:SetPetSoulLevel(selfId, BagPos, pet_soul_level)
		end
		--标记兑换
		tState[nStateIdx + 1] = 1;
		nStateData = self:MathCilCompute_1_OutEx(tState)
		self:SetMissionDataEx(selfId,TopChongZhiData[nMdExIdx + 1],nStateData);
		self:NotifyTips( selfId, "领取成功，请查看您的背包" )
		self:OnEventRequest(selfId, targetId,self.script_id, 1)
	end
end

function odali_gongcaiyun:ShowCharacterCanGetAward(selfId, targetId)
	local awards = self:GetCanGetAwardList(selfId)
	self:BeginEvent(self.script_id)
	if #awards > 0 then
		self:AddText("当前可领取的奖励:")
		for i = 1, 15 do
			local award = awards[i]
			if award then
				self:AddNumText(award.award_name, 6, 80000 + i)
			end
		end
	else
		self:AddText("当前没有可领取的奖励")
	end
	self:EndEvent()
	self:DispatchEventList(selfId, targetId)
end

function odali_gongcaiyun:SeeCharacterCanGetAward(selfId, nOperation)
	local index = nOperation - 80000
	local award_list = self:GetCanGetAwardList(selfId)
	local awards = award_list[index]
	if awards == nil then
		self:notify_tips(selfId, "没有奖励可以领取")
		return
	end
	self:BeginEvent(self.script_id)
	local content = string.format("您当前可以领取的%s内容为:", awards.award_name)
	self:AddText(content)
	for _, p in ipairs(awards.award_list) do
		p.itemid = math.floor(p.itemid)
        if p.itemid then
            local item_name = self:GetItemName(p.itemid)
            if p.soul_level then
                self:AddText(item_name .. " " .. p.soul_level + 1 .. "阶 X" ..  math.floor(p.num))
            else
                self:AddText(item_name .. "X" .. math.floor(p.num))
            end
        end
	end
	self:AddNumText("确认领取",6, 100 + nOperation )
	self:EndEvent()
	self:DispatchEventList(selfId,-1)
end

function odali_gongcaiyun:GetCharacterCanGetAward(selfId, nOperation, targetId)
	local index = nOperation - 80100
	local award_list = self:GetCanGetAwardList(selfId)
	local awards = award_list[index]
	if awards == nil then
		self:notify_tips(selfId, "没有奖励可以领取")
		return
	end
	self:BeginAddItem()
	local pet_soul_level
	for _,item in pairs(awards.award_list) do
        if item.title_id then
            if not self:LuaFnHaveAgname(selfId, item.title_id) then
                self:LuaFnAddNewAgname(selfId, item.title_id)
            end
        else
            self:AddItem(item.itemid, item.num, true)
            if item.soul_level then
                pet_soul_level = item.soul_level
            end
        end
	end
	if not self:EndAddItem(selfId) then
		self:NotifyTips( selfId, "背包空间不足" )
		return
	end
	self:RemoveCanGetAward(awards.id)
	self:AddItemListToHuman(selfId)
	if pet_soul_level then
		local BagPos = self:GetBagPosByItemSn(selfId, 70600015)
		self:SetPetSoulLevel(selfId, BagPos, pet_soul_level)
	end
	self:BeginEvent(self.script_id)
	self:AddText(string.format("%s领取成功", awards.award_name))
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_gongcaiyun:GetCanGetAwardList(selfId)
	local guid = self:LuaFnGetGUID(selfId)
	local skynet = require "skynet"
    local query_tbl = { guid = guid, status = 0}
    local coll_name = "can_get_awards"
    local response = skynet.call(".char_db", "lua", "findAll", { collection = coll_name, query = query_tbl})
	response = response or {}
	local list = {}
	for _, resp in ipairs(response) do
		local award_name = resp.award_name
		local award_list = resp.award_list
		local id = resp["_id"]
		table.insert(list, { award_name = award_name, award_list = award_list, id = id })
	end
	return list
end

function odali_gongcaiyun:RemoveCanGetAward(id)
	local selector = {["_id"] = id}
    local updater = {}
    updater["$set"] = { status = 1 }
    local sql = { collection = "can_get_awards", selector = selector, update = updater}
	local skynet = require "skynet"
    skynet.call(".char_db", "lua", "safe_update", sql)
end

function odali_gongcaiyun:LuaFnGetPetData(selfId, petGUID_H, petGUID_L, key)
    local obj = self.scene:get_obj_by_id(selfId)
    local container = obj:get_pet_bag_container()
	local pet_guid_cls = require "pet_guid"
    local guid = pet_guid_cls.new()
    guid:set(petGUID_H, petGUID_L)
    local pet_detail = container:get_pet_by_guid(guid)
    return pet_detail:get_attrib(key)
end

function odali_gongcaiyun:ShowRechargeGiveLevel(selfId, Money, targetId)
	local give_level = self:GetRechargeGiveLevel(Money)
	self:BeginEvent(self.script_id)
	local content = string.format("您当前可以直接升级至: %d级", give_level)
	self:AddText(content)
	self:AddNumText("确认升级",6, 50007)
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_gongcaiyun:GetRechargeGiveLevel(nPreMoney)
	for i = #RechargeGiveLevel, 1, -1 do
		local gift = RechargeGiveLevel[i]
		if gift.money <= nPreMoney then
			return gift.give_level
		end
	end
end

function odali_gongcaiyun:ShowPreRechageGiftContent(selfId, PreMoney, targetId)
	local val = self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_GETD)
	if val ~= 0 then
		self:BeginEvent(self.script_id)
		self:AddText("预充奖励已领取")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local gift_config = self:GetPreRechargeGiftContent(PreMoney)
	if gift_config == nil then
		self:BeginEvent(self.script_id)
		self:AddText(string.format("您当前预充数额为%d元, 没有预充礼包可以领取", PreMoney))
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local prize = gift_config.prize
	self:BeginEvent(self.script_id)
	local content = "您当前可以领取的预充礼包内容为:"
	self:AddText(content)
	for _, p in ipairs(prize) do
        if p.itemid then
            local item_name = self:GetItemName(p.itemid)
            if p.soul_level then
                self:AddText(item_name .. " " .. p.soul_level + 1 .. "阶 X" .. p.num)
            else
                self:AddText(item_name .. "X" .. p.num)
            end
        end
	end
	self:AddText("预充礼包只能领取1个")
	self:AddNumText("确认领取",6, 50003)
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_gongcaiyun:GetPreRechargeGiftAward(selfId, PreMoney, targetId)
	local val = self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_GETD)
	if val ~= 0 then
		self:BeginEvent(self.script_id)
		self:AddText("预充奖励已领取")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local gift_config = self:GetPreRechargeGiftContent(PreMoney)
	if gift_config == nil then
		self:BeginEvent(self.script_id)
		self:AddText(string.format("您当前预充数额为%d元, 没有预充礼包可以领取", PreMoney))
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	self:SetMissionDataEx(selfId, MDEX_PRE_RECHAGE_GETD, 1)
	self:BeginAddItem()
	local pet_soul_level
	for i,item in pairs(gift_config.prize) do
        if item.title_id then
            if not self:LuaFnHaveAgname(selfId, item.title_id) then
                self:LuaFnAddNewAgname(selfId, item.title_id)
            end
        else
            self:AddItem(item.itemid, item.num, true)
            if item.soul_level then
                pet_soul_level = item.soul_level
            end
        end
	end
	if not self:EndAddItem(selfId) then
		self:NotifyTips( selfId, "背包空间不足" )
		return
	end
	self:AddItemListToHuman(selfId)
	if pet_soul_level then
		local BagPos = self:GetBagPosByItemSn(selfId, 70600015)
		self:SetPetSoulLevel(selfId, BagPos, pet_soul_level)
	end
	self:BeginEvent(self.script_id)
	self:AddText("预充奖励领取成功")
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_gongcaiyun:ShowPreRechageGiftUpgradeContent(selfId, PreRechageMoney, PreRechageUpgradeMoney, targetId)
	local val = self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_GETD)
	if val == 0 then
		self:BeginEvent(self.script_id)
		self:AddText("第一次预充奖励未领取")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	if PreRechageMoney == PreRechageUpgradeMoney then
		self:BeginEvent(self.script_id)
		self:AddText("未达到新的预充档位")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	if PreRechageMoney > PreRechageUpgradeMoney then
		self:BeginEvent(self.script_id)
		self:AddText("配置异常")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local val_upgrade = self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_UPGRADE)
	if val_upgrade ~= 0 then
		self:BeginEvent(self.script_id)
		self:AddText("预充奖励已升级")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local prize = self:GetPreRechargeGiftUpgradeContent(PreRechageMoney, PreRechageUpgradeMoney)
	self:BeginEvent(self.script_id)
	local content = "你当前升级预充礼包后可以获得:"
	self:AddText(content)
	for _, p in ipairs(prize) do
		local item_name = self:GetItemName(p.itemid)
		if p.soul_level then
			self:AddText(item_name .. " " .. p.soul_level + 1 .. "阶 X" .. p.num)
		elseif p.upgrade_soul_level then
			self:AddText(item_name .. " 升级到 " .. p.upgrade_soul_level + 1 .. "阶")
		else
			self:AddText(item_name .. "X" .. p.num)
		end
	end
	self:AddText("预充礼包只能升级1次,升级后将不能再次领取")
	self:AddNumText("确认领取",6, 50005)
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_gongcaiyun:GetPreRechargeGiftUpgradeAward(selfId, PreRechageMoney, PreRechageUpgradeMoney, targetId)
	local val = self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_GETD)
	if val == 0 then
		self:BeginEvent(self.script_id)
		self:AddText("第一次预充奖励未领取")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	if PreRechageMoney == PreRechageUpgradeMoney then
		self:BeginEvent(self.script_id)
		self:AddText("未达到新的预充档位")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	if PreRechageMoney > PreRechageUpgradeMoney then
		self:BeginEvent(self.script_id)
		self:AddText("配置异常")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local val_upgrade = self:GetMissionDataEx(selfId, MDEX_PRE_RECHAGE_UPGRADE)
	if val_upgrade ~= 0 then
		self:BeginEvent(self.script_id)
		self:AddText("预充奖励已升级")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local gift_config, upgrade_soul_level_item_id = self:GetPreRechargeGiftUpgradeContent(PreRechageMoney, PreRechageUpgradeMoney)
	if #gift_config == 0 then
		self:BeginEvent(self.script_id)
		self:AddText("配置异常2")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	if upgrade_soul_level_item_id then
		local BagPos = self:GetBagPosByItemSn(selfId, upgrade_soul_level_item_id)
		if BagPos == define.INVAILD_ID then
			local item_name = self:GetItemName(upgrade_soul_level_item_id)
			self:BeginEvent(self.script_id)
			self:AddText("请将要升级的" .. item_name .. "放入背包")
			self:EndEvent()
			self:DispatchEventList(selfId,targetId)
			return
		end
	end
	self:SetMissionDataEx(selfId, MDEX_PRE_RECHAGE_UPGRADE, 1)
	self:BeginAddItem()
	local pet_soul_level
	local upgrade_soul_level_item
	for i,item in pairs(gift_config) do
		if item.upgrade_soul_level then
			upgrade_soul_level_item = item
		else
			self:AddItem(item.itemid, item.num, true)
			if item.soul_level then
				pet_soul_level = item.soul_level
			end
		end
	end
	if not self:EndAddItem(selfId) then
		self:NotifyTips( selfId, "背包空间不足" )
		return
	end
	self:AddItemListToHuman(selfId)
	if pet_soul_level then
		local BagPos = self:GetBagPosByItemSn(selfId, 70600015)
		self:SetPetSoulLevel(selfId, BagPos, pet_soul_level)
	end
	if upgrade_soul_level_item then
		local BagPos = self:GetBagPosByItemSn(selfId, upgrade_soul_level_item.itemid)
		self:SetPetSoulLevel(selfId, BagPos, upgrade_soul_level_item.upgrade_soul_level)
	end
	self:BeginEvent(self.script_id)
	self:AddText("预充奖励领取成功")
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_gongcaiyun:GetPreRechargeGiftContent(nPreMoney)
	local gifts = {prize = {}}
	for i = #PreRecharge_Gift, 1, -1 do
		local gift = PreRecharge_Gift[i]
		if gift.money <= nPreMoney then
			for _, p in ipairs(gift.prize) do
				table.insert(gifts.prize, p)
			end
		end
	end
	if #gifts.prize == 0 then
		return
	end
	return gifts
end

function odali_gongcaiyun:GetPreRechargeGiftUpgradeContent(nPreMoney, nPreUpMoney)
	local gift_1 = self:GetPreRechargeGiftContent(nPreMoney)
	local gift_2 = self:GetPreRechargeGiftContent(nPreUpMoney)
	if gift_1 == nil then
		return gift_2
	end
	local gift = {}
	local upgrade_soul_level_item_id = nil
	for _, g2 in ipairs(gift_2.prize) do
		local insert = false
		for _, g1 in ipairs(gift_1.prize) do
			if g2.itemid == g1.itemid then
				insert = true
				if g2.soul_level then
					table.insert(gift, { itemid = g2.itemid, num = 1, upgrade_soul_level = g2.soul_level })
					upgrade_soul_level_item_id = g2.itemid
				else
					table.insert(gift, { itemid = g2.itemid, num = g2.num - g1.num})
				end
				break
			end
		end
		if not insert then
			table.insert(gift, { itemid = g2.itemid, num = g2.num, soul_level = g2.soul_level})
		end
	end
	return gift, upgrade_soul_level_item_id
end

function odali_gongcaiyun:SetPetSoulLevel(selfId, BagPos, level)
	local human = self:get_scene():get_obj_by_id(selfId)
	local prop_bag_container = human:get_prop_bag_container()
	local item = prop_bag_container:get_item(BagPos)
	item:get_pet_equip_data():set_pet_soul_level(level)
	self:LuaFnRefreshItemInfo(selfId, BagPos)
end

function odali_gongcaiyun:OnMissionAccept(selfId, targetId, missionScriptId)
end

function odali_gongcaiyun:OnMissionRefuse(selfId, targetId, missionScriptId)
end

function odali_gongcaiyun:OnMissionContinue(selfId, targetId, missionScriptId)
end

function odali_gongcaiyun:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function odali_gongcaiyun:OnDie(selfId, killerId)
end

function odali_gongcaiyun:NotifyTips(selfId,msg)
	self:BeginEvent()
        self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end
return odali_gongcaiyun
