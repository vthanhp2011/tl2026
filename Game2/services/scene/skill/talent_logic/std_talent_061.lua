local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local DI_DamagesByValue_T = require "scene.skill.impact_logic.std_impact_003"
local base = require "scene.skill.talent_logic.base"
local std_talent_061 = class("std_talent_061", base)

function std_talent_061:is_specific_impact(impact_id)
    return impact_id== 115
end

function std_talent_061:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_061:refix_impact(talent, level, imp)
    if self:is_specific_impact(imp:get_impact_id()) then
        local percent = self:get_refix_value(talent, level)
        local logic = impactenginer:get_logic(imp)
        if imp:get_logic_id() == 11 then
            do
                local value = logic:get_value_of_refix_attrib_att_physics(imp)
                value = math.ceil(value * (100 + percent)/ 100)
                logic:set_value_of_refix_attrib_att_physics(imp, value)
            end
            do
                local value = logic:get_value_of_refix_attrib_def_physics(imp)
                value = math.ceil(value * (100 + percent)/ 100)
                logic:set_value_of_refix_attrib_def_physics(imp, value)
            end
        end
    end
end

return std_talent_061