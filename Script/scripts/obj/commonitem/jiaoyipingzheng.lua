local ScriptGlobal = require "scripts.ScriptGlobal"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)

function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
	if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end
    local enddate = self:GetMissionData(selfId, ScriptGlobal.MD_JIAOYIPINGZHENG_END_TIME)
    local nowdate = self:GetTime2Day2()
    if enddate > nowdate then
        self:notify_tips(selfId, "#H您已经使用交易凭证激活了便捷功能，且功能尚未结束，此时无法使用道具。")
        return 0
    end
	return 1
end

function common_item:OnDeplete(selfId)
    return 1
end

function common_item:OnActivateOnce(selfId)
    local item_count = self:LuaFnGetAvailableItemCount(selfId, 38000217)
    if item_count < 1 then
        self:notify_tips(selfId, "背包里没发现交易凭证道具")
        return
    end
    local BagPos = self:LuaFnGetItemPosByItemDataID(selfId, 38000217)
    self:LuaFnDelAvailableItem(selfId, 38000217, 1)
    local end_date = self:GetDiffTime2Day2(30 * 24 * 60 * 60)
    self:SetMissionData(selfId, ScriptGlobal.MD_JIAOYIPINGZHENG_END_TIME, end_date)
	self:notify_tips(selfId, "#H成功激活了30天的交易凭证便捷功能。")
	return 1
end

return common_item