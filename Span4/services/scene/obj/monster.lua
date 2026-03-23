local skynet = require "skynet"
local class = require "class"
local define = require "define"
local packet_def = require "game.packet"
local configenginer = require "configenginer":getinstance()
local ai_monster = require "scene.ai.monster"
local character = require "scene.obj.character"
local monster_db_attr = require "db.monster_attrib"
local db_impact = require "db.impact_data"
local monster = class("monster", character)

function monster:ctor(data)
	self.dataid = data.dataid
    self.patrol_id = data.patrol_id or define.INVAILD_ID
    self.script_id = data.script_id
    self.ai_script = data.ai_script
    self.respawn_time = data.respawn_time
    self.group_id = data.group_id
    self.active_time = data.active_time
    self.fight_with_npc_flag = 0
    self.script_timer = nil
	self.interaction_type = data.interaction_type or 0
	self.need_skill = data.need_skill or -1
	self.scene_params = {}
	self.update_top_timer = 1000
	self.die_timer = nil
	self.is_top_monster = nil
	self.is_unconstrained_monster = nil
    self.owners = setmetatable({}, {__mode = "kv"})
    self.db = monster_db_attr.new(self, data.db_attribs)
    self.impacts = db_impact.new()
    self.impacts:set_obj(self)
    self:reset()
	-- if self.dataid == 11392 then
		-- skynet.logi("霜影创建:",os.time(),"stack =",debug.traceback())
	-- end
end

function monster:init()
    self.super.init(self)
    self.ai:on_init()
end

function monster:set_die_time(timer)
    self.die_timer = timer
end

function monster:set_top_monster()
    self.is_top_monster = true
end

function monster:empty_top_monster()
    self.is_top_monster = nil
end

function monster:update(...)
	local scene = self:get_scene()
    local sceneid = scene:get_id()
    if define.MAIN_CITY[sceneid] then
        if not self.is_unconstrained_monster and not self:is_patrol_monster() then
            return
        end
    end
    self.ai:call_ai_script("OnHeartBeat", self:get_obj_id(), ...)
    self:check_script_timer(...)
    self.super.update(self, ...)
	local delta_time = ...
	if self.is_top_monster then
		if self.update_top_timer <= delta_time then
			self.update_top_timer = self.update_top_timer + 1000
			scene:set_dmg_top_list(self:get_obj_id(),self:get_damage_member())
		else
			self.update_top_timer = self.update_top_timer - delta_time
		end
	end
	if self.die_timer then
		if self.die_timer > delta_time then
			self.die_timer = self.die_timer - delta_time
		else
			self.die_timer = nil
			scene:delete_temp_monster(self)
		end
	end
end

function monster:check_script_timer(delta_time)
    if self.script_timer then
        self.script_timer_step = self.script_timer_step or 0 + delta_time
        if self.script_timer_step >= self.script_timer then
            self.script_timer_step = 0
            self.ai:call_ai_script("OnCharacterTimer", self:get_obj_id(), self:get_model(), self.script_timer)
        end
    end
end

function monster:get_aoi_mode()
    local id = self:get_scene():get_id()
    if define.MAIN_CITY[id] then
        return "m"
    else
        return "wm"
    end
end

function monster:get_group_id()
    return self.group_id
end

function monster:get_active_time()
    return self.active_time
end

function monster:send_refresh_attrib()
    self.db:send_refresh_attrib()
end

function monster:reset()
    self:set_attrib({occupant_guid = define.INVAILD_ID, team_occipant_guid = define.INVAILD_ID,raid_occipant_guid = define.INVAILD_ID})
    self.damage_member_list = {}
    self.misions_toggle = {}
    local config_info = configenginer:get_config("config_info")
    self.position_range = config_info.Monster.DefaultPositionRange
    self.respawn_pos = table.clone(self:get_world_pos())
    self.owner_drop_item_list = setmetatable({}, { __mode = "kv" })
    self.owners = setmetatable({}, {__mode = "kv"})
    self:set_hp(self:get_max_hp())
    self.ai = ai_monster.new()
    self.ai:init(self)
end

function monster:on_obj_enter_view(obj)
    self.super.on_obj_enter_view(self, obj)
end

function monster:set_attrib(...)
    self.db:set_attrib(...)
end

function monster:get_impact_list()
    return self.impacts:get_list()
end

function monster:get_detail_attribs()
    return self.db:get_detail_attribs()
end

function monster:get_name()
    return self.db:get_attrib("name")
end

function monster:get_model()
    return self.db:get_attrib("model")
end

function monster:get_script_id()
    return self.script_id
end

function monster:get_respawn_pos()
    return self.respawn_pos
end

function monster:get_pos_range()
    return self.position_range
end

function monster:get_obj_type()
     return "monster"
end

function monster:get_stealth_level()
    return self.db:get_attrib("stealth_level")
end

function monster:get_speed()
    return self.db:get_attrib("speed")
end

function monster:get_base_ai()
    return self.db:get_attrib("base_ai")
end

function monster:get_ai_script()
    return self.ai_script
end

function monster:get_attack_traits_type() return 10 end

function monster:get_attack_anim_time()
    return self.db:get_attrib("attack_anim_time")
end

function monster:get_base_exp()
    return self.db:get_attrib("base_exp")
end

function monster:set_group_id(id)
    self.group_id = id
end

function monster:get_group_id()
    return self.group_id
end

function monster:set_fight_with_npc_flag(flag)
    self.fight_with_npc_flag = flag
end

function monster:set_ai_type(ai_type)
    self.db:set_attrib({ base_ai = ai_type})
end

function monster:set_ai_script(ai_script)
    self.ai_script = ai_script
end

function monster:get_fight_with_npc_flag()
    return self.fight_with_npc_flag
end

function monster:set_script_timer(delta_time)
	if delta_time and delta_time > 0 then 
		self.script_timer = delta_time
	else
		self.script_timer = nil
	end
end

function monster:default_event(who)
    self:get_script_enginer():call(self:get_script_id(), "OnDefaultEvent", who,
                                   self:get_obj_id())
end

function monster:event_request(who, ...)
    self:get_script_enginer():call(self:get_script_id(), "OnEventRequest", who,
                                   self:get_obj_id(), ...)
end

function monster:get_ai_type() return self.db:get_attrib("ai_type") end

function monster:is_npc()
    return self.db:get_attrib("is_npc")
end

function monster:is_enemy(other)
    if self:get_obj_id() == other:get_obj_id() then
        return false
    end
    if self:get_reputation() == 0 then
        return false
    end
    if other:get_reputation() == self:get_reputation() then
        return false
    end
    if other:get_obj_type() == "monster" then
        if self:get_fight_with_npc_flag() == 0 then
            return false
        end
    end
    if other:get_obj_type() == "pet" then
        local owner = other:get_owner()
        if owner and owner:get_obj_id() == self:get_obj_id() then
            return false
        end
        if owner == nil then
            return false
        end
        return self:is_enemy(owner)
    end
    return self:is_enemy_camp(other)
end

function monster:on_die(...)
    -- print("monster name =", self:get_name(), "on die")
	if self.is_top_monster then
		self:get_scene():empty_dmg_top_monid()
	end
    self.super.on_die(self, ...)
    self:on_die_after(...)
end

function monster:add_owner_drop_item(obj, item)
    local list = self.owner_drop_item_list[obj] or {}
    table.insert(list, item)
    self.owner_drop_item_list[obj] = list
    -- skynet.logi("add_owner_drop_item human name =", obj:get_name(), ";item =", item)
end

function monster:refix_occupant_guid()
    if self:get_occupant_guid() == define.INVAILD_ID 
	and self:get_raid_occipant_guid() == define.INVAILD_ID 
	and self:get_team_occipant_guid() == define.INVAILD_ID then
        local damage_list = {}
        for obj_guid, damage in pairs(self.damage_member_list) do
            table.insert(damage_list, { obj_guid = obj_guid, damage = damage })
        end
        if #damage_list > 0 then
            table.sort(damage_list, function(l1, l2)
                return l1.damage > l2.damage
            end)
            local attacker_obj_guid = damage_list[1].obj_guid
            local attacker = self:get_scene():get_obj_by_guid(attacker_obj_guid)
            if attacker then
                self:set_occipant_guid(attacker_obj_guid)
				local raid_id = attacker:get_raid_id()
				local team_id = attacker:get_team_id()
                self:set_team_occipant_guid(team_id)
				self:set_raid_occipant_guid(raid_id)
            end
        end
    end
end

function monster:caculate_owner_list()
    local config_info = configenginer:get_config("config_info")
    local position = self:get_world_pos()
    local operate = {obj = self, x = position.x, y = position.y, radious = config_info.Human.CanGetExpRange}
    local nearbys = self:get_scene():scan(operate)
    local team_leader
	local occupant_guid = self:get_occupant_guid()
	local team_occipant_guid = self:get_team_occipant_guid()
	local raid_occipant_guid = self:get_raid_occipant_guid()
	local kill_call = false
    for _, n in ipairs(nearbys) do
        if n:get_obj_type() == "human" then
            if n:get_guid() == occupant_guid then
				table.insert(self.owners, n)
                n:on_kill_object(self)
				kill_call = true
			elseif raid_occipant_guid ~= define.INVAILD_ID then
				if n:get_raid_id() == raid_occipant_guid then
					table.insert(self.owners, n)
				end
			elseif team_occipant_guid ~= define.INVAILD_ID then
				if n:get_team_id() == team_occipant_guid then
					table.insert(self.owners, n)
					if n:get_team_info():is_leader() then
						team_leader = n
					end
				end
            end
        end
    end
	if not kill_call then
		local obj = self:get_scene():get_obj_by_guid(occupant_guid)
		if obj then
			obj:on_kill_object(self)
		end
	end
    return team_leader,self.owners
end

function monster:on_die_after()
    self:get_scene():after_monster_die(self)
    self:refix_occupant_guid()
    local team_leader = self:caculate_owner_list()
	if self:get_raid_occipant_guid() == -1 then
		self:dispatch_exp(self.owners, team_leader)
		self:dispatch_good_bad(team_leader, self.owners)
		self:dispatch_friend_point(self.owners)
		self:dispatch_item_box(self.owners)
		self:dispatch_kill_monster_count(self.owners)
	end
    self.damage_member_list = {}
end

function monster:caculate_base_exp(level, killer_level, exp)
    local exp_attenuation = self:get_scene():get_config_enginer():get_config(
                                "exp_attenuation")
    local delta = level - killer_level
    local rate = exp_attenuation[delta]
    local config_info = configenginer:get_config("config_info")
    return math.ceil(exp * rate * config_info.Exp.ExpParam)
    -- return math.ceil(exp * rate * exp_rate)
    --return exp * rate * exp_rate
end

function monster:dispatch_exp(owners, team_leader)
    -- print("dispatch_exp #owners =", #owners)
    local base_exp = self:get_base_exp()
	scene_exp_rate = self:get_scene():get_scene_exp_rate()
	if scene_exp_rate ~= 0 then
		scene_exp_rate = scene_exp_rate + 1
		base_exp = base_exp * scene_exp_rate
	end
	if base_exp <= 0 then
		return
	end
    if #owners == 1 then
        local add_exp = self:caculate_base_exp(self:get_level(), owners[1]:get_level(), base_exp)
        local pet = owners[1]:get_pet()
        local pet_add_exp = 0
        if pet then
            pet_add_exp = self:caculate_base_exp(self:get_level(), pet:get_level(), base_exp)
        end
        owners[1]:add_exp(add_exp, pet_add_exp, true)
    elseif #owners > 1 then
        local exp_mode = 0
        if team_leader then
            local team_info = team_leader:get_team_info()
            if team_info then
                exp_mode = team_info:get_exp_mode()
            end
        end
        local occupant_guid = self:get_occupant_guid()
        local exp = (base_exp + (base_exp * (#owners - 1) / 10)) / #owners
        for _, o in ipairs(owners) do
            local add = self:caculate_base_exp(self:get_level(), o:get_level(), exp)
            if exp_mode == 1 then
                if o:get_guid() == occupant_guid then
                    add = add + add * (#owners - 1) / 3
                else
                    add = add * 2 / 3
                end
            end
            local pet_add_exp = 0
             local pet = o:get_pet()
            if pet then
                pet_add_exp = self:caculate_base_exp(self:get_level(), pet:get_level(), exp)
            end
            o:add_exp(add, pet_add_exp, true)
        end
    end
end

function monster:dispatch_good_bad(team_leader, owners)
    if team_leader then
        local config_info = configenginer:get_config("config_info")
        if team_leader:get_level() >= config_info.GoodBad.LevelNeeded then
            local vaild_newbie_member_count = 0
            local vaild_prentice_member_count = 0
            local MemberLevelLimit = config_info.GoodBad.MemberLevelLimit
            local MemberLevel = config_info.GoodBad.MemberLevel
            local GoodBadRadius = config_info.GoodBad.GoodBadRadius
            local LevelDis = config_info.GoodBad.LevelDis
            local BonusPerMember = config_info.GoodBad.BonusPerMember
            local BonusPerPrentice = config_info.GoodBad.BonusPerPrentice
            local leader_level = team_leader:get_level()
            for _, o in ipairs(owners) do
                if o ~= team_leader then
                    local level = o:get_level()
                    local diff = leader_level - level
                    if diff >= LevelDis then
                        local dist = self:get_scene():cal_dist(o:get_world_pos(), team_leader:get_world_pos())
                        if dist <= GoodBadRadius then
                            if level < MemberLevelLimit and level >= MemberLevel then
                                vaild_newbie_member_count = vaild_newbie_member_count + 1
                                if team_leader:is_prentice_relation(o) then
                                    vaild_prentice_member_count = vaild_prentice_member_count + 1
                                end
                            end
                        end
                    end
                end
            end
            local add_good_bad_value = vaild_newbie_member_count * BonusPerMember + vaild_prentice_member_count * BonusPerPrentice
            team_leader:add_good_bad_value(add_good_bad_value)
        end
    end
end

function monster:dispatch_friend_point(owners)
    for i = 1, #owners do
        for j = i + 1, #owners do
            if owners[i]:is_friend_relation(owners[j]) and owners[j]:is_friend_relation(owners[i]) then
                owners[i]:inc_friend_point(owners[j])
                owners[j]:inc_friend_point(owners[i])
            end
        end
    end
end

function monster:dispatch_kill_monster_count(owners)
    local owners_count = #owners
    local count = 1
    if owners_count > 1 then
        count = 1 / owners_count * 0.8
    end
    for _, owner in ipairs(owners) do
        owner:update_kill_monster_count(count)
    end
end

function monster:caculate_drop_ruler()
    local scene = self:get_scene()
    local item_drop_manager = scene:get_item_drop_manager()
    return item_drop_manager:caculate_drop_item_box(self:get_model())
end

function monster:dispatch_item_box(owners)
    for _, o in ipairs(owners) do
        if o:can_be_dispatch_item_box() then
            local drop_items = self:caculate_drop_ruler()
            self:add_drop_item(o, drop_items)
            if #drop_items > 0 then
                local conf = {}
                conf.owner_guid = o:get_guid()
                conf.monster_id = self:get_obj_id()
                conf.world_pos = self:get_world_pos()
                conf.drop_items = drop_items
                self:get_scene():create_item_box(conf)
            end
        end
    end

    local owner_drop_item_list = {}
    for o in pairs(self.owner_drop_item_list) do
        -- skynet.logi("dispatch_item_box owner name =", o:get_name(), ";item =", table.tostr(self.owner_drop_item_list[o]))
        table.insert(owner_drop_item_list, { owner = o, item_list = self.owner_drop_item_list[o]})
    end
    for i = #owner_drop_item_list, 1, -1 do
        local drop_items = {}
        local owner = owner_drop_item_list[i].owner
        self:add_drop_item(owner, drop_items)
        if #drop_items > 0 then
            local conf = {}
            conf.owner_guid = owner:get_guid()
            conf.monster_id = self:get_obj_id()
            conf.world_pos = self:get_world_pos()
            conf.drop_items = drop_items
            self:get_scene():create_item_box(conf)
        end
    end
end

function monster:add_drop_item(o, drop_items)
    if self.owner_drop_item_list[o] then
        for _, itemid in ipairs(self.owner_drop_item_list[o]) do
            table.insert(drop_items, 1, { id = itemid, count = 1, drop_class = define.INVAILD_ID})
        end
    end
    self.owner_drop_item_list[o] = nil
end

function monster:rage_increment()

end

function monster:set_occipant_guid(guid)
    self:set_attrib({occupant_guid = guid})
end

function monster:set_team_occipant_guid(team_id)
    self:set_attrib({team_occipant_guid = team_id})
end

function monster:set_raid_occipant_guid(raid_id)
    self:set_attrib({raid_occipant_guid = raid_id})
end

function monster:get_occupant_guid()
    return self:get_attrib("occupant_guid")
end

function monster:get_team_occipant_guid()
    return self:get_attrib("team_occipant_guid")
end

function monster:get_raid_occipant_guid()
    return self:get_attrib("raid_occipant_guid")
end

function monster:get_owners()
    return self.owners
end

function monster:on_damages(damages, caster_obj_id, is_critical, skill_id, imp)
	-- skynet.logi("monster:on_damages skill_id = ",skill_id,"caster_obj_id = ",caster_obj_id)
	
    local scene = self:get_scene()
    local sender = scene:get_obj_by_id(caster_obj_id)
	-- if sender then
		-- skynet.logi("objtype = ",sender:get_obj_type())
	-- else
		-- skynet.logi("objtype = nil")
	-- end

	
    if sender and sender:is_character_obj() then
        sender:on_damage_target(self, damages, skill_id, imp)
    end
    self:impact_on_damages(damages, caster_obj_id, is_critical, skill_id, imp)
	if damages.flag_immu then
		self:show_skill_missed(self:get_obj_id(),caster_obj_id,skill_id,self:get_logic_count(),define.MISS_FLAG.FLAG_IMMU)
		return
	elseif damages.imm_dmg_rate and damages.imm_dmg_rate >= 100 then
		self:show_skill_missed(self:get_obj_id(),caster_obj_id,skill_id,self:get_logic_count(),define.MISS_FLAG.FLAG_IMMU)
		return
	end
    character.on_damages(self, damages, caster_obj_id, is_critical, skill_id,imp)
end

function monster:back_monster_damage(hp_modify,sender)
    -- if hp_modify < 0 then
        -- local abs_damage = math.abs(hp_modify)
        if hp_modify > 0 then
            local attacker = sender
            if attacker then
                local obj_type = attacker:get_obj_type()
                if obj_type == "human" or obj_type == "pet" then
                    if attacker:get_obj_type() == "pet" then
                        attacker = attacker:get_owner()
                    end
					local raid_id = attacker:get_raid_id()
					local team_id = attacker:get_team_id()
					local att_guid = attacker:get_guid()
                    local his_damage = self.damage_member_list[att_guid] or 0
                    his_damage = his_damage + hp_modify
                    self.damage_member_list[att_guid] = his_damage
                    if self:get_occupant_guid() == define.INVAILD_ID 
					and self:get_raid_occipant_guid() == define.INVAILD_ID
					and self:get_team_occipant_guid() == define.INVAILD_ID then
                        if his_damage > self:get_max_hp() * 0.1 then
                            self:set_occipant_guid(att_guid)
                            self:set_team_occipant_guid(team_id)
                            self:set_raid_occipant_guid(raid_id)
                        end
                    end
                end
            end
        end
    -- end
end
-- function monster:gm_kill_obj(targetId)
    -- local sender = self:get_scene():get_obj_by_id(targetId)
	-- if sender then
		-- local hp_modify = self:get_attrib("hp")
		-- self:back_monster_damage(hp_modify,sender)
	-- end
	-- return character.gm_kill_obj(self,targetId)
-- end


-- function monster:health_increment(hp_modify, sender, is_critical_hit, imp)
    -- if hp_modify < 0 then
        -- local abs_damage = math.abs(hp_modify)
        -- if abs_damage > 0 then
            -- local attacker = sender
            -- if attacker then
                -- local obj_type = attacker:get_obj_type()
                -- if obj_type == "human" or obj_type == "pet" then
                    -- if attacker:get_obj_type() == "pet" then
                        -- attacker = attacker:get_owner()
                    -- end
                    -- local team_id = attacker:get_team_id()
					-- local att_guid = attacker:get_guid()
                    -- local his_damage = self.damage_member_list[attacker:get_obj_id()] or 0
                    -- his_damage = his_damage + abs_damage
                    -- self.damage_member_list[att_guid] = his_damage
                    -- local occupant_guid = self:get_occupant_guid()
                    -- local team_occupant_guid = self:get_team_occipant_guid()
                    -- if occupant_guid == define.INVAILD_ID and team_occupant_guid == define.INVAILD_ID then
                        -- if his_damage > self:get_max_hp() * 0.1 then
                            -- self:set_occipant_guid(att_guid)
                            -- self:set_team_occipant_guid(team_id)
                        -- end
                    -- end
                -- end
            -- end
        -- end
    -- end
    -- -- self.super.health_increment(self, hp_modify, sender, is_critical_hit, imp)
    -- character.health_increment(self, hp_modify, sender, is_critical_hit, imp)
-- end

function monster:get_respawn_time() return self.respawn_time end

function monster:respawn()
    self:set_hp(self:get_max_hp())
    self:set_world_pos(self:get_respawn_pos())
    self:set_occipant_guid(define.INVAILD_ID)
    self:set_team_occipant_guid(define.INVAILD_ID)
    self:set_raid_occipant_guid(define.INVAILD_ID)
    self.damage_member_list = {}
    self.owner_drop_item_list = setmetatable({}, { __mode = "kv" })
    self.owners = setmetatable({}, {__mode = "kv"})
    self.misions_toggle = {}
    self.ai:respawn()
	-- if self.dataid == 11392 then
		-- skynet.logi("霜影刷新:",os.time(),"stack =",debug.traceback())
	-- end
end

function monster:set_patrol_id(id)
    local patrol = self:get_scene():get_patrol_path_by_index(id)
    if patrol then
        self.patrol_id = id
        if self:is_patrol_monster() then
            self:get_ai():start_patrol()
        end
    else
        print("error can not find patrol path =", id)
    end
end

function monster:get_patrol_id()
    return self.patrol_id
end

function monster:is_patrol_monster()
    return self.patrol_id >= 0
end

function monster:set_mp()
end

function monster:set_hp_max(hp_max)
    assert(hp_max > 0)
    assert(hp_max < define.UINT32_MAX)
    self.db:set_db_attrib({ hp_max = hp_max})
end

function monster:set_mind_attack(mind_attack)
    assert(mind_attack > 0)
    assert(mind_attack < define.UINT32_MAX)
    self.db:set_db_attrib({ mind_attack = mind_attack})
end

function monster:set_attrib_hit(attrib_hit)
    assert(attrib_hit > 0)
    assert(attrib_hit < define.UINT32_MAX)
    self.db:set_db_attrib({ attrib_hit = attrib_hit})
end

function monster:set_attrib_miss(attrib_miss)
    assert(attrib_miss > 0)
    assert(attrib_miss < define.UINT32_MAX)
    self.db:set_db_attrib({ attrib_miss = attrib_miss})
end

function monster:set_attrib_att_physics(attrib_att_physics)
    assert(attrib_att_physics > 0)
    assert(attrib_att_physics < define.UINT32_MAX)
    self.db:set_db_attrib({ attrib_att_physics = attrib_att_physics})
end

function monster:set_attrib_def_physics(attrib_def_physics)
    assert(attrib_def_physics > 0)
    assert(attrib_def_physics < define.UINT32_MAX)
    self.db:set_db_attrib({ attrib_def_physics = attrib_def_physics})
end

function monster:set_attrib_att_magic(attrib_att_magic)
    assert(attrib_att_magic > 0)
    assert(attrib_att_magic < define.UINT32_MAX)
    self.db:set_db_attrib({ attrib_att_magic = attrib_att_magic})
end

function monster:set_attrib_def_magic(attrib_def_magic)
    assert(attrib_def_magic > 0)
    assert(attrib_def_magic < define.UINT32_MAX)
    self.db:set_db_attrib({ attrib_def_magic = attrib_def_magic})
end

function monster:set_att_cold(att_cold)
    assert(att_cold >= 0)
    assert(att_cold < define.UINT32_MAX)
    self.db:set_db_attrib({ att_cold = att_cold})
end

function monster:set_def_cold(def_cold)
    assert(def_cold >= 0)
    assert(def_cold < define.UINT32_MAX)
    self.db:set_db_attrib({ def_cold = def_cold})
end

function monster:set_att_fire(att_fire)
    assert(att_fire >= 0)
    assert(att_fire < define.UINT32_MAX)
    self.db:set_db_attrib({ att_fire = att_fire})
end

function monster:set_def_fire(def_fire)
    assert(def_fire >= 0)
    assert(def_fire < define.UINT32_MAX)
    self.db:set_db_attrib({ def_fire = def_fire})
end

function monster:set_att_light(att_light)
    assert(att_light >= 0)
    assert(att_light < define.UINT32_MAX)
    self.db:set_db_attrib({ att_light = att_light})
end

function monster:set_def_light(def_light)
    assert(def_light >= 0)
    assert(def_light < define.UINT32_MAX)
    self.db:set_db_attrib({ def_light = def_light})
end

function monster:set_att_poison(att_poison)
    assert(att_poison >= 0)
    assert(att_poison < define.UINT32_MAX)
    self.db:set_db_attrib({ att_poison = att_poison})
end

function monster:set_def_poison(def_poison)
    assert(def_poison >= 0)
    assert(def_poison < define.UINT32_MAX)
    self.db:set_db_attrib({ def_poison = def_poison})
end

function monster:get_attrib(attr)
    return self.db:get_attrib(attr)
end

function monster:get_dir()
    return self:get_attrib("dir")
end

function monster:mark_unbreakable_flag()
    self:set_attrib({ unbreakable = 1 })
end

function monster:clear_unbreakable_flag()
    self:set_attrib({ unbreakable = 0 })
end

function monster:set_temp_camp_id(id)
    self.db:set_db_attrib({ camp_id = id})
end

function monster:create_new_obj_packet()
    if self:is_moving() then
        local msg = packet_def.GCNewMonster_Move.new()
        msg.m_objID = self:get_obj_id()
        msg.guid = self:get_model()
        msg.world_pos = self:get_world_pos()
        msg.dir = self:get_dir()
        msg.speed = self:get_speed()
        msg.handle = self.move.handle
        msg.path = self.move.targetPos
        return msg
    else
        local msg = packet_def.GCNewMonster.new()
        msg.guid = self:get_guid()
        msg.m_objID = self:get_obj_id()
        msg.dir = self:get_dir()
        msg.unknow_1 = 1656600794
        msg.unknow_10 = 2518342987
        msg.unknow_11 = 1190194235
        msg.unknow_12 = 955012720
        msg.unknow_13 = 65009746
        msg.unknow_15 = 2623905260
        msg.unknow_16 = 2705976078
        msg.unknow_17 = 2927752741
        msg.unknow_18 = 4194946202
        msg.speed = self:get_speed()
        msg.unknow_2 = 1149116311
        msg.unknow_20 = 1869628498
        msg.unknow_21 = 2696114389
        msg.unknow_22 = 2333910085
        msg.unknow_23 = 1643806583
        msg.unknow_24 = 8374
        msg.unknow_25 = {0, 0, 0, 0, 0, 0, 0, 0}
        msg.unknow_3 = 1111842826
        msg.unknow_4 = 622429864
        msg.unknow_6 = 290492800
        msg.unknow_7 = 38247240
        msg.unknow_8 = 537823071
        msg.unknow_9 = 1784045101
        msg.worldPos = table.clone(self:get_world_pos())
        return msg
    end
end

function monster:set_create_time(time)
    self.create_time = time
end

function monster:get_create_time()
    return self.create_time
end

function monster:on_impact_fade_out(imp)
    self.ai:call_ai_script("OnImpactFadeOut", self:get_obj_id(), imp:get_data_index())
    self.super.on_impact_fade_out(self, imp)
end

function monster:AIS_SetPatrolID(patrol_id)
    self:set_patrol_id(patrol_id)
end

function monster:AIS_SetBaseAIType(_, _, ai_type)
    self:set_ai_type(ai_type)
end

function monster:AIS_SetReputationID_CodingRefix(reputation_id)
    self:set_reputation(reputation_id)
end

function monster:AIS_SetMonsterFightWithNpcFlag(flag)
    self:set_fight_with_npc_flag(flag)
end

function monster:set_near_humans(humans)
    self.near_humans = humans
end

function monster:get_near_humans()
    return self.near_humans
end

function monster:get_dw_jinjie_effect_details(id)
    return 0
end

function monster:get_interaction_type()
    return self.interaction_type
end

function monster:get_need_skill()
    return self.need_skill
end

function monster:get_damage_member()
    return self.damage_member_list
end

function monster:get_scene_params(index)
	return self.scene_params[index] or 0
end

function monster:set_scene_params(index,value)
	if not index then
		return
	end
	self.scene_params[index] = value
end

function monster:set_unconstrained_monster(value)
	self.is_unconstrained_monster = value
end

return monster
