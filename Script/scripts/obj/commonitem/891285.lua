local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local useitemid = 38002397
function common_item:OnDefaultEvent(selfId, bagIndex)
end

function common_item:IsSkillLikeScript(selfId)
    return 1
end

function common_item:CancelImpacts(selfId)
    return 0
end

function common_item:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    return 1
end

function common_item:OnDeplete(selfId)
    -- if (self:LuaFnDepletingUsedItem(selfId)) then
        -- return 1
    -- end
    return 1
end

function common_item:OnActivateOnce(selfId)
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId )
	if useid ~= useitemid then
		return 0
	end
	local usepos = self:LuaFnGetBagIndexOfUsedItem(selfId)
	if self:LuaFnGetItemTableIndexByIndex(selfId,usepos) ~= useid then
		return 0
	end
    local talent_type = self:GetTalentType(selfId)
	if talent_type == define.INVAILD_ID then
		self:notify_tips(selfId, "请加入流派后再来使用。")
		return 0
	end
	local maxcount = self:LuaFnGetAvailableItemCount(selfId,useid)
	self:BeginUICommand()
	self:UICommand_AddInt(useid)
	self:UICommand_AddInt(maxcount)
	self:UICommand_AddInt(891285)
	self:UICommand_AddInt(usepos)
	self:UICommand_AddStr("Use_XuanYuanDan")
	self:EndUICommand()
	self:DispatchUICommand(selfId,88991501)
    -- self:LuaFnAddTalentUnderstandPoint(selfId, 1)
    -- self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 149, 0)
    return 1
end

function common_item:OnActivateEachTick(selfId)
    return 1
end
function common_item:Use_XuanYuanDan(selfId,bagpos,count)
	if self:LuaFnGetItemTableIndexByIndex(selfId,bagpos) ~= useitemid then
		self:notify_tips(selfId, "使用的不是武道玄元丹。")
		return
	elseif not count or count < 1 then
		self:notify_tips(selfId, "使用数量至少为1颗。")
		return
	elseif self:LuaFnGetAvailableItemCount(selfId,useitemid) < count then
		self:notify_tips(selfId, "背包没有这么多玄元丹可使用。")
		return
	elseif self:GetTalentType(selfId) == define.INVAILD_ID then
		self:notify_tips(selfId, "未加入流派。")
		return
	end
	self:LuaFnDelAvailableItem(selfId, useitemid,count)
	self:LuaFnAddTalentUnderstandPoint(selfId,count)
	self:ShowObjBuffEffect(selfId,selfId,-1,149)
end
return common_item
