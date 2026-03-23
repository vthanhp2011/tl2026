local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local maan = 56
local gold_maan = 58

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
    return 1
end

function common_item:OnDeplete(selfId)
    return true
end

function common_item:OnActivateOnce(selfId)
    self:BeginUICommand()
	self:EndUICommand()
	self:DispatchUICommand(selfId, 5422 )
    return 1
end

function common_item:CallBackSpeakerAfter(selfId)
    local bag_index = self:LuaFnGetBagIndexOfUsedItem(selfId)
    self:LuaFnDecItemLayCount(selfId, bag_index, 1)
end

return common_item