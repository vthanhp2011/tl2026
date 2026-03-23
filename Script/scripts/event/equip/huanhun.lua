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
	
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(huanhun_config.active_cost_materials) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
    if allnum < huanhun_config.active_cost_material_count then
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
    if not self:LuaFnMtl_CostMaterial(selfId, huanhun_config.active_cost_material_count, costtab) then
        self:notify_tips(selfId, "材料扣除失败")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, huanhun_config.active_cost_money)
    self:UnLockWuHunWg(selfId, huanhun_id)
    self:notify_tips(selfId, "幻魂激活成功!")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

function huanhun:skill_effect_on_uint_once(selfId, ...)
    local type, arg1, arg2 = ...
    if type == 2 then
        self:filling_in(selfId, arg1, arg2)
    end
end

function huanhun:filling_in(selfId, arg1, arg2)
	if not selfId or selfId >= 0 then
		return
	end
	selfId = selfId * -1
    local wg = self:GetWuHunWg(selfId)
    local s_huanhun_id = tostring(arg2)
    if not wg[s_huanhun_id] then
        self:notify_tips(selfId, "幻魂未激活")
        return
    end
    self:SetWuHunWgQKIndex(selfId, arg1, arg2)
end
function huanhun:SwitchYY(selfId,wg_flag)
	if wg_flag ~= 0 and wg_flag ~= 1 then
		return
	end
	self:SetWuHunWgVisualFlag(selfId,wg_flag)
end
function huanhun:TakeOut(selfId,qk_flag)
	if qk_flag ~= 0 and qk_flag ~= 1 then
		return
	end
	self:SetWuHunWgQKIndex(selfId, qk_flag, 0)
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
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(cost_materials) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
	
	
    if allnum < cost_materials_count then
        self:notify_tips(selfId, "材料不足")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
    if not self:LuaFnMtl_CostMaterial(selfId, cost_materials_count, costtab) then
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
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(cost_materials) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
    if allnum < cost_materials_count then
        self:notify_tips(selfId, "材料不足")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
    if not self:LuaFnMtl_CostMaterial(selfId, cost_materials_count, costtab) then
        self:notify_tips(selfId, "材料扣除失败")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, cost_money)
    self:WuHunWgLevelUp(selfId, huanhun_id)
    self:notify_tips(selfId, "幻魂进阶成功!")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

return huanhun