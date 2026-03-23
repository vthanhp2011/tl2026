local class = require "class"
local define = require "define"
local script_base = require "script_base"
local city0_building4 = class("city0_building4", script_base)
city0_building4.script_id = 805011
city0_building4.g_BuildingID5 = 4
city0_building4.g_ItemInfo = {
    {
        30900057, 30900061, 20109101, 20501004, 20502008, 20502004, 20800000,
        20800002, 20800004, 20800006, 20800008, 20800010
    }, {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {430, 110, 230, 156, 156, 156, 68, 68, 68, 68, 68, 68, 68}
}

function city0_building4:OnDefaultEvent(selfId, targetId)
    local guildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    local strText
    if (guildid ~= cityguildid) then
        self:BeginEvent(self.script_id)
        strText = "    非我帮众，一切精良装备恕不外卖。"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    self:BeginEvent(self.script_id)
    strText ="    我是百宝阁的大掌柜，有何指教？有帮贡有关的事，找我周无忌肯定没错。#r帮会的等级越高，帮会的折扣越大。"
    self:AddText(strText)
    self:AddNumText("帮贡商店", 7, 7)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function city0_building4:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:CityBuildingChange(selfId, self.g_BuildingID5, 0)
    elseif index == 2 then
        self:CityBuildingChange(selfId, self.g_BuildingID5, 1)
    elseif index == 3 then
        self:CityBuildingChange(selfId, self.g_BuildingID5, 2)
    elseif index == 4 then
        self:CityBuildingChange(selfId, self.g_BuildingID5, 3)
    elseif index == 5 then
        self:CityBuildingChange(selfId, self.g_BuildingID5, 4)
    elseif index == 6 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_FangJuFang}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 7 then
        local DataStr_1, DataStr_2, DataStr_3, DataStr_4 = "", "", "", ""
        for i = 1,#(self.g_ItemInfo[1]) do
            DataStr_1 = DataStr_1 .. self.g_ItemInfo[1][i] .. ","
            DataStr_2 = DataStr_2 .. self.g_ItemInfo[2][i] .. ","
            DataStr_3 = DataStr_3 .. self.g_ItemInfo[3][i] .. ","
            DataStr_4 = DataStr_4 .. self.g_ItemInfo[4][i] .. ","
        end
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddStr(DataStr_1)
        self:UICommand_AddStr(DataStr_2)
        self:UICommand_AddStr(DataStr_3)
        self:UICommand_AddStr(DataStr_4)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 20201124)
    elseif index == 9 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function city0_building4:nMsg(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function city0_building4:BuyBangGongShopItem(selfId, nIndex)
    if self.g_ItemInfo[1][nIndex] == nil then return end
    local guildLevel = self:GetGuildLevel(selfId)
    local nHaveBangGong = self:CityGetAttr(selfId, 6)
    local nPrize = self.g_ItemInfo[4][nIndex]
    if nHaveBangGong < nPrize then
        self:nMsg(selfId, "帮贡不足" .. nPrize .. "点，购买失败。")
        return
    end
    if self:LuaFnGetHumanBag(selfId, {self.g_ItemInfo[1][nIndex]}, {1}) == 0 then
        self:nMsg(selfId, "背包空间不足。")
        return
    end
    ret = self:CityChangeAttr(selfId, 6, -nPrize)
    if not ret or ret ~= 1 then return end
    self:TryRecieveItem(selfId, self.g_ItemInfo[1][nIndex], 1)
    self:nMsg(selfId, self:format("成功购买%s",  self:GetItemName(self.g_ItemInfo[1][nIndex])))
end

return city0_building4
