local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_076 = class("std_talent_076", base)
local DI_DamagesByValue_T = require "scene.skill.impact_logic.std_impact_003"
local DAMAGE_TYPE_BACK = DI_DamagesByValue_T.enum_DAMAGE_TYPE_BACK

function std_talent_076:is_liangyi_jian_skill(skill_id)
    return skill_id == 373
end

function std_talent_076:get_absorb_percent(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_076:on_damage_target(talent, level, id, human, target, damages, skill_id)
    if self:is_liangyi_jian_skill(skill_id) then
		if damages and damages.damage_rate then
			local percent = self:get_absorb_percent(talent, level)
			local key = DAMAGE_TYPE_BACK[4]
			table.insert(damages[key],{rate = percent})
			key = DAMAGE_TYPE_BACK[5]
			table.insert(damages[key],{rate = percent})
		end
        -- local value = math.ceil(math.abs(damages.hp_damage) * percent / 100)
        -- human:health_increment(value, human, false)
        -- human:mana_increment(value, human, false)
    end
end

return std_talent_076