local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_tianhanfu = class("p_tianhanfu", script_base)
p_tianhanfu.script_id = 700341
p_tianhanfu.g_AbilityNeedLevel = 8
p_tianhanfu.g_RecipeId = 341
p_tianhanfu.g_SpecialEffectID = 18
function p_tianhanfu:OnDefaultEvent(selfId,bagIndex)

end

function p_tianhanfu:IsSkillLikeScript(selfId)
return 1
end

function p_tianhanfu:CancelImpacts(selfId)
return 0
end

function p_tianhanfu:OnConditionCheck(selfId)
AbilityLevel = self:QueryHumanAbilityLevel(selfId,define.ABILITY_ZHIFU)
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

function p_tianhanfu:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_tianhanfu:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_tianhanfu:OnActivateEachTick(selfId)
return 1
end

return p_tianhanfu