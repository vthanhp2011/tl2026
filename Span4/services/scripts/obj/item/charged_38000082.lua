local class = require "class"
local define = require "define"
local script_base = require "script_base"
local charged_38000082 = class("charged_38000082", script_base)
charged_38000082.script_id = 892681
charged_38000082.iteminfo = {30310021,30309098,10124415,10124860,10124578,10124876,10125333,10142287,10142303,10142235,10142101,10142023,38008100,38008143,38008146,38008142}
charged_38000082.menpainame = 
{
	"少林凌云者",
	"明教凌云者",
	"丐帮凌云者",
	"武当凌云者",
	"峨眉凌云者",
	"星宿凌云者",
	"天龙凌云者",
	"天山凌云者",
	"逍遥凌云者",
	"无门派",
	"曼陀山庄凌云者",
}
charged_38000082.menpaititle = {38008120,38008124,38008127,38008121,38008122,38008123,38008125,38008128,38008126,-1,38008139}
function charged_38000082:OnDefaultEvent(selfId)
	local nStateData_1 = self:GetMissionDataEx(selfId,400)
	local nStateData_2 = self:GetMissionDataEx(selfId,401)
	local nStateData_3 = self:GetMissionDataEx(selfId,402)
	local nStateData_4 = self:GetMissionDataEx(selfId,403)
	local menpaiID = self:GetMenPai(selfId)
	self:BeginEvent(self.script_id)
	self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑5选1，称号5选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的200个武道玄元丹。")
	if nStateData_1 == 0 then
		self:AddNumText("领取尚品珍兽蛋：巧巧",6,1)
		self:AddNumText("领取尚品珍兽蛋：安琪儿",6,2)
	elseif nStateData_1 > 0 and nStateData_2 == 0 then
		self:AddNumText("领取时装：断桥残雪",6,3)
		self:AddNumText("领取时装：上元清嘉景",6,4)
		self:AddNumText("领取时装：夜雨听竹",6,5)
		self:AddNumText("领取时装：星河落雪",6,6)
		self:AddNumText("领取时装：浮光尽染【星潮风格】",6,7)
	elseif nStateData_1 > 0 and nStateData_2 > 0 and nStateData_3 == 0 then
		self:AddNumText("领取坐骑：凤栖云台",6,8)
		self:AddNumText("领取坐骑：羊驼",6,9)
		self:AddNumText("领取坐骑：拾光恋羽",6,10)
		self:AddNumText("领取坐骑：烈焰追风",6,11)
		self:AddNumText("领取坐骑：凤凰座",6,12)
	elseif nStateData_1 > 0 and nStateData_2 > 0 and nStateData_3 > 0 and nStateData_4 == 0 then
		self:AddNumText("领取称号：英雄大会·一方逍遥",6,13)
		self:AddNumText("领取称号：塞外绝尘·惊鸣者",6,14)
		self:AddNumText("领取称号：破煞渡厄·行者",6,15)
		self:AddNumText("领取称号：塞外绝尘·凌霄客",6,16)
		self:AddNumText("领取称号："..self.menpainame[menpaiID + 1],6,17)
	end
	self:EndEvent()
	self:DispatchEventList(selfId,-1)
end
function charged_38000082:OnEventRequest(selfId, targetId, arg, index)
	local eventID = index
	local nStateData_1 = self:GetMissionDataEx(selfId,400)
	local nStateData_2 = self:GetMissionDataEx(selfId,401)
	local nStateData_3 = self:GetMissionDataEx(selfId,402)
	local nStateData_4 = self:GetMissionDataEx(selfId,403)
	local menpaiID = self:GetMenPai(selfId)
	local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
	local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
	if nStateData_1 > 0 and nStateData_2 > 0 and nStateData_3 > 0 and nStateData_4 > 0 then
		self:notify_tips(selfId,"每人只能领取一次。")
		return
	end
	if eventID >= 1 and eventID <= 2 then
		if nBagsPos < 2 then
			self:notify_tips(selfId,"请保证道具栏存在两个空位。")
			return
		end
		self:BeginAddItem()
			self:AddItem(self.iteminfo[eventID],1,true)
		self:AddItem(38002397,200,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在两个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得武道玄元丹200个。")
		self:notify_tips(selfId,"获得"..self:GetItemName(self.iteminfo[eventID]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,400,self:GetDayTime())
		self:BeginEvent(self.script_id)
		self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑5选1，称号5选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的200个武道玄元丹。")
		self:AddNumText("领取时装：断桥残雪",6,3)
		self:AddNumText("领取时装：上元清嘉景",6,4)
		self:AddNumText("领取时装：夜雨听竹",6,5)
		self:AddNumText("领取时装：星河落雪",6,6)
		self:AddNumText("领取时装：浮光尽染【星潮风格】",6,7)
		self:EndEvent()
		self:DispatchEventList(selfId,-1)
		return
	end
	if eventID >= 3 and eventID <= 7 then
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
		self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑5选1，称号5选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的200个武道玄元丹。")
		self:AddNumText("领取坐骑：凤栖云台",6,8)
		self:AddNumText("领取坐骑：羊驼",6,9)
		self:AddNumText("领取坐骑：拾光恋羽",6,10)
		self:AddNumText("领取坐骑：烈焰追风",6,11)
		self:AddNumText("领取坐骑：凤凰座",6,12)
		self:EndEvent()
		self:DispatchEventList(selfId,-1)
		return
	end
	if eventID >= 8 and eventID <= 12 then
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
		self:AddText("   本礼盒为自选礼盒，自选规则，珍兽2选1，时装坐骑5选1，称号5选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的200个武道玄元丹。")
		self:AddNumText("领取称号：英雄大会·一方逍遥",6,13)
		self:AddNumText("领取称号：塞外绝尘·惊鸣者",6,14)
		self:AddNumText("领取称号：破煞渡厄·行者",6,15)
		self:AddNumText("领取称号：塞外绝尘·凌霄客",6,16)
		self:AddNumText("领取称号："..self.menpainame[menpaiID + 1],6,17)
		self:EndEvent()
		self:DispatchEventList(selfId,-1)
		return
	end
	if eventID >= 13 and eventID <= 16 then
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
		self:LuaFnDelAvailableItem(selfId,38000082,1)
	end
	if eventID == 17 then
		if nBagsPos < 1 then
			self:notify_tips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:BeginAddItem()
		self:AddItem(self.menpaititle[menpaiID + 1],1,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在一个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得"..self:GetItemName(self.menpaititle[menpaiID + 1]))
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,403,self:GetDayTime())
		self:LuaFnDelAvailableItem(selfId,38000082,1)
	end
	self:BeginUICommand()
	self:EndUICommand()
	self:DispatchUICommand(selfId, 1000)
end
function charged_38000082:IsSkillLikeScript(selfId)
    return 0
end

return charged_38000082
