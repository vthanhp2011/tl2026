local class = require "class"
local define = require "define"
local script_base = require "script_base"
local chonglouequipbag = class("chonglouequipbag", script_base)
chonglouequipbag.g_tableRewardInfo = { 10422150, 10423024 }
chonglouequipbag.script_id = 892042
function chonglouequipbag:IsSkillLikeScript(selfId)
    return 1
end

function chonglouequipbag:CancelImpacts(selfId)
    return 0
end

function chonglouequipbag:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
        return 0
    end
    local nItemId = self:LuaFnGetItemIndexOfUsedItem(selfId)
    if nItemId ~= 38002943 then
        self:NotifyFailTips(selfId,"物品非法。")
        return 0
    end
	self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 2023061200)
    return 0
end

function chonglouequipbag:OnDeplete(selfId)
    if self:LuaFnDepletingUsedItem(selfId) then
        return 1
    end
    return 0
end

function chonglouequipbag:OnActivateOnce(selfId)
    return 1
end

function chonglouequipbag:OpenTwoGift(selfId, nSelect)
    local nItemId = self:LuaFnGetItemIndexOfUsedItem(selfId)
    if nItemId ~= 38002943 then
        self:NotifyFailTips(selfId,"物品非法。")
        return 0
    end
    if nSelect < 1 or nSelect > 2 then
        return
    end
    if self.g_tableRewardInfo[nSelect] == nil then
        return
    end
    self:BeginAddItem()
    self:AddItem(self.g_tableRewardInfo[nSelect], 1,true)
    if not self:EndAddItem(selfId) then
        self:NotifyFailTips(selfId,"请保证道具栏存在一个空位。")
        return
    end
    if self:LuaFnGetPropertyBagSpace(selfId) < 1 then
        self:NotifyFailTips(selfId,"请保证道具栏存在一个空位。")
        return
    end
    self:AddItemListToHuman(selfId)
    self:LuaFnDelAvailableItem(selfId, nItemId, 1)
    self:NotifyFailTips(selfId, string.format("您获得了1件%s。", self:GetItemName(self.g_tableRewardInfo[nSelect])))
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

function chonglouequipbag:OnActivateEachTick(selfId)
    return 1
end

function chonglouequipbag:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return chonglouequipbag
