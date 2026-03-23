local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_184 = class("std_talent_184", base)
function std_talent_184:is_specific_skill_1(skill_id)
    return skill_id == 521
end

function std_talent_184:is_specific_skill_2(skill_id)
    return skill_id == 525
end

function std_talent_184:get_odd(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_184:on_hit_target(talent, level, sender, reciver, skill_id)
    if self:is_specific_skill_1(skill_id) then
        local odd = self:get_odd(sender)
        local num = math.random(100)
        if num <= odd then
            impactenginer:send_impact_to_unit(sender, 50065, sender, 0, false, 0)
        end
    elseif self:is_specific_skill_2(skill_id) then
        impactenginer:send_impact_to_unit(sender, 50065, sender, 0, false, 0)
    end
end

local odds = { 11, 12, 13, 14, 15}
function std_talent_184:get_odd(sender)
    local talent_level = sender:get_talent_level_by_id(591)
    return odds[talent_level] or 10
end

return std_talent_184