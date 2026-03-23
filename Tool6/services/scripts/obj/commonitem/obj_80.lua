local class = require "class"
local define = require "define"
local script_base = require "script_base"
local obj_80 = class("obj_80", script_base)
obj_80.script_id = 331080
obj_80.g_Impact1 = 3003
obj_80.g_Impact2 = -1
obj_80.g_SpecailObj = 91

function obj_80:OnDefaultEvent(selfId, bagIndex) end

function obj_80:IsSkillLikeScript(selfId) return 1 end

function obj_80:CancelImpacts(selfId) return 0 end

function obj_80:OnConditionCheck(selfId)
    return self:LuaFnVerifyUsedItem(selfId)
end

function obj_80:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function obj_80:OnActivateOnce(selfId)
    if (-1 ~= self.g_Impact1) then
        local posX, posZ = self:GetWorldPos(selfId)
        self:CreateSpecialObjByDataIndex(selfId, self.g_SpecailObj, posX, posZ)
    end
    return 1
end

function obj_80:OnActivateEachTick(selfId) return 1 end

return obj_80
