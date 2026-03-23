local class = require "class"
local define = require "define"
local impactenginer = require "impactenginer":getinstance()
local base = require "scene.special_obj.base"
local trap = class("trap", base)
trap.type = base.eSpecailObjType.TRAP_OBJ
trap.MASK_ACTIVATE_WHEN_FADE_OUT = 1
trap.MASK_TRIGGER_BY_CHARACTER = 2
trap.MASK_TRIGGER_BY_TRAP = 4

function trap:ctor()
end

function trap:get_type()
    return self.type
end

function trap:get_impact(obj, key)
    local data = obj:get_data_record()
    return data.descriptor[key]
end

function trap:impact_activate_odds(obj, key)
    local data = obj:get_data_record()
    return data.descriptor[key]
end

function trap:force_activate(obj)
    if not obj:is_fade_out() then
        self:activate(obj)
        self:force_fade_out(obj)
    end
end

function trap:force_fade_out(obj)
    if self:activate_when_fade_out(obj) then
        self:activate(obj)
    end
    obj:mark_fade_out_flag()
end

function trap:on_tick(obj)
    if self:trigger_check(obj) then
        self:activate(obj)
    end
end

function trap:trigger_check(obj)
    local scene = obj:get_scene()
    local data = obj:get_data_record()
    if data == nil then
        return false
    end
    if not self:can_be_character_activate(obj) then
        return false
    end
    local position = obj:get_world_pos()
    local radious = data.trigger_radious
    local affect_count = data.affect_count
    local owner_obj_id = obj:get_owner_obj_id()
    local owner = obj:get_scene():get_obj_by_id(owner_obj_id)
    if owner then
        local operate = {scaner = obj, obj = owner, x = position.x, y = position.y, target_logic_by_stand = 1, radious = radious, count = affect_count}
        local targets= scene:scan(operate)
        if #targets > 0 then
            return true
        end
    end
    return false
end

function trap:activate(obj)
    if obj:is_fade_out() then
        return
    end
    local scene = obj:get_scene()
    if scene == nil then
        return
    end
    local data = obj:get_data_record()
    if data == nil then
        return
    end
    if obj:get_active_times() == 0 then
        obj:mark_fade_out_flag()
        return
    end
    local times = obj:get_active_times()
    if times > 0 then
        obj:set_active_times(times - 1)
    end
    local position = obj:get_world_pos()
    local radious = data.effect_radious
    local affect_count = data.affect_count
    local owner_obj_id = obj:get_owner_obj_id()
    local owner = obj:get_scene():get_obj_by_id(owner_obj_id)
	if not owner then
		return
	end
    local operate = {scaner = obj, obj = owner, x = position.x, y = position.y, target_logic_by_stand = 1, radious = radious, count = affect_count}
    local targets = scene:scan(operate)
    obj:on_trigger(targets)
    for _, obj_tar in ipairs(targets) do
        if obj_tar:is_character_obj() then
            self:effect_on_char(obj, obj_tar)
        end
    end
end

function trap:effect_on_char(obj_me, obj_tar)
    local scene = obj_me:get_scene()
    local owner = scene:get_obj_by_id(obj_me:get_owner_obj_id())
    scene:get_event_enginer():register_be_skill_event(obj_tar, owner, define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_HOSTILITY, 500)
	local refix_by_rate = obj_me:get_power_refix_by_rate()
	local skill_id = obj_me:get_skill_id()
	local impact_data_index = self:get_impact(obj_me, "效果1") or define.INVAILD_ID
    if impact_data_index ~= define.INVAILD_ID then
        impactenginer:send_impact_to_unit(obj_tar,impact_data_index,owner,500,false,refix_by_rate,skill_id)
    end
    impact_data_index = self:get_impact(obj_me, "效果2") or define.INVAILD_ID
    if impact_data_index ~= define.INVAILD_ID then
        impactenginer:send_impact_to_unit(obj_tar,impact_data_index,owner,500,false,refix_by_rate,skill_id)
    end
    impact_data_index = self:get_impact(obj_me, "效果4") or define.INVAILD_ID
    if impact_data_index ~= define.INVAILD_ID then
        impactenginer:send_impact_to_unit(obj_tar,impact_data_index,owner,500,false,refix_by_rate,skill_id)
    end
    local rand = math.random(100)
    local odds = self:impact_activate_odds(obj_me, "效果3几率") or define.INVAILD_ID
    if rand < odds then
        impact_data_index = self:get_impact(obj_me, "效果3") or define.INVAILD_ID
        if impact_data_index ~= define.INVAILD_ID then
			impactenginer:send_impact_to_unit(obj_tar,impact_data_index,owner,500,false,refix_by_rate,skill_id)
        end
    end
    return true
end

function trap:effect_on_trap(obj_me)
end

function trap:on_time_over(obj_me)
    if self:activate_when_fade_out(obj_me) then
        self:activate(obj_me)
    end
end

function trap:activate_when_fade_out(obj_me)
    local data_record = obj_me:get_data_record()
    local trap_used_flag = data_record.trap_used_flag
    return trap_used_flag & trap.MASK_ACTIVATE_WHEN_FADE_OUT == trap.MASK_ACTIVATE_WHEN_FADE_OUT
end

function trap:can_be_character_activate(obj_me)
    local data_record = obj_me:get_data_record()
    local trap_used_flag = data_record.trap_used_flag
    return trap_used_flag & trap.MASK_TRIGGER_BY_CHARACTER == trap.MASK_TRIGGER_BY_CHARACTER
end

function trap:is_scaned_target_vaild()

end

return trap