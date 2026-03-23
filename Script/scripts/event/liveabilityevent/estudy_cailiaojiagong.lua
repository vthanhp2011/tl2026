local class = require "class"
local define = require "define"
local script_base = require "script_base"
local estudy_cailiaojiagong = class("estudy_cailiaojiagong", script_base)
estudy_cailiaojiagong.script_id = 713538
estudy_cailiaojiagong.g_MessageStudy = "如果你达到%d级并且肯花费#{_EXCHG%d}就可以学会材料加工技能。你决定学习么？"
estudy_cailiaojiagong.g_AbilityID = define.ABILITY_CAILIAOHECHENG
estudy_cailiaojiagong.g_AbilityName = "材料加工"
estudy_cailiaojiagong.g_PeiFangID = { 399, 400, 401, 402, 403, 404, 405, 406, 407 }
function estudy_cailiaojiagong:OnDefaultEvent(selfId, targetId, ButtomNum, g_Npc_ScriptId)
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, self.g_AbilityID)
    if AbilityLevel >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText("你已经学会" .. self.g_AbilityName .. "技能了")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    if ButtomNum == 0 then
        local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel, extraMoney, extraExp = self:LuaFnGetAbilityLevelUpConfig2(define.ABILITY_NIANGJIU, 1)
        if ret then
            self:BeginEvent(self.script_id)
            local addText = string.format(self.g_MessageStudy, limitLevel, demandMoney)
            self:AddText(addText)
            self:AddNumText("我确定要学习", 6, 2)
            self:AddNumText("我只是来看看", 8, 3)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif ButtomNum == 2 then
        local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel, extraMoney, extraExp = self:LuaFnGetAbilityLevelUpConfig2(define.ABILITY_NIANGJIU, 1)
        if ret then
            if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < demandMoney then
                self:BeginEvent(self.script_id)
                self:AddText("你的金钱不足")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
            if self:GetLevel(selfId) < limitLevel then
                self:BeginEvent(self.script_id)
                self:AddText("你的等级不够")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
            self:LuaFnCostMoneyWithPriority(selfId, demandMoney)
            self:SetHumanAbilityLevel(selfId, self.g_AbilityID, 10)
            self:AddAllPeiFang(selfId )
            self:BeginEvent(self.script_id)
            self:AddText("你学会了" .. self.g_AbilityName .. "技能")
            self:EndEvent()
            self:LuaFnAuditLearnLifeAbility(selfId, self.g_AbilityID)
            self:DispatchEventList(selfId, targetId)
        end
    else
        self:CallScriptFunction(g_Npc_ScriptId, "OnDefaultEvent", selfId, targetId)
    end
end

function estudy_cailiaojiagong:OnEnumerate(caller, selfId, targetId, bid)
    caller:AddNumTextWithTarget(self.script_id, "学习" .. self.g_AbilityName .. "技能", 12, 0)
end

function estudy_cailiaojiagong:CheckAccept()

end

function estudy_cailiaojiagong:OnAccept()

end

function estudy_cailiaojiagong:AddAllPeiFang(selfId )
	for i, pfID in pairs(self.g_PeiFangID) do
		if not self:IsPrescrLearned(selfId, pfID )  then
			self:SetPrescription(selfId, pfID, 1 )
		end
	end
end


return estudy_cailiaojiagong
