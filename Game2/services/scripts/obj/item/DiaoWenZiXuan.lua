local class = require "class"
local define = require "define"
local script_base = require "script_base"
local DiaoWenZiXuan = class("DiaoWenZiXuan", script_base)
DiaoWenZiXuan.script_id = 100020
local diaowen_types = {
    [1] = {
        {name = "武器冰攻雕纹图样", index = 101, award = 30120014},
        {name = "武器火攻雕纹图样", index = 102, award = 30120015},
        {name = "武器玄攻雕纹图样", index = 103, award = 30120016},
        {name = "武器毒攻雕纹图样", index = 104, award = 30120017},
        {name = "护腕冰攻雕纹图样", index = 105, award = 30120035},
        {name = "护腕火攻雕纹图样", index = 106, award = 30120036},
        {name = "护腕玄攻雕纹图样", index = 107, award = 30120037},
        {name = "护腕毒攻雕纹图样", index = 108, award = 30120038},
        {name = "暗器冰攻雕纹图样", index = 113, award = 30120066},
        {name = "暗器火攻雕纹图样", index = 114, award = 30120067},
        {name = "暗器玄攻雕纹图样", index = 115, award = 30120068},
        {name = "暗器毒攻雕纹图样", index = 116, award = 30120069},
    },
    [2] = {
        {name = "鞋子体力雕纹图样", index = 201, award = 30120008},
        {name = "腰带体力雕纹图样", index = 202, award = 30120010},
        {name = "衣服体力雕纹图样", index = 203, award = 30120028},
        {name = "护肩体力雕纹图样", index = 204, award = 30120042},
        {name = "武魂体力雕纹图样", index = 205, award = 30120050},
        {name = "帽子体力雕纹图样", index = 206, award = 30120145},
        {name = "手套体力雕纹图样", index = 207, award = 30120041},
    }
}
function DiaoWenZiXuan:OnDefaultEvent(selfId)
    self:BeginEvent(self.script_id)
    self:AddText("#Y雕纹自选")
    self:AddText("  可以从下面几个雕纹类型中选一个")
    self:AddNumText("属性雕纹", 0, 1)
    self:AddNumText("体力雕纹", 0, 2)
    self:EndEvent()
    self:DispatchEventList(selfId, -1)
end

function DiaoWenZiXuan:IsSkillLikeScript(selfId)
    return 0
end

function DiaoWenZiXuan:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        local type_of_diaowens = diaowen_types[1]
        self:BeginEvent(self.script_id)
        self:AddText("#Y属性雕纹自选")
        self:AddText("  可以从下面几个属性雕纹中选一个")
        for _, d in ipairs(type_of_diaowens) do
            self:AddNumText(d.name, 0, d.index)
        end
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    if index == 2 then
        local type_of_diaowens = diaowen_types[2]
        self:BeginEvent(self.script_id)
        self:AddText("#Y体力雕纹自选")
        self:AddText("  可以从下面几个体力雕纹中选一个")
        for _, d in ipairs(type_of_diaowens) do
            self:AddNumText(d.name, 0, d.index)
        end
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
    if nBagsPos < 1 then
        self:BeginEvent(self.script_id)
        self:AddText("至少需要一个道具栏空间")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    local item_count = self:LuaFnGetAvailableItemCount(selfId, 38000960)
    if item_count < 1 then
        self:BeginEvent(self.script_id)
        self:AddText("背包没有雕纹自选礼盒")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    local config = self:GetSelectDiaowen(index)
    if config == nil then
        self:BeginEvent(self.script_id)
        self:AddText("配置异常")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    self:LuaFnDelAvailableItem(selfId, 38000960, 1)
    self:TryRecieveItem(selfId, config.award, true)
    self:BeginEvent(self.script_id)
    self:AddText(string.format("领取%s成功", config.name))
    self:EndEvent()
    self:DispatchEventList(selfId, -1)
end

function DiaoWenZiXuan:GetSelectDiaowen(index)
    for _, dt in pairs(diaowen_types) do
        for _, d in ipairs(dt) do
            if d.index == index then
                return d
            end
        end
    end
end


return DiaoWenZiXuan
