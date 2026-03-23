local class = require "class"
local define = require "define"
local script_base = require "script_base"
local obj_9 = class("obj_9", script_base)
obj_9.script_id = 331009
obj_9.g_Impact1 = 3003
obj_9.g_Impact2 = -1
obj_9.g_SpecailObj = 9

function obj_9:OnDefaultEvent(selfId, bagIndex) end

function obj_9:IsSkillLikeScript(selfId)
	return 1; 
end

function obj_9:CancelImpacts(selfId) return 0 end

function obj_9:OnConditionCheck(selfId)
    return self:LuaFnVerifyUsedItem(selfId)
end

function obj_9:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function obj_9:OnActivateOnce(selfId)
    if (-1 ~= self.g_Impact1) then
        local posX, posZ = self:GetWorldPos(selfId)
        self:CreateSpecialObjByDataIndex(selfId, self.g_SpecailObj, posX, posZ)
    end
    return 1
end

function obj_9:OnActivateEachTick(selfId) return 1 end

return obj_9
