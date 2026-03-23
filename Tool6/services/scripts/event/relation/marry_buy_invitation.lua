local class = require "class"
local define = require "define"
local script_base = require "script_base"
local marry_buy_invitation = class("marry_buy_invitation", script_base)
marry_buy_invitation.script_id = 806017
marry_buy_invitation.g_invitationDataId_level1 = 30303100
marry_buy_invitation.g_invitationDataId_level2 = 30303101
marry_buy_invitation.g_invitationDataId_level3 = 30303102
marry_buy_invitation.g_eventId_update = 0
marry_buy_invitation.g_eventId_cancel = 1
marry_buy_invitation.g_eventId_select_level = 1000
marry_buy_invitation.g_eventId_select_count = 2000
marry_buy_invitation.g_eventId_select_buy = 3000
function marry_buy_invitation:OnDefaultEvent(selfId, targetId, index)
    local selectEventId = index
    if selectEventId then
        if selectEventId > self.g_eventId_select_buy - 1 then
            local level = math.floor((selectEventId - self.g_eventId_select_buy) / 100)
            local count = selectEventId % 100
            self:OnBuy(selfId, targetId, level, count)
        elseif selectEventId > self.g_eventId_select_count - 1 then
            local level = math.floor((selectEventId - self.g_eventId_select_count) / 100)
            local count = selectEventId % 100
            self:OnSelectCount(selfId, targetId, level, count)
        elseif selectEventId > self.g_eventId_select_level - 1 then
            local level = math.floor((selectEventId - self.g_eventId_select_level) / 100)
            self:OnSelectLevel(selfId, targetId, level)
        elseif selectEventId == self.g_eventId_update then
            self:OnUpdate(selfId, targetId)
        else
            self:BeginUICommand()
            self:EndUICommand()
            self:DispatchUICommand(selfId, 1000)
        end
    end
end

function marry_buy_invitation:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "购买请帖", 7, self.g_eventId_update)
end

function marry_buy_invitation:OnUpdate(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("请帖是有有效期的，有效期一个月，所以没准备好结婚的时候不要提早购买啊。你只要将请帖交易给你的朋友，你的朋友就可以使用此物品参加您的婚礼了。")
    self:AddNumText("购买" .. self:GetItemLevelNameByLevel(selfId, 0) .. "请帖", 7, 0 * 100 + self.g_eventId_select_level)
    self:AddNumText("购买" .. self:GetItemLevelNameByLevel(selfId, 1) .. "请帖", 7, 1 * 100 + self.g_eventId_select_level)
    self:AddNumText("购买" .. self:GetItemLevelNameByLevel(selfId, 2) .. "请帖", 7, 2 * 100 + self.g_eventId_select_level)
    self:AddNumText("离开……", 8, self.g_eventId_cancel)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function marry_buy_invitation:OnSelectLevel(selfId, targetId, itemLevel)
    self:BeginEvent(self.script_id)
    self:AddText("请选择你要购买的数量：")
    self:AddNumText("一张", 6, itemLevel * 100 + self.g_eventId_select_count + 1)
    self:AddNumText("五张", 6, itemLevel * 100 + self.g_eventId_select_count + 5)
    self:AddNumText("十张", 6, itemLevel * 100 + self.g_eventId_select_count + 10)
    self:AddNumText("返回", 8, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function marry_buy_invitation:OnSelectCount(selfId, targetId, itemLevel, itemCount)
    if itemLevel and itemCount then
        self:BeginEvent(self.script_id)
        local szText =
            string.format(
            "购买%d张%s请帖，共需花费#{_EXCHG%d}，是否确认购买？",
            itemCount,
            self:GetItemLevelNameByLevel(selfId, itemLevel),
            itemCount * self:GetItemPriceByLevel(selfId, itemLevel)
        )
        self:AddText(szText)
        self:AddNumText("确定", 6, itemLevel * 100 + self.g_eventId_select_buy + itemCount)
        self:AddNumText("取消", 8, itemLevel * 100 + self.g_eventId_select_level)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function marry_buy_invitation:OnBuy(selfId, targetId, itemLevel, itemCount)
    if itemLevel and itemCount and itemCount > 0 then
        local itemPrice = self:GetItemPriceByLevel(selfId, itemLevel)
        local money = self:LuaFnGetMoney(selfId)
        local moneyJZ = self:GetMoneyJZ(selfId)
        local needMoney = itemPrice * itemCount
        if money and needMoney and moneyJZ and (money + moneyJZ) < needMoney then
            self:MessageBox(selfId, targetId, "很抱歉，你没有足够的金钱！", 1)
            return 0
        end
        local selfProSpace = self:LuaFnGetPropertyBagSpace(selfId)
        if selfProSpace and selfProSpace >= itemCount then
        else
            self:MessageBox(selfId, targetId, "很抱歉，你的背包没有足够的空间！", 1)
            return 0
        end
        self:LuaFnCostMoneyWithPriority(selfId, needMoney)
        local selfName = self:LuaFnGetName(selfId)
        local selfGUID = self:LuaFnGetGUID(selfId)
        local itemId = self:GetItemDataByLevel(selfId, itemLevel)
        for i = 1, itemCount do
            local pos = self:TryRecieveItem(selfId, itemId, false)
            if pos and pos ~= -1 then
                self:LuaFnSetItemCreator(selfId, pos, selfName)
                self:SetBagItemParam(selfId, pos, 0, selfGUID, "uint")
            end
        end
    end
    self:OnSelectLevel(selfId, targetId, itemLevel)
end

function marry_buy_invitation:MessageBox(selfId, targetId, msg, showReturn)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    if showReturn and showReturn == 1 then
        self:AddNumText("返回", 8, self.g_eventId_update)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function marry_buy_invitation:GetItemLevelNameByLevel(selfId, level)
    if level == 2 then
        return "豪华"
    elseif level == 1 then
        return "高级"
    else
        return "普通"
    end
end

function marry_buy_invitation:GetItemDataByLevel(selfId, level)
    local itemId
    if level == 2 then
        itemId = self.g_invitationDataId_level3
    elseif level == 1 then
        itemId = self.g_invitationDataId_level2
    else
        itemId = self.g_invitationDataId_level1
    end
    return itemId
end

function marry_buy_invitation:GetItemPriceByLevel(selfId, level)
    local itemId = self:GetItemDataByLevel(selfId, level)
    local price = self:LuaFnGetItemPrice(itemId)
    return price
end

return marry_buy_invitation
