local class = require "class"
local define = require "define"
local base = require "scene.skill.base"
local impact = require "scene.skill.impact"
local skill_642 = class("skill_642", base)
local skill_id_2_index = {
    [274] = 1,
    [275] = 2,
    [276] = 3,
}

function skill_642:get_impact(obj_me, index)
    local container = obj_me:get_equip_container()
    local anqi = container:get_item(define.HUMAN_EQUIP.HEQUIP_ANQI)
    return anqi:get_equip_data():get_aq_skill(index) or define.INVAILD_ID
end

function skill_642:specific_condition_check(obj_me)
    local skillinfo = obj_me:get_skill_info()
    local skill_id = skillinfo:get_skill_id()
    local container = obj_me:get_equip_container()
    local anqi = container:get_item(define.HUMAN_EQUIP.HEQUIP_ANQI)
    if anqi == nil then
        obj_me:notify_tips("使用暗器技能需要装备暗器！")
        return false
    end
    local index = skill_id_2_index[skill_id]
    local skill = anqi:get_equip_data():get_aq_skill(index)
    if skill == 0 then
        obj_me:notify_tips("未领悟暗器对应技能！")
        return false
    end
    return true
end

function skill_642:effect_on_unit_once(obj_me, obj_tar, is_critical)
    local skillinfo = obj_me:get_skill_info()
    local skill_id = skillinfo:get_skill_id()
    local params = obj_me:get_targeting_and_depleting_params()
    local value
    local scene = obj_me:get_scene()
    local impactenginer = scene:get_impact_enginer()
    local index = skill_id_2_index[skill_id]
    value = self:get_impact(obj_me, index)
    if value ~= define.INVAILD_ID then
        -- print("skill_642:effect_on_unit_once impact obj_id =", obj_me:get_obj_id(), ";logic_id =", value)
        local imp = impact.new()
        imp:clean_up()
        impactenginer:init_impact_from_data(value, imp)
        self:register_impact_event(obj_tar, obj_me, imp, params:get_delay_time(), is_critical)
    end
end

return skill_642