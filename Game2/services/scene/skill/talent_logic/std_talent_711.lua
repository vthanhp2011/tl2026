local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_711 = class("std_talent_711", base)

function std_talent_711:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1]
end

function std_talent_711:refix_skill_info(talent, level, skill_info, human)
	if skill_info.id == 313 then
		if human:impact_have_impact_of_specific_impact_id(581) then
			local value = self:get_refix_value(talent, level)
			if math.random(100) <= value then
				local cool_down_id = skillenginer:get_skill_template(313,"cool_down_id")
				if cool_down_id then
					local cool_down_time = human:get_cool_down_by_cool_down_id(cool_down_id)
					human:update_cool_down_by_cool_down_id(cool_down_id, cool_down_time)
				end
			end
		end
	end
end

return std_talent_711