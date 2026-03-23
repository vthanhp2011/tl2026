local class = require "class"
local impact = class("impact")
impact.enum_IDX = {
    IDX_FADE_OUT = "IDX_FADE_OUT",
    IDX_CRITICAL = "IDX_CRITICAL",
    IDX_CREATE_BY_PLAYER = "IDX_CREATE_BY_PLAYER"
}

function impact:ctor()
    self.sn = nil
    self.data_index = nil
    self.impact_id = nil
    self.skill_id = nil
    self.is_over_timed = false
    self.caster_obj_id = nil
    self.caster_unique_id = nil
    self.logic_id = nil
    self.caster_logic_count = 0
    self.continuance = 0
    self.continuance_elapsed = 0
    self.interval_elapsed = 0
    self.interval = 0
    self.mutex_id = 0
    self.mutex_priority = 0
    self.flags = {}
    self.params = {}
    self.transport_dest = {}
    self.use_skill_success_fully_count = 0
    self.hit_target_count = 0
    self.can_be_cancled = false
    self.skill_segment = 0
    -- self.features = {}
end

function impact:clean_up()
    self.sn = nil
    self.data_index = nil
    self.impact_id = nil
    self.skill_id = nil
    self.caster_obj_id = nil
    self.caster_unique_id = nil
    self.caster_logic_count = 0
    self.continuance = 0
    self.continuance_elapsed = 0
    self.interval_elapsed = 0
    self.interval = 0
    self.mutex_id = 0
    self.mutex_priority = 0
    self.flags = {}
    self.params = {}
    self.transport_dest = {}
    self.use_skill_success_fully_count = 0
    self.hit_target_count = 0
    self.logic_count = 0
    self.can_be_cancled = false
    self.skill_segment = 0
    -- self.features = {}
end

function impact:init_from_data(data)
    data.continuance = (data.continuance or 0) - (data.continuance_elapsed or 0)
    data.continuance_elapsed = 0
    for key, value in pairs(data) do
        if key == "params" and type(value) == "table" then
            for k in pairs(value) do
                if k == "" then
                    value[k] = nil
                end
            end
        end
        self[key] = value
    end
end



function impact:get_sn()
    return self.sn
end

function impact:set_sn(sn)
    self.sn = sn
end

function impact:set_logic_id(logic_id)
    self.logic_id = logic_id
end

function impact:get_logic_id()
    return self.logic_id
end
function impact:add_rate_params(key,value)
	self.params[key] = (self.params[key] or 100) + value
end

function impact:add_point_params(key,value)
	self.params[key] = (self.params[key] or 0) + value
end

function impact:get_features()
    return self.features_value
end

function impact:set_features(value)
	self.features_value = value
end

function impact:get_data_index()
    return self.data_index or -1
end

function impact:set_data_index(data_index)
    self.data_index = data_index
end

function impact:get_impact_id()
    return self.impact_id
end

function impact:set_impact_id(impact_id)
    self.impact_id = impact_id
end

function impact:get_class_id()
    return self.class_id
end

function impact:set_class_id(class_id)
    self.class_id = class_id
end

function impact:get_skill_id()
    return self.skill_id
end

function impact:set_skill_id(skill_id)
    self.skill_id = skill_id
end

function impact:get_skill_level()
    return self.skill_level or 1
end

function impact:set_skill_level(skill_level)
    self.skill_level = skill_level
end

function impact:set_is_over_timed(is)
    self.is_over_timed = is
end

function impact:get_is_over_timed()
    return self.is_over_timed
end

function impact:get_caster_obj_id()
    return self.caster_obj_id
end

function impact:set_caster_obj_id(caster_obj_id)
    self.caster_obj_id = caster_obj_id
end

function impact:get_caster_logic_count()
    return self.caster_logic_count
end

function impact:set_caster_logic_count(caster_logic_count)
    self.caster_logic_count = caster_logic_count
end

function impact:get_continuance()
    return self.continuance
end

function impact:set_continuance(continuance)
    self.continuance = continuance
end

function impact:get_continuance_elapsed()
    return self.continuance_elapsed
end

function impact:set_continuance_elapsed(continuance_elapsed)
    self.continuance_elapsed = continuance_elapsed
end

function impact:get_interval_elapsed()
    return self.interval_elapsed
end

function impact:set_interval_elapsed(interval_elapsed)
    self.interval_elapsed = interval_elapsed
end

function impact:is_create_by_player()
    return self.flags[self.enum_IDX.IDX_CREATE_BY_PLAYER] == 1
end

function impact:mark_create_by_player_flag()
    self.flags[self.enum_IDX.IDX_CREATE_BY_PLAYER] = 1
end

function impact:clear_create_by_player_flag()
    self.flags[self.enum_IDX.IDX_CREATE_BY_PLAYER] = 0
end

function impact:is_fade_out()
    return self.flags[self.enum_IDX.IDX_FADE_OUT] == 1
end

function impact:mark_fade_out_flag()
    self.flags[self.enum_IDX.IDX_FADE_OUT] = 1
end

function impact:clear_fade_out_flag()
    self.flags[self.enum_IDX.IDX_FADE_OUT] = 0
end

function impact:is_critical_hit()
    return self.flags[self.enum_IDX.IDX_CRITICAL] == 1
end

function impact:mark_critical_hit_flag()
    self.flags[self.enum_IDX.IDX_CRITICAL] = 1
end

function impact:clear_critical_hit_flag()
    self.flags[self.enum_IDX.IDX_CRITICAL] = 0
end

function impact:get_param_by_index(idx)
    return self.params[idx]
end

function impact:set_param_by_index(idx, value)
    self.params[idx] = value
end

function impact:set_params(params)
    self.params = params
end

function impact:set_caster_unique_id(unique_id)
    self.caster_unique_id = unique_id
end

function impact:get_caster_unique_id()
    return self.caster_unique_id
end

function impact:get_transport_dest()
    return self.transport_dest
end

function impact:get_mutex_id()
    return self.mutex_id
end

function impact:set_mutex_id(mutex_id)
    self.mutex_id = mutex_id
end

function impact:get_mutex_priority()
    return self.mutex_priority
end

function impact:set_mutex_priority(mutex_priority)
    self.mutex_priority = mutex_priority
end

function impact:is_can_be_cancled()
    if self.can_be_cancled == nil then
        return true
    end
    return self.can_be_cancled
end

function impact:set_can_be_cancled(can)
    self.can_be_cancled = can
end

function impact:is_counter_when_offline()
    return self.counter_when_offline
end

function impact:set_counter_when_offline(is)
    self.counter_when_offline = is
end

function impact:is_need_channel_support()
    return self.need_channel_support
end

function impact:set_need_channel_support(need)
    self.need_channel_support = need
end

function impact:is_need_equip_support()
    return self.need_equip_support
end

function impact:set_need_equip_support(need)
    self.need_equip_support = need
end

function impact:is_remain_on_corpse()
    return self.remain_on_corpse
end

function impact:set_remain_on_corpse(remain)
    self.remain_on_corpse = remain
end

function impact:set_interval(interval)
    self.interval = interval
end

function impact:get_interval()
    return self.interval
end

function impact:get_interval_elpased()
    return self.interval_elapsed
end

function impact:set_interval_elpased(elapsed)
    self.interval_elapsed = elapsed
end

function impact:set_activate_times(times)
    self.activate_times = times
end

function impact:get_activate_times()
    return self.activate_times
end

function impact:is_can_be_dispeled()
    return self.can_be_dispeled
end

function impact:set_can_be_dispeled(can)
    self.can_be_dispeled = can
end

function impact:is_fade_out_when_unit_on_damage()
    return self.fade_out_when_unit_on_damage
end

function impact:set_fade_out_when_unit_on_damage(is)
    self.fade_out_when_unit_on_damage = is
end

function impact:is_fade_out_when_unit_on_move()
    return self.fade_out_when_unit_on_move
end

function impact:set_fade_out_when_unit_on_move(is)
    self.fade_out_when_unit_on_move = is
end

function impact:is_fade_out_when_unit_on_action_start()
    return self.fade_out_when_unit_on_action_start
end

function impact:set_fade_out_when_unit_on_action_start(is)
    self.fade_out_when_unit_on_action_start = is
end

function impact:is_fade_out_when_unit_offline()
    return self.fade_out_when_unit_offline
end

function impact:set_fade_out_when_unit_offline(is)
    self.fade_out_when_unit_offline = is
end

function impact:set_use_skill_success_fully_count(count)
    self.use_skill_success_fully_count = count
end

function impact:get_use_skill_success_fully_count()
    return self.use_skill_success_fully_count
end

function impact:set_hit_target_count(count)
    self.hit_target_count = count
end

function impact:get_hit_target_count()
    return self.hit_target_count
end

function impact:get_stand_flag()
    return self.stand_flag
end

function impact:set_stand_flag(flag)
    self.stand_flag = flag
end

function impact:set_skill_segment(segment)
    self.skill_segment = segment
end

function impact:get_skill_segment()
    return self.skill_segment
end

function impact:get_is_out()
    return self.is_out
end

function impact:set_is_out()
    self.is_out = true
end

function impact:get_chonglou_sash()
    return self.chonglou_sash
end

function impact:set_chonglou_sash()
    self.chonglou_sash = true
end

return impact