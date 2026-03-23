local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_332201 = class("item_332201", script_base)
item_332201.script_id = 332201
item_332201.g_DarkBox = 30008010
item_332201.g_MultiDarkKeyMaxUseCount = 99
function item_332201:OnDefaultEvent(selfId, bagIndex)
end

function item_332201:IsSkillLikeScript(selfId)
    return 1
end

function item_332201:CancelImpacts(selfId)
    return 0
end

function item_332201:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    local FreeSpace = self:LuaFnGetPropertyBagSpace(selfId)
    if (FreeSpace < 2) then
        local strNotice = "您的道具栏没有空间，需要整理。"
        self:ShowNotice(selfId, strNotice)
        return 0
    end
    FreeSpace = self:LuaFnGetMaterialBagSpace(selfId)
    if (FreeSpace < 1) then
        local strNotice = "您的材料栏没有空间，需要整理。"
        self:ShowNotice(selfId, strNotice)
        return 0
    end
    local ItemCount = self:LuaFnGetAvailableItemCount(selfId, self.g_DarkBox)
    if ItemCount < 1 then
        local strNotice = "需要" .. "#{_ITEM" .. (self.g_DarkBox) .. "}"
        self:ShowNotice(selfId, strNotice)
        return 0
    end
    return 1
end

function item_332201:OnDeplete(selfId)
    if (self:LuaFnDepletingUsedItem(selfId)) then
        return 1
    end
    return 0
end

function item_332201:GetPos(DropList, RandomID)
    local ListSize = #(DropList)
    for i = 1, ListSize do
        if RandomID == DropList[i][1] then
            return i
        end
    end
    return 0
end

function item_332201:OnActivateOnce(selfId)
    local bagId = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local UseValue = self:GetBagItemParam(selfId, bagId, 8, 2)
    local ValidValue = self.g_MultiDarkKeyMaxUseCount - UseValue
    local ret = self:LuaFnDelAvailableItem(selfId, self.g_DarkBox, 1)
    if not ret then
        return
    end
    if bagId >= 0 then
        local UseValue = self:GetBagItemParam(selfId, bagId, 8, 2)
        if UseValue >= self.g_MultiDarkKeyMaxUseCount then
            return 0
        end
        local CurValue = UseValue + 1
        self:SetBagItemParam(selfId, bagId, 4, 2, self.g_MultiDarkKeyMaxUseCount)
        self:SetBagItemParam(selfId, bagId, 8, 2, CurValue)
        local CheckParam1 = self:GetBagItemParam(selfId, bagId, 4, 2)
        local CheckParam2 = self:GetBagItemParam(selfId, bagId, 8, 2)
        if CheckParam1 ~= self.g_MultiDarkKeyMaxUseCount then
            return 0
        end
        if CheckParam2 ~= CurValue then
            return 0
        end
        self:LuaFnRefreshItemInfo(selfId, bagId)
        if CurValue >= self.g_MultiDarkKeyMaxUseCount then
            local EraseRet = self:EraseItem(selfId, bagId)
            if not EraseRet then
                local strNotice = "需要暗金钥匙"
                self:ShowNotice(selfId, strNotice)
                return 0
            end
        end
    else
        local strNotice = "需要暗金钥匙"
        self:ShowNotice(selfId, strNotice)
        return 0
    end
    local nRemain = self.g_MultiDarkKeyMaxUseCount - UseValue - 1
    if (0 > nRemain) then
        nRemain = 0
    end
    self:LuaFnAuditDarkKeyUsed(selfId, 1, nRemain)
    local RandomBase = self:GetDarkBoxItemDropCount(selfId)
    if (RandomBase > 0) then
        local RandomNum = math.random(0, RandomBase - 1)
        local RandomID, Notice = self:DarkBoxItemDropRandom(selfId, RandomNum)
        if (RandomID > 0) then
            self:BeginAddItem()
            self:AddItem(RandomID, 1)
            local Ret = self:LuaFnEndAddItemIgnoreFatigueState(selfId)
            if Ret > 0 then
                self:LuaFnAddItemListToHumanIgnoreFatigueState(selfId)
                if 1 == Notice then
                    local szItemTransfer = self:GetItemTransfer(selfId, 0)
                    local ItemInfo = "#{_INFOMSG" .. szItemTransfer .. "}"
                    self:ShowRandomSystemNotice(selfId, ItemInfo)
                end
                local strNotice = "成功打开宝箱，恭喜您获得了" .. "#B#{_ITEM" .. (RandomID) .. "}"
                self:ShowNotice(selfId, strNotice)
                self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
            else
                local strNotice = "背包空间不足"
                self:ShowNotice(selfId, strNotice)
            end
            local SubItem = 30008026
            self:BeginAddItem()
            self:AddItem(SubItem, 1)
            Ret = self:LuaFnEndAddItemIgnoreFatigueState(selfId)
            if Ret > 0 then
                self:LuaFnAddItemListToHumanIgnoreFatigueState(selfId)
            else
                local strNotice = "背包空间不足"
                self:ShowNotice(selfId, strNotice)
            end
        end
    end
    return 1
end

function item_332201:OnActivateEachTick(selfId)
    return 1
end

function item_332201:ShowNotice(selfId, strNotice)
    self:BeginEvent(self.script_id)
    self:AddText(strNotice)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function item_332201:ShowRandomSystemNotice(selfId, strItemInfo)
    local strNotice = {
        "#W%s#H看着空空如也的#Y%s#H，怒从心头起挥刀将其砍碎，意外发现宝箱夹层中藏着的#W%s。",
        "#W%s#H双手颤抖的将#Y%s#H缓缓打开，只见一道金光闪过，#W%s#H就静静的躺在箱底。",
        "#W%s#H沐浴更衣，斋戒素食……诵经千遍后，打开了#Y%s#H，箱子里果然有一个#W%s！"
    }

    local strDarkBox = "#{_ITEM30008010}"
    local PlayerName = self:GetName(selfId)
    local PlayerInfoName = "#{_INFOUSR" .. PlayerName .. "}"
    local RandomNotice = math.random(1, 3)
    local notice = gbk.fromutf8(strNotice[RandomNotice])
    PlayerInfoName = gbk.fromutf8(PlayerInfoName)
    local SysStr = string.format(notice, PlayerInfoName, strDarkBox, strItemInfo)
    self:BroadMsgByChatPipe(selfId, SysStr, 4)
end

return item_332201
