local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_nuanyihuo = class("p_nuanyihuo", script_base)
p_nuanyihuo.script_id = 700395
p_nuanyihuo.g_AbilityNeedLevel = 3
p_nuanyihuo.g_RecipeId = 395
p_nuanyihuo.g_SpecialEffectID = 18
function p_nuanyihuo:OnDefaultEvent(selfId,bagIndex)

end

function p_nuanyihuo:IsSkillLikeScript(selfId)
return 1
end

function p_nuanyihuo:CancelImpacts(selfId)
return 0
end

function p_nuanyihuo:OnConditionCheck(selfId)
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

function p_nuanyihuo:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_nuanyihuo:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_nuanyihuo:OnActivateEachTick(selfId)
return 1
end

return p_nuanyihuo