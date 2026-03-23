local class = require "class"
local define = require "define"
local script_base = require "script_base"
local estudy_yangshengfa = class("estudy_yangshengfa", script_base)
estudy_yangshengfa.script_id = 713528
estudy_yangshengfa.g_MessageStudy = "如果你达到%d级并且肯花费#{_EXCHG%d}就可以学会养生法技能。你决定学习么？"
estudy_yangshengfa.g_AbilityID = define.ABILITY_YANGSHENGFA
estudy_yangshengfa.g_AbilityName = "养生法"
function estudy_yangshengfa:OnDefaultEvent(selfId, targetId, ButtomNum, g_Npc_ScriptId, bid)
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, self.g_AbilityID)
    if AbilityLevel >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText("你已经学会" .. self.g_AbilityName .. "技能了")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    if bid then
        self:StudyInCity(selfId, targetId, ButtomNum, g_Npc_ScriptId, bid)
        return
    end
    if ButtomNum == 0 then
        local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel, extraMoney, extraExp = self:LuaFnGetAbilityLevelUpConfig2(define.ABILITY_YANGSHENGFA, 1)
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
        local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel, extraMoney, extraExp = self:LuaFnGetAbilityLevelUpConfig2(define.ABILITY_YANGSHENGFA, 1)
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

function estudy_yangshengfa:OnEnumerate(caller, selfId, targetId, bid)
    if bid then
        local ret =  self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck", selfId, self.g_AbilityID, bid, 5)
        if ret > 0 then
            caller:AddNumTextWithTarget(self.script_id, "学习" .. self.g_AbilityName .. "技能", 12, 0)
        end
        return
    end
    local ret = self:LuaFnGetAbilityLevelUpConfig(define.ABILITY_YANGSHENGFA, 1)
    if ret then
        caller:AddNumTextWithTarget(self.script_id, "学习" .. self.g_AbilityName .. "技能", 12, 0)
    end
    return
end

function estudy_yangshengfa:CheckAccept()

end

function estudy_yangshengfa:OnAccept()

end

function estudy_yangshengfa:StudyInCity(selfId, targetId, ButtomNum, g_Npc_ScriptId, bid)
    if bid then
        if 0 == ButtomNum then
            if self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "CheckCityStatus", selfId, targetId) < 0 then
                return
            end
            self:BeginEvent(self.script_id)
            local lv, money, con = self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityAction", selfId, targetId, self.g_AbilityID, bid,4)
            local studyMsg = string.format("如果你达到%d级并且肯花费#{_EXCHG%d}和%d点帮贡就可以学会" .. self.g_AbilityName .. "技能。你决定学习么？", lv, money, con)
            self:AddText(studyMsg)
            self:AddNumText("我确定要学习", 6, 2)
            self:AddNumText("我只是来看看", 8, 3)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        elseif 2 == ButtomNum then
            local ret = self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck", selfId, self.g_AbilityID, bid, 1)
            if ret > 0 then
                self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityAction", selfId, targetId, self.g_AbilityID, bid, 1)
            end
        else
            self:CallScriptFunction(g_Npc_ScriptId, "OnDefaultEvent", selfId, targetId)
        end
    end
end

return estudy_yangshengfa
