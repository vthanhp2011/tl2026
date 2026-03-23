local class = require "class"
local utils = require "utils"
local gbk = require "gbk"
local skynet = require "skynet"
local define = require "define"
local script_base = require "script_base"
local bet = class("bet", script_base)
local Texts = {
    [38008157] = { name = "天外代币1", options = { {id = 101, desc = "合成1次"}, {id = 102, desc = "合成10次"}, {id = 104, desc = "兑换游戏道具"} } },
    [38008158] = { name = "天外代币2", options = { {id = 201, desc = "分解1次"}, {id = 202, desc = "分解10次"}, {id = 104, desc = "兑换游戏道具"} }},
}
local ExchangeConfigs = {
    { id = 10001, desc = "6888个兑换重楼自选礼盒1个", need_count = 6888, awards = { item_id = 38002943, item_num = 1}, need_space_count = 1},
    { id = 10002, desc = "100个兑换武道玄元丹100个", need_count = 100, awards = { item_id = 38002397, item_num = 100}, need_space_count = 1},
    { id = 10003, desc = "688个兑换神魂檀箱366个", need_count = 688, awards = { item_id = 38002499, item_num = 366}, need_space_count = 3},
}
function bet:OnBet(selfId, main,action,score,append)
    local guid = self:LuaFnGetGUID(selfId)
    local area = utils.get_node_name()
    local name = self:LuaFnGetName(selfId)
    --skynet.send(".mqttor", "lua", "client_request", area, guid, main, action, score, append, name)
end

function bet:OnDefaultEvent(selfId, bag_index)
    local itemTblIndex = self:LuaFnGetItemTableIndexByIndex(selfId,bag_index)
    local Config = Texts[itemTblIndex]
    if Config == nil then
        self:notify_tips(selfId, "配置异常")
        return
    end
    self:BeginEvent(self.script_id)
    self:AddText(string.format("#Y%s", Config.name))
    for _, op in ipairs(Config.options) do
        self:AddNumText(op.desc, 0, op.id)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, -1)
    return 0
end

function bet:OnEventRequest(selfId, targetId, arg, index)
    if index == 101 then
        self:DaiBiOneToDaiBiTwo(selfId, 1)
        return
    end
    if index == 102 then
        self:DaiBiOneToDaiBiTwo(selfId, 10)
        return
    end
    if index == 103 then
        self:ShowUseMethod(selfId)
        return
    end
    if index == 104 then
        self:ShowExchangeList(selfId)
        return
    end
    if index == 201 then
        self:DaiBiTwoToDaiBiOne(selfId, 1)
        return
    end
    if index == 202 then
        self:DaiBiTwoToDaiBiOne(selfId, 10)
        return
    end
    if index >= 10001 then
        self:ExchangeItems(selfId, index)
        return
    end
end

function bet:GetExchangeConfig(index)
    for _, c in ipairs(ExchangeConfigs) do
        if c.id == index then
            return c
        end
    end
end

function bet:ExchangeItems(selfId, index)
    local config = self:GetExchangeConfig(index)
    if config == nil then
        self:BeginEvent(self.script_id)
        self:AddText("配置不存在")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    local space_count = self:LuaFnGetPropertyBagSpace(selfId)
    if space_count < config.need_space_count then
        self:BeginEvent(self.script_id)
        self:AddText(string.format("背包空间不足,需要%d个,拥有%d个", config.need_space_count, space_count))
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    local item_count = self:LuaFnGetAvailableItemCount(selfId, 38008157)
    if item_count < config.need_count then
        self:BeginEvent(self.script_id)
        self:AddText(string.format("一级天外代币不足,需要%d个,拥有%d个", config.need_count, item_count))
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    local r = self:LuaFnDelAvailableItem(selfId, 38008157, config.need_count)
    if not r then
        self:notify_tips(selfId, "扣除失败,请联系客服处理")
        return
    end
    self:BeginAddItem()
    self:AddItem(config.awards.item_id, config.awards.item_num)
    if not self:EndAddItem(selfId) then
        self:notify_tips(selfId,"背包空间不足。")
        return
    end
    self:AddItemListToHuman(selfId)
    self:notify_tips(selfId, "代币兑换成功！")
end

function bet:ShowExchangeList(selfId)
    self:BeginEvent(self.script_id)
    self:AddText("游戏道具兑换:")
    for _, op in ipairs(ExchangeConfigs) do
        self:AddNumText(op.desc, 0, op.id)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, -1)
end

function bet:DaiBiOneToDaiBiTwo(selfId, count)
    count = count or 1
    local cost_count = count * 100
    local item_count = self:LuaFnGetAvailableItemCount(selfId, 38008157)
    if item_count < cost_count then 
        self:notify_tips(selfId, string.format("代币1数量不足, 当前%d个, 需要%d个", item_count, cost_count))
        return
    end
    self:BeginAddItem()
    self:AddItem(38008158, count)
    if not self:EndAddItem(selfId) then
        self:notify_tips(selfId,"背包空间不足。")
        return
    end
    local r = self:LuaFnDelAvailableItem(selfId, 38008157, cost_count)
    if not r then
        self:notify_tips(selfId, "扣除失败,请联系客服处理")
        return
    end
    self:AddItemListToHuman(selfId)
    self:notify_tips(selfId, "代币兑换成功！")
end

function bet:DaiBiTwoToDaiBiOne(selfId, count)
    count = count or 1
    local cost_count = count
    local item_count = self:LuaFnGetAvailableItemCount(selfId, 38008158)
    if item_count < cost_count then
        self:notify_tips(selfId, string.format("代币2数量不足, 当前%d个, 需要%d个", item_count, cost_count))
        return
    end
    self:BeginAddItem()
    self:AddItem(38008157, count * 100)
    if not self:EndAddItem(selfId) then
        self:notify_tips(selfId,"背包空间不足。")
        return
    end
    local r = self:LuaFnDelAvailableItem(selfId, 38008158, cost_count)
    if not r then
        self:notify_tips(selfId, "扣除失败,请联系客服处理")
        return
    end
    self:AddItemListToHuman(selfId)
    self:notify_tips(selfId, "代币兑换成功！")
end

function bet:ShowUseMethod(selfId)

end


function bet:IsSkillLikeScript(selfId) return 0 end

return bet