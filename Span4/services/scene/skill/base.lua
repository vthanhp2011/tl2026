local skynet = require "skynet"
local packet_def = require "game.packet"
local combat_core = require "scene.skill.combat_core"
local condition_delplete_core = require "scene.skill.condition_delplete_core"
local define = require "define"
local class = require "class"
local skill = class("skill")
local enum_OPERATE_RESULT = define.OPERATE_RESULT
local enum_SYSTEM_USE_SKILL = define.SYSTEM_USE_SKILL
local CONDITION_AND_DEPLETE_TERM_NUMBER = 3

function skill:speical_operation_on_skill_start()
    return true
end

function skill:is_passive()
    return false
end

function skill:on_interrupt()
    return false
end

function skill:on_cancel(obj_me)
    local params = obj_me:get_targeting_and_depleting_params()
    params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_SKILL)
    params:set_errparam(params:get_activated_skill())
end

function skill:start_launching(obj_me)
    return self:action_active_once_handler(obj_me)
end

function skill:start_charging(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local maxtime = skill_info:get_charge_time()
    local ret = true
    -- print("skill:start_charging maxtime =", maxtime)
    if maxtime <= 0 then
        ret = self:action_active_once_handler(obj_me)
    else
        ret = obj_me:get_scene():get_action_enginer():register_charge_action_for_skill(obj_me, skill_info:get_skill_id(), maxtime)
    end
    if ret then
        params:set_errcode(enum_OPERATE_RESULT.OR_OK)
    end
    return ret
end

function skill:start_channeling(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local maxtime = skill_info:get_channel_time()
    -- skynet.logi("skill:start_channeling maxtime =", maxtime)
    if maxtime <= 0 then
        skynet.logw("skill logic start_channeling: zero channel time found!!")
        return false
    end
    local ret = true
    if not params:get_ignore_condition_check_flag() then
        ret = self:deplete_process(obj_me)
    end
    -- print("skill:start_channeling ret =", ret)
    if ret then
        obj_me:on_use_skill_success_fully(skill_info)
        if obj_me:get_scene():get_action_enginer():register_channel_action_for_skill(obj_me, skill_info:get_skill_id(), maxtime, skill_info:get_charges_or_interval()) then
            self:cooldown_process(obj_me)
            params:set_errcode(enum_OPERATE_RESULT.OR_OK)
            self:activate_once(obj_me)
            return true
        end
    end
    return false
end

function skill:is_wantd_target(obj_me, obj_tar, skill_info)
    local otype = skill_info:get_target_check_by_obj_type()
    if otype == 0 then
        if obj_tar:get_obj_type() ~= "human" then
            return false
        end
    elseif otype == 1 then
        if obj_tar:get_obj_type() ~= "pet" then
            return false
        end
    elseif otype == 2 then
        if obj_tar:get_obj_type() ~= "monster" then
            return false
        end
    end

    local stand_type = skill_info:get_target_logic_by_stand()
    if stand_type == 0 then
        if obj_tar:is_enemy(obj_me) and obj_me:is_enemy(obj_tar) then
            return false
        else
            local is_party_only = skill_info:is_party_only()
            if is_party_only then
                if not obj_me:is_party(obj_tar) then
                    return false
                end
            end
        end
    elseif stand_type == 1 then
        if obj_tar:is_friend(obj_me) and obj_me:is_friend(obj_tar) then
            return false
        end
    end

    local must_in_special_state = skill_info:get_target_must_in_special_state()
    if must_in_special_state == 0 then
        if not obj_tar:is_alive() then
            return false
        end
    elseif must_in_special_state == 1 then
        if obj_tar:is_dead() then
            return false
        end
    end

    return self:is_special_target_wanted(obj_me, obj_tar, skill_info)
end

function skill:refix_deplete_by_rate(skill_info, rate)
    if self:can_be_refix() then
        skill_info:set_deplete_refix_by_rate(rate)
    end
end

function skill:refix_power_by_rate(skill_info, rate)
    if self:can_be_refix() then
        skill_info:set_power_refix_by_rate(rate)
    end
end

function skill:can_be_refix()
    return false
end

function skill:is_condition_satisfied(obj_me)
    return self:common_condition_check(obj_me) and self:specific_condition_check(obj_me)
end

function skill:cancel_skill_effect()

end

function skill:action_active_once_handler(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if not self:is_condition_satisfied(obj_me) then
        return false
    end
    local ret = true
    if not params:get_ignore_condition_check_flag() then
        ret = self:deplete_process(obj_me)
    end
    if ret then
        local actiontime = self:calculate_action_time(obj_me)
        print("actiontime =", actiontime)
        if not obj_me:get_scene():get_action_enginer():register_instant_action_for_skill(obj_me, skill_info:get_skill_id(), actiontime) then
            return false
        end
        obj_me:set_action_time(actiontime)
        self:cooldown_process(obj_me)
        local active_times = skill_info:get_charges_or_interval()
        if active_times <= 0 then
            active_times = 1
        end
        local delaytime = skill_info:get_delay_time() == 0 and define.MIN_DELAY_TIME or skill_info:get_delay_time()
        params:set_delay_time(delaytime)
        for i = 1, active_times do
            local r, err = pcall(self.activate_once, self, obj_me)
            if not r then
                skynet.loge("skill:action_active_once_handler error =", err)
            end
        end
        obj_me:on_use_skill_success_fully(skill_info)
        self:on_use_skill_success_fully(obj_me)
    end
end

function skill:action_active_each_tick_handler(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if self:target_check_for_each_tick(obj_me) then
        params:set_delay_time(skill_info:get_delay_time())
        self:activate_each_tick(obj_me)
        return true
    end
    return false
end

function skill:get_skill_info_descriptor_vlue_by_Index()

end

function skill:set_skill_info_descriptor_vlue_by_Index()

end
function skill:calculate_target_list(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local target_mode = skill_info:get_targeting_logic()
    local ret = false
    local objs = {}
	--skynet.logi("target_mode = ",target_mode)
    if target_mode == define.ENUM_TARGET_LOGIC.TARGET_SELF then
        table.insert(objs, obj_me)
    elseif target_mode == define.ENUM_TARGET_LOGIC.TARGET_MY_PET then
        table.insert(objs, obj_me:get_pet())
    elseif target_mode == define.ENUM_TARGET_LOGIC.TARGET_MY_SHADOW_GUARD then
        table.insert(objs, obj_me:get_my_shadow_guard())
    elseif target_mode == define.ENUM_TARGET_LOGIC.TARGET_MY_MASTER then
        table.insert(objs, obj_me:get_my_master())
    elseif target_mode == define.ENUM_TARGET_LOGIC.TARGET_AE_AROUND_SELF then
        local pos = obj_me:get_world_pos()
        objs = self:scan_unit_for_target(obj_me, pos.x, pos.y)
    elseif target_mode == define.ENUM_TARGET_LOGIC.TARGET_AE_AROUND_UNIT
	or target_mode == define.ENUM_TARGET_LOGIC.TARGET_AE_AROUND_UNIT_NEW then
        local obj_tar = obj_me:get_specific_obj_in_same_scene_by_id(params:get_target_obj())
        local pos = obj_tar:get_world_pos()
        objs = self:scan_unit_for_target(obj_me, pos.x, pos.y)
    elseif target_mode == define.ENUM_TARGET_LOGIC.TARGET_AE_AROUND_POSITION then
        local pos = params:get_target_position()
        objs = self:scan_unit_for_target(obj_me, pos.x, pos.y)
    elseif target_mode == define.ENUM_TARGET_LOGIC.TARGET_SPECIFIC_UNIT then
        local obj_tar = obj_me:get_specific_obj_in_same_scene_by_id(params:get_target_obj())
        table.insert(objs, obj_tar)
    end
    return objs
end

function skill:activate_once(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local targets = self:calculate_target_list(obj_me)
    local target_count = #targets
    local hit_flag_list = {}
    if target_count == 0 then
    else
		local skill_id = skill_info:get_skill_id()
		local delay_time = skill_info:get_delay_time()
        for i, o in ipairs(targets) do
            if self:hit_this_target(obj_me, o) then
                hit_flag_list[i] = true
            else
				target_count = target_count - 1
                hit_flag_list[i] = false
            end
            self:register_be_skill_event(o, obj_me, skill_id, delay_time)
        end
		target_count = target_count < 1 and 1 or target_count
        params:set_target_count(target_count)
        for i, o in ipairs(targets) do
            if hit_flag_list[i] then
                local critical_hit = self:critical_hit_this_target(obj_me, o)
                --skynet.logi("skill:activate_once skill_id =", skill_info:get_skill_id())
                self:effect_on_unit_once(obj_me, o, critical_hit)
            end
        end
    end
    self:broadcast_target_list_message(obj_me, targets, hit_flag_list)
    return true
end

function skill:activate_each_tick(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local targets = self:calculate_target_list(obj_me)
    --skynet.logi("skill:activate_each_tick targets =", #targets)
    local target_count = #targets
    local hit_flag_list = {}
    if target_count == 0 then

    else
		local skill_id = skill_info:get_skill_id()
		local delay_time = skill_info:get_delay_time()
        for i, o in ipairs(targets) do
            if self:hit_this_target(obj_me, o) then
                hit_flag_list[i] = true
            else
				target_count = target_count - 1
                hit_flag_list[i] = false
            end
            self:register_be_skill_event(o, obj_me, skill_id, delay_time)
        end
		target_count = target_count < 1 and 1 or target_count
        params:set_target_count(target_count)
        for i, o in ipairs(targets) do
            if hit_flag_list[i] then
                local critical_hit = self:critical_hit_this_target(obj_me, o)
                local r, err = pcall(self.effect_on_unit_each_tick, self, obj_me, o, critical_hit)
                if not r then
                    print("skill:activate_each_tick error =", err)
                end
            end
        end
    end
    self:broadcast_target_list_message(obj_me, targets, hit_flag_list)
    return true
end

function skill:effect_on_unit_each_tick()
    return true
end

function skill:effect_on_unit_once()
    return true
end

function skill:on_use_skill_success_fully()
    return true
end

function skill:is_character_obj(t)
    return t == "monster" or t == "pet" or t == "human"
end

function skill:target_check_for_each_tick(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if skill_info:get_select_type() ~= 1 then
        return true
    end
    local obj_tar = self:get_target_obj(obj_me)
    if obj_tar then
        if self:is_character_obj(obj_tar:get_obj_type()) then
            if not obj_tar:can_view_me(obj_me) then
                params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                params:set_errparam(0)
                return false
            end
            local must_in_special_state = skill_info:get_target_must_in_special_state()
            if must_in_special_state == 0 then
                if not obj_tar:is_alive() then
                    params:set_errcode(enum_OPERATE_RESULT.OR_TARGET_DIE)
                    params:set_errparam(0)
                    return false
                end
            elseif must_in_special_state == 1 then
                if obj_tar:is_alive_in_deed() then
                    params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                    return false
                end
            end
            if self:is_out_of_range_to_obj(obj_me, obj_tar) then
		-- skynet.logi("target_check_for_each_tick 111")
                params:set_errcode(enum_OPERATE_RESULT.OR_OUT_RANGE)
                params:set_errparam(0)
                return false
            end
            return true
        end
    end
end

function skill:target_check_for_activate_once(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local select_type = skill_info:get_select_type()
    print("skill_info.get_select_type =", select_type)
    if select_type ~= define.ENUM_SELECT_TYPE.SELECT_TYPE_CHARACTER then
        if select_type == define.ENUM_SELECT_TYPE.SELECT_TYPE_POS then
            local pos = params:get_target_position()
            if self:is_out_of_range_to_pos(obj_me, pos) then
                return false
            end
        end
        return true
    else
        local obj_tar = self:get_target_obj(obj_me)
        if obj_tar then
            if self:is_character_obj(obj_tar:get_obj_type()) then
                --[[if not obj_tar:can_view_me(obj_me) then
                    params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                    params:set_errparam(0)
                    print("target can not view me")
                    return false
                end]]
                local otype = skill_info:get_target_check_by_obj_type()
                if otype == 0 then
                    if obj_tar:get_obj_type() ~= "human" then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        params:set_errparam(0)
                        print("target not human")
                        return false
                    end
                elseif otype == 1 then
                    if obj_tar:get_obj_type() ~= "pet" then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        params:set_errparam(0)
                        print("target not pet")
                        return false
                    end
                elseif otype == 2 then
                    if obj_tar:get_obj_type() ~= "monster" then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        params:set_errparam(0)
                        print("target not monster")
                        return false
                    end
                end
                local stand_type = skill_info:get_target_logic_by_stand()
                if stand_type == 0 then
                    if obj_tar:is_enemy(obj_me) and obj_me:is_enemy(obj_tar) then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        params:set_errparam(0)
                        print("target is enemy")
                        return false
                    end
                elseif stand_type == 1 then
                    if obj_tar:is_friend(obj_me) and obj_me:is_friend(obj_tar) then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        params:set_errparam(0)
                        print("target is friend")
                        return false
                    end
                end
                local must_in_special_state = skill_info:get_target_must_in_special_state()
                if must_in_special_state == 0 then
                    if not obj_tar:is_alive() then
                        params:set_errcode(enum_OPERATE_RESULT.OR_TARGET_DIE)
                        params:set_errparam(0)
                        print("target not alive")
                        return false
                    end
                elseif must_in_special_state == 1 then
                    if obj_tar:is_alive_in_deed() then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        print("target not deed")
                        return false
                    end
                end
                local party_only = skill_info:is_party_only()
                if party_only then
                    if not obj_tar:is_party(obj_me) and not obj_me:is_party(obj_tar) then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        params:set_errparam(0)
                        print("target no party")
                        return false
                    end
                end
                if self:is_out_of_range_to_obj(obj_me, obj_tar) then
		-- skynet.logi("target_check_for_activate_once 111")
                    params:set_errcode(enum_OPERATE_RESULT.OR_OUT_RANGE)
                    params:set_errparam(0)
                    print("target out of range")
                    return false
                end
                local target_level = skill_info:get_target_level()
                if target_level ~= -1 then
                    if target_level > obj_tar:get_level() then
                        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
                        params:set_errparam(0)
                        print("target level too bigger")
                        return false
                    end
                end
                return true
            end
        end
        print("target is nil")
        return false
    end
    return false
end

function skill:deplete_process(obj_me)
    return self:common_deplete(obj_me) and self:specific_deplete(obj_me)
end

function skill:common_condition_check(obj_me)
    local skill_info = obj_me:get_skill_info()
    for i = 1, define.CONDITION_AND_DEPLETE_TERM_NUMBER do
        local term = skill_info.condition_and_deplete[i]
        if term then
            if not condition_delplete_core:condition_check(obj_me, term) then
                return false
            end
        end
    end
    if not self:target_check_for_activate_once(obj_me) then
        return false
    end
    return true
end

function skill:specific_condition_check()
    return true
end

function skill:common_deplete(obj_me)
    local skill_info = obj_me:get_skill_info()
    for i = 1, CONDITION_AND_DEPLETE_TERM_NUMBER do
        local term = skill_info.condition_and_deplete[i]
        if term then
            if not condition_delplete_core:deplete(obj_me, term) then
                return false
            end
        end
    end
    return true
end

function skill:specific_deplete()
    return true
end

function skill:is_special_target_wanted()
    return true
end

function skill:cancel_skill_effect()
    return false
end

function skill:get_target_obj(obj)
    local skill_info = obj:get_skill_info()
    local params = obj:get_targeting_and_depleting_params()

    local target_id = params:get_target_obj()
    -- print("get_target_obj target id =", target_id)
    local obj_tar = obj:get_specific_obj_in_same_scene_by_id(target_id)
    if obj_tar == nil then
        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
        return
    end
    if not obj_tar:is_active_obj() then
        params:set_errcode(enum_OPERATE_RESULT.OR_INVALID_TARGET)
        return 
    end
    return obj_tar
end

function skill:is_out_of_range_to_obj(obj_me, obj_tar)
    if obj_me:get_obj_type() == "pet" then
        return false
    end
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local acceptable_distance_error
    if obj_tar:get_obj_type() == "human" then
        acceptable_distance_error = define.AcceptableDistanceError_NS.ADE_FOR_HUMAN / 4
    else
        acceptable_distance_error = define.AcceptableDistanceError_NS.ADE_FOR_NPC / 4
    end
    acceptable_distance_error = acceptable_distance_error * 2
    if obj_tar:get_character_logic() == define.ENUM_CHARACTER_LOGIC.CHARACTER_LOGIC_MOVE then
        acceptable_distance_error = acceptable_distance_error + 0.5
    end
    local min = skill_info:get_optimal_range_min()
    local max = skill_info:get_optimal_range_max()
	
	local skill_id = skill_info:get_skill_id()
	local effect_value,feature_rate = 0,0
	local skillenginer = obj_me:get_scene():get_skill_enginer()
	if skillenginer:is_skill_in_collection(skill_id,121) then
		effect_value,feature_rate = obj_me:get_dw_jinjie_effect_details(15)
		if effect_value > 0 then
			effect_value = effect_value / feature_rate
		end
	end
    min = min - acceptable_distance_error
    max = max + acceptable_distance_error + effect_value
    min = min > 0 and min * min or 0
    max = max > 0 and max * max or 0
    local pos_me = obj_me:get_world_pos()
    local pos_tar = obj_tar:get_world_pos()
    local dist2targetsq = self:distance_sq(pos_me, pos_tar)
    if dist2targetsq < min then
        params:set_errcode(enum_OPERATE_RESULT.OR_OUT_RANGE)
        params:set_errparam(dist2targetsq - min)
        return true
    end
    if dist2targetsq > max then
        params:set_errcode(enum_OPERATE_RESULT.OR_OUT_RANGE)
        params:set_errparam(dist2targetsq - max)
        return true
    end
    params:set_errcode(enum_OPERATE_RESULT.OR_OK)
    return false
end

function skill:is_out_of_range_to_pos(obj_me, pos_tar)
    if obj_me:get_obj_type() == "pet" then
        return false
    end
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local min = skill_info:get_optimal_range_min()
    local max = skill_info:get_optimal_range_max()
    min = min > 0 and min * min or 0
    max = max > 0 and max * max or 0
    local pos_me = obj_me:get_world_pos()
    local dist2targetsq = self:distance_sq(pos_me, pos_tar)
    if dist2targetsq < min then
		-- skynet.logi("is_out_of_range_to_pos 111")
        params:set_errcode(enum_OPERATE_RESULT.OR_OUT_RANGE)
        params:set_errparam(dist2targetsq - min)
        return true
    end
    if dist2targetsq > max then
		-- skynet.logi("is_out_of_range_to_pos 222")
        params:set_errcode(enum_OPERATE_RESULT.OR_OUT_RANGE)
        params:set_errparam(dist2targetsq - max)
        return true
    end
    params:set_errcode(enum_OPERATE_RESULT.OR_OK)
    return false
end

function skill:set_cool_down(obj, id, cool_down_time)
    obj:set_cool_down(id, cool_down_time)
end

function skill:set_auto_repeat_cool_down(obj, cool_down_time)
    local auto_repeat_cool_down_time = obj:get_auto_repeat_cool_down()
    print("skill:set_auto_repeat_cool_down obj =", obj:get_obj_id(), ";cool_down_time =", cool_down_time, ";auto_repeat_cool_down_time =", auto_repeat_cool_down_time)
    cool_down_time = cool_down_time + auto_repeat_cool_down_time
    obj:set_auto_repeat_cool_down(cool_down_time)
end

function skill:scan_unit_for_target(obj_me, x, y)
    local skill_info = obj_me:get_skill_info()
    --local params = obj_me:get_targeting_and_depleting_params()
    local scene = obj_me:get_scene()
    local operate = {}
    operate.skill_info = skill_info
    operate.obj = obj_me
    operate.scene = scene
    operate.radious = skill_info:get_radious()
    operate.x = x
    operate.y = y
    operate.target_logic_by_stand = skill_info:get_target_logic_by_stand()
    operate.target_check_by_obj_type = skill_info:get_target_check_by_obj_type()
    operate.target_must_be_teammate = skill_info:get_target_must_be_teammate()
    operate.count = skill_info:get_target_count()
    return scene:scan(operate)
end

function skill:hit_this_target(obj_me, obj_tar)
	-- skynet.logi("hit_this_target")
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local scene = obj_me:get_scene()
    if obj_me:is_friend(obj_tar) then
        return true
    end
    if not self:is_hit(obj_me, obj_tar, skill_info:get_accuracy()) then
        scene:get_event_enginer():register_skill_miss_event(obj_me, obj_tar, skill_info:get_skill_id(), skill_info:get_delay_time())
        return false
    end
    scene:get_event_enginer():register_skill_hit_event(obj_me, obj_tar, skill_info:get_skill_id(), skill_info:get_delay_time())
    return true
end

function skill:critical_hit_this_target(obj_me, obj_tar)
    if obj_me:is_friend(obj_tar) then
        return false
    end
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if self:is_critical_hit(obj_me, obj_tar, skill_info:get_critical_rate(), skill_info) then
        obj_me:on_critical_hit_target(skill_info:get_skill_id(), obj_tar)
        obj_tar:on_be_critical_hit(skill_info:get_skill_id(), obj_me)
        return true
    end
    return false
end


function skill:is_target_alive(obj_tar)
    return obj_tar:is_alive()
end

function skill:distance_sq(p1, p2)
    local dx = p2.x - p1.x
    local dy = p2.y - p1.y
    return dx * dx + dy * dy
end

function skill:is_hit(obj_me, obj_tar, accuracy)
    local combat = combat_core.new()
    if accuracy == -1 then
        accuracy = combat:calculate_hit_rate(obj_me:get_hit(), obj_tar:get_miss())
        local refix_miss_rate = obj_tar:refix_miss_rate()
        local target_refix_accuracy_rate = obj_tar:target_refix_accuracy_rate(obj_me)
        local skill_info = obj_me:get_skill_info()
        local skill_accuracy_rate_up = skill_info:get_accuracy_rate_up()
        accuracy = accuracy + (target_refix_accuracy_rate / 100) + (skill_accuracy_rate_up / 100) - (refix_miss_rate / 100)
    end
    local rand = math.random(100)
    return combat:is_hit(accuracy, rand)
end
function skill:is_critical_hit(obj_me, obj_tar, critical_rate, skill_info)
    local combat = combat_core.new()
    if critical_rate == -1 then
        local mind_attack = obj_me:get_mind_attack()
        local mind_defend = obj_tar:get_mind_defend()
        critical_rate = combat:calculate_critical_rate(mind_attack, mind_defend)
        critical_rate = obj_me:impact_refix_critical_rate(critical_rate, skill_info)
        critical_rate = critical_rate + skill_info:get_mind_attack_rate_up()
        -- print("is_critical_hit critical_rate =", critical_rate)
    end
    local rand = math.random(100)
    return combat:is_critical_hit(critical_rate, rand)
end

function skill:refix_play_action_time_with_attack_rate(play_action_time, attack_rate)
    return play_action_time * attack_rate / 100
end

function skill:refix_cool_down_time_with_attack_rate(cool_down_time, attack_rate)
    return cool_down_time * attack_rate / 100
end

function skill:register_impact_event(reciver, sender, imp, delaytime, critical_flag)
    local skill_info = sender:get_skill_info()
    local params = sender:get_targeting_and_depleting_params()

    imp:set_skill_id(skill_info:get_skill_id())
    imp:set_skill_level(skill_info:get_skill_level())

    if critical_flag then
        imp:mark_critical_hit_flag()
    end
    local scene = reciver:get_scene()
    local eventenginer = scene:get_event_enginer()
    if imp:get_logic_id() == 3 then
        local co = combat_core.new()
		co:get_result_impact(sender, reciver, imp)
    end
    return eventenginer:register_impact_event(reciver, sender, imp, delaytime, imp:get_skill_id())
end

function skill:register_skill_miss_event(reciver, sender, skill_id, delaytime)
    local scene = reciver:get_scene()
    return scene:get_event_enginer():register_skill_miss_event(reciver, sender, skill_id, delaytime)
end

function skill:register_be_skill_event(reciver, sender, skill_id, delaytime)
    local skillenginer = sender:get_scene():get_skill_enginer()
    local template = skillenginer:get_skill_template(skill_id)
    local behaviortype
    if template.stand_flag > 0 then
        behaviortype = define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_AMITY
    elseif template.stand_flag < 0 then
        behaviortype = define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_HOSTILITY
    else
        behaviortype = define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_NEUTRALITY
    end
    return reciver:get_scene():get_event_enginer():register_be_skill_event(reciver, sender, skill_id, behaviortype, delaytime)
end

function skill:broadcast_target_list_message(obj_me, obj_tars, hitflags)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local ret = packet_def.GCTargetListAndHitFlags.new()
    ret.m_objID = obj_me:get_obj_id()
    ret.logic_count = obj_me:get_logic_count()
    ret.data_type = ret.enum_type.UNIT_USE_SKILL
    ret.skill_or_special_obj_id = skill_info:get_skill_id()
    ret.target_pos = params:get_target_position()
    ret.target_list = {}
    for i, flag in ipairs(hitflags) do
        if flag ~= nil then
            local obj = obj_tars[i]
            table.insert(ret.target_list, obj:get_obj_id())
        end
    end
    ret.size = #(ret.target_list)
    local scene = obj_me:get_scene()
    scene:broadcast(obj_me, ret, true)
end

function skill:calculate_action_time(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local action_time = skill_info:get_play_action_time()
    if enum_SYSTEM_USE_SKILL.MELEE_ATTACK == params:get_activated_skill() then
        if obj_me:get_obj_type() == "monster" then
            action_time = obj_me:get_attack_anim_time()
        end
    end
    return action_time
end

function skill:cooldown_process(obj_me)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local play_action_time = skill_info:get_play_action_time()
    local cool_down = skill_info:get_cool_down_time()
    local delay = skill_info:get_delay_time()
    if enum_SYSTEM_USE_SKILL.MELEE_ATTACK == params:get_activated_skill() then
        if obj_me:get_obj_type() == "monster" then
            play_action_time = obj_me:get_attack_anim_time()
            cool_down = obj_me:get_attack_cool_down_time()
        end
    end
    cool_down = obj_me:refix_skill_cool_down_time(skill_info, cool_down)
    if cool_down < play_action_time then
        cool_down = play_action_time
    end
    local is_auto_shot_skill = skill_info:is_auto_shot_skill()
    print("is_auto_shot_skill =", is_auto_shot_skill, ";cool_down =", cool_down)
    if is_auto_shot_skill then
        self:set_auto_repeat_cool_down(obj_me, cool_down)
    else
        self:set_cool_down(obj_me, skill_info:get_cool_down_id(), cool_down)
    end
end

function skill:register_active_obj(obj, sender, delaytime, skill_id)
    local scene = sender:get_scene()
    local eventenginer = scene:get_event_enginer()
    return eventenginer:register_active_special_obj_event(obj:get_obj_id(), sender, delaytime, skill_id)
end

function skill:skill_get_logic()

end

return skill