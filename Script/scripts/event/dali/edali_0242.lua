local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0242 = class("edali_0242", script_base)
edali_0242.script_id = 210242
edali_0242.g_ItemId = {
    30505114, 30505115, 30505116, 30505117, 30505118, 30505119, 30505120
}
edali_0242.g_PetEggId = 30505121
edali_0242.g_Drop_QiXingSuiPian_StartDay = 9045
edali_0242.g_Drop_QiXingSuiPian_EndDay = 9090
edali_0242.g_ExchangePenguinEggStartDay = 9045
edali_0242.g_ExchangePenguinEggEndDay = 9120
function edali_0242:OnDefaultEvent(selfId, targetId, index)
    if self:IsValidPenguinEggExchangeTime() == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("#Y兑换企鹅")
        self:AddText("    活动已经过期。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#Y兑换企鹅")
        self:AddText(
            "  炎热的夏天里，你想不想要一阵凉风？想不想要一杯冷饮？想不想要一丝清爽？")
        self:AddText(
            "  只要有全部七颗七星碎片，你就都可以获得啦！")
        self:AddText(
            "  一位不知名的长者，可以使用这些碎片来让天龙八部的世界变得更加清爽，而作为奖励，他还托我送给收集七星碎片的人一件最清爽的礼物！")
        self:AddText("  一只可爱的企鹅！")
        self:AddText("  您确认要兑换企鹅蛋吗？")
        self:AddNumText("确定", 8, 3)
        self:AddNumText("取消", 8, 4)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 4 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return
    end
    if index == 3 then
        local HaveAllItem = 1
        for i, ItemId in pairs(self.g_ItemId) do
            if self:GetItemCount(selfId, ItemId) < 1 then
                HaveAllItem = 0
            end
        end
        if HaveAllItem == 0 then
            self:BeginEvent(self.script_id)
            self:AddText(
                "    兑换企鹅蛋需要金、木、水、火、土、日、月七种碎片各一个，您身上的碎片不全，因此无法兑换。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return

        end
        local AllItemCanDelete = 1
        for i, ItemId in pairs(self.g_ItemId) do
            if self:LuaFnGetAvailableItemCount(selfId, ItemId) < 1 then
                AllItemCanDelete = 0
                break
            end
        end

        if AllItemCanDelete == 0 then
            self:BeginEvent(self.script_id)
            self:AddText(
                "    扣除你身上的物品失败，请检测你是否对物品加锁，或者物品处于交易状态。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:BeginAddItem()
        self:AddItem(self.g_PetEggId, 1)
        local ret = self:EndAddItem(selfId)
        local delret = 1
        if ret then
            for i, ItemId in pairs(self.g_ItemId) do
                if not self:LuaFnDelAvailableItem(selfId, ItemId, 1) then
                    delret = 0
                    break
                end
            end
            if delret == 1 then
                self:AddItemListToHuman(selfId)
                local transfer = self:GetItemTransfer(selfId, 0)
                local fmt = "#P #{_INFOUSR%s}经过一番努力，终于收集全了象徵七曜的金星、木星、水星、火星、土星、月亮、太阳七颗碎片。作为酬谢，大理的龚彩云特赠送给其一颗#{_INFOMSG%s}。"
                fmt = gbk.fromutf8(fmt)
                local str = string.format(fmt, gbk.fromutf8(self:GetName(selfId)), transfer)
                self:BroadMsgByChatPipe(selfId, str, 4)
                self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 1000)
                self:BeginUICommand()
                self:EndUICommand()
                self:DispatchUICommand(selfId, 1000)
            end
        end
        return
    end
    if index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#Y兑换企鹅")
        self:AddText("#{duihuanqie_shuoming}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function edali_0242:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:IsValidPenguinEggExchangeTime() == 0 then return end
    caller:AddNumTextWithTarget(self.script_id, "我要兑换企鹅蛋", 6, 1)
    caller:AddNumTextWithTarget(self.script_id, "关于兑换企鹅蛋", 0, 2)
end

function edali_0242:CheckAccept(selfId) end

function edali_0242:OnAccept(selfId, targetId) end

function edali_0242:OnAbandon(selfId) end

function edali_0242:CheckSubmit(selfId) end

function edali_0242:OnSubmit(selfId, targetId, selectRadioId) end

function edali_0242:OnEnterZone(selfId, zoneId) end

function edali_0242:IsValidPenguinEggExchangeTime()
    local theDay = self:GetDayTime()
    if theDay < self.g_ExchangePenguinEggStartDay or theDay >
        self.g_ExchangePenguinEggEndDay then return 0 end
    return 1
end

function edali_0242:PickupItem(selfId, itemId, bagidx)
    local transfer = self:GetBagItemTransfer(selfId, bagidx)
    local fmt = "#P #{_INFOUSR%s}刨出了一块怪石，擦乾净泥土之后，才发现居然是一块#{_INFOMSG%s}。"
    fmt = gbk.fromutf8(fmt)
    local str = string.format(fmt, self:GetName(selfId), transfer)
    self:BroadMsgByChatPipe(selfId, str, 4)
end

function edali_0242:CheckPercentOK(numerator, denominator)
    local roll = math.random(denominator)
    if roll <= numerator then return 1 end
    return 0
end

function edali_0242:IsValidDayToDrop_QiXingSuiPian()
    local DayTime = self:GetDayTime()
    if DayTime < self.g_Drop_QiXingSuiPian_StartDay or DayTime >
        self.g_Drop_QiXingSuiPian_EndDay then return 0 end
    return 1
end

function edali_0242:DropStoneList(LongzhuIndex)
    if 0 == self:IsValidDayToDrop_QiXingSuiPian() then return -1 end
    if 1 == LongzhuIndex then
        local CheckOK = self:CheckPercentOK(667, 100000)
        if 1 == CheckOK then return 30505114 end
    end
    if 2 == LongzhuIndex then
        local CheckOK = self:CheckPercentOK(167, 100000)
        if 1 == CheckOK then return 30505115 end
    end

    if 3 == LongzhuIndex then
        local CheckOK = self:CheckPercentOK(67, 100000)
        if 1 == CheckOK then return 30505116 end
    end
    if 4 == LongzhuIndex then
        local CheckOK = self:CheckPercentOK(37, 100000)
        if 1 == CheckOK then return 30505117 end
    end
    if 5 == LongzhuIndex then
        local CheckOK = self:CheckPercentOK(23, 100000)
        if 1 == CheckOK then return 30505118 end
    end
    if 6 == LongzhuIndex then
        local CheckOK = self:CheckPercentOK(13, 100000)
        if 1 == CheckOK then return 30505119 end
    end
    if 7 == LongzhuIndex then
        local CheckOK = self:CheckPercentOK(7, 100000)
        if 1 == CheckOK then return 30505120 end
    end
    return -1
end

return edali_0242
