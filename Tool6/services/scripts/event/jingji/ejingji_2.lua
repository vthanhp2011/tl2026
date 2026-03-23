local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ejingji_2 = class("ejingji_2", script_base)
ejingji_2.script_id = 125021
ejingji_2.g_StoneId = 30505143
ejingji_2.g_Item_1 = 10421018
ejingji_2.g_Item_2 = 10421019
ejingji_2.g_Item_3 = 10421020
ejingji_2.g_Item_4 = 10421021
ejingji_2.g_Exp = 50000
function ejingji_2:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget("盟主铜腰带兑换盟主之印", 12, 1)
    caller:AddNumTextWithTarget("盟主银腰带兑换盟主之印", 12, 2)
    caller:AddNumTextWithTarget("盟主金腰带兑换盟主之印", 12, 3)
    caller:AddNumTextWithTarget("升级为盟主铜腰带", 6, 7)
    caller:AddNumTextWithTarget("升级为盟主银腰带", 6, 4)
    caller:AddNumTextWithTarget("升级为盟主金腰带", 6, 5)
    caller:AddNumTextWithTarget("升级为盟主七宝腰带", 6, 6)
end

function ejingji_2:OnDefaultEvent(selfId, targetId, arg, index)
    local Num = index
    if Num == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#B盟主铜腰带兑换盟主之印")
        self:AddText("  1个盟主铜腰带可以兑换1个盟主之印")
        self:AddNumText("确定", 8, 10)
        self:AddNumText("取消", 8, 20)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif Num == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#B盟主银腰带兑换盟主之印")
        self:AddText("  1个盟主银腰带可以兑换10个盟主之印")
        self:AddNumText("确定", 8, 11)
        self:AddNumText("取消", 8, 20)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif Num == 3 then
        self:BeginEvent(self.script_id)
        self:AddText("#B盟主金腰带兑换盟主之印")
        self:AddText("  1个盟主金腰带可以兑换100个盟主之印")
        self:AddNumText("确定", 8, 12)
        self:AddNumText("取消", 8, 20)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif Num == 4 then
        self:BeginEvent(self.script_id)
        self:AddText("#B升级为盟主银腰带")
        self:AddText("  升级成为盟主银腰带需要消耗：#r#G    1个盟主铜腰带#r    9个盟主之印#r    你确定要升级吗？")
        self:AddNumText("确定", 8, 13)
        self:AddNumText("取消", 8, 20)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif Num == 5 then
        self:BeginEvent(self.script_id)
        self:AddText("#B升级为盟主金腰带")
        self:AddText("  升级成为盟主金腰带需要消耗：#r#G    1个盟主银腰带#r    90个盟主之印#r    #{_EXCHG" ..tostring(500000) .. "}#W#r  你确定要升级吗？")
        self:AddNumText("确定", 8, 14)
        self:AddNumText("取消", 8, 20)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif Num == 6 then
        self:BeginEvent(self.script_id)
        self:AddText("#B升级为盟主七宝腰带")
        self:AddText("  升级成为盟主七宝腰带需要消耗：#r#G    1个盟主金腰带#r    400个盟主之印#r    #{_EXCHG" ..tostring(1000000) .. "}#W#r  你确定要升级吗？")
        self:AddNumText("确定", 8, 15)
        self:AddNumText("取消", 8, 20)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif Num == 7 then
        self:BeginEvent(self.script_id)
        self:AddText("#B升级为盟主铜腰带")
        self:AddText("  升级成为盟主铜腰带需要消耗：#r#G    40个盟主铜腰带碎片#W#r  你确定要升级吗？")
        self:AddNumText("确定", 8, 16)
        self:AddNumText("取消", 8, 20)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if Num == 10 then
        self:ChangeItem(selfId, 1)
    elseif Num == 11 then
        self:ChangeItem(selfId, 2)
    elseif Num == 12 then
        self:ChangeItem(selfId, 3)
    end
    if Num == 13 then
        self:UpdateItem(selfId, 1)
    elseif Num == 14 then
        self:UpdateItem(selfId, 2)
    elseif Num == 15 then
        self:UpdateItem(selfId, 3)
    end
    if Num == 16 then self:StoneToItem(selfId) end
    if Num == 20 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
end

function ejingji_2:StoneToItem(selfId)
    self:BeginAddItem()
    self:AddItem(self.g_Item_1, 1)
    local ret = self:EndAddItem(selfId)
    local nStoneId = 40004434
    if ret then
        if self:LuaFnGetAvailableItemCount(selfId, nStoneId) >= 40 then
            self:LuaFnDelAvailableItem(selfId, nStoneId, 40)
            self:AddItemListToHuman(selfId)
            self:DispatchTips(selfId, 1)
            self:LuaFnAuditPlayerBehavior(selfId, "碎片换腰带")
        else
            self:DispatchTips(selfId, 0)
        end
    else
        self:DispatchTips(selfId, -2)
    end
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
end

function ejingji_2:UpdateItem(selfId, nIndex)
    if nIndex == 1 then
        self:BeginAddItem()
        self:AddItem(self.g_Item_2, 1)
        local ret = self:EndAddItem(selfId)
        if ret then
            if self:LuaFnGetAvailableItemCount(selfId, self.g_StoneId) >= 9 and
                self:LuaFnGetAvailableItemCount(selfId, self.g_Item_1) >= 1 then
                self:LuaFnDelAvailableItem(selfId, self.g_StoneId, 9)
                self:LuaFnDelAvailableItem(selfId, self.g_Item_1, 1)
                self:AddItemListToHuman(selfId)
                self:LuaFnAuditPlayerBehavior(selfId, "铜腰带换银腰带")
                self:DispatchTips(selfId, 1)
                return
            end
        end
    elseif nIndex == 2 then
        if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < 500000 then
            self:DispatchTips(selfId, -1)
            return
        end
        self:BeginAddItem()
        self:AddItem(self.g_Item_3, 1)
        local ret = self:EndAddItem(selfId)
        if ret then
            if self:LuaFnGetAvailableItemCount(selfId, self.g_StoneId) >= 90 and
                self:LuaFnGetAvailableItemCount(selfId, self.g_Item_2) >= 1 then
                self:LuaFnDelAvailableItem(selfId, self.g_StoneId, 90)
                self:LuaFnDelAvailableItem(selfId, self.g_Item_2, 1)
                self:LuaFnCostMoneyWithPriority(selfId, 500000)
                self:AddItemListToHuman(selfId)
                self:LuaFnAuditPlayerBehavior(selfId, "银腰带换金腰带")
                self:DispatchTips(selfId, 1)
                return
            end
        end
    elseif nIndex == 3 then
        if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < 1000000 then
            self:DispatchTips(selfId, -1)
            return
        end
        self:BeginAddItem()
        self:AddItem(self.g_Item_4, 1)
        local ret = self:EndAddItem(selfId)
        if ret then
            if self:LuaFnGetAvailableItemCount(selfId, self.g_StoneId) >= 400 and
                self:LuaFnGetAvailableItemCount(selfId, self.g_Item_3) >= 1 then
                self:LuaFnDelAvailableItem(selfId, self.g_StoneId, 400)
                self:LuaFnDelAvailableItem(selfId, self.g_Item_3, 1)
                self:LuaFnCostMoneyWithPriority(selfId, 1000000)
                self:AddItemListToHuman(selfId)
                self:LuaFnAuditPlayerBehavior(selfId, "金腰带换七宝腰带")
                self:DispatchTips(selfId, 1)
                local BagPos = self:LuaFnGetItemPosByItemDataID(selfId, self.g_Item_4)
                local szTransferEquip = self:GetItemTransfer(selfId, BagPos)
                local name = self:GetName(selfId)
                name = gbk.fromutf8(name)
                local str = string.format("#P於九莲大喊：天下英雄们！伟大的英雄#{_INFOUSR%s}多年来在封禅台上浴血奋战，终於赢得了武林盟主真正的标志！#{_INFOMSG%s}！", name, szTransferEquip)
                self:BroadMsgByChatPipe(selfId, str, 4)
                return
            end
        end
    end
    self:DispatchTips(selfId, 0)
end

function ejingji_2:ChangeItem(selfId, nIndex)
    if nIndex == 1 then
        self:BeginAddItem()
        self:AddItem(self.g_StoneId, 1)
        local ret = self:EndAddItem(selfId)
        if ret then
            if self:LuaFnDelAvailableItem(selfId, self.g_Item_1, 1) then
                self:AddItemListToHuman(selfId)
                self:LuaFnAuditPlayerBehavior(selfId, "铜腰带换1盟主印")
                self:DispatchTips(selfId, 1)
                return
            end
        end
    elseif nIndex == 2 then
        self:BeginAddItem()
        self:AddItem(self.g_StoneId, 10)
        local ret = self:EndAddItem(selfId)
        if ret then
            if self:LuaFnDelAvailableItem(selfId, self.g_Item_2, 1) then
                self:AddItemListToHuman(selfId)
                self:LuaFnAuditPlayerBehavior(selfId, "银腰带换10盟主印")
                self:DispatchTips(selfId, 1)
                return
            end
        end
    elseif nIndex == 3 then
        self:BeginAddItem()
        self:AddItem(self.g_StoneId, 100)
        local ret = self:EndAddItem(selfId)
        if ret then
            if self:LuaFnDelAvailableItem(selfId, self.g_Item_3, 1) then
                self:AddItemListToHuman(selfId)
                self:LuaFnAuditPlayerBehavior(selfId, "金腰带换100盟主印")
                self:DispatchTips(selfId, 1)
                return
            end
        end
    end
    self:DispatchTips(selfId, 0)
    return
end

function ejingji_2:DispatchTips(selfId, bOk)
    if bOk == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("兑换失败，请检查物品是否足够兑换。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    elseif bOk == -1 then
        self:BeginEvent(self.script_id)
        self:AddText("金钱不足")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    elseif bOk == -2 then
        self:BeginEvent(self.script_id)
        self:AddText("你的背包没有空间了。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    else
        self:BeginEvent(self.script_id)
        self:AddText("兑换成功。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    end
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
end

return ejingji_2
