local class = require "class"
local define = require "define"
local pet_guid = require "pet_guid"
local targeting_and_depleting_params = class("targeting_and_depleting_params")

function targeting_and_depleting_params:ctor()
    self:reset()
    self.target_position = {x = -1, y = -1}
end
function targeting_and_depleting_params:reset()
    self.delay_time = 0
    self.error_code = 0
    self.errparam = 0
    self.ignore_condition_check_flag = false
    self.target_count = 0
    self.active_time = 0
    self.target_obj_id = define.INVAILD_ID
    self.skill_id = define.INVAILD_ID
    self.skill_level = 1
    self.target_dir = -1
    self.target_guid = define.INVAILD_ID
    self.depleted_strike_point = 1
    self.target_bag_index = define.INVAILD_ID
    self.deplted_item_guid = nil
    self.activated_skill = define.INVAILD_ID
    self.activated_script = define.INVAILD_ID
    self.script_arg_1 = define.INVAILD_ID
    self.script_arg_2 = define.INVAILD_ID
	
    self.bag_index_of_deplted_item = define.INVAILD_ID
    self.item_index_of_deplted_item = define.INVAILD_ID
    self.bag_index_of_deplted_item_uicall = define.INVAILD_ID
    self.item_index_of_deplted_item_uicall = define.INVAILD_ID
	
    self.target_pet_guid = pet_guid.new()
	self.talent_id = {}
end

function targeting_and_depleting_params:set_item_index_of_deplted_item(index)
    self.item_index_of_deplted_item = index
end

function targeting_and_depleting_params:get_item_index_of_deplted_item()
    return self.item_index_of_deplted_item
end

function targeting_and_depleting_params:set_item_index_of_deplted_item_uicall(index)
    self.item_index_of_deplted_item_uicall = index
end

function targeting_and_depleting_params:get_item_index_of_deplted_item_uicall()
    return self.item_index_of_deplted_item_uicall
end

function targeting_and_depleting_params:set_bag_index_of_deplted_item(index)
    self.bag_index_of_deplted_item = index
end

function targeting_and_depleting_params:get_bag_index_of_deplted_item()
    return self.bag_index_of_deplted_item
end

function targeting_and_depleting_params:set_bag_index_of_deplted_item_uicall(index)
    self.bag_index_of_deplted_item_uicall = index
end

function targeting_and_depleting_params:get_bag_index_of_deplted_item_uicall()
    return self.bag_index_of_deplted_item_uicall
end


function targeting_and_depleting_params:set_errcode(code)
    self.error_code = code
end

function targeting_and_depleting_params:set_errparam(errparam)
    self.errparam = errparam
end

function targeting_and_depleting_params:set_ignore_condition_check_flag(flag)
    self.ignore_condition_check_flag = flag
end

function targeting_and_depleting_params:get_ignore_condition_check_flag()
    return self.ignore_condition_check_flag
end

function targeting_and_depleting_params:set_delay_time(time)
    self.delay_time = time
end

function targeting_and_depleting_params:get_delay_time()
    return self.delay_time
end

function targeting_and_depleting_params:set_target_count(count)
    self.target_count = count
end

function targeting_and_depleting_params:get_target_count()
    return self.target_count or 0
end

function targeting_and_depleting_params:get_target_position()
    return self.target_position
end

function targeting_and_depleting_params:get_target_obj()
    return self.target_obj_id
end

function targeting_and_depleting_params:get_activated_skill()
    return self.skill_id
end

function targeting_and_depleting_params:set_activated_skill(skill_id)
    self.skill_id = skill_id
end

function targeting_and_depleting_params:set_skill_level(level)
    self.skill_level = level
end

function targeting_and_depleting_params:get_skill_level()
    return self.skill_level
end

function targeting_and_depleting_params:set_target_obj(obj_id)
    self.target_obj_id = obj_id
end

function targeting_and_depleting_params:set_target_position(pos_tar)
    if pos_tar.x ~= 0 and pos_tar.y ~= 0 then
        self.target_position = {}
        self.target_position.x = pos_tar.x
        self.target_position.y = pos_tar.y
    end
end

function targeting_and_depleting_params:set_target_dir(dir)
    self.target_dir = dir
end

function targeting_and_depleting_params:get_target_dir()
    return self.target_dir
end

function targeting_and_depleting_params:set_target_guid(guid)
    self.target_guid = guid
end

function targeting_and_depleting_params:get_errorcode()
    return self.error_code
end

function targeting_and_depleting_params:get_depleted_strike_point()
    return self.depleted_strike_point
end

function targeting_and_depleting_params:set_target_bag_index(index)
    self.target_bag_index = index
end

function targeting_and_depleting_params:get_target_bag_index()
    return self.target_bag_index
end

function targeting_and_depleting_params:set_target_pet_guid(guid)
    self.target_pet_guid = guid
end

function targeting_and_depleting_params:get_target_pet_guid()
    return self.target_pet_guid
end

function targeting_and_depleting_params:set_deplted_item_guid(guid)
    self.deplted_item_guid = guid
end

function targeting_and_depleting_params:get_deplted_item_guid()
    return self.deplted_item_guid
end



function targeting_and_depleting_params:set_activated_script(script)
    self.activated_script = script
end

function targeting_and_depleting_params:get_activated_script()
    return self.activated_script
end

function targeting_and_depleting_params:set_activated_skill(skill)
    self.activated_skill = skill
end

function targeting_and_depleting_params:get_activated_skill()
    return self.activated_skill
end

function targeting_and_depleting_params:set_script_arg_1(arg1)
    self.script_arg_1 = arg1
end

function targeting_and_depleting_params:get_script_arg_1()
    return self.script_arg_1
end

function targeting_and_depleting_params:set_script_arg_2(arg2)
    self.script_arg_2 = arg2
end

function targeting_and_depleting_params:get_script_arg_2()
    return self.script_arg_2
end

function targeting_and_depleting_params:set_script_arg_3(arg3)
    self.script_arg_3 = arg3
end

function targeting_and_depleting_params:get_script_arg_3()
    return self.script_arg_3
end

function targeting_and_depleting_params:set_deplete_rage(rage)
    self.deplete_rage = rage
end

function targeting_and_depleting_params:set_deplete_strike_point(point)
    self.depleted_strike_point = point
end

function targeting_and_depleting_params:set_active_time(active_time)
    self.active_time = active_time
end

function targeting_and_depleting_params:get_active_time()
    return self.active_time
end

function targeting_and_depleting_params:get_talent_id(id)
    return self.talent_id[id]
end

function targeting_and_depleting_params:set_talent_id(id)
    self.talent_id[id] = true
end

return targeting_and_depleting_params