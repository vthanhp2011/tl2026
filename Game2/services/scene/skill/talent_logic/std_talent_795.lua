local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_795 = class("std_talent_795", base)

function std_talent_795:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_795:refix_impact(talent, level, imp, sender, reciver)
	if imp:get_skill_id() == 445 then
		if imp:get_logic_id() == 11 then
			if math.random(100) <= self:get_refix_value(talent, level) then
				impactenginer:send_impact_to_unit(reciver, 51733, sender, 0, false, 0)
			end
		end
	end
end

return std_talent_795