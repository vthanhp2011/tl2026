local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_4410 = class("item_4410", script_base)
item_4410.script_id = 334410
item_4410.g_Impact1 = 4410
item_4410.g_Impact2 = -1
function item_4410:OnDefaultEvent(selfId, bagIndex)
end

function item_4410:IsSkillLikeScript(selfId)
    return 1
end

function item_4410:CancelImpacts(selfId)
    return 0
end

function item_4410:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    return 1
end

function item_4410:OnDeplete(selfId)
    if (self:LuaFnDepletingUsedItem(selfId)) then
        return 1
    end
    return 0
end

function item_4410:OnActivateOnce(selfId)
    if (-1 ~= self.g_Impact1) then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, self.g_Impact1, 0)
    end
    return 1
end

function item_4410:OnActivateEachTick(selfId)
    return 1
end

return item_4410
