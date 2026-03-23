-- 宠物悟性提升
local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local petsavvyggd = class("petsavvyggd", script_base)
local g_Name = "云霏霏"
-- 悟性等级对应元宝
local YuanBaoCosts = {
	[0] = 96000,
	[1] = 94000,
	[2] = 93000,
	[3] = 92000,
	[4] = 91000,
	[5] = 81000,
	[6] = 79000,
	[7] = 76000,
	[8] = 74000,
	[9] = 1550,
}
function petsavvyggd:OnDefaultEvent(selfId, targetId)
    if self:GetName(targetId) ~= g_Name then		--判断该 npc 是否是指定的npc
		return
	end
	self:BeginUICommand()
    self:UICommand_AddInt(targetId)
	self:EndUICommand()
	self:DispatchUICommand(selfId, 19820425)
end

function petsavvyggd:OnEnumerate(caller, _, targetId)
    if self:GetName(targetId) ~= g_Name then		--判断该 npc 是否是指定的npc
		return
	end
    caller:AddNumTextWithTarget(self.script_id, "用成年珍兽提升悟性", 6, -2)
    caller:AddNumTextWithTarget(self.script_id, "使用根骨丹提升悟性", 6, -1)
end

function petsavvyggd:PetSavvy(selfId, mainPetGuidH, mainPetGuidL, check)
	local savvy = self:GetPetSavvy(selfId, mainPetGuidH, mainPetGuidL )
	if savvy == 10 then
		self:notfiy_tips(selfId, "悟性已经打到最高，不能再提升！" )
		return 0
	end
	local cost = self:GetCostOfGenGuBySavvy(savvy)
	local succRate = self:GetSuccrateOfGenGuBySavvy(savvy)
	local rand = math.random(100)
	--检查 跟骨 丹
	local nSavvyNeed = savvy + 1
	local nItemIdGenGuDan = 0
	local msgTemp
	if nSavvyNeed >= 1 and nSavvyNeed <= 3 then
		msgTemp = "低"
		nItemIdGenGuDan = 30502000
	elseif nSavvyNeed >= 4 and nSavvyNeed <= 6 then
		msgTemp = "中"
		nItemIdGenGuDan = 30502001
	elseif nSavvyNeed >= 7 and nSavvyNeed <= 10 then
		msgTemp = "高"
		nItemIdGenGuDan = 30502002
	end
	local nYaoDingCount = self:LuaFnGetAvailableItemCount(selfId, nItemIdGenGuDan)
	if nYaoDingCount <= 0 then
		if nSavvyNeed >= 1 and nSavvyNeed <= 3 then
			--没有绑定的低级根骨丹
			nItemIdGenGuDan = 30502000
			nYaoDingCount = self:LuaFnGetAvailableItemCount(selfId, nItemIdGenGuDan)
			if nYaoDingCount<= 0 then
				self:PetSavvy_YuanbaoPay(selfId, nItemIdGenGuDan, check)
				return 0
			end
		else
			self:PetSavvy_YuanbaoPay(selfId, nItemIdGenGuDan, check)
			return 0
		end
	end
	local SelfMoney = self:GetMoney(selfId)  +  self:GetMoneyJZ(selfId)
	if SelfMoney < cost then
		return 0
	end
	--删除跟骨 丹
	local bRet = self:LuaFnDelAvailableItem(selfId, nItemIdGenGuDan, 1)
	if not bRet then
		local msg = string.format("删除道具失败！")
		self:notify_tips(selfId, msg )
		return 0
	end
	local costRet = self:LuaFnCostMoneyWithPriority(selfId, cost)
	if not costRet then
		return 0
	end
    print("rand > succRate", rand, succRate)
	if rand > succRate then
		local nSavvyDown = self:GetLeveldownOfCompoundBySavvy(savvy )
		if nSavvyDown > savvy then
			nSavvyDown = savvy
        end
		self:SetPetSavvy(selfId, mainPetGuidH, mainPetGuidL, savvy - nSavvyDown )
		local msg = string.format("合成失败，目前珍兽的悟性为%d", savvy - nSavvyDown )
		self:notify_tips(selfId, msg )
		return 0
	end
	self:SetPetSavvy(selfId, mainPetGuidH, mainPetGuidL, nSavvyNeed )
	local szPlayerName, szPetTransString
	szPetTransString = self:GetPetTransString( selfId, mainPetGuidH, mainPetGuidL );
	szPlayerName = self:GetName(selfId )
	local msg = string.format("恭喜您，合成成功，您的珍兽悟性＋1。")
	self:notify_tips(selfId, msg )

	--成功的光效
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
	if nSavvyNeed >= 7 then
		local szMsg;
		szMsg = string.format("#{_INFOUSR%s}#{ZW_1}#{_INFOMSG%s}#{ZW_2}%d#{ZW_3}", gbk.fromutf8(szPlayerName), szPetTransString, nSavvyNeed )
		self:BroadMsgByChatPipe(selfId, szMsg, 4)
	end
end

function petsavvyggd:PetSavvy_YuanbaoPay(selfId, ItemIndex, check)
	local hint = "#{ZSYB_160113_28"
	local index, merchadise = self:GetMerchadiseByItemIndex(selfId, ItemIndex)
	if index == nil then
		return
	end
	self:BeginUICommand()
	self:UICommand_AddInt(5)
	self:UICommand_AddInt(5)
	self:UICommand_AddInt(merchadise.price)
	self:UICommand_AddInt(index - 1)
	self:UICommand_AddInt(0)
	self:UICommand_AddInt(self.script_id)
	self:UICommand_AddInt(check)
	self:UICommand_AddInt(131071)
	self:UICommand_AddInt(1)
	local str = self:ContactArgs(hint, merchadise.id, merchadise.price, "#{XFYH_20120221_10}", "#{XFYH_20120221_12}", merchadise.pnum or 1, merchadise.id) .. "}"
	self:UICommand_AddStr(str)
	self:EndUICommand()
	self:DispatchUICommand(selfId, 20120222)
end

function petsavvyggd:QuickPetSavvy(selfId, mainPetGuidH, mainPetGuidL)
	local savvy = self:GetPetSavvy(selfId, mainPetGuidH, mainPetGuidL )
	if savvy == 10 then
		self:notfiy_tips(selfId, "悟性已经打到最高，不能再提升！" )
		return 0
	end
	local cost = YuanBaoCosts[savvy]
	local my_yuanbao = self:GetYuanBao(selfId)
    if my_yuanbao < cost then
		self:notify_tips(selfId, "元宝不足" )
		return
    end
    self:LuaFnCostYuanBao(selfId, cost)
    savvy = 10
	self:SetPetSavvy(selfId, mainPetGuidH, mainPetGuidL, savvy)
	local szPlayerName, szPetTransString
	szPetTransString = self:GetPetTransString( selfId, mainPetGuidH, mainPetGuidL );
	szPlayerName = self:GetName(selfId )
	szPlayerName = gbk.fromutf8(szPlayerName)
    local szMsg = string.format("#{_INFOUSR%s}#{ZW_1}#{_INFOMSG%s}#{ZW_2}%d#{ZW_3}",szPlayerName, szPetTransString, savvy)
    self:BroadMsgByChatPipe(selfId, szMsg, 4)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
end

return petsavvyggd