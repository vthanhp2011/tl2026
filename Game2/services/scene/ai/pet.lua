local skynet = require "skynet"
local class = require "class"
local define = require "define"
local pet_guid = require "pet_guid"
local configenginer = require "configenginer":getinstance()
local actionenginer = require "actionenginer":getinstance()
local skillenginer = require "skillenginer":getinstance()
local ai_character = require "scene.ai.character"
local pet = class("pet", ai_character)
local BODYSTAYTIME = 5000
local REFOLLOW_DISTSQR_A = 9
local REFOLLOW_DISTSQR_B = 64
local REFOLLOW_DISTSQR_C = 225

function pet:init(...)
    self.super.init(self, ...)
    self:reset()
end

function pet:reset()
    self.skill_id = 0
    self.next_skill_id = define.INVAILD_ID
    self.delay_time = define.DELAY_TIME
    self.ai_command = { type = define.E_COMMAND_TYPE.E_COMMAND_TYPE_INVALID }
    self:change_state("idle")
end

function pet:baby_go(pos_tar)
    local character = self:get_character()
    local owner = character:get_owner()
    local dir = owner:get_dir() - define.HALF_PI
    local x = pos_tar.x + (2 * math.sin(dir))
    local y = pos_tar.y + (2 * math.cos(dir))
    local world_pos = { x = x, y = y}
    local can = character:get_scene():is_can_go(character:get_world_pos(), world_pos)
    if can then
        self:move_to_pos(world_pos)
    else
        self:move_to_pos(pos_tar)
    end
end

function pet:baby_to_attack()
    self:change_state("combat")
end

function pet:baby_to_idle()
    self:change_state("idle")
    self:get_character():set_target_id(define.INVAILD_ID)
end

function pet:event_on_die()
    if self:get_character():is_die() then
        self:after_die()
        self.body_timer = BODYSTAYTIME
        self:change_state("dead")
    end
end

function pet:after_die()
    local character = self:get_character()
    local owner = character:get_owner()
    if owner then
        owner:impact_clean_all_impact_when_pet_dead(character:get_obj_id())
        character:impact_clean_all_impact_when_pet_dead(character:get_obj_id())
        character:sendmsg_refresh_attrib()
        owner:clean_up_pet()
        owner:set_current_pet_guid(pet_guid.new())
        owner:send_operate_result_msg(define.OPERATE_RESULT.OR_PET_DIE)
    end
end

function pet:ai_logic_idle(utime)
    local character = self:get_character()
    if character:get_creator() == nil then
    else
        if self.delay_time > 0 then
            self.delay_time = self.delay_time - utime
        else
            if not character:is_moving() then
                self:process_skill_in_cache(false)
            end
            self:change_move_mode()
        end
    end
end

function pet:change_move_mode()
    local character = self:get_character()
    local onwer = character:get_owner()
    local dist_sqr = self:calc_dist_sqrt_of_to_owner()
    if dist_sqr > REFOLLOW_DISTSQR_C then
        if character:can_move() then
            local dir = onwer:get_dir() - define.HALF_PI
            local x = onwer:get_world_pos().x - (-1 * math.sin(dir))
            local y = onwer:get_world_pos().y - (math.cos(dir))
            local pos_tar = { x = x, y = y}
            character:on_teleport(pos_tar)
            character:set_move_mode(define.ENUM_MOVE_MODE.MOVE_MODE_WALK)
            return
        end
    elseif dist_sqr > REFOLLOW_DISTSQR_B then
        character:set_move_mode(define.ENUM_MOVE_MODE.MOVE_MODE_SPRINT)
    elseif dist_sqr > REFOLLOW_DISTSQR_A then
        if character:get_move_mode() ~= define.ENUM_MOVE_MODE.MOVE_MODE_SPRINT then
            character:set_move_mode(define.ENUM_MOVE_MODE.MOVE_MODE_RUN)
        end
    else
        if character:get_move_mode() ~= define.ENUM_MOVE_MODE.MOVE_MODE_WALK then
            character:set_move_mode(define.ENUM_MOVE_MODE.MOVE_MODE_WALK)
        end
    end
    if not character:is_moving() and dist_sqr > 4.1 then
        self:baby_go(onwer:get_world_pos())
    end
end

function pet:calc_dist_sqrt_of_to_owner()
    local character = self:get_character()
    if character then
        local onwer = character:get_owner()
        if onwer then
            local delta_x = onwer:get_world_pos().x - character:get_world_pos().x
            local delta_y = onwer:get_world_pos().y - character:get_world_pos().y
            return delta_x * delta_x + delta_y * delta_y
        end
    end
    return 0
end

function pet:ai_logic_dead(utime)
    if self.body_timer then
        if self.body_timer > 0 then
            self.body_timer = self.body_timer - utime
        else
            self.body_timer = nil
            local character = self:get_character()
            character:get_scene():delete_obj(character)
            character:set_hp(character:get_max_hp())
            character:send_refresh_attrib()
            if self:get_character():is_can_relive() then
                local owner = self:get_character():get_owner()
                if owner then
                    owner:call_up_pet()
                end
            end
        end
    end
end

function pet:ai_logic_combat()
    local character = self:get_character()
    if self:is_combat_over() then
        self:change_state("idle")
        character:set_target_id(define.INVAILD_ID)
        return
    end
    if not character:can_use_skill_now() then
        return
    end
    if character:is_moving() then
        return
    end
    if not self:process_skill_in_cache(true) then
        local obj = character:get_scene():get_obj_by_id(character:get_target_id())
        if obj == nil or not obj:is_alive() then
            self:change_state("idle")
            character:set_target_id(define.INVAILD_ID)
            return
        end
        local pos_tar = obj:get_world_pos()
        self:use_skill(0, character:get_target_id(), pos_tar.x, pos_tar.y)
    end
end

function pet:set_skill_param_in_cache(param)
    self.skill_param_in_cache = param
end

function pet:get_skill_param_in_cache()
    return self.skill_param_in_cache
end

function pet:push_command_use_skill(skill_id,id_tar, x, y, dir, guid_tar)
    local param = {
        skill_id = skill_id,
        id_tar = id_tar,
        pos_tar = { x = x, y = y},
        dir = dir,
        guid_tar = guid_tar
    }
    local character = self:get_character()
    if character:client_can_use_skill(skill_id) then
        self:set_skill_param_in_cache(param)
        return define.OPERATE_RESULT.OR_OK
    else
        local owner = character:get_owner()
        if owner and owner:get_obj_type() == "human" then
            return define.OPERATE_RESULT.OR_WARNING
        end
    end
end

function pet:get_impact_refix_skill_launch_rate(args)
    local character = self:get_character()
    return character:impact_refix_skill_launch_rate(args)
end

function pet:process_skill_in_cache(is_in_attack_state)
    local character = self:get_character()
    if not character:can_use_skill_now() then
        return false
    end
    local owner = character:get_owner()
    if owner == nil then
        return false
    end
    local skill_param = self:get_skill_param_in_cache()
    if skill_param then
        local ret = self:use_skill(skill_param.skill_id, skill_param.id_tar, skill_param.pos_tar.x, skill_param.pos_tar.y, skill_param.guid_tar)
        self:set_skill_param_in_cache(nil)
        if ret < 0 then
            owner:send_operate_result_msg(ret)
        end
        return true
    end
    local skill_cache = character:get_skill_cache()
    for i = #skill_cache, 1, -1 do
        local cache = skill_cache[i]
        local cool_down = character:is_skill_cool_down(cache)
        if cool_down then
            local template = skillenginer:get_skill_template(cache)
            if template == nil then
                return false
            end
            local operate_mode = template.operate_mode
            local type_of_skill = template.type_of_skill
            if is_in_attack_state then
                local rate = template.pet_rate_of_skill
                rate = rate == -1 and 100 or rate
                local pet_ai_stratety_table = configenginer:get_config("pet_ai_stratety_table")
                local ai_type = character:get_ai_type()
                if type_of_skill == define.INVAILD_ID then
                    type_of_skill = 1
                end
                print("type_of_skill =", type_of_skill, ";ai_type =", ai_type)
                local launch_rate = pet_ai_stratety_table[type_of_skill][ai_type]
                local luanch_rate_refix_args = { id = cache, value = launch_rate}
                self:get_impact_refix_skill_launch_rate(luanch_rate_refix_args)
                local use_skill_rate = rate * luanch_rate_refix_args.value
                if math.random(100) < use_skill_rate then
                    if define.PET_SKILL_OPERATEMODE.PET_SKILL_OPERATE_AISTRATEGY == operate_mode and (define.PET_TYPE_AISKILL.PET_TYPE_AISKILL_PHYSICATTACK == type_of_skill or define.PET_TYPE_AISKILL.PET_TYPE_AISKILL_MAGICATTACK == type_of_skill) then
                        local obj_tar = character:get_scene():get_obj_by_id(character:get_target_id())
                        if obj_tar == nil or not obj_tar:is_alive() then
                            character:set_target_id(define.INVAILD_ID)
                            return false
                        end
                        local pos_tar = obj_tar:get_world_pos()
                        local result = self:use_skill(cache, obj_tar:get_obj_id(), pos_tar.x, pos_tar.y)
                        if result == define.OPERATE_RESULT.OR_OK then
                            return true
                        end
                    end
                end
            end
            --print("operate_mode =", operate_mode)
            if define.PET_SKILL_OPERATEMODE.PET_SKILL_OPERATE_INCEACEATTR == operate_mode then
                local pos_tar = character:get_world_pos()
                local result = self:use_skill(cache, character:get_obj_id(), pos_tar.x, pos_tar.y)
                if result == define.OPERATE_RESULT.OR_OK then
                    table.remove(skill_cache, i)
                    return true
                end
            end
            if define.PET_SKILL_OPERATEMODE.PET_SKILL_OPERATE_AISTRATEGY == operate_mode then
                if define.PET_TYPE_AISKILL.PET_TYPE_AISKILL_PROTECTEOWNER == type_of_skill then
                    local have_impact = owner:impact_have_impact_of_specific_impact_id(template.impact_id_of_skill)
                    if not have_impact then
                        local pos_tar = owner:get_world_pos()
                        local result = self:use_skill(cache, pos_tar.x, pos_tar.y)
                        if define.OPERATE_RESULT.OR_OK == result then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

function pet:is_combat_over()
    local character = self:get_character()
    local creator = character:get_creator()
    if creator == nil then
        return true
    end
    if creator:get_attrib("stealth_level") > 0 then
        return true
    end
    local target_id = character:get_target_id()
    if target_id ~= define.INVAILD_ID then
        local obj = character:get_scene():get_obj_by_id(target_id)
        if obj and obj:is_character_obj() and not obj:is_friend() then
            if not obj:is_can_view(creator) then
                return true
            end
            local dist_x = obj:get_world_pos().x - character:get_world_pos().x
            local dist_y = obj:get_world_pos().y - character:get_world_pos().y
            local dist_sq = dist_x * dist_x + dist_y * dist_y
            if dist_sq > define.REFOLLOW_DISTSQR_C then
                return true
            end
        end
    end
    return false
end

function pet:on_relive_info_changed()
    if self:get_character():is_can_relive() then
    end
end

function pet:relive(is_skill_relive)
    local relive_info = self:get_character():get_relive_info(is_skill_relive)
    if relive_info then
        if relive_info.hp_recover_rate then
            local hp = math.floor(self:get_character():get_max_hp() * relive_info.hp_recover_rate)
            self:get_character():set_hp(hp)
        end
    end
    if self:get_character():get_hp() <= 0 then
        self:get_character():set_hp(1)
    end
    self:get_character():clear_skill_relive_info()
    self:change_state("idle")
end

return pet