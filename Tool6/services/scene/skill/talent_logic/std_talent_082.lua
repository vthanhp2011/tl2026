local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_074 = class("std_talent_074", base)

function std_talent_074:is_refix_impact_skill(skill_info)
    return skill_info.id == 374
end

function std_talent_074:get_refix_impact_value(talent, level)
    local params = talent.params[level]
    return params[1]
end

function std_talent_074:refix_impact(talent, level, imp)
    if imp:get_impact_id() == 132 then
        local value = self:get_refix_impact_value(talent, level)
        value = -1 * math.abs(value)
        local logic = impactenginer:get_logic(imp)
        if logic and logic.set_refix_speed then
            logic:set_refix_speed(imp, value)
        end
    end
end

return std_talent_074