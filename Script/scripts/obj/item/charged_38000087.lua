local class = require "class"
local define = require "define"
local script_base = require "script_base"
local charged_38000087 = class("charged_38000087", script_base)
charged_38000087.script_id = 889903
charged_38000087.iteminfo = {30310022,30309996,10124415,10124860,10124578,10142287,10142303,10142235,38008100,38008143,38008146}
function charged_38000087:OnDefaultEvent(selfId)
	local nStateData_1 = self:GetMissionDataEx(selfId,400)
	local nStateData_2 = self:GetMissionDataEx(selfId,401)
	local nStateData_3 = self:GetMissionDataEx(selfId,402)
	local nStateData_4 = self:GetMissionDataEx(selfId,403)
	self:BeginEvent(self.script_id)
	self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑3选1，称号3选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的100个武道玄元丹。")
	if nStateData_1 == 0 then
		self:AddNumText("领取超级珍兽笼：巧巧",6,1)
		self:AddNumText("领取超级珍兽笼：安琪儿",6,2)
	elseif nStateData_1 > 0 and nStateData_2 == 0 then
		self:AddNumText("领取时装：断桥残雪",6,3)
		self:AddNumText("领取时装：上元清嘉景",6,4)
		self:AddNumText("领取时装：夜雨听竹",6,5)
	elseif nStateData_1 > 0 and nStateData_2 > 0 and nStateData_3 == 0 then
		self:AddNumText("领取坐骑：凤栖云台",6,6)
		self:AddNumText("领取坐骑：羊驼",6,7)
		self:AddNumText("领取坐骑：拾光恋羽",6,8)
	elseif nStateData_1 > 0 and nStateData_2 > 0 and nStateData_3 > 0 and nStateData_4 == 0 then
		self:AddNumText("领取称号：英雄大会·一方逍遥",6,9)
		self:AddNumText("领取称号：塞外绝尘·惊鸣者",6,10)
		self:AddNumText("领取称号：破煞渡厄·行者",6,11)
	end
	self:EndEvent()
	self:DispatchEventList(selfId,-1)
end
function charged_38000087:OnEventRequest(selfId, targetId, arg, index)
	local eventID = index
	local nStateData_1 = self:GetMissionDataEx(selfId,400)
	local nStateData_2 = self:GetMissionDataEx(selfId,401)
	local nStateData_3 = self:GetMissionDataEx(selfId,402)
	local nStateData_4 = self:GetMissionDataEx(selfId,403)
	local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
	local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
	if nStateData_1 > 0 and nStateData_2 > 0 and nStateData_3 > 0 and nStateData_4 > 0 then
		self:notify_tips(selfId,"每人只能领取一次。")
		return
	end
	if eventID >= 1 and eventID <= 2 then
		if nBagsPos < 5 then
			self:notify_tips(selfId,"请保证道具栏存在五个空位。")
			return
		end
		self:BeginAddItem()
			self:AddItem(self.iteminfo[eventID],1,true)
			self:AddItem(38002397,300,true)
			self:AddItem(38002499,300,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在五个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得武道玄元丹300个。")
		self:notify_tips(selfId,"获得神魂檀箱300个。")
		self:notify_tips(selfId,"获得"..self:GetItemName(self.iteminfo[eventID]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,400,self:GetDayTime())
		self:BeginEvent(self.script_id)
		self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑3选1，称号3选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的100个武道玄元丹。")
		self:AddNumText("领取时装：断桥残雪",6,3)
		self:AddNumText("领取时装：上元清嘉景",6,4)
		self:AddNumText("领取时装：夜雨听竹",6,5)
		self:EndEvent()
		self:DispatchEventList(selfId,-1)
		return
	end
	if eventID >= 3 and eventID <= 5 then
		if nBagsPos < 1 then
			self:notify_tips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:BeginAddItem()
		self:AddItem(self.iteminfo[eventID],1,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得"..self:GetItemName(self.iteminfo[eventID]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,401,self:GetDayTime())
		self:BeginEvent(self.script_id)
		self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑3选1，称号3选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的100个武道玄元丹。")
		self:AddNumText("领取坐骑：凤栖云台",6,6)
		self:AddNumText("领取坐骑：羊驼",6,7)
		self:AddNumText("领取坐骑：拾光恋羽",6,8)
		self:EndEvent()
		self:DispatchEventList(selfId,-1)
		return
	end
	if eventID >= 6 and eventID <= 8 then
		if nBagsPos < 1 then
			self:notify_tips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:BeginAddItem()
		self:AddItem(self.iteminfo[eventID],1,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得"..self:GetItemName(self.iteminfo[eventID]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,402,self:GetDayTime())
		self:BeginEvent(self.script_id)
		self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑3选1，称号3选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的100个武道玄元丹。")
		self:AddNumText("领取称号：英雄大会·一方逍遥",6,9)
		self:AddNumText("领取称号：塞外绝尘·惊鸣者",6,10)
		self:AddNumText("领取称号：破煞渡厄·行者",6,11)
		self:EndEvent()
		self:DispatchEventList(selfId,-1)
		return
	end
	if eventID >= 9 then
		if nBagsPos < 1 then
			self:notify_tips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:BeginAddItem()
		self:AddItem(self.iteminfo[eventID],1,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得"..self:GetItemName(self.iteminfo[eventID]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,403,self:GetDayTime())
		self:LuaFnDelAvailableItem(selfId,38000087,1)
		self:BeginUICommand()
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1000)
	end
end
function charged_38000087:IsSkillLikeScript(selfId)
    return 0
end

return charged_38000087
