local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_yutitie = class("p_yutitie", script_base)
p_yutitie.script_id = 700329
p_yutitie.g_AbilityNeedLevel = 4
p_yutitie.g_RecipeId = 329
p_yutitie.g_SpecialEffectID = 18
function p_yutitie:OnDefaultEvent(selfId,bagIndex)

end

function p_yutitie:IsSkillLikeScript(selfId)
return 1
end

function p_yutitie:CancelImpacts(selfId)
return 0
end

function p_yutitie:OnConditionCheck(selfId)
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

function p_yutitie:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_yutitie:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_yutitie:OnActivateEachTick(selfId)
return 1
end

return p_yutitie