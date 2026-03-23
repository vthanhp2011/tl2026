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
    local enddate = self:GetMissionData(selfId, ScriptGlobal.MD_YU_LONG_TIE_END_TIME)
    local nowdate = self:GetTime2Day2()
    if enddate > nowdate then
        self:notify_tips(selfId, "#{HJYK_201223_03}")
        return 0
    end
	return 1
end

function common_item:OnDeplete(selfId)
    return 1
end

function common_item:OnActivateOnce(selfId)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 89266601)
	return 1
end

return common_item