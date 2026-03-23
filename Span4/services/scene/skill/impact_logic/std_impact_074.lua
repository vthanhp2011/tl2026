local class = require "class"
local base = require "scene.skill.impact_logic.base"
local std_impact_074 = class("std_impact_074", base)

function std_impact_074:is_over_timed()
    return false
end

function std_impact_074:is_intervaled()
    return false
end

function std_impact_074:on_active(imp, obj)
    local caster_id = imp:get_caster_obj_id()
    if obj:get_obj_type() == "monster" and obj:is_alive() then
        obj:get_ai():add_primary_enemy(caster_id)
    end
end

return std_impact_074