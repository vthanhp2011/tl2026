local class = require "class"
local define = require "define"
local skynet = require "skynet"
local packet_def = require "game.packet"
local impactenginer = require "impactenginer":getinstance()
local configenginer = require "configenginer":getinstance()
local skillenginer = require "skillenginer":getinstance()
local actionenginer = require "actionenginer":getinstance()
local item_container = require "item_container"
local ai_pet = require "scene.ai.pet"
local character = require "scene.obj.character"
local pet_db_attr = require "db.pet_attrib"
local db_impact = require "db.impact_data"
local pet = class("pet", character)

function pet:ctor(data)
    self.skill_list = data.skill_list
    self.titles = data.titles or {}
    self.skill_cache = {}
    self.owner_obj_id = data.owner_obj_id
    self.db = data.db
    self.db:set_pet(self)
    self.equip_container = data.equip_container
    self.ai = ai_pet.new()
    self.ai:init(self)
    self.send_all = true
	self.die_timer = nil
    if self.owner_obj_id == nil or self.owner_obj_id == define.INVAILD_ID then
        self.captures = setmetatable({}, {__mode = "kv"})
    end
    self:item_flush()
    for _, skill in ipairs(self.skill_list.positive) do
        self:push_skill_to_cache(skill)
    end
    self:auto_use_pet_soul_skill()
end

function pet:do_move(handle, pos_tar)
    -- skynet.logi("pet:do_move ", handle)
    local stop_move = false
    local stop_logic_count = self:get_logic_count()
    if not self:is_character_logic_stopped() then
        if self:get_character_logic() ~= define.ENUM_CHARACTER_LOGIC.CHARACTER_LOGIC_MOVE then
            self:stop_character_logic(true)
        else
            stop_move = true
            self:stop_character_logic(false)
        end
    end
    if self:get_speed() < 0.1 then
        -- skynet.logi("name =", self:get_name(), "speed less than 0.1 can not move")
        return define.OPERATE_RESULT.OR_LIMIT_MOVE
    end
    if self:is_limit_move() then
        return define.OPERATE_RESULT.OR_LIMIT_MOVE
    end
    if not self:is_alive() then
        return define.OPERATE_RESULT.OR_DIE
    end
    if handle ~= -1 then
        self:set_logic_count(handle)
    else
        self:add_logic_count()
    end
    local actionenginer = require "actionenginer":getinstance()
    actionenginer:interrupt_current_action(self)
    self.move = {}
    self.move.targetPos = pos_tar
    self.move.handle = self:get_logic_count()
    self:set_character_logic(define.ENUM_CHARACTER_LOGIC.CHARACTER_LOGIC_MOVE)
    local msg = packet_def.GCCharMove.new()
    msg.m_objID = self:get_obj_id()
    msg.start_time = skynet.now() * 10
    msg.handleID = self:get_logic_count()
    msg.size = #(pos_tar)
    msg.path = pos_tar
    if stop_move then
        msg.flag = msg.flag | 0x4
        msg.stop_pos = self:get_world_pos()
        msg.stop_logic_count = stop_logic_count
    else
        msg.flag = msg.flag & ~0x4
    end
    self:get_scene():broadcast(self, msg, false)
    self:impact_on_move()
    return define.OPERATE_RESULT.OR_OK
end

function pet:on_impact_get_combat_result(imp, combat_core, defencer)
    self:impact_on_impact_get_combat_result(imp, combat_core, defencer)
end

function pet:impact_on_impact_get_combat_result(imp, combat_core, defencer)
    local list = self:get_impact_list()
    for _, current in ipairs(list) do
        local logic = impactenginer:get_logic(current)
        if logic then
            logic:on_impact_get_combat_result(current, imp, combat_core, self, defencer)
        end
    end
end


function pet:get_obj_type()
    return "pet"
end

function pet:set_die_time(timer)
    self.die_timer = timer
end

function pet:update(...)
    self:send_refresh_attrib()
    self:update_protect_occpaint(...)
    self.super.update(self, ...)
	local delta_time = ...
	if self.die_timer then
		if self.die_timer > delta_time then
			self.die_timer = self.die_timer - delta_time
		else
			self.die_timer = nil
			self:get_scene():delete_temp_monster(self)
		end
	end
end

function pet:set_cool_down(id, cool_down_time)
    self.super.set_cool_down(self, id, cool_down_time)
    local owner = self:get_owner()
    if owner then
        local pet_guid = self:get_guid()
        local msg = packet_def.GCCooldownUpdate.new()
        msg.m_nNumCooldown = 1
        msg.m_aCooldowns = {}
        msg.m_uHighSection = pet_guid.m_uHighSection
        msg.m_uLowSection = pet_guid.m_uLowSection
        msg.m_aCooldowns[1] = { m_nID = tonumber(id), m_nCooldown = cool_down_time, m_nCooldownElapsed = 0}
        self:get_scene():send2client(owner, msg)
    end
end
-- function pet:send_cool_down_time()
    -- local cool_down_times = self.cool_down_times or {}
    -- local cool_down_times_array = {}
    -- for id, time in pairs(cool_down_times) do
        -- table.insert(cool_down_times_array, { m_nID = tonumber(id), m_nCooldown = time, m_nCooldownElapsed = 0})
    -- end
	-- local pet_guid = self:get_guid()
    -- local msg = packet_def.GCCooldownUpdate.new()
	-- msg.m_uHighSection = pet_guid.m_uHighSection
	-- msg.m_uLowSection = pet_guid.m_uLowSection
    -- msg.m_nNumCooldown = #cool_down_times_array
    -- msg.m_aCooldowns = cool_down_times_array
    -- self:get_scene():send2client(self, msg)
-- end

function pet:rage_increment()

end

function pet:send_refresh_attrib(send_all, type)
    self.db:send_refresh_attrib(self:get_owner(), send_all or self.send_all, self.skill_list, type)
    self.send_all = false
end

function pet:other_ask_info(who)
    self.db:send_refresh_attrib(who, true, self.skill_list, 5)
end

function pet:get_attrib(attr)
    return self.db:get_attrib(attr)
end

function pet:get_model()
    return self.db:get_attrib("data_id")
end

function pet:get_name()
    return self.db:get_attrib("name")
end

function pet:get_take_level()
    return self.db:get_attrib("take_level")
end

function pet:get_wuxing()
    return self.db:get_attrib("wuxing")
end

function pet:sendmsg_refresh_attrib()

end

function pet:get_speed()
    return self.db:get_attrib("speed")
end

function pet:get_ai_type()
    return self.db:get_attrib("ai_type")
end

function pet:get_stealth_level()
    return self.db:get_attrib("stealth_level")
end

function pet:get_titles()
    return self.titles
end

function pet:get_occupant_guid()
    return 0
end

function pet:is_npc()
    return false
end

function pet:is_enemy(other)
    if self:get_obj_id() == other:get_obj_id() then
        return false
    end
    local owner = self:get_owner()
    if owner then
        if owner:get_obj_id() == other:get_obj_id() then
            return false
        end
        return owner:is_enemy(other)
    else
        return self:is_enemy_camp(other)
    end
end

function pet:get_owner_obj_id()
    return self.owner_obj_id
end

function pet:get_owner()
    local id = self:get_owner_obj_id()
    return self:get_scene():get_obj_by_id(id)
end

function pet:get_creator()
    return self:get_owner()
end

function pet:get_my_master()
    return self:get_owner()
end

function pet:create_new_obj_packet()
    local msg = packet_def.GCNewPet.new()
    msg.m_objID = self:get_obj_id()
    msg.speed = self:get_speed()
    msg.world_pos = table.clone(self:get_world_pos())
    return msg
end

function pet:get_world_pos()
    return self.db:get_attrib("world_pos")
end

function pet:get_skill_cache()
    return self.skill_cache
end

function pet:push_skill_to_cache(skill)
    table.insert(self.skill_cache, skill)
end

function pet:mark_all_attr_dirty()
    self.db:mark_all_attr_dirty()
end

function pet:mark_attrib_refix_dirty(attr)
    self.db:mark_attrib_refix_dirty(attr)
end

function pet:get_exp()
    return self:get_attrib("exp")
end

function pet:set_move_mode(move_mode)
    self.db:set_db_attrib({move_mode = move_mode})
end

function pet:get_move_mode()
    return self:get_attrib("move_mode")
end

function pet:set_exp(exp)
    self.db:set_db_attrib({exp = exp})
end

function pet:set_happiness(happiness)
    self.db:set_db_attrib({ happiness = happiness })
end

function pet:on_be_skill(sender, skill_id, behaviortype)
    character.on_be_skill(self, sender, skill_id, behaviortype)
    if behaviortype ~= define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_HOSTILITY then
        return
    end
    local owner = self:get_owner()
    if owner then
        owner:on_be_hostility_skill(sender, skill_id, behaviortype)
    end
end

function pet:on_damages(damages, caster_obj_id, is_critical, skill_id, imp)
    local scene = self:get_scene()
    local sender = scene:get_obj_by_id(caster_obj_id)
    if sender and sender:is_character_obj() then
        sender:on_damage_target(self, damages, skill_id)
    end
    self:impact_on_damages(damages, caster_obj_id, is_critical, skill_id, imp)
	if damages.flag_immu then
		self:show_skill_missed(self:get_obj_id(),caster_obj_id,skill_id,self:get_logic_count(),define.MISS_FLAG.FLAG_IMMU)
		return
	elseif damages.imm_dmg_rate and damages.imm_dmg_rate >= 100 then
		self:show_skill_missed(self:get_obj_id(),caster_obj_id,skill_id,self:get_logic_count(),define.MISS_FLAG.FLAG_IMMU)
		return
	end
    self.super.on_damages(self, damages, caster_obj_id, is_critical,skill_id,imp)
end

function pet:add_exp(add)
    local level = self:get_level()
    if level == define.PET_LEVEL_NUM then
        return
    end
	local human_level
    local owner = self:get_owner()
    if owner then
		human_level = owner:get_level()
		if human_level < self:get_take_level() then
            owner:notify_tips("#{QXHB_20210701_278}")
            return
		end
        -- if not owner:can_take(self) then
            -- owner:notify_tips("宠物等级已超过玩家等级5级，无法获取经验")
            -- return
        -- end
	else
		return
    end
	local wuxing = self:get_wuxing()
    local extra_take_level = math.ceil(wuxing / 2) + 5
	human_level = human_level + extra_take_level
	if human_level <= level then
		local msg = string.format("珍兽等级高于主人%d级，无法获取经验。",extra_take_level)
		owner:notify_tips(msg)
		return
	end
	
	
    local cur_exp = self:get_exp()
    cur_exp = cur_exp + add
    local pet_level_up_table = configenginer:get_config("pet_level_up_table")
    local need_exp = pet_level_up_table[level]
    while cur_exp >= need_exp do
        self:level_up()
        cur_exp = cur_exp - need_exp
        need_exp = pet_level_up_table[self:get_level()]
		level = self:get_level()
        if level == define.PET_LEVEL_NUM then
            cur_exp = 0
            break
		elseif level >= human_level then
            cur_exp = 0
            break
        end
        -- if not owner:can_take(self) then
            -- break
        -- end
    end
    self:set_exp(cur_exp)
end

function pet:set_used_procreate_count(count)
    self.db:set_db_attrib({ used_procreate_count = count })
end

function pet:get_used_procreate_count()
    return self:get_attrib("used_procreate_count")
end

function pet:get_remain_procreate_count()
    local used_procreate_count = self:get_used_procreate_count()
    local level = self:get_level()
    local count = 0
    for _, target_level in ipairs(define.ProCreateTargetLevel) do
        if level >= target_level then
            count = count + 1
        end
    end
    local remain_count = (count - used_procreate_count)
    return remain_count >= 0 and remain_count or 0
end

function pet:level_up()
    local owner = self:get_owner()
    if owner == nil then
        return
    end
    local level = self:get_level()
    if level == define.PET_LEVEL_NUM then
        return
    end
    level = level + 1
    self:set_level(level)
    local lv1_attribs = self.db:get_lv1_attrib()
    self.db:set_lv1_attrib( { str = lv1_attribs.str + 1} )
    self.db:set_lv1_attrib( { spr = lv1_attribs.spr + 1} )
    self.db:set_lv1_attrib( { con = lv1_attribs.con + 1} )
    self.db:set_lv1_attrib( { int = lv1_attribs.int + 1} )
    self.db:set_lv1_attrib( { dex = lv1_attribs.dex + 1} )
    self.db:set_lv1_attrib( { point_remain = lv1_attribs.point_remain + 5} )

    self:set_hp(self:get_max_hp())
    self:set_happiness(100)

    self:skill_apperceive()

    local msg = packet_def.GCLevelUp.new()
    msg.m_objID = self:get_obj_id()
    msg.level = level
    self:get_scene():broadcast(self, msg, true)
end

function pet:skill_apperceive()
    local skill_count = self:get_skill_max_control_by_ai() + self:get_skill_max_control_by_player()
    local learned_voluntary_skill_count = self:skill_get_count_control_by_player()
    local learned_passive_skill_count = self:skill_get_count_control_by_ai()
    local pet_apperceive_skill_table = configenginer:get_config("pet_apperceive_skill_table")
    local pet_attr_table = configenginer:get_config("pet_attr_table")
    pet_attr_table = pet_attr_table[self:get_model()]
    for i = 0, define.PET_APPERCEIVESKILLRATE_NUM do
        local t = pet_apperceive_skill_table[i]
        if skill_count == t.skill_count and learned_passive_skill_count == t.passive_skill_count and learned_voluntary_skill_count == t.voluntary_skill_count then
            local voluntary_rate = t.voluntary_rate
            local passive_rate = t.passive_rate + voluntary_rate
            local num = math.random(100)
            num = num * 100
            -- skynet.logi("num =", num, ";voluntary_rate =", voluntary_rate, ";passive_rate =", passive_rate)
            if num < voluntary_rate then
                for i = 1, 2 do
                    local skill = pet_attr_table.skill.activate[i].id
                    -- skynet.logi("skill =", skill)
                    if skill and skill ~= define.INVAILD_ID and not self:have_this_group_skill(skill) then
                        return self:skill_modify_skill_realize(skill)
                    end
                end
            elseif num < passive_rate then
                for i = 1, 10 do
                    local skill = pet_attr_table.skill.positive[i].id
                    -- skynet.logi("skill =", skill)
                    if skill and skill ~= define.INVAILD_ID and not self:have_this_group_skill(skill) then
                        return self:skill_modify_skill_realize(skill)
                    end
                end
            end
        end
    end
end

function pet:skill_get_count_control_by_player()
    return #(self.skill_list.activate)
end

function pet:skill_get_count_control_by_ai()
    return #(self.skill_list.positive)
end

function pet:have_this_group_skill(skill)
    local template = skillenginer:get_skill_template(skill)
    for _, sk in ipairs(self.skill_list.activate) do
        local sk_template = skillenginer:get_skill_template(sk)
        if sk_template.group_id == template.group_id then
            return true
        end
    end
    for _, sk in ipairs(self.skill_list.positive) do
        local sk_template = skillenginer:get_skill_template(sk)
        if sk_template.group_id == template.group_id then
            return true
        end
    end
    return false
end

function pet:skill_have_skill(skill)
    for _, sk in ipairs(self.skill_list.activate) do
        if sk == skill then
            return true
        end
    end
    for _, sk in ipairs(self.skill_list.positive) do
        if sk == skill then
            return true
        end
    end
    return false
end

function pet:skill_modify_skill_realize(skill)
    local template = skillenginer:get_skill_template(skill)
    if template == nil then
        return false
    end
    if self:skill_have_skill(skill) then
        return false
    end
    local operate_mode = template.operate_mode
    if operate_mode == define.PET_SKILL_OPERATEMODE.PET_SKILL_OPERATE_NEEDOWNER then
        return self:register_skill(skill, self.skill_list.activate, 2)
    else
        return self:register_skill(skill, self.skill_list.positive, 5)
    end
end

function pet:register_skill(skill, skills, max)
    -- skynet.logi("pet_register_skill", skill)
    self.db:mark_skill_dirty()
    local template = skillenginer:get_skill_template(skill)
    for i, sk in ipairs(skills) do
        local sk_template = skillenginer:get_skill_template(sk)
        if sk_template.group_id == template.group_id then
            skills[i] = skill
            return true
        end
    end
    if #skills >= max then
        return false
    end
    table.insert(skills, skill)
    return true
end

function pet:get_skill_max_control_by_ai()
    return 10
end

function pet:get_skill_max_control_by_player()
    return 2
end

function pet:get_equip_container()
    return self.equip_container
end

function pet:get_equips()
    return self.equip_container:copy_raw_data()
end

function pet:get_total_skills_list()
    local total = table.clone(self.skill_list.positive)
    local pet_soul_skill = self.db:get_pet_soul_skill()
    table.insert(total, pet_soul_skill)
    return total
end

function pet:get_can_client_use_skill()
    local total = table.clone(self.skill_list.activate)
    local pet_soul_skill = self.db:get_pet_soul_skill()
    table.insert(total, pet_soul_skill)
    return total
end

function pet:have_skill(skill)
    local skills = self:get_total_skills_list()
    for _, id in ipairs(skills) do
        if id == skill then
            return true
        end
    end
    return false
end

function pet:client_can_use_skill(skill)
    local skills = self:get_can_client_use_skill()
    for _, id in ipairs(skills) do
        if id == skill then
            return true
        end
    end
    return false
end

function pet:auto_use_pet_soul_skill()
    local pet_soul_skill = self.db:get_pet_soul_skill()
    if pet_soul_skill ~= define.INVAILD_ID then
        local template = skillenginer:get_skill_template(pet_soul_skill)
        if template.operate_mode == define.PET_SKILL_OPERATEMODE.PET_SKILL_OPERATE_AISTRATEGY then
            local pos_tar = self:get_world_pos()
            local oresult = self:get_ai():use_skill(pet_soul_skill, self:get_obj_id(), pos_tar.x, pos_tar.y)
            -- if oresult ~= 0 then
				-- if pet_soul_skill >= 3481 and pet_soul_skill <= 3486 then
					-- local cool_down_time = self:get_cool_down(165)
					-- if cool_down_time < 0 then
						-- cool_down_time = 0
					-- end
					-- self:set_cool_down(165,cool_down_time)
				-- end
			-- end
			-- skynet.logi("auto_use_pet_soul_skill skill =", pet_soul_skill, ";oresult =", oresult)
        end
    end
end

function pet:item_flush()
    self.db:item_effect_flush()
    self.db:item_std_impact_effect()
end

function pet:set_capture_protect(occupantguid)
    self.protect_capture_protect_guid = occupantguid
    self.protect_capture_protect_remain_time = 300 * 1000
end

function pet:update_protect_occpaint(delta_time)
    if self.protect_capture_protect_remain_time then
        if self.protect_capture_protect_remain_time > 0 then
            self.protect_capture_protect_remain_time = self.protect_capture_protect_remain_time - delta_time
            if self.protect_capture_protect_remain_time <= 0 then
                self.protect_capture_protect_guid = define.INVAILD_ID
            end
        end
    end
end

function pet:add_capturer(capturer)
    self.captures[capturer] = true
end

function pet:del_capturer(capturer)
    self.captures[capturer] = nil
end

function pet:send_capture_failed_to_others(capturer)
    local msg = packet_def.GCManipulatePetRet.new()
    msg.guid = self:get_guid()
    msg.ret = define.ENUM_MANIPULATEPET_RET.MANIPULATEPET_RET_CAPTUREFALID
    for obj in pairs(self.captures) do
        if obj ~= capturer then
            actionenginer:interrupt_current_action(obj)
            obj:get_ai():stop()
            obj:get_scene():send2client(obj, msg)
        end
    end
end

function pet:set_detail(detail)
    self.detail = detail
end

function pet:get_detail()
    return self.detail
end

function pet:get_pet()
    return self
end

function pet:get_team_id()
    if self.owner == nil then
        return define.INVAILD_ID
    end
    return self.owner:get_team_id()
end

function pet:get_dw_jinjie_effect_details(id)
    return 0
end
function pet:get_attack_traits_type() return 10 end

return pet
