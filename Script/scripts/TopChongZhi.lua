--===================================
-- 一掷豪礼千金情
--===================================
local gbk = require "gbk"
local class = require "class"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local TopChongZhi = class("TopChongZhi", script_base)

--暂用，这个功能需重写，分配太乱了
--充值1重 默认
TopChongZhi.Openlv = 8				--开启重数  最多八重  下面数据配置要保留重数
--充值2重
TopChongZhi.Openlv_ex = 0				--开启重数  最多八重  下面数据配置要保留重数
--0元  充值过默认转移
TopChongZhi.Openlv_zero = 8				--开启重数  最多八重  下面数据配置要保留重数
--充值1重 默认 需求
TopChongZhi.TopChongZhi_GetGiftsCondition =
{
	[1] = { Exch = 50, Cost = 50000, },
	[2] = { Exch = 100, Cost = 100000, },
	[3] = { Exch = 150, Cost = 150000, },
	[4] = { Exch = 200, Cost = 200000, },
	[5] = { Exch = 250, Cost = 250000, },
	[6] = { Exch = 300, Cost = 300000, },
	[7] = { Exch = 400, Cost = 400000, },
	[8] = { Exch = 500, Cost = 500000, },
}
--充值2重 需求
TopChongZhi.TopChongZhi_GetGiftsCondition_ex =
{
	[1] = { Exch = 800, Cost = 4000000, },
	[2] = { Exch = 1000, Cost = 5000000, },
	[3] = { Exch = 1300, Cost = 6500000, },
	[4] = { Exch = 1500, Cost = 7500000, },
	[5] = { Exch = 1800, Cost = 9000000, },
	[6] = { Exch = 2000, Cost = 10000000, },
	[7] = { Exch = 2500, Cost = 12500000, },
	[8] = { Exch = 3000, Cost = 15000000, },
}
--0元  需求
TopChongZhi.TopChongZhi_GetGiftsCondition_zero =
{
	[1] = { Exch = 0, Cost = 0, },
	[2] = { Exch = 0, Cost = 0, },
	[3] = { Exch = 0, Cost = 0, },
	[4] = { Exch = 0, Cost = 0, },
	[5] = { Exch = 0, Cost = 0, },
	[6] = { Exch = 0, Cost = 0, },
	[7] = { Exch = 0, Cost = 0, },
	[8] = { Exch = 0, Cost = 0, },
}
--充值1重 默认  奖励
TopChongZhi.TopChongZhi_Gifts = {
	[1] ={
		{GiftItemID = 20501003, num = 10,},{GiftItemID = 20502003, num = 10,},{GiftItemID = 38000220, num = 1,},{GiftItemID = 10415055, num = 1,}
	,},
	[2] ={
		{GiftItemID = 20800012, num = 100,},{GiftItemID = 20310166, num = 100,},{GiftItemID = 20310174, num = 100,},{GiftItemID = 38008160, num = 100,}
	,},
	[3] ={
		{GiftItemID = 30900132, num = 2,},{GiftItemID = 38002397, num = 100,},{GiftItemID = 20500003, num = 10,},{GiftItemID = 38008160, num = 100,}
	,},
	[4] ={
		{GiftItemID = 30900132, num = 2,},{GiftItemID = 38002499, num = 100,},{GiftItemID = 38003055, num = 5,},{GiftItemID = 38008160, num = 150,}
	,},
	[5] ={
		{GiftItemID = 30900132, num = 2,},{GiftItemID = 38002397, num = 100,},{GiftItemID = 10155003, num = 1,},{GiftItemID = 38008160, num = 150,}
	,},
	[6] ={
		{GiftItemID = 30900132, num = 2,},{GiftItemID = 38008166, num = 1,},{GiftItemID = 38008167, num = 1,},{GiftItemID = 30505906, num = 1,}
	,},
	[7] ={
		{GiftItemID = 30900132, num = 2,},{GiftItemID = 38003055, num = 10,},{GiftItemID = 30900057, num = 2,},{GiftItemID = 38008160, num = 150,}
	,},
	[8] ={
		{GiftItemID = 20501004, num = 5,},{GiftItemID = 20502004, num = 5,},{GiftItemID = 30900057, num = 2,},{GiftItemID = 10413102, num = 1,}
	,},
}
--充值2重 奖励
TopChongZhi.TopChongZhi_Gifts_ex = {
	[1] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 38002499, num = 100,},{GiftItemID = 38002397, num = 80,},{GiftItemID = 38003055, num = 5,}
	,},
	[2] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 20600003, num = 5,},{GiftItemID = 38002397, num = 100,},{GiftItemID = 10420088, num = 1,}
	,},
	[3] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 38002499, num = 100,},{GiftItemID = 20501004, num = 10,},{GiftItemID = 20502004, num = 10,}
	,},
	[4] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 38003055, num = 10,},{GiftItemID = 10422150, num = 1,},{GiftItemID = 38003672, num = 1,}
	,},
	[5] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 38002499, num = 100,},{GiftItemID = 20600003, num = 5,},{GiftItemID = 38003609, num = 1,}
	,},
	[6] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 38002499, num = 100,},{GiftItemID = 38002397, num = 100,},{GiftItemID = 10423024, num = 1,}
	,},
	[7] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 38008160, num = 150,},{GiftItemID = 38002499, num = 100,},{GiftItemID = 38002397, num = 100,}
	,},
	[8] ={
		{GiftItemID = 38008160, num = 150,},{GiftItemID = 20501004, num = 20,},{GiftItemID = 20502004, num = 20,},{GiftItemID = 20310228, num = 30,}
	,},
}
--0元  奖励
TopChongZhi.TopChongZhi_Gifts_zero = {
	[1] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 10141040, num = 1,},{GiftItemID = 10141030, num = 1,},{GiftItemID = 20500003, num = 2,}
	,},
	[2] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 20501003, num = 3,},{GiftItemID = 20502003, num = 3,},{GiftItemID = 38002397, num = 20,}
	,},
	[3] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 20310166, num = 50,},{GiftItemID =  20310174, num = 30,},{GiftItemID = 30900057, num = 1,}
	,},
	[4] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 38003055, num = 2,},{GiftItemID = 38008203, num = 1,},{GiftItemID = 38008160, num = 50,}
	,},
	[5] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 38003055, num = 3,},{GiftItemID = 38002397, num = 30,},{GiftItemID = 38008160, num = 50,}
	,},
	[6] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 38002532, num = 50,},{GiftItemID = 30900057, num = 1,},{GiftItemID = 38008160, num = 50,}
	,},
	[7] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 20501003, num = 5,},{GiftItemID = 20502003, num = 5,},{GiftItemID = 20500003, num = 5,}
	,},
	[8] ={
		{GiftItemID = 30900132, num = 1,},{GiftItemID = 20800012, num = 50,},{GiftItemID = 30900057, num = 1,},{GiftItemID = 38008160, num = 50,}
	,},
}
function TopChongZhi:OpenTopChongZhi(selfId,targetId,index)
	local ExchYuanBao = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_OLD) / ScriptGlobal.MD_CHANGE_YUANBAO_OLD_RATE
    ExchYuanBao = ExchYuanBao + self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW) / ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
	local CostYuanBao = self:GetMissionData(selfId,389)
	local need_tal,open_lv,nCurPrize,tPirzeFlag
	local flag
	if index == 101 then
		open_lv = self.Openlv
		nCurPrize = self:GetMissionData(selfId,ScriptGlobal.MD_HUIKUI_1)
		tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
		for i = 1,open_lv do
			if tPirzeFlag[i] ~= 2 then
				need_tal = self.TopChongZhi_GetGiftsCondition
				flag = 1
				break
			end
		end
		if not need_tal then
			open_lv = self.Openlv_ex
			nCurPrize = self:GetMissionData(selfId,ScriptGlobal.MD_HUIKUI_2)
			tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
			need_tal = self.TopChongZhi_GetGiftsCondition_ex
			flag = 2
		end
	elseif index == 102 then
		open_lv = self.Openlv_zero
		nCurPrize = self:GetMissionData(selfId,ScriptGlobal.MD_HUIKUI_0)
		tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
		need_tal = self.TopChongZhi_GetGiftsCondition_zero
		flag = 0
	end
	if not flag then
		self:NotifyTips(selfId,"回馈已全部领取。")
		return
	end
	-- if not need_tal or not open_lv or not flag or not tPirzeFlag then
		-- local msg = string.format("error:[%s][%s][%s][%s]",type(need_tal),type(open_lv),type(flag),type(tPirzeFlag))
		-- self:NotifyTips(selfId,msg)
		-- return
	-- end
	self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:UICommand_AddInt(ExchYuanBao) --兑换元宝数量 400为比例
		self:UICommand_AddInt(CostYuanBao) --消耗元宝数量
		self:UICommand_AddInt(flag)
		self:UICommand_AddInt(open_lv)
		for i = 1,8 do
			if tPirzeFlag[i] == 2 then
				self:UICommand_AddInt(tPirzeFlag[i])
			else
				if self.TopChongZhi_GetGiftsCondition[i] ~= nil then
					if ExchYuanBao >= need_tal[i].Exch and CostYuanBao >= need_tal[i].Cost then
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

function TopChongZhi:YBCost_GetPrize(selfId,TargetID,nSelectIdx,flag)
	local open_lv,need_tbl,award,mdid
	local TopChongZhiTxt
	if flag == 0 then
		open_lv = self.Openlv_zero
		need_tbl = self.TopChongZhi_GetGiftsCondition_zero
		award = self.TopChongZhi_Gifts_zero
		mdid = ScriptGlobal.MD_HUIKUI_0
		TopChongZhiTxt = {"一","二","三","四","五","六","七","八"}
	elseif flag == 1 then
		open_lv = self.Openlv
		need_tbl = self.TopChongZhi_GetGiftsCondition
		award = self.TopChongZhi_Gifts
		mdid = ScriptGlobal.MD_HUIKUI_1
		TopChongZhiTxt = {"一","二","三","四","五","六","七","八"}
	elseif flag == 2 then
		open_lv = self.Openlv_ex
		need_tbl = self.TopChongZhi_GetGiftsCondition_ex
		award = self.TopChongZhi_Gifts_ex
		mdid = ScriptGlobal.MD_HUIKUI_2
		TopChongZhiTxt = {"九","十","十一","十二","十三","十四","十五","十六"}
	else
		return
	end
	if not nSelectIdx or nSelectIdx < 1 or nSelectIdx > open_lv then
		return
	end
	if not need_tbl[nSelectIdx] or not award[nSelectIdx] then
		self:NotifyTips(selfId,"需求或奖励异常。")
		return
	end
	if self:GetLevel(selfId) < 15 then
		self:NotifyTips(selfId,"#{CZHL_200916_22}")
		return
	end
	--检查领取情况
	local nCurPrize = self:GetMissionData(selfId,mdid)
	local tPirzeFlag = self:MathCilCompute_1_InEx(nCurPrize)
	if tPirzeFlag[nSelectIdx] == 2 then
		self:NotifyTips(selfId,string.format("您已领取过%s重豪情礼，无法重复领取。",TopChongZhiTxt[nSelectIdx]))
		return
	end
	local ExchYuanBao = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_OLD) / ScriptGlobal.MD_CHANGE_YUANBAO_OLD_RATE
    ExchYuanBao = ExchYuanBao + self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW) / ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
	local CostYuanBao = self:GetMissionData(selfId,389)
	--检查是否达到条件
	if ExchYuanBao >= need_tbl[nSelectIdx].Exch
	and CostYuanBao >=  need_tbl[nSelectIdx].Cost then
		--条件到达检查背包
		self:BeginAddItem()
		for i,item in pairs(award[nSelectIdx]) do
			self:AddItem(item.GiftItemID,item.num,true)
		end
		if not self:EndAddItem(selfId) then
			return
		end
		tPirzeFlag[nSelectIdx]  = 2;
		nCurPrize = self:MathCilCompute_1_OutEx(tPirzeFlag)
		self:SetMissionData(selfId,mdid,nCurPrize);
		if self:GetMissionData(selfId,mdid) == nCurPrize then
			self:AddItemListToHuman(selfId)
			self:NotifyTips(selfId,string.format("%s重豪情礼领取成功！",TopChongZhiTxt[nSelectIdx]))
			self:ShowObjBuffEffect(selfId,selfId,-1,18)
			local strGlobalNews = gbk.fromutf8("#P少侠#{_INFOUSR%s}尽显豪侠风范，在#G洛阳钱庄#P的#Y孙进宝#G（65，40）#P处参与#Y一掷千金豪情礼#P活动，获得#G%s重豪情礼")
			self:AddGlobalCountNews(string.format(strGlobalNews, gbk.fromutf8(self:GetName(selfId)),gbk.fromutf8(TopChongZhiTxt[nSelectIdx])), true)
		else
			self:BeginAddItem()
			self:NotifyTips(selfId,"领取失败")
		end
		if flag == 0 then
			self:OpenTopChongZhi(selfId,TargetID,102)
		else
			self:OpenTopChongZhi(selfId,TargetID,101)
		end
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