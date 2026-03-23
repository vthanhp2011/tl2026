local class = require "class"
local define = require "define"
local script_base = require "script_base"
local charged_38000083 = class("charged_38000083", script_base)
charged_38000083.script_id = 892682

function charged_38000083:OnDefaultEvent(selfId)
	local nStateData_1 = self:GetMissionDataEx(selfId,400)
	self:BeginEvent(self.script_id)
	self:AddText("   本礼盒为自选礼盒，自选规则，坐骑2选1，如果选择中不慎关闭窗口，重新打开选择即可，在少侠选择完坐骑后，将会发放您所选择的所有奖励，以及额外的100个武道玄元丹和100个神魂檀箱和荆棘玫瑰(碎梦风格)。")
	if nStateData_1 == 0 then
		self:AddNumText("坐骑：曙光荧翼",6,1)
		self:AddNumText("坐骑：夜霞赤羽",6,2)
	end
	self:EndEvent()
	self:DispatchEventList(selfId,-1)
end

function charged_38000083:OnEventRequest(selfId, targetId, arg, index)
	local eventID = index
	local nStateData_1 = self:GetMissionDataEx(selfId,400)
	local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
	if nStateData_1 > 0 then
		self:notify_tips(selfId,"每人只能领取一次。")
		return
	end
	if eventID >= 1 and eventID <= 2 then
		if nBagsPos < 4 then
			self:notify_tips(selfId,"请保证道具栏存在四个空位。")
			return
		end
		self:BeginAddItem()
		self:AddItem(38002397,100,true)
		self:AddItem(38002499,100,true)
		self:AddItem(10125552,1,true)
		if eventID == 1 then
			self:AddItem(10142467,1,true)
		else
			self:AddItem(10142449,1,true)
		end
		if not self:EndAddItem(selfId) then
			self:NotifyTips(selfId,"请保证道具栏存在四个空位。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId,"获得武道玄元丹100个。")
		self:notify_tips(selfId,"获得神魂檀箱100个。")
		self:notify_tips(selfId,"获得荆棘玫瑰(碎梦风格)1件。")
		self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
		self:SetMissionDataEx(selfId,400,self:GetDayTime())
		self:LuaFnDelAvailableItem(selfId,38000083,1)
	end
	self:BeginUICommand()
	self:EndUICommand()
	self:DispatchUICommand(selfId, 1000)
end
function charged_38000083:IsSkillLikeScript(selfId)
    return 0
end

return charged_38000083
