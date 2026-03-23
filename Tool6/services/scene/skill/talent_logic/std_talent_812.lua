local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_812 = class("std_talent_812", base)

function std_talent_812:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_812:refix_impact(talent, level, imp, sender, reciver)
	if imp:get_skill_id() == 488 then
		if imp:get_logic_id() == 523 then
			if reciver:get_obj_type() == "human" then
				local id = imp:get_data_index()
				local attr = 0
				if id >= 29743 and id <= 29758 then
					attr = sender:get_attrib("att_cold") + sender:get_attrib("att_fire") + sender:get_attrib("att_light")
				elseif id >= 29759 and id <= 29774 then
					attr = sender:get_attrib("att_cold") + sender:get_attrib("att_fire") + sender:get_attrib("att_poison")
				elseif id >= 29775 and id <= 29790 then
					attr = sender:get_attrib("att_cold") + sender:get_attrib("att_light") + sender:get_attrib("att_poison")
				else
					attr = sender:get_attrib("att_light") + sender:get_attrib("att_fire") + sender:get_attrib("att_poison")
				end
				local value = self:get_refix_value(talent, level)
				if value > 0 then
					local logic = impactenginer:get_logic(imp)
					if logic then
						logic:set_interval_mana_cost(imp, -1 * attr * value / 100)
						logic:set_linked_buff(imp, 51820)
					end
				end
			end
		end
	end
end

return std_talent_812