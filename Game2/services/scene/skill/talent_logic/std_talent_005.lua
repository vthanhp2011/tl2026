local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_005 = class("std_talent_005", base)
local give_impact_id = 50017
function std_talent_005:is_specific_skill(skill_id)
    return skill_id == 343
end

function std_talent_005:get_give_impact_odd(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_005:on_hit_target(talent, level, sender, reciver, skill_id)
    if self:is_specific_skill(skill_id) then
        local odd = self:get_give_impact_odd(talent, level)
        local num = math.random(100)
        if num <= odd then
            impactenginer:send_impact_to_unit(reciver, give_impact_id, sender, 0, false, 0)
        end
    end
end

return std_talent_005