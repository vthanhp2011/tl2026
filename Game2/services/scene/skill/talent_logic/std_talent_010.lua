local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_010 = class("std_talent_010", base)

function std_talent_010:is_specific_skill(skill_id)
    return skill_id == 347
end

function std_talent_010:get_damage_add_percent(talent, level, segment)
    local params = talent.params[level]
    return params[segment] or 0
end

function std_talent_010:on_damage_target(talent, level, id, _, target, damages, skill_id)
    if self:is_specific_skill(skill_id) then
        local segment = 3
        local percent = self:get_damage_add_percent(talent, level, segment) - 100
		if percent > 0 then
			if damages and damages.damage_rate then
				for _,j in ipairs(DAMAGE_TYPE_RATE) do
					damages[j] = damages[j] + percent
				end
			end
		end
        -- damages.hp_damage = 0
        -- local damage_impact_logic = require "scene.skill.impact_logic.std_impact_003"
        -- for i = damage_impact_logic.enum_DAMAGE_TYPE.IDX_DAMAGE_PHY, damage_impact_logic.enum_DAMAGE_TYPE.IDX_DAMAGE_DIRECHT do
            -- damages[i] = math.floor((damages[i] or 0) * percent / 100)
            -- damages.hp_damage = (damages.hp_damage or 0) + damages[i]
        -- end
    end
end

return std_talent_010