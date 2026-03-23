local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_062 = class("std_talent_062", base)
function std_talent_062:is_specific_skill(skill_id)
    return skill_id == 313
end

function std_talent_062:get_target_skill_id()
    return 335
end

function std_talent_062:get_trigger_percent(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_062:on_critical_hit_target(talent, level, human, obj_tar, skill_id)
    print("0 std_talent_062:on_critical_hit_target")
    if self:is_specific_skill(skill_id) then
        local percent = self:get_trigger_percent(talent, level)
        local n = math.random(100)
        if n <= percent then
            local cool_down_id = skillenginer:get_skill_template(self:get_target_skill_id(),"cool_down_id")
            -- local cool_down_id = template.cool_down_id
            local cool_down_time = human:get_cool_down_by_cool_down_id(cool_down_id)
            print("1 std_talent_062:on_critical_hit_target cool_down_time =", cool_down_time, ";cool_down_id =", cool_down_id)
            human:update_cool_down_by_cool_down_id(cool_down_id, 10000)
            cool_down_time = human:get_cool_down_by_cool_down_id(cool_down_id)
            print("2 std_talent_062:on_critical_hit_target cool_down_time =", cool_down_time, ";cool_down_id =", cool_down_id)
        end
    end
end

return std_talent_062