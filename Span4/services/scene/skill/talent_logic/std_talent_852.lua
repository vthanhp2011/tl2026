local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_852 = class("std_talent_852", base)

function std_talent_852:is_specific_skill(skill_id)
    return skill_id == 541
end

function std_talent_852:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_852:on_damage_target(talent, level, id, sender, reciver, damages, skill_id)
    if self:is_specific_skill(skill_id) then
		if imp and imp:get_logic_id() == 70 then
			local value = self:get_refix_value(talent, level)
			if value > 0 then
				local logic = impactenginer:get_logic(imp)
				if logic then
					logic:set_critical_absorb_ratio_boost(imp,value)
				end
			end
		end
	end
end

return std_talent_852