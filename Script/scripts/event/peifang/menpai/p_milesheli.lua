local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_milesheli = class("p_milesheli", script_base)
p_milesheli.script_id = 700294
p_milesheli.g_AbilityNeedLevel = 7
p_milesheli.g_RecipeId = 294
p_milesheli.g_SpecialEffectID = 18
function p_milesheli:OnDefaultEvent(selfId,bagIndex)

end

function p_milesheli:IsSkillLikeScript(selfId)
return 1
end

function p_milesheli:CancelImpacts(selfId)
return 0
end

function p_milesheli:OnConditionCheck(selfId)
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

function p_milesheli:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_milesheli:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_milesheli:OnActivateEachTick(selfId)
return 1
end

return p_milesheli