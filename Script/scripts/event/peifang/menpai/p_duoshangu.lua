local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_duoshangu = class("p_duoshangu", script_base)
p_duoshangu.script_id = 700296
p_duoshangu.g_AbilityNeedLevel = 5
p_duoshangu.g_RecipeId = 296
p_duoshangu.g_SpecialEffectID = 18
function p_duoshangu:OnDefaultEvent(selfId,bagIndex)

end

function p_duoshangu:IsSkillLikeScript(selfId)
return 1
end

function p_duoshangu:CancelImpacts(selfId)
return 0
end

function p_duoshangu:OnConditionCheck(selfId)
AbilityLevel = self:QueryHumanAbilityLevel(selfId,define.ABILITY_ZHIGU)
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

function p_duoshangu:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_duoshangu:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_duoshangu:OnActivateEachTick(selfId)
return 1
end

return p_duoshangu