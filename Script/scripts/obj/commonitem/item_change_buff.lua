local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_change_buff = class("item_change_buff", script_base)
item_change_buff.script_id = 899998
--道具BUFF
item_change_buff.useitems = {
	[38000961] = 5997,
	[38000962] = 5998,
	[38000963] = 5999,


}

function item_change_buff:OnDefaultEvent(selfId, bagIndex)
end
function item_change_buff:IsSkillLikeScript(selfId)
    return 1
end

function item_change_buff:CancelImpacts(selfId)
    return 0
end

function item_change_buff:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId )
	if not self.useitems[useid] then
		return 0
	end
	local usepos = self:LuaFnGetBagIndexOfUsedItem(selfId)
	if self:LuaFnGetItemTableIndexByIndex(selfId,usepos) ~= useid then
		return 0
	end
    return 1
end

function item_change_buff:OnDeplete(selfId)
    -- if (self:LuaFnDepletingUsedItem(selfId)) then
        -- return 1
    -- end
    return 1
end

function item_change_buff:OnActivateOnce(selfId)
	local useid = self:LuaFnGetItemIndexOfUsedItem(selfId )
	local buffid = self.useitems[useid]
	if not buffid then
		return 0
	end
	local usepos = self:LuaFnGetBagIndexOfUsedItem(selfId)
	if self:LuaFnGetItemTableIndexByIndex(selfId,usepos) ~= useid then
		return 0
	end
	if self:LuaFnHaveImpactOfSpecificDataIndex(selfId,buffid) then
		self:notify_tips(selfId, "该状态还存在，避免造成浪费请结束后再使用。")
		return 0
	end
	self:EraseItem(selfId, usepos)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, buffid, 100)
	self:notify_tips(selfId, "使用成功。")
	return 1
end

function item_change_buff:OnActivateEachTick(selfId)
    return 1
end

return item_change_buff
