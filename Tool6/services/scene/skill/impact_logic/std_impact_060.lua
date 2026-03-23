local class = require "class"
local define = require "define"
local impactenginer  = require "impactenginer":getinstance()
local base = require "scene.skill.impact_logic.base"
local std_impact_060 = class("std_impact_060", base)
local DI_DamagesByValue_T = require "scene.skill.impact_logic.std_impact_003"
local DAMAGE_TYPE_RATE = DI_DamagesByValue_T.enum_DAMAGE_TYPE_RATE

function std_impact_060:is_over_timed()
    return true
end

function std_impact_060:is_intervaled()
    return false
end

function std_impact_060:get_refix_rage_regenerate(imp, obj)
    local value = imp.params["怒气增长修正"]
    if value ~= define.INVAILD_ID then
        return ( 100 + value ) / 100
    end
end

function std_impact_060:get_odds(imp)
    return imp.params["激发几率"]
end

function std_impact_060:add_odds(imp, odd)
    imp.params["激发几率"] = (imp.params["激发几率"] or 0) + odd
end

function std_impact_060:get_give_target(imp)
    return imp.params["给目标的效果"]
end

function std_impact_060:get_give_self(imp)
    return imp.params["给自己的效果"]
end

function std_impact_060:set_add_buff(imp,value)
    imp.params["给自己的效果"] = value
end

function std_impact_060:get_add_buff(imp)
    return imp.params["给自己的效果"] or -1
end

function std_impact_060:get_talent_752_value(imp)
    return imp.params["每万蓝增加伤害加成"] or 0
end

function std_impact_060:set_talent_752_value(imp,value)
    imp.params["每万蓝增加伤害加成"] = value
end

function std_impact_060:on_damage_target(imp, obj, tar, damages, skill_id, impx)
	if not skill_id or skill_id == define.INVAILD_ID then
		return
	end
	local dmg_rate = self:get_talent_752_value(imp)
	if dmg_rate > 0 then
		if damages and damages.damage_rate then
			if tar:get_obj_type() == "human" then
				local me_mp = obj:get_mp()
				local tar_mp = tar:get_mp()
				me_mp = me_mp - tar_mp
				me_mp = me_mp // 10000
				dmg_rate = dmg_rate * me_mp
				if dmg_rate > 0 then
					if dmg_rate > 10 then
						dmg_rate = 10
					end
					for _,key in ipairs(DAMAGE_TYPE_RATE) do
						damages[key] = damages[key] + dmg_rate
					end
				end
			end
		end
	end
    local odd = self:get_odds(imp)
    local num = math.random(100)
    -- print("std_impact_060:on_damage_target num =", num, ";odd =", odd)
    if num > odd then
        return
    end
	local imp_skill = impx and impx:get_skill_id() or -1
    local give_target = self:get_give_target(imp)
    -- print("std_impact_060:on_damage_target give_target =", give_target)
    if give_target ~= define.INVAILD_ID then
        impactenginer:send_impact_to_unit(tar, give_target, obj, 0, imp:is_critical_hit(), self:refix_power_by_rate(imp),imp_skill)
    end
	local buffid = self:get_add_buff(imp)
	if buffid ~= -1 then
		impactenginer:send_impact_to_unit(tar, buffid, obj, 0, false, 0)
	end
    local give_self = self:get_give_self(imp)
    if give_self ~= define.INVAILD_ID then
        impactenginer:send_impact_to_unit(obj, give_self, obj, 0, imp:is_critical_hit(), self:refix_power_by_rate(imp),imp_skill)
    end
end

return std_impact_060