local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_shenxinghuo = class("p_shenxinghuo", script_base)
p_shenxinghuo.script_id = 700282
p_shenxinghuo.g_AbilityNeedLevel = 7
p_shenxinghuo.g_RecipeId = 282
p_shenxinghuo.g_SpecialEffectID = 18
function p_shenxinghuo:OnDefaultEvent(selfId,bagIndex)

end

function p_shenxinghuo:IsSkillLikeScript(selfId)
return 1
end

function p_shenxinghuo:CancelImpacts(selfId)
return 0
end

function p_shenxinghuo:OnConditionCheck(selfId)
AbilityLevel = self:QueryHumanAbilityLevel(selfId,define.ABILITY_SHENGHUOSHU)
if not self:LuaFnVerifyUsedItem(selfId) then
return 0
end
if AbilityLevel < self.g_AbilityNeedLevel then
self:BeginEvent(self.script_id)
strText = "技能等级不足"
self:AddText(strText)
self:EndEvent()
self:DispatchMissionTips(selfId)
return 0
end
if self:LuaFnIsPrescrLearned(selfId,self.g_RecipeId) then
self:BeginEvent(self.script_id)
strText = "这个配方已经学会了"
self:AddText(strText)
self:EndEvent()
self:DispatchMissionTips(selfId)
return 0
end
return 1
end

function p_shenxinghuo:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_shenxinghuo:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_shenxinghuo:OnActivateEachTick(selfId)
return 1
end

return p_shenxinghuo