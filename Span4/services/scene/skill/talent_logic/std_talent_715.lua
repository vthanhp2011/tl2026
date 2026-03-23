local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_715 = class("std_talent_715", base)
-- local impacts = {
    -- 51821, 51822, 51823, 51824, 51825
-- }

function std_talent_715:is_specific_skill(skill_id)
    return skill_id == 323
end

function std_talent_715:get_talent_value(talent,level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_715:refix_impact(talent, level, imp, sender, reciver)
    local skill_id = imp:get_skill_id()
    if self:is_specific_skill(skill_id) then
		-- if imp:get_logic_id() == 14 then
			imp:set_is_out()
			local cool_down_id = skillenginer:get_skill_template(323,"cool_down_id")
			if cool_down_id then
				sender:set_cool_down(cool_down_id, 100000)
				local value = self:get_talent_value(talent,level)
				if value > 0 then
					value = value * sender:get_max_hp() / 100
					sender:health_increment(recover_hp,sender)
				end
			end
		-- end
	end
end

return std_talent_715