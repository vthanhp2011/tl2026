local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_056 = class("std_talent_056", base)
local std_impact_1 = 50031
local std_impact_2 = 50032
local std_impact_3 = 50033
function std_talent_056:on_damages(talent, level, damages, obj_me)
    local max_hp = obj_me:get_max_hp()
    local hp = obj_me:get_hp()
    local rate = math.floor(hp / max_hp * 100)
	local lv3 = 20
	local refix_lv3 = obj_me:have_talent(713)
	if refix_lv3 > lv3 then
		lv3 = refix_lv3
	end
    if rate <= lv3 then
        if obj_me:impact_get_first_impact_of_specific_data_index(std_impact_3) == nil then
            impactenginer:send_impact_to_unit(obj_me, std_impact_3, obj_me, 0, false, 0)
        end
    elseif rate <= 50 then
        if obj_me:impact_get_first_impact_of_specific_data_index(std_impact_2) == nil then
            impactenginer:send_impact_to_unit(obj_me, std_impact_2, obj_me, 0, false, 0)
        end
    elseif rate <= 80 then
        if obj_me:impact_get_first_impact_of_specific_data_index(std_impact_1) == nil then
            impactenginer:send_impact_to_unit(obj_me, std_impact_1, obj_me, 0, false, 0)
        end
    end
end

return std_talent_056