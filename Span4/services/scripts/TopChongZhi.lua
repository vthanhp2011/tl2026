--===================================
-- 一掷豪礼千金情
--===================================
local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local TopChongZhi = class("TopChongZhi", script_base)
TopChongZhi.TopChongZhi_GetGiftsCondition =
{
	[1] = { Exch = 30000, Cost = 30000, },
	[2] = { Exch = 60000, Cost = 60000, },
	[3] = { Exch = 120000, Cost = 120000, },
	[4] = { Exch = 300000, Cost = 300000, },
	[5] = { Exch = 600000, Cost = 600000, },
	[6] = { Exch = 900000, Cost = 900000, },
	[7] = { Exch = 1200000, Cost = 1200000, }, 
	[8] = { Exch = 1800000, Cost = 1800000, }, 
}

TopChongZhi.TopChongZhi_Gifts = {
	[1] ={
		{GiftItemID = 50513004, num = 1,},{GiftItemID = 30900045, num = 3,},{GiftItemID = 30900056, num = 2,},{GiftItemID = 30900056, num = 2,}
	,},
	[2] ={
		{GiftItemID = 50513004, num = 1,},{GiftItemID = 30900045, num = 3,},{GiftItemID = 20501003, num = 10,},{GiftItemID = 20502003, num = 10,}
	,},
	[3] ={
		{GiftItemID = 50513004, num = 1,},{GiftItemID = 20310168, num = 200,},{GiftItemID = 38002397, num = 50,},{GiftItemID = 38002498, num = 50,}
	,},
	[4] ={
		{GiftItemID = 50513004, num = 1,},{GiftItemID = 30900057, num = 1,},{GiftItemID = 30900057, num = 1,},{GiftItemID = 30900057, num = 1,}
	,},
	[5] ={
		{GiftItemID = 30900057, num = 1,},{GiftItemID = 30900057, num = 1,},{GiftItemID = 30900057, num = 1,},{GiftItemID = 38002499, num = 50,}
	,},
	[6] ={
		{GiftItemID = 10141095, num = 1,},{GiftItemID = 20501003, num = 15,},{GiftItemID = 20502003, num = 15,},{GiftItemID = 38002397, num = 50,}
	,},
	[7] ={
		{GiftItemID = 10124231, num = 1,},{GiftItemID = 20501004, num = 10,},{GiftItemID = 20502004, num = 10,},{GiftItemID = 38002499, num = 100,}
	,}, 
	[8] ={
		{GiftItemID = 38002540, num = 200,},{GiftItemID = 20501004, num = 10,},{GiftItemID = 20502004, num = 10,}
	,}, 
} 
local TopChongZhiBagSpace = 
{
	[1] = {["Property"] = 3,["Material"] = 1},
	[2] = {["Property"] = 1,["Material"] = 3},
	[3] = {["Property"] = 2,["Material"] = 2},
	[4] = {["Property"] = 1,["Material"] = 1},
	[5] = {["Property"] = 1,["Material"] = 2},
	[6] = {["Property"] = 2,["Material"] = 2},
	[7] = {["Property"] = 2,["Material"] = 2},
	[8] = {["Property"] = 1,["Material"] = 2},
}
function TopChongZhi:OpenTopChongZhi(selfId,targetId)
	local ExchYuanBao = self:GetMissionData(selfId,388)
	local CostYuanBao = self:GetMissionData(selfId,389)
	self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:UICommand_AddInt(ExchYuanBao) --兑换元宝数量 400为比例
		self:UICommand_AddInt(CostYuanBao) --消耗元宝数量
		self:UICommand_AddInt(0)
		local nCurPrize = self:GetMissionData(selfId,390)
		local tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
		for i = 1,8 do
			if tPirzeFlag[i] == 2 then
				self:UICommand_AddInt(tPirzeFlag[i])
				else
				if self.TopChongZhi_GetGiftsCondition[i] ~= nil then
					if ExchYuanBao >= self.TopChongZhi_GetGiftsCondition[i].Exch and CostYuanBao >= self.TopChongZhi_GetGiftsCondition[i].Cost then
						self:UICommand_AddInt(1) --可以兑换
					end
					else
						self:UICommand_AddInt(0) --不可以兑换
				end
			end
		end
	self:EndUICommand()
	self:DispatchUICommand(selfId,18100001)
end

function TopChongZhi:YBCost_GetPrize(selfId,TargetID,nSelectIdx)
	local TopChongZhiTxt = {"一","二","三","四","五","六","七","八"}
	if self.TopChongZhi_GetGiftsCondition[nSelectIdx] == nil then
		return
	end
	if self:GetLevel(selfId) < 15 then
		self:NotifyTips(selfId,"#{CZHL_200916_22}")
		return
	end
	--检查领取情况
	local nCurPrize = self:GetMissionData(selfId,390)
	local tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
	if tPirzeFlag[nSelectIdx] == 2 then
		self:NotifyTips(selfId,string.format("您已领取过%s重豪情礼，无法重复领取。",TopChongZhiTxt[nSelectIdx]))
		return
	end
	local ExchYuanBao = self:GetMissionData(selfId,388)
	local CostYuanBao = self:GetMissionData(selfId,389)
	--检查是否达到条件
	if ExchYuanBao >= self.TopChongZhi_GetGiftsCondition[nSelectIdx].Exch
	and CostYuanBao >=  self.TopChongZhi_GetGiftsCondition[nSelectIdx].Cost then
		--条件到达检查背包
		self:BeginAddItem()
		for i,item in pairs(self.TopChongZhi_Gifts[nSelectIdx]) do
			self:AddItem(item.GiftItemID,item.num,true)
		end
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"背包空间不足。")
			return
		end
		local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
		local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
		if nBagsPos < TopChongZhiBagSpace[nSelectIdx]["Property"] or nBagMaterial < TopChongZhiBagSpace[nSelectIdx]["Material"] then
			self:NotifyTips(selfId,"背包空间不足。")
			return
		end
		self:AddItemListToHuman(selfId)
		--添加领取标记
		tPirzeFlag[nSelectIdx]  = 2;
		nCurPrize = self:MathCilCompute_1_OutEx(tPirzeFlag)
		self:SetMissionData(selfId,390,nCurPrize);
		local nCurPrizeEx = self:GetMissionData(selfId,390)
		local tPirzeFlagEx = self:MathCilCompute_1_InEx(nCurPrizeEx)
	    local Isopen = 0
    	for i = 1,8 do
        	if tPirzeFlagEx[i] == 2 then
        	else
            	Isopen = i
            	break
       		end
    	end
    	if Isopen == 0 then
			self:NotifyTips(selfId,"恭喜您，成功领取了一掷豪礼千金情全部奖励，开启了大理龚彩云得隐藏奖励！")
    	end
		--给兑换提示
		local strGlobalNews = gbk.fromutf8("#P少侠#{_INFOUSR%s}尽显豪侠风范，在#G洛阳钱庄#P的#Y孙进宝#G（65，40）#P处参与#Y一掷千金豪情礼#P活动，获得#G%s重豪情礼")
		self:NotifyTips(selfId,string.format("%s重豪情礼领取成功！",TopChongZhiTxt[nSelectIdx]))
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0);
		self:AddGlobalCountNews(string.format(strGlobalNews, gbk.fromutf8(self:GetName(selfId)),gbk.fromutf8(TopChongZhiTxt[nSelectIdx])), true)
		--奖励领取完毕更新窗口
		self:OpenTopChongZhi(selfId,TargetID)
	else
		self:NotifyTips(selfId, string.format("尚未达到领取%s重豪情礼的条件。",TopChongZhiTxt[nSelectIdx]))
		return
	end
end

function TopChongZhi:NotifyTips(selfId,msg)
	self:BeginEvent()
        self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return TopChongZhi