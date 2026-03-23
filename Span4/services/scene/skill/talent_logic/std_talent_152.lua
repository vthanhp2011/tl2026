local class = require "class"
local define = require "define"
local skillenginer = require "skillenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.skill.talent_logic.base"
local std_talent_152 = class("std_talent_152", base)
function std_talent_152:is_specific_impact(impact_id)
    return impact_id == 515 or impact_id == 516 or impact_id == 517 or impact_id == 518
end

function std_talent_152:get_refix_value(talent, level)
    local params = talent.params[level]
    return params[1] or 0
end

function std_talent_152:refix_impact(talent, level, imp)
    if self:is_specific_impact(imp:get_impact_id())  then
        if imp:get_logic_id() == 523 then
            local value = self:get_refix_value(talent, level)
            local logic = impactenginer:get_logic(imp)
            if logic then
                local impact_id = imp:get_impact_id()
                if impact_id == 515 then
                    do
                        local def = logic:get_value_of_refix_def_fire(imp)
                        def = def - value
                        logic:set_value_of_refix_def_fire(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_light(imp)
                        def = def - value
                        logic:set_value_of_refix_def_light(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_poison(imp)
                        def = def - value
                        logic:set_value_of_refix_def_poison(imp, def)
                    end
                elseif impact_id == 516 then
                    do
                        local def = logic:get_value_of_refix_def_cold(imp)
                        def = def - value
                        logic:set_value_of_refix_def_cold(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_light(imp)
                        def = def - value
                        logic:set_value_of_refix_def_light(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_poison(imp)
                        def = def - value
                        logic:set_value_of_refix_def_poison(imp, def)
                    end
                elseif impact_id == 517 then
                    do
                        local def = logic:get_value_of_refix_def_cold(imp)
                        def = def - value
                        logic:set_value_of_refix_def_cold(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_fire(imp)
                        def = def - value
                        logic:set_value_of_refix_def_fire(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_poison(imp)
                        def = def - value
                        logic:set_value_of_refix_def_poison(imp, def)
                    end
                elseif impact_id == 518 then
                    do
                        local def = logic:get_value_of_refix_def_cold(imp)
                        def = def - value
                        logic:set_value_of_refix_def_cold(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_fire(imp)
                        def = def - value
                        logic:set_value_of_refix_def_fire(imp, def)
                    end
                    do
                        local def = logic:get_value_of_refix_def_light(imp)
                        def = def - value
                        logic:set_value_of_refix_def_light(imp, def)
                    end
                end
            end
        end
    end
end

return std_talent_152