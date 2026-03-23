local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_069 = class("std_talent_069", base)

function std_talent_069:is_add_mp_rate_skill(skill_id)
    return skill_id == 376
end

function std_talent_069:get_extra_add_mp_rate_value(talent, level)
    local params = talent.params[level]
    return params[1]
end

function std_talent_069:refix_impact(talent, level, imp)
    local skill_id = imp:get_skill_id()
    if self:is_add_mp_rate_skill(skill_id) then
        local value = self:get_extra_add_mp_rate_value(talent, level)
        local logic = impactenginer:get_logic(imp)
        if logic then
            logic:set_refix_mp_max(imp, value)
        end
    end
end

return std_talent_069