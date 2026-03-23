local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_808 = class("std_talent_808", base)

function std_talent_808:is_specific_skill(skill_id)
    return skill_id == 463
end

function std_talent_808:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end
function std_talent_808:on_critical_hit_target(talent, level, sender, reciver, skill_id)
	if self:is_specific_skill(skill_id) then
		if math.random(100) <= self:get_refix_value(talent, level) then
			sender:impact_empty_continuance_elapsed(50052)
		end
	end
end


return std_talent_808