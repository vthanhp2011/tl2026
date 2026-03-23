--幻魂
--脚本号
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local huanhun = class("huanhun", script_base)

function huanhun:ActiveWg(selfId, ...)
    local huanhun_id = ...
    local huanhun_config = self:GetWuHunWgConfig(huanhun_id)
    if self:LuaFnMtl_GetCostNum(selfId, huanhun_config.active_cost_materials) < huanhun_config.active_cost_material_count then
        self:notify_tips(selfId, "材料不足")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < huanhun_config.active_cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
    local wg = self:GetWuHunWg(selfId)
    local s_huanhun_id = tostring(huanhun_id)
    if wg[s_huanhun_id] then
        self:notify_tips(selfId, "已激活")
        return
    end
    if not self:LuaFnMtl_CostMaterial(selfId, huanhun_config.active_cost_material_count, huanhun_config.active_cost_materials) then
        self:notify_tips(selfId, "材料扣除失败")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, huanhun_config.active_cost_money)
    self:UnLockWuHunWg(selfId, huanhun_id)
    self:notify_tips(selfId, "幻魂激活成功!")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

function huanhun:skill_effect_on_uint_once(selfId, ...)
	if selfId >= 0 then return end
	selfId = math.abs(selfId)
    local type, arg1, arg2 = ...
    if type == 2 then
        self:filling_in(selfId, arg1, arg2)
    end
end

function huanhun:filling_in(selfId, arg1, arg2)
    local wg = self:GetWuHunWg(selfId)
    local s_huanhun_id = tostring(arg2)
    if wg[s_huanhun_id] == nil then
        self:notify_tips(selfId, "幻魂未激活")
        return
    end
    self:SetWuHunWgQKIndex(selfId, arg1, arg2)
end

function huanhun:LevelUpWg(selfId, ...)
    local huanhun_id = ...
    local index = self:GetWuHunWgIndex(selfId, huanhun_id)
    if index == 0 then
        self:notify_tips(selfId, "幻魂未激活")
        return
    end
    local wuhun_wg_level = self:GetWuHunWgLevelConfig()
    wuhun_wg_level = wuhun_wg_level[index]
    assert(wuhun_wg_level, index)
    local cost_money = wuhun_wg_level.cost_money
    if cost_money == define.INVAILD_ID then
        self:notify_tips(selfId, "幻魂已经达到顶级")
        return
    end
    local cost_materials = wuhun_wg_level.cost_materials
    local cost_materials_count = wuhun_wg_level.cost_materials_count
    if self:LuaFnMtl_GetCostNum(selfId, cost_materials) < cost_materials_count then
        self:notify_tips(selfId, "材料不足")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
    if not self:LuaFnMtl_CostMaterial(selfId, cost_materials_count, cost_materials) then
        self:notify_tips(selfId, "材料扣除失败")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, cost_money)
    self:WuHunWgLevelUp(selfId, huanhun_id)
    self:notify_tips(selfId, "幻魂升级成功!")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

function huanhun:GradeUpWg(selfId, ...)
    local huanhun_id = ...
    local index = self:GetWuHunWgIndex(selfId, huanhun_id)
    if index == 0 then
        self:notify_tips(selfId, "幻魂未激活")
        return
    end
    local wuhun_wg_level = self:GetWuHunWgLevelConfig()
    wuhun_wg_level = wuhun_wg_level[index]
    assert(wuhun_wg_level, index)
    local cost_money = wuhun_wg_level.cost_money
    if cost_money == define.INVAILD_ID then
        self:notify_tips(selfId, "幻魂已经达到顶级")
        return
    end
    local cost_materials = wuhun_wg_level.cost_materials
    local cost_materials_count = wuhun_wg_level.cost_materials_count
    if self:LuaFnMtl_GetCostNum(selfId, cost_materials) < cost_materials_count then
        self:notify_tips(selfId, "材料不足")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
    if not self:LuaFnMtl_CostMaterial(selfId, cost_materials_count, cost_materials) then
        self:notify_tips(selfId, "材料扣除失败")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, cost_money)
    self:WuHunWgLevelUp(selfId, huanhun_id)
    self:notify_tips(selfId, "幻魂进阶成功!")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

return huanhun