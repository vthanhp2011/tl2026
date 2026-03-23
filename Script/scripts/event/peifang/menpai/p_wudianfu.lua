local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_wudianfu = class("p_wudianfu", script_base)
p_wudianfu.script_id = 700321
p_wudianfu.g_AbilityNeedLevel = 7
p_wudianfu.g_RecipeId = 321
p_wudianfu.g_SpecialEffectID = 18
function p_wudianfu:OnDefaultEvent(selfId,bagIndex)

end

function p_wudianfu:IsSkillLikeScript(selfId)
return 1
end

function p_wudianfu:CancelImpacts(selfId)
return 0
end

function p_wudianfu:OnConditionCheck(selfId)
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

function p_wudianfu:OnDeplete(selfId)
if self:LuaFnDepletingUsedItem(selfId) then
return 1
end
return 0
end

function p_wudianfu:OnActivateOnce(selfId)
self:CallScriptFunction(713501,"ReadRecipe",selfId,self.g_RecipeId)
self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,self.g_SpecialEffectID,0)
return 1
end

function p_wudianfu:OnActivateEachTick(selfId)
return 1
end

return p_wudianfu