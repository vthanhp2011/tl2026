local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0238 = class("edali_0238", script_base)
edali_0238.script_id = 210238
edali_0238.g_Position_X = 160.0895
edali_0238.g_Position_Z = 156.9309
edali_0238.g_SceneID = 2
edali_0238.g_AccomplishNPC_Name = "赵天师"
edali_0238.g_MissionId = 1424
edali_0238.g_Name = "赵天师"
edali_0238.g_MissionKind = 13
edali_0238.g_MissionLevel = 1
edali_0238.g_IfMissionElite = 0
edali_0238.g_IsMissionOkFail = 0
edali_0238.g_MissionName = "十年"
edali_0238.g_MissionInfo = "    我们四大善人老哥儿几个一看到你，就觉得你是百年一遇的武学奇才，若得到名师传授，前途不可限量啊。"
edali_0238.g_MissionInfo1 = "    不过你现在最主要的事情，还是先把武学根基打好。根基扎好了之后，就可以找一位名师，学习高深武功，以后成为一代大英雄，大侠士！"
edali_0238.g_MissionInfo2 = "    这样吧，等你达到10级，就来找我赵天师，我们几个老家伙会给你准备一份很特殊的礼物。"
edali_0238.g_MissionTarget = "#{MIS_dali_ZTS_002}"
edali_0238.g_ContinueInfo = "#{XSRW_100111_107}"
edali_0238.g_MissionComplete = "  太好了，你可以加入门派了。"
edali_0238.g_exp = 0
edali_0238.g_ItemBonus = {}
edali_0238.g_Custom = {{["id"] = "已达等级",["num"] = 10}}
function edali_0238:OnDefaultEvent(selfId,targetId,arg,index)
	if self:IsMissionHaveDone(selfId,self.g_MissionId) then
		return
	elseif self:IsHaveMission(selfId,self.g_MissionId) then
		self:BeginEvent(self.script_id)
		self:AddText(self.g_MissionName)
		self:AddText(self.g_ContinueInfo)
		self:EndEvent()
	local bDone = self:CheckSubmit(selfId)
		self:DispatchMissionDemandInfo(selfId,targetId,self.script_id,self.g_MissionId,bDone)
	elseif self:CheckAccept(selfId) > 0 then
		self:BeginEvent(self.script_id)
		self:AddText(self.g_MissionName)
		self:AddText(self.g_MissionInfo)
		self:AddText(self.g_MissionInfo1)
		self:AddText(self.g_MissionInfo2)
		self:EndEvent()
		self:DispatchMissionInfo(selfId,targetId,self.script_id,self.g_MissionId)
	end
end

function edali_0238:OnEnumerate(caller,selfId,targetId,arg,index)
	if self:IsMissionHaveDone(selfId,self.g_MissionId) then
		return
	elseif self:IsHaveMission(selfId,self.g_MissionId) then
	local bDone = self:CheckSubmit(selfId)
	if (1 == bDone) then
		caller:AddNumTextWithTarget(self.script_id, self.g_MissionName,2,1)
	else
		caller:AddNumTextWithTarget(self.script_id, self.g_MissionName,1,1)
	end
	elseif self:CheckAccept(selfId) > 0 then
		caller:AddNumTextWithTarget(self.script_id, self.g_MissionName,1,1)
	end
end

function edali_0238:CheckAccept(selfId)
	if self:GetLevel(selfId) >= self.g_MissionLevel then
		return 1
	else
		return 0
	end
end

function edali_0238:OnAccept(selfId)
	if self:IsMissionHaveDone(selfId,self.g_MissionId) then
		return
	end
	local ret = self:AddMission(selfId,self.g_MissionId,self.script_id,1,0,0)
	if not ret then
		self:Msg2Player(selfId,"#Y你的任务日志已经满了",define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
		return
	end
	self:Msg2Player(selfId,"接受任务:#Y" .. self.g_MissionName,define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
	local misIndex = self:GetMissionIndexByID(selfId,self.g_MissionId)
	self:SetMissionByIndex(selfId,misIndex,1, self:GetLevel(selfId))
end

function edali_0238:OnAbandon(selfId)
	self:DelMission(selfId,self.g_MissionId)
end

function edali_0238:OnContinue(selfId,targetId)
	self:BeginEvent(self.script_id)
	self:AddText(self.g_MissionName)
	self:AddText(self.g_MissionComplete)
	for i,item in pairs(self.g_ItemBonus) do
		self:AddItemBonus(item["id"] ,item["num"] )
	end
	self:EndEvent()
	self:DispatchMissionContinueInfo(selfId,targetId,self.script_id,self.g_MissionId)
end

function edali_0238:CheckSubmit(selfId)
	local Level = self:GetLevel(selfId)
	if (Level < 10) then
		return 0
	end
	return 1
end

function edali_0238:OnSubmit(selfId,targetId,selectRadioId)
	if not self:IsHaveMission(selfId,self.g_MissionId) then
		return
	end
	if self:CheckSubmit(selfId) <= 0 then
		return
	end
	if (self.g_exp > 0) then
		self:LuaFnAddExp(selfId,self.g_exp)
	end
	self:DelMission(selfId,self.g_MissionId)
	self:MissionCom(selfId,self.g_MissionId)
end

function edali_0238:OnKillObject(selfId,objdataId,objId)

end

function edali_0238:OnEnterArea(selfId,zoneId)

end

function edali_0238:OnItemChanged(selfId,itemdataId)

end

return edali_0238