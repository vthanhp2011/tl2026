local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_749 = class("std_talent_749", base)

function std_talent_749:get_talent_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_749:refix_impact(talent, level, imp, sender, reciver)
	if imp:get_skill_id() == 382 then
		if imp:get_logic_id() == 4 then
			local max_hp = sender:get_max_hp()
			local hp = sender:get_hp()
			if hp <= max_hp * 0.1 then
				local value = self:get_talent_value(talent, level)
				if value > 0 then
					local logic = impactenginer:get_logic(imp)
					if logic then
						local mp_modify = logic:get_mp_modify(imp)
						value = value * mp_modify / 100
						logic:set_mp_modify(imp,value + mp_modify)
					end
				end
			end
		end
	end
end

return std_talent_749