local class = require "class"
local define = require "define"
local script_base = require "script_base"
local obaixihu_mozhichou = class("obaixihu_mozhichou", script_base)
obaixihu_mozhichou.g_eventList = { 888808 }
function obaixihu_mozhichou:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{SWXT_221213_1}")
    if self:GetMissionData(selfId, 854) == 1 then
        self:AddNumText("#{SWXT_221213_241}", 6, 1)
    else
        self:AddNumText("#{SWXT_221213_2}", 6, 1)
    end
    self:AddNumText("#{SWXT_221213_3}", 11, 2)
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function obaixihu_mozhichou:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:DispatchShengWangInfo(selfId, 1)
        return
    end
    if index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SWXT_221213_221}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function obaixihu_mozhichou:JoinCamp(selfId, targetId, camp)
    self:SetMissionData(selfId, 854, camp)
    if camp == 1 then
        --self:notify_tips(selfId, "加入了铸法派系-无忌")
    elseif camp == 2 then
        --self:notify_tips(selfId, "加入了铸法派系-守心")
    elseif camp == 3 then
        --self:notify_tips(selfId, "加入了铸法派系-破阵")
    end
    self:DispatchShengWangInfo(selfId, camp)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
end

local LingWuGoods = {
    [38002818] = { price = 1500, limit = 10 },
    [38002817] = { price = 450, limit = 10  },
    [38002812] = { price = 1200, limit = 1  },

    [38002800] = { price = 300, limit = 15 },
    [38002799] = { price = 300, limit = 15 },
    [38002802] = { price = 300, limit = 15 },
    [38002801] = { price = 300, limit = 15 },
    [38002804] = { price = 300, limit = 15 },
    [38002803] = { price = 300, limit = 15 },

    [20600003] = { price = 3000, limit = 15 },
    [20600002] = { price = 1200, limit = 15 },
}
function obaixihu_mozhichou:YBbuyitem(selfId, targetId, Index, ItemId)
    local Goods = LingWuGoods[ItemId]
    if Goods == nil then
        self:notify_tips(selfId, "配置不正确")
        return
    end
    local yuanbao = self:GetYuanBao(selfId)
    if yuanbao < Goods.price * 2 then
        self:notify_tips(selfId, "元宝不足")
        return
    end
    local buy_count = self:LuaFnGetWanShiGeShopCountByID(selfId, ItemId)
    if buy_count >= Goods.limit then
        self:notify_tips(selfId, "购买数量已达上限")
        return
    end
    self:BeginAddItem()
    self:AddItem(ItemId, 1)
    local ret = self:EndAddItem(selfId)
    if ret then
        self:AddItemListToHuman(selfId)
        self:LuaFnCostYuanBao(selfId, Goods.price * 2)
        self:notify_tips(selfId, string.format("您成功兑换了一个%s", self:GetItemName(ItemId)))
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
        self:OnWanShiGeExchange(selfId, Index, ItemId)
    else
        self:notify_tips(selfId, "背包空间不足")
        return
    end
end

return obaixihu_mozhichou