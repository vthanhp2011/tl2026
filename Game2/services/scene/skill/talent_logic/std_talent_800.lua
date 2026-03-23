local class = require "class"
local define = require "define"
-- local impact = require "scene.skill.impact"
-- local combat_core = require "scene.skill.combat_core"
-- local DI_DamagesByValue_T = require "scene.skill.impact_logic.std_impact_003"
local skillenginer = require "skillenginer":getinstance()
-- local eventenginer = require "eventenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_800 = class("std_talent_800", base)
local impacts = {
	51732,
	51733,
}
function std_talent_800:is_specific_impact(data_index)
    return data_index >= 1867 and data_index <= 1878
end

function std_talent_800:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_800:refix_impact(talent, level, imp, sender, reciver)
    if self:is_specific_impact(imp:get_data_index()) then
        if imp:get_logic_id() == 3 then
            local value = self:get_refix_value(talent, level)
			if value > 0 then
				local logic = impactenginer:get_logic(imp)
				if logic then
					local index = logic:get_trigger_index(imp)
					if index == 2 then
						if math.random(100) <= self:get_refix_value(talent, level) then
							local ks_id
							for _,id in ipairs(impacts) do
								if reciver:impact_empty_continuance_elapsed(id) then
									ks_id = id
								end
							end
							if ks_id then
								local radious = 5
								local affect_count = 3
								local position = reciver:get_world_pos()
								local operate = {
									obj = sender,
									x = position.x,
									y = position.y,
									radious = radious,
									count = affect_count,
									target_logic_by_stand = 1
								}
								local nearbys = reciver:get_scene():scan(operate)
								for _, nb in ipairs(nearbys) do
									if nb:is_character_obj() then
										if nb:is_alive() and nb ~= reciver then
											if affect_count > 0 then
												impactenginer:send_impact_to_unit(nb, ks_id, sender, 0, false, 0)
												affect_count = affect_count - 1
											else
												break
											end
										end
									end
								end
							
							end
						end
					end
				end
			end
		end
    end
end

return std_talent_800