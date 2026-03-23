local class = require "class"
local define = require "define"
local script_base = require "script_base"
local estudy_qimendunjia = class("estudy_qimendunjia", script_base)
estudy_qimendunjia.script_id = 713520
estudy_qimendunjia.g_MessageStudy = "如果你达到%d级并且肯花费#{_EXCHG%d}就可以学会奇门遁甲技能。你决定学习么？"
estudy_qimendunjia.g_AbilityID = define.ABILITY_QIMENDUNJIA
estudy_qimendunjia.g_AbilityName = "奇门遁甲"
function estudy_qimendunjia:OnDefaultEvent(selfId, targetId, ButtomNum, g_Npc_ScriptId)
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
            if self:GetMenPai(selfId) ~= define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO then
                self:BeginEvent(self.script_id)
                self:AddText("你不是本派弟子，我不能教你。");
                self:EndEvent()
                self:DispatchEventList(selfId,targetId)
                return
            end
            self:LuaFnCostMoneyWithPriority(selfId, demandMoney)
            self:SetHumanAbilityLevel(selfId, self.g_AbilityID, 10)
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

function estudy_qimendunjia:OnEnumerate(caller, selfId, targetId, bid)
    caller:AddNumTextWithTarget(self.script_id, "学习" .. self.g_AbilityName .. "技能", 12, 0)
end

function estudy_qimendunjia:CheckAccept()

end

function estudy_qimendunjia:OnAccept()

end

return estudy_qimendunjia
