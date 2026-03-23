local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_4833 = class("item_4833", script_base)
item_4833.script_id = 334833
item_4833.g_Impact1 = 4833
item_4833.g_Impact2 = -1
item_4833.g_Yinpiao = 40002000
function item_4833:OnDefaultEvent(selfId, bagIndex)
end

function item_4833:IsSkillLikeScript(selfId)
    return 1
end

function item_4833:CancelImpacts(selfId)
    return 0
end

function item_4833:OnConditionCheck(selfId)
    if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText("你身上有银票，正在跑商！不可以使用传送功能。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    if self:IsHaveMission(selfId, 4021) then
        self:BeginEvent(self.script_id)
        local strText = "您处于漕运状态中，不可以使用传送功能。"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return 0
    end
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    return 1
end

function item_4833:OnDeplete(selfId)
    if (self:LuaFnDepletingUsedItem(selfId)) then
        return 1
    end
    return 0
end

function item_4833:OnActivateOnce(selfId)
    if (-1 ~= self.g_Impact1) then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, self.g_Impact1, 0)
    end
    return 1
end

function item_4833:OnActivateEachTick(selfId)
    return 1
end

return item_4833
