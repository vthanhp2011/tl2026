local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_shenlisheli = class("p_shenlisheli", script_base)
p_shenlisheli.script_id = 700246
p_shenlisheli.g_AbilityNeedLevel = 7
p_shenlisheli.g_RecipeId = 246
p_shenlisheli.g_SpecialEffectID = 18
function p_shenlisheli:OnDefaultEvent(selfId,bagIndex)

end

function p_shenlisheli:IsSkillLikeScript(selfId)
return 1
end

function p_shenlisheli:CancelImpacts(selfId)
return 0
end

function p_shenlisheli:OnConditionCheck(selfId)
AbilityLevel = self:QueryHumanAbilityLevel(selfId,define.ABILITY_KAIGUANG)
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

function p_shenlisheli:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_shenlisheli:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_shenlisheli:OnActivateEachTick(selfId)
return 1
end

return p_shenlisheli