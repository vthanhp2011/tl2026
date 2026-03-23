local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_4414 = class("item_4414", script_base)
item_4414.script_id = 334414
item_4414.g_Impact1 = 4414
item_4414.g_Impact2 = -1
function item_4414:OnDefaultEvent(selfId, bagIndex)
end

function item_4414:IsSkillLikeScript(selfId)
    return 1
end

function item_4414:CancelImpacts(selfId)
    return 0
end

function item_4414:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    return 1
end

function item_4414:OnDeplete(selfId)
    if (self:LuaFnDepletingUsedItem(selfId)) then
        return 1
    end
    return 0
end

function item_4414:OnActivateOnce(selfId)
    if (-1 ~= self.g_Impact1) then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, self.g_Impact1, 0)
    end
    return 1
end

function item_4414:OnActivateEachTick(selfId)
    return 1
end

return item_4414
