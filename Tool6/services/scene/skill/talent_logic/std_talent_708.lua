local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_708 = class("std_talent_708", base)


function std_talent_708:is_specific_skill(skill_id)
    return skill_id == 325
end

function std_talent_708:get_send_impact()
    local impact_id = 45917
    return impact_id
end

function std_talent_708:get_refix_p(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_708:on_critical_hit_target(talent, level, sender, reciver, skill_id)
    if self:is_specific_skill(skill_id) then
		local imp = reciver:impact_get_first_impact_of_specific_impact_id(35)
		if imp and imp:get_logic_id() == 15 then
			local p = self:get_refix_p(talent, level)
			local n = math.random(100)
			if n <= p then
				imp:set_continuance(30000)
			end
		end
	end
end

return std_talent_708