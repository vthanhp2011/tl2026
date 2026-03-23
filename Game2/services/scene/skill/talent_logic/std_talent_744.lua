local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_744 = class("std_talent_744", base)
-- local DI_DamagesByValue_T = require "scene.skill.impact_logic.std_impact_003"
-- local DAMAGE_TYPE_POINT = DI_DamagesByValue_T.enum_DAMAGE_TYPE_POINT

function std_talent_744:is_specific_skill(skill_id)
    return skill_id == 378
end

function std_talent_744:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_744:on_damage_target(talent, level, id, sender, reciver, damages, skill_id)
    if self:is_specific_skill(skill_id) then
		local value = self:get_refix_value(talent, level)
		if value > 0 then
			reciver_mp = reciver:get_max_mp()
			value = value * reciver_mp / 100
			local dmg_mp = reciver:mana_increment(value, sender)
			if dmg_mp and dmg_mp > 0 then
				sender:mana_increment(dmg_mp, sender)
			end
		end
	end
end

return std_talent_744