local class = require "class"
local define = require "define"
local impactenginer  = require "impactenginer":getinstance()
local skillenginer = require "skillenginer":getinstance()
local base = require "scene.skill.impact_logic.base"
local std_impact_124 = class("std_impact_124", base)

function std_impact_124:is_over_timed()
    return true
end

function std_impact_124:is_intervaled()
    return false
end

function std_impact_124:get_affect_radious(imp)
    return imp.params["扫描半径"]
end

function std_impact_124:get_affect_target_count(imp)
    return imp.params["影响目标人数"]
end

function std_impact_124:get_target_select_stand(imp)
    local stand = imp.params["目标选择标记：-1:敌人,0:中立,1:友好,2:友好+队友;"]
    if stand == -1 then
        return 1
    elseif stand == 2 then
        return 0
    end
end

function std_impact_124:get_is_affect_self(imp)
    return imp.params["是否影响自己：0不影响，1影响；"] == 1
end

function std_impact_124:get_impact_stand(imp)
    return imp.params["受到影响的类型：-1:负面,0:中性,1:增益;"]
end

function std_impact_124:get_is_damage_use_combat_rule(imp)
    return imp.params["伤害是否使用战斗计算规则"] == 1
end

function std_impact_124:get_alive_impact(imp, index)
    local key = string.format("存活效果%d", index)
    return imp.params[key] or define.INVAILD_ID
end

function std_impact_124:get_dead_impact(imp, index)
    local key = string.format("死亡效果%d", index)
    return imp.params[key] or define.INVAILD_ID
end

function std_impact_124:get_talent_802_value(imp)
	return imp.params["武道802效果"] or 0
end

function std_impact_124:set_talent_802_value(imp, value)
	imp.params["武道802效果"] = value
end

function std_impact_124:on_fade_out(imp, obj)
    -- print("std_impact_124:on_fade_out")
    local radious = self:get_affect_radious(imp)
    local affect_count = self:get_affect_target_count(imp)
    local target_logic_by_stand = self:get_target_select_stand(imp)
    local is_affect_self = self:get_is_affect_self(imp)
    local position = obj:get_world_pos()
    local operate = {obj = obj, x = position.x, y = position.y, radious = radious,target_logic_by_stand = 1}
    local nearbys = obj:get_scene():scan(operate)
    local caster_obj_id = imp:get_caster_obj_id()
    local sender = obj:get_scene():get_obj_by_id(caster_obj_id)
    if sender then
        local count = 0
        for _, nb in ipairs(nearbys) do
            -- print("nb.classname =", nb.classname)
            if nb:is_character_obj() then
               if sender:is_enemy(nb) and nb:is_alive() and nb ~= obj then
                    for i = 1, 2 do
                        local value
                        if obj:is_alive() then
                            value = self:get_alive_impact(imp, i)
                        else
                            value = self:get_dead_impact(imp, i)
                        end
                        -- print("value =", value)
                        if value ~= define.INVAILD_ID then
                            impactenginer:send_impact_to_unit(nb, value, obj, 0, imp:is_critical_hit(), self:refix_power_by_rate(imp))
                        end
                    end
                    count = count + 1
                    if count >= affect_count then
                        break
                    end
               end
            end
        end
		local value = self:get_talent_802_value(imp)
		if value < 0 and count > 0 then
			value = value * count
			local cool_down_id = skillenginer:get_skill_template(435,"cool_down_id")
			if cool_down_id then
				sender:update_cool_down_by_cool_down_id(cool_down_id, value)
			end
			cool_down_id = skillenginer:get_skill_template(454,"cool_down_id")
			if cool_down_id then
				sender:update_cool_down_by_cool_down_id(cool_down_id, value)
			end
			local max_hp = sender:get_max_hp()
			local hp_modify = max_hp * 0.02 * count
			sender:health_increment(hp_modify, sender)
		end
	end
end

return std_impact_124