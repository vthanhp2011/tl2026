local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_tianyitie = class("p_tianyitie", script_base)
p_tianyitie.script_id = 700368
p_tianyitie.g_AbilityNeedLevel = 8
p_tianyitie.g_RecipeId = 368
p_tianyitie.g_SpecialEffectID = 18
function p_tianyitie:OnDefaultEvent(selfId,bagIndex)

end

function p_tianyitie:IsSkillLikeScript(selfId)
return 1
end

function p_tianyitie:CancelImpacts(selfId)
return 0
end

function p_tianyitie:OnConditionCheck(selfId)
AbilityLevel = self:QueryHumanAbilityLevel(selfId,define.ABILITY_QIMENDUNJIA)
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

function p_tianyitie:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_tianyitie:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_tianyitie:OnActivateEachTick(selfId)
return 1
end

return p_tianyitie