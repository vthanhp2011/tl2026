local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ScriptGlobal = require "scripts.ScriptGlobal"
local Prize_Card = class("Prize_Card", script_base)
Prize_Card.script_id = 999911
Prize_Card.g_Item = 
{
    [38008168] = 20,
    [38008169] = 30,
    [38008170] = 50,
    [38008171] = 80,
    [38008172] = 100,
    [38008173] = 150,
    [38008174] = 200,
    [38008179] = 300,
    [38008180] = 500,
    [38008181] = 1000,
    [38008182] = 2000,
    [38008183] = 3000,
    [38008184] = 5000,
    [38008185] = 100000,
    [38008209] = 70,
    [38008155] = 500,
}
function Prize_Card:OnDefaultEvent(selfId, bagIndex)
end
function Prize_Card:IsSkillLikeScript(selfId)
    return 1
end
function Prize_Card:CancelImpacts(selfId)
    return 0
end
function Prize_Card:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
        return 0
    end
    local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId)
    if self.g_Item[itemTblIndex] == nil then
        self:Tip(selfId, "物品非法")
        return 0
    end
	if not ScriptGlobal.is_internal_test then
		if itemTblIndex == 38008155 or itemTblIndex == 38008185 then
			return 0
		end
	end
    if (self.g_Item[itemTblIndex] * 800 + self:GetYuanBao(selfId)) > 2100000000 then
        self:Tip(selfId, "你兑换的元宝超过上限了请少换点")
        return 0
    end
    return 1
end
function Prize_Card:OnDeplete(selfId)
    if self:LuaFnDepletingUsedItem(selfId) then
        return 1
    end
    return 1
end
function Prize_Card:OnActivateOnce(selfId)
    local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local addyuanbao = self.g_Item[itemTblIndex] * ScriptGlobal.MD_CHANGE_YUANBAO_NEW_RATE
	self:CSAddYuanbao(selfId, addyuanbao)
	self:Tip(selfId, "您成功的兑换了" .. addyuanbao .. "点元宝。")
	local acme_havepoint = self:GetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW)
	self:SetMissionData(selfId, ScriptGlobal.MD_CHANGE_YUANBAO_NEW, acme_havepoint + addyuanbao)
	self:CallScriptFunction(888817,"ResetPayReward",selfId,self.g_Item[itemTblIndex],666666,888888)		--666666,888888 此两值不要改动
	--刷新下称号
    self:CallScriptFunction(888899, "AddPayTitle", selfId)
    return 1
end
function Prize_Card:OnActivateEachTick(selfId)
    return 1
end
function Prize_Card:Tip(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end
return Prize_Card