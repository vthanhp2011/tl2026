--无崖子

local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_wuyazi = class("odali_wuyazi", script_base)
function odali_wuyazi:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
    self:AddText("#{WH_090729_03}")
    self:AddNumText("提升武魂合成等级",6,1)
    self:AddNumText("武魂开辟属性栏",6,2)
    self:AddNumText("武魂扩展属性学习",6,3)
    self:AddNumText("武魂扩展属性升级",6,4)
    self:AddNumText("武魂领悟技能",6,5)
    self:AddNumText("重洗武魂技能",6,6)
    self:AddNumText("武魂技能升级",6,7)
    self:AddNumText("武魂说明",11,8)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_wuyazi:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
		self:BeginUICommand()
			self:UICommand_AddInt(targetId);
			self:UICommand_AddInt(2)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 20090721)
	elseif index == 2 then 
	    self:BeginUICommand()
			self:UICommand_AddInt(targetId);
			self:UICommand_AddInt(4)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 20090721)
	elseif index == 3 then 
		self:BeginUICommand()
			self:UICommand_AddInt(targetId);
			self:UICommand_AddInt(1)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 20090721)
	elseif index == 4 then
		self:BeginUICommand()
			self:UICommand_AddInt(targetId);
			self:UICommand_AddInt(1)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 20090720 )
	elseif index == 5 then
		self:BeginUICommand()
		    self:UICommand_AddInt(targetId)
	        self:UICommand_AddInt(1)
        self:EndUICommand()
        self:DispatchUICommand(selfId,20090722)
	elseif index == 6 then
		self:BeginUICommand()
		    self:UICommand_AddInt(targetId)
	        self:UICommand_AddInt(2)
        self:EndUICommand()
        self:DispatchUICommand(selfId,20090722)
	elseif index == 7 then
		self:BeginUICommand()
		    self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId,20090723)
	elseif index == 8 then
		self:BeginEvent(self.script_id)
			self:AddNumText("武魂背景介绍",11,9)
			self:AddNumText("怎样获得武魂及相关道具",11,10)
			self:AddNumText("武魂升级介绍",11,11)
			self:AddNumText("武魂合成等级介绍",11,12)
			self:AddNumText("武魂拓展属性介绍",11,13)
			self:AddNumText("武魂技能介绍",11,14)
			self:AddNumText("武魂属相介绍",11,15)
			self:AddNumText("武魂的寿命",11,16)
			self:AddNumText("返回上一页",8,17)
	    self:EndEvent()
	    self:DispatchEventList(selfId, targetId)
	elseif index == 9 then
		self:BeginEvent(self.script_id)
		self:AddText("#{WH_090820_01}")
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 10 then
		self:BeginEvent(self.script_id)
		self:AddText( "#{WH_090729_59}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 11 then
		self:BeginEvent(self.script_id)
		self:AddText( "#{WH_090729_45}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 12 then
		self:BeginEvent(self.script_id)
		self:AddText( "#{WH_090729_46}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 13 then
		self:BeginEvent(self.script_id)
		self:AddText( "#{WH_090729_47}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 14 then
		self:BeginEvent(self.script_id)
		self:AddText( "#{WH_090729_48}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 15 then
		self:BeginEvent(self.script_id)
		self:AddText( "#{WH_090729_49}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 16 then
		self:BeginEvent(self.script_id)
		self:AddText( "#{WH_090820_02}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 17 then
		self:OnDefaultEvent(selfId,targetId )
	end
end

function odali_wuyazi:GetCostGongLi(XiuLianMiJiLevel)
	local nXiulianNeedPower = 0
	if (XiuLianMiJiLevel >= 0 and XiuLianMiJiLevel < 30)  then
		  nXiulianNeedPower = 33
	elseif(XiuLianMiJiLevel >= 30 and XiuLianMiJiLevel < 60 )  then
		  nXiulianNeedPower = 50
	elseif(XiuLianMiJiLevel >= 60 and XiuLianMiJiLevel <= 150)  then
		  nXiulianNeedPower = 100
	end
	return nXiulianNeedPower
end

function odali_wuyazi:AskXiuLianLevelUp(selfId, targetId, mjId)
	local xiulian_level = self:GetXiuLianLevel(selfId, mjId + 1)
	local xiulian_detail = self:GetXiuLianDetail(selfId, mjId, xiulian_level + 1)
	if xiulian_detail == nil then
		self:notify_tips(selfId, "修炼已经满级")
		return
	end
	local cost_exp = xiulian_detail.cost_exp
	if self:GetExp(selfId) < cost_exp then
		self:notify_tips(selfId, "经验不足")
		return
	end
	local cost_money = xiulian_detail.cost_gold
	local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
	if nMoneySelf < cost_money then
		self:notify_tips(selfId, "金币不足")
		return
	end
	local cost_gongli = self:GetCostGongLi(xiulian_level + 1)
	local nGongLi = self:GetGongLi(selfId)
	if nGongLi < cost_gongli then
		self:notify_tips(selfId, "功力不足")
		return
	end
	local can = self:XiuLianCanLevelUp(selfId, mjId + 1)
	if not can then
		self:notify_tips(selfId, "请先提升修炼境界")
		return
	end
	self:LuaFnCostMoneyWithPriority(selfId, cost_money)
	self:LuaFnCostExp(selfId, cost_exp)
	self:LuaFnCostGongLi(selfId, cost_gongli)
	self:XiuLianLevelUp(selfId, mjId + 1)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
	self:notify_tips(selfId, "#{XL_090707_07}")
end

function odali_wuyazi:GetCostMoney(CurMaxLevel)
	local nJingJieNum
	if(CurMaxLevel <= 60)   then
		  nJingJieNum = CurMaxLevel/10;
	else
		  nJingJieNum = ((CurMaxLevel-60)/15) + 6
	end
	nJingJieNum = nJingJieNum + 1
	return math.floor(nJingJieNum * nJingJieNum)
end

function odali_wuyazi:AskXiuLianAdvanceJingJie(selfId, targetId, mjId)
	local xiulian_level = self:GetXiuLianLevel(selfId, mjId + 1)
	local xiulian_detail = self:GetXiuLianDetail(selfId, mjId, xiulian_level + 1)
	if xiulian_detail == nil then
		self:notify_tips(selfId, "修炼已经满级")
		return
	end
	local can = self:XiuLianCanLevelUp(selfId, mjId + 1)
	if can then
		self:notify_tips(selfId, "请先点满层数")
		return
	end
	local CurMaxLevel = self:GetXiuLianLevelUpperLimit(selfId, mjId + 1)
	local cost_money = self:GetCostMoney(CurMaxLevel)
	local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
	if nMoneySelf < cost_money then
		self:notify_tips(selfId, "金币不足")
		return
	end
	self:LuaFnCostMoneyWithPriority(selfId, cost_money)
	self:XiuLianLevelUpperLimitUp(selfId, mjId + 1, 10)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

return odali_wuyazi