local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_wuweifu = class("p_wuweifu", script_base)
p_wuweifu.script_id = 700378
p_wuweifu.g_AbilityNeedLevel = 3
p_wuweifu.g_RecipeId = 378
p_wuweifu.g_SpecialEffectID = 18
function p_wuweifu:OnDefaultEvent(selfId,bagIndex)

end

function p_wuweifu:IsSkillLikeScript(selfId)
return 1
end

function p_wuweifu:CancelImpacts(selfId)
return 0
end

function p_wuweifu:OnConditionCheck(selfId)
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

function p_wuweifu:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_wuweifu:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_wuweifu:OnActivateEachTick(selfId)
return 1
end

return p_wuweifu