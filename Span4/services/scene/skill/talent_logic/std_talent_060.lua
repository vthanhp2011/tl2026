local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local DI_DamagesByValue_T = require "scene.skill.impact_logic.std_impact_003"
local base = require "scene.skill.talent_logic.base"
local std_talent_060 = class("std_talent_060", base)

function std_talent_060:is_specific_impact(impact_id)
    return impact_id== 109
end

function std_talent_060:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_060:refix_impact(talent, level, imp)
    if self:is_specific_impact(imp:get_impact_id()) then
        local value = self:get_refix_value(talent, level)
        local logic = impactenginer:get_logic(imp)
        if imp:get_logic_id() == DI_DamagesByValue_T then
            local damage_cold = logic:get_damage_cold(imp)
            local cold = math.floor(damage_cold * (value / 100))
            logic:set_damage_cold(damage_cold - cold)
            local damage_fire = logic:get_damage_fire(imp)
            logic:set_damage_fire(damage_fire + cold)
        end
    end
end

return std_talent_060