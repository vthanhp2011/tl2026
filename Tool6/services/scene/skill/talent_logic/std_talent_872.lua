local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_872 = class("std_talent_872", base)
local impacts = {
	51801,
	51802,
	51803,
	51804,
	51805,
}

function std_talent_872:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_872:refix_impact(talent, level, imp, sender, reciver)
	if imp:get_skill_id() == 780 then
		if imp:get_logic_id() == 304 then
			local impact = impacts[level] or -1
			if impact ~= -1 then
				local logic = impactenginer:get_logic(imp)
				if logic then
					logic:set_linked_buff(imp, impact)
				end
				impactenginer:send_impact_to_unit(sender, impact, sender, 0, false, 0)
			end
		end
	end
end

return std_talent_872