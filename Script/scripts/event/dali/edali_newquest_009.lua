local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_newquest_009 = class("edali_newquest_009", script_base)
edali_newquest_009.script_id = 210274
edali_newquest_009.g_NextScriptId = 210280
edali_newquest_009.g_Position_X=214
edali_newquest_009.g_Position_Z=284
edali_newquest_009.g_SceneID=2
edali_newquest_009.g_AccomplishNPC_Name="段延庆"
edali_newquest_009.g_MissionId = 1408
edali_newquest_009.g_MissionIdPre = 1407
edali_newquest_009.g_Name	="高升祥"
edali_newquest_009.g_MissionKind = 13
edali_newquest_009.g_MissionLevel = 5
edali_newquest_009.g_MinMissionLevel = 5
edali_newquest_009.g_IfMissionElite = 0
edali_newquest_009.g_MissionName="大理怪人"
edali_newquest_009.g_MissionTarget="#{XSRW_100111_59}"
edali_newquest_009.g_MissionInfo="#{XSRW_100111_20}"
edali_newquest_009.g_ContinueInfo ="#{XSRW_100111_71}"
edali_newquest_009.g_MissionComplete="#{XSRW_100111_21}"
edali_newquest_009.g_MoneyJZBonus=100
edali_newquest_009.g_ExpBonus = 3200
edali_newquest_009.g_SignPost = {x = 214, z = 284, tip = "段延庆"}
edali_newquest_009.g_RadioItemBonus={}
edali_newquest_009.g_ItemBonus={}
edali_newquest_009.g_Custom = { {id="已找到段延庆",num=1} }
edali_newquest_009.g_IsMissionOkFail = 0		--变量的第0位

function edali_newquest_009:OnDefaultEvent(selfId, targetId, arg, index)
	if self:IsMissionHaveDone(selfId, self.g_MissionId) or not self:IsMissionHaveDone(selfId, self.g_MissionIdPre) then
		return
	elseif self:IsHaveMission(selfId, self.g_MissionId) and self:GetName(targetId) == self.g_AccomplishNPC_Name then
		self:BeginEvent(self.script_id)
		self:AddText(self.g_MissionName)
		self:AddText(self.g_ContinueInfo)
		self:EndEvent()
		local bDone = self:CheckSubmit(selfId)
		self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, self.g_MissionId, bDone)
	elseif self:CheckAccept(selfId) > 0 then
		self:BeginEvent(self.script_id)
		self:AddText(self.g_MissionName)
		self:AddText(self.g_MissionInfo)
		self:AddText(self.g_MissionTarget)
		for i, item in pairs(self.g_ItemBonus) do
			self:AddRadioItemBonus(item["id"], item["num"])
		end
		self:EndEvent()
		self:DispatchMissionInfo(selfId, targetId, self.script_id, self.g_MissionId)
	end
end

function edali_newquest_009:OnEnumerate(caller, selfId, targetId, arg, index)
	if self:IsMissionHaveDone(selfId, self.g_MissionId) or not self:IsMissionHaveDone(selfId, self.g_MissionIdPre) then
		return
	elseif self:GetName(targetId) == self.g_AccomplishNPC_Name and self:IsHaveMission(selfId, self.g_MissionId) then
		caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 2, 1)
	elseif self:GetName(targetId) ~= self.g_AccomplishNPC_Name and not self:IsHaveMission(selfId, self.g_MissionId) then
		caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 1, 1)
	end
end

function edali_newquest_009:OnAccept(selfId)
	if self:IsMissionHaveDone(selfId, self.g_MissionId) then
		return
	end
	local ret = self:AddMission(selfId, self.g_MissionId, self.script_id, 1, 0, 0)
	if not ret then
		self:notify_tips(selfId, "#Y你的任务日志已经满了")
		return
	end
	self:notify_tips(selfId, "接受任务:#Y" .. self.g_MissionName)
	local misIndex = self:GetMissionIndexByID(selfId,self.g_MissionId)
	self:SetMissionByIndex(selfId, misIndex, 0, 1)
	self:SetMissionByIndex(selfId, misIndex, 1, 1)
end

function edali_newquest_009:CheckSubmit(selfId)
	local bRet = self:CallScriptFunction(define.SCENE_SCRIPT_ID, "CheckSubmit", selfId, self.g_MissionId)
	if bRet ~= 1 then
		return 0
	end
	return 1
end

function edali_newquest_009:OnAbandon(selfId)
	self:DelMission(selfId, self.g_MissionId)
end

function edali_newquest_009:OnContinue(selfId, targetId)
	self:BeginEvent(self.script_id)
	self:AddText(self.g_MissionName)
	self:AddText(self.g_MissionComplete)
	for i, item in pairs(self.g_ItemBonus) do
		self:AddRadioItemBonus(item["id"], item["num"])
	end
	self:EndEvent()
	self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_newquest_009:OnSubmit(selfId, targetId)
	if not self:IsHaveMission(selfId, self.g_MissionId) then
		return
	end
	if self:CheckSubmit(selfId) <= 0 then
		return
	end
	self:BeginAddItem()
	for i, item in pairs(self.g_ItemBonus) do
		self:AddItem(item["id"], item["num"])
	end
	local ret = self:EndAddItem(selfId)
	if ret then
		if (self.g_MoneyJZBonus > 0) then
			self:AddMoneyJZ(selfId, self.g_MoneyJZBonus)
		end
		if (self.g_ExpBonus > 0) then
			self:LuaFnAddExp(selfId, self.g_ExpBonus)
		end
		ret = self:DelMission(selfId, self.g_MissionId)
		if ret then
			self:MissionCom(selfId, self.g_MissionId)
			self:AddItemListToHuman(selfId)
			self:notify_tips(selfId, "完成任务：大理怪人")
			self:CallScriptFunction(self.g_NextScriptId, "OnDefaultEvent", selfId, targetId)
		end
	end
end

function edali_newquest_009:CheckAccept(selfId)
	if self:IsMissionHaveDone(selfId, self.g_MissionIdPre) then
		return 1
	else
		return 0
	end
end

function edali_newquest_009:OnKillObject(selfId, objdataId, objId)
end

function edali_newquest_009:OnEnterArea(selfId, zoneId)
end

function edali_newquest_009:OnItemChanged(selfId, itemdataId)
end

return edali_newquest_009
