local class = require "class"
local define = require "define"
local script_base = require "script_base"
local obj_50 = class("obj_50", script_base)
obj_50.script_id = 331050
obj_50.g_Impact1 = 3003
obj_50.g_Impact2 = -1
obj_50.g_SpecailObj = 50

function obj_50:OnDefaultEvent(selfId, bagIndex) end

function obj_50:IsSkillLikeScript(selfId) return 1 end

function obj_50:CancelImpacts(selfId) return 0 end

function obj_50:OnConditionCheck(selfId)
    return self:LuaFnVerifyUsedItem(selfId)
end

function obj_50:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function obj_50:OnActivateOnce(selfId)
    if (-1 ~= self.g_Impact1) then
        local posX, posZ = self:GetWorldPos(selfId)
        self:CreateSpecialObjByDataIndex(selfId, self.g_SpecailObj, posX, posZ)
    end
    return 1
end

function obj_50:OnActivateEachTick(selfId) return 1 end

return obj_50
