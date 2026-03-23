local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_379 = class("std_talent_379", base)
function std_talent_379:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

return std_talent_379