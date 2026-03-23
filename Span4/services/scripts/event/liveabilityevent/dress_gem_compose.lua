-- 时装点缀合成
-- 普通
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local packet_def = require "game.packet"
local human_item_logic = require "human_item_logic"
local script_base = require "script_base"
local dress_gem_compose = class("dress_gem_compose", script_base)
local MAT_ITEM_INDEX = 30503137
function dress_gem_compose:Dress_GemCompose(selfId, gem_pos_1, gem_pos_2, gem_pos_3,gem_pos_4, gem_pos_5, mat_index)
    print("dress_gem_compose:Dress_GemCompose =", selfId, gem_pos_1, gem_pos_2, gem_pos_3,gem_pos_4, gem_pos_5, mat_index)
    local gem_1 = self:GetBagItem(selfId, gem_pos_1)
    local gem_2 = self:GetBagItem(selfId, gem_pos_2)
    local gem_3 = self:GetBagItem(selfId, gem_pos_3)
    local gem_4 = self:GetBagItem(selfId, gem_pos_4)
    local gem_5 = self:GetBagItem(selfId, gem_pos_5)
    local gems = {}
    local gems_pos = {}
    if gem_1 then
        table.insert(gems, gem_1)
        table.insert(gems_pos, gem_pos_1)
    else
        assert(gem_pos_1 == define.INVAILD_ID)
    end
    if gem_2 then
        table.insert(gems, gem_2)
        table.insert(gems_pos, gem_pos_2)
    else
        assert(gem_pos_2 == define.INVAILD_ID)
    end
    if gem_3 then
        table.insert(gems, gem_3)
        table.insert(gems_pos, gem_pos_3)
    else
        assert(gem_pos_3 == define.INVAILD_ID)
    end
    if gem_4 then
        table.insert(gems, gem_4)
        table.insert(gems_pos, gem_pos_4)
    else
        assert(gem_pos_4 == define.INVAILD_ID)
    end
    if gem_5 then
        table.insert(gems, gem_5)
        table.insert(gems_pos, gem_pos_5)
    else
        assert(gem_pos_5 == define.INVAILD_ID)
    end
    for i = 1, #gems do
        if i > 1 then
            if gems[i]:get_index() ~= gems[i - 1]:get_index() then
                self:notify_tips(selfId, "#{SZPR_091023_61}")
                return
            end
        end
    end
    if #gems < 2 then
        self:notify_tips(selfId, "放入的时装配饰需要大于2个")
        return
    end
    if gems[1]:get_base_config().quality >= 4 then
        self:notify_tips(selfId, "#{SZPR_091023_63}")
        return
    end
    local mat = self:GetBagItem(selfId, mat_index)
    if mat == nil or mat:get_index() ~= MAT_ITEM_INDEX then
        self:notify_tips(selfId, "#{SZPR_XML_41}")
        return
    end
    local cost_money = 5000
    local HumanMoney = self:GetMoney(selfId) + self:GetMoneyJZ(selfId)
    if HumanMoney < cost_money then
        self:notify_tips(selfId, "金币不足")
        return
    end
    self:LuaFnCostMoneyWithPriority( selfId, cost_money)
    for i = 1, #gems_pos do
        self:LuaFnDecItemLayCount(selfId, gems_pos[i], 1)
    end
    self:LuaFnDecItemLayCount(selfId, mat_index, 1)
    local item_index = gems[1]:get_index()
    item_index = item_index + 100000
    self:TryRecieveItem(selfId, item_index, false, 1)
end

return dress_gem_compose
