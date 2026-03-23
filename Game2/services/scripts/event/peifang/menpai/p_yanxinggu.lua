local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_yanxinggu = class("p_yanxinggu", script_base)
p_yanxinggu.script_id = 700278
p_yanxinggu.g_AbilityNeedLevel = 4
p_yanxinggu.g_RecipeId = 278
p_yanxinggu.g_SpecialEffectID = 18
function p_yanxinggu:OnDefaultEvent(selfId,bagIndex)

end

function p_yanxinggu:IsSkillLikeScript(selfId)
return 1
end

function p_yanxinggu:CancelImpacts(selfId)
return 0
end

function p_yanxinggu:OnConditionCheck(selfId)
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

function p_yanxinggu:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_yanxinggu:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_yanxinggu:OnActivateEachTick(selfId)
return 1
end

return p_yanxinggu