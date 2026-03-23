local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.impact_logic.base"
local std_impact_525 = class("std_impact_525", base)
local DI_DamagesByValue_T = require "scene.skill.impact_logic.std_impact_003"
local DAMAGE_TYPE_RATE = DI_DamagesByValue_T.enum_DAMAGE_TYPE_RATE

function std_impact_525:is_over_timed()
    return true
end

function std_impact_525:is_intervaled()
    return false
end

function std_impact_525:get_need_skill(imp)
    return imp.params["指定技能"] or -1
end

function std_impact_525:get_increase_target_status_probability()
    return imp.params["增加目标状态概率"] or 0
end

function std_impact_525:refix_skill(imp, obj, skill_info)
    if skill_info:get_skill_id() == self:get_need_skill(imp) then
		local value = self:get_increase_target_status_probability()
		if value > 0 then
			local give_target = skill_info:get_give_target_impact()
			give_target.p = give_target.p + value
		end
    end
end

return std_impact_525