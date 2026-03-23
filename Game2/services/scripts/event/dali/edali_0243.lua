local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0243 = class("edali_0243", script_base)
edali_0243.script_id = 210243
edali_0243.g_ItemId = {
    {["mp"] = 0, ["Item"] = 10124009, ["mpname"] = "少林派"},
    {["mp"] = 1, ["Item"] = 10124010, ["mpname"] = "明教"},
    {["mp"] = 2, ["Item"] = 10124011, ["mpname"] = "丐帮"},
    {["mp"] = 4, ["Item"] = 10124012, ["mpname"] = "峨嵋派"},
    {["mp"] = 3, ["Item"] = 10124013, ["mpname"] = "武当派"},
    {["mp"] = 5, ["Item"] = 10124014, ["mpname"] = "星宿派"},
    {["mp"] = 7, ["Item"] = 10124015, ["mpname"] = "天山派"},
    {["mp"] = 8, ["Item"] = 10124016, ["mpname"] = "逍遥派"},
    {["mp"] = 6, ["Item"] = 10124017, ["mpname"] = "天龙派"},
    {["mp"] = 9, ["Item"] = 0}
}
edali_0243.g_Stone = {["id"] = 30505122, ["num"] = 20}
edali_0243.g_Stone2 = {["id"] = 30505135, ["num"] = 20}
function edali_0243:OnDefaultEvent(selfId, targetId)
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#Y领取门派高级时装")
        self:AddText("  有一位旅行家曾经惊奇的发现，银皑雪原上的一些怪物身上可能携带有神秘的#Y怪物日记本#W。如果你能帮他找来20本#Y怪物日记本#W，就可以得到他赠予的一件门派高级时装。#r    怎麽样，你打算交换吗？")
        self:AddNumText("兑换", 8, 3)
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
        local nMenpai = self:GetMenPai(selfId)
        if nMenpai < 0 or nMenpai > 8 then
            self:BeginEvent(self.script_id)
            self:AddText("  你还没有加入一个门派，只有九大门派的弟子才能兑换门派高级时装啊。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local HaveAllItem = 1
        if (self:GetItemCount(selfId, self.g_Stone["id"]) +
            self:GetItemCount(selfId, self.g_Stone2["id"])) <
            self.g_Stone["num"] then HaveAllItem = 0 end
        if HaveAllItem == 0 then
            self:BeginEvent(self.script_id)
            self:AddText("  你需要拿20个怪物日记本才能兑换门派高级时装。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local AllItemCanDelete = 1
        local Stone1_Num = self:LuaFnGetAvailableItemCount(selfId, self.g_Stone["id"])
        local Stone2_Num = self:LuaFnGetAvailableItemCount(selfId, self.g_Stone2["id"])
        if Stone1_Num + Stone2_Num < self.g_Stone["num"] then
            AllItemCanDelete = 0
        end
        if AllItemCanDelete == 0 then
            self:BeginEvent(self.script_id)
            self:AddText("    扣除你身上的物品失败，请检测你是否对物品加锁，或者物品处於交易状态。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local bagpos = -1
        if Stone1_Num > 0 then
            bagpos = self:GetBagPosByItemSn(selfId, self.g_Stone["id"])
        elseif Stone1_Num == 0 and Stone2_Num > 0 then
            bagpos = self:GetBagPosByItemSn(selfId, self.g_Stone2["id"])
        end
        local GemItemInfo
        if bagpos ~= -1 then
            GemItemInfo = self:GetBagItemTransfer(selfId, bagpos)
        end
        local nItemId = 0
        local nMenpaiName = ""
        for i = 1, 10 do
            if nMenpai == self.g_ItemId[i]["mp"] then
                nItemId = self.g_ItemId[i]["Item"]
                nMenpaiName = self.g_ItemId[i]["mpname"]
            end
        end
        if nItemId == 0 then return end
        self:BeginAddItem()
        self:AddItem(nItemId, 1)
        local ret = self:EndAddItem(selfId)
        local delret = 1
        if ret then
            local DeleteNum = self:LuaFnGetAvailableItemCount(selfId, self.g_Stone["id"])
            if (DeleteNum >= self.g_Stone["num"]) then
                if not self:LuaFnDelAvailableItem(selfId, self.g_Stone["id"], self.g_Stone["num"]) then
                    delret = 0
                end
            elseif (DeleteNum == 0) then
                if not self:LuaFnDelAvailableItem(selfId, self.g_Stone2["id"], self.g_Stone["num"]) then
                    delret = 0
                end
            else
                if not self:LuaFnDelAvailableItem(selfId, self.g_Stone["id"], DeleteNum) then
                    delret = 0
                end
                DeleteNum = self.g_Stone["num"] - DeleteNum
                if not self:LuaFnDelAvailableItem(selfId, self.g_Stone2["id"], DeleteNum) then
                    delret = 0
                end
            end
            if delret == 1 then
                self:AddItemListToHuman(selfId)
                self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 1000)
                self:BeginEvent(self.script_id)
                self:AddText("您获得了" .. nMenpaiName .. "的高级门派套装一件。")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                local str = ""
                local rand = math.random(3)
                local name = self:GetName(selfId)
                name = gbk.fromutf8(name)
                if rand == 1 then
                    str = string.format( "#P突然！天昏地暗，众人皆不知所措，原来是#{_INFOUSR%s}使用#G20本#{_INFOMSG%s}#P换取到了无出其右羡煞旁人的#G %s高级门派时装#P！", name, GemItemInfo, nMenpaiName)
                elseif rand == 2 then
                    str = string.format("#P哇呀！#{_INFOUSR%s}使用#G20本#{_INFOMSG%s}#P换到了#G %s高级门派时装#P，穿上後真是惊人的耀眼！", name, GemItemInfo, nMenpaiName)
                else
                    str = string.format("#P#{_INFOUSR%s}使用#G20本#{_INFOMSG%s}#P换到了#G %s高级门派时装#P！恭喜！恭喜！再恭喜！", name, GemItemInfo, nMenpaiName)
                end
                self:BroadMsgByChatPipe(selfId, str, 4)
                self:BeginUICommand()
                self:EndUICommand()
                self:DispatchUICommand(selfId, 1000)
                return
            end
        end
        return
    end
    if index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_094}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function edali_0243:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "领取门派高级时装", 6, 1)
    caller:AddNumTextWithTarget(self.script_id, "领取高级门派时装介绍", 0, 2)
end

function edali_0243:CheckAccept(selfId) end

function edali_0243:OnAccept(selfId, targetId) end

function edali_0243:OnAbandon(selfId) end

function edali_0243:CheckSubmit(selfId) end

function edali_0243:OnSubmit(selfId, targetId, selectRadioId) end

function edali_0243:OnEnterZone(selfId, zoneId) end

return edali_0243
