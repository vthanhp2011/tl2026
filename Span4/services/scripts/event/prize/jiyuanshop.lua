--机缘商店
--普通
local class = require "class"
local script_base = require "script_base"
local jiyuanshop = class("jiyuanshop", script_base)
local shop_items = 
{ 
    [38002675] = {2400,100},
    [20500003] = {1200,30},

}
function jiyuanshop:buyitem(selfId, ...)
    print("jiyuanshop:buyitem ... =", ...)
    local targetId, shop_item = ...
    local price = shop_items[shop_item][1]
    local nCount = shop_items[shop_item][2]
    local yuanbao = self:GetYuanBao(selfId)
    if yuanbao < price then
        self:notify_tips(selfId, "元宝不足")
        return
    end
    local buy_count = self:LuaFnGetJiYuanShopCountByID(selfId, shop_item)
    if buy_count >= nCount then
        self:notify_tips(selfId, "购买数量已达上限")
        return
    end
    self:LuaFnCostYuanBao(selfId, price)
    self:TryRecieveItem(selfId, shop_item)
    self:notify_tips(selfId, "购买成功")
    self:OnJiYuanShopBuy(selfId, shop_item, targetId)
end
return jiyuanshop