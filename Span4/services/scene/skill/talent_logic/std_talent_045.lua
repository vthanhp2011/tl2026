local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_045 = class("std_talent_045", base)
local skill_id = 3293
function std_talent_045:on_active(talent, level, human)
    if not human:have_skill(skill_id) then
        human:add_skill(skill_id)
        human:send_skill_list()
    end
end

function std_talent_045:on_remove(talent, level, human)
    if human:have_skill(skill_id) then
        human:del_skill(skill_id)
    end
end

return std_talent_045