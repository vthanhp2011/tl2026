local class = require "class"
local define = require "define"
local script_base = require "script_base"
local charged_38000084 = class("charged_38000084", script_base)
charged_38000084.script_id = 892683
local items = {
	30309088,
	30309098,
	30310021,
	30310065,
	30310088
}
function charged_38000084:OnDefaultEvent(selfId)
	local nStateData_1 = self:GetMissionDataEx(selfId,401)
	self:BeginEvent(self.script_id)
	self:AddText("   本礼盒为自选礼盒，自选规则，尚品珍兽蛋5选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完珍兽蛋后，将会发放您所选择的所有奖励，以及额外的200个武道玄元丹和200个神魂檀箱和荆棘玫瑰(碎梦风格)。")
	if nStateData_1 == 0 then
		self:AddNumText("尚品珍兽蛋：狭路逢",6,1)
		self:AddNumText("尚品珍兽蛋：安琪儿",6,2)
		self:AddNumText("尚品珍兽蛋：巧巧",6,3)
		self:AddNumText("尚品珍兽蛋：七彩辉骏",6,4)
		self:AddNumText("尚品珍兽蛋：鸾凤和鸣",6,5)
	end
	self:EndEvent()
	self:DispatchEventList(selfId,-1)
end

function charged_38000084:OnEventRequest(selfId, targetId, arg, index)
	local eventID = index
	local nStateData_1 = self:GetMissionDataEx(selfId,401)
	local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
	if nStateData_1 > 0 then
		self:notify_tips(selfId,"每人只能领取一次。")
		return
	end
	if eventID >= 1 and eventID <= 5 then
		if nBagsPos < 4 then
			self:notify_tips(selfId,"请保证道具栏存在四个空位。")
			return
		end
		self:BeginAddItem()
		self:AddItem(38002397,200,true)
		self:AddItem(38002499,200,true)
		self:AddItem(10125552,1,true)
		self:AddItem(items[eventID],1,true)
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在四个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得武道玄元丹200个。")
		self:notify_tips(selfId,"获得神魂檀箱200个。")
		self:notify_tips(selfId,"获得荆棘玫瑰(碎梦风格)1件。")
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,401,self:GetDayTime())
		self:LuaFnDelAvailableItem(selfId,38000084,1)
	end
	self:BeginUICommand()
	self:EndUICommand()
	self:DispatchUICommand(selfId, 1000)
end
function charged_38000084:IsSkillLikeScript(selfId)
    return 0
end

return charged_38000084
