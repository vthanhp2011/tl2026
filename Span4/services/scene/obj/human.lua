local skynet = require "skynet"
local gbk = require "gbk"
local profile = require "skynet.profile"
local define = require "define"
local class = require "class"
local utils = require "utils"
local impactenginer = require "impactenginer":getinstance()
local configenginer = require "configenginer":getinstance()
local actionenginer = require "actionenginer":getinstance()
local skillenginer = require "skillenginer":getinstance()
local talentenginer = require "talentenginer":getinstance()
local petmanager = require "petmanager":getinstance()
local shopenginer = require "shopenginer":getinstance()
local human_item_logic = require "human_item_logic"
local packet_def = require "game.packet"
local team_info_cls = require "teaminfo"
local raid_info_cls = require "raidinfo"
local exchange_box_cls = require "exchange_box"
local Item_cls = require "item"
local pet_guid = require "pet_guid"
local shop_guid = require "shop_guid"
local item_container = require "item_container"
local pet_container = require "pet_container"
local stall_bax = require "stallbox"
local human_bag_container = require "human_bag_container"
local attacker_or_pk_delaction_list = require "attacker_or_pk_delaction_list"
local wild_war_guilds = require "wild_war_guilds"
local human_db_attr = require "db.human_attrib"
local pet_detail = require "pet_detail"
local db_impact = require "db.impact_data"
local menpai_logic = require "menpai"
local ai_human = require "scene.ai.human"
local character = require "scene.obj.character"
local human = class("human", character)

function human:ctor(data)
    self.game_flag = data.game_flag
	-- self.update_world_data_tick = 1000
	self.check_item_time = math.random(60000,120000)
	self.player_tick = 5000
	self.restore_hp_tick = 0
	self.restore_hp_rate = 0
	self.restore_hp_value = 0
	self.restore_hp_reset_time = 0
    self.xinfa_list = data.xinfa_list
    self.xiulian_list = data.xiulian_list
    self.skill_list = data.skill_list
    self.talent = data.talent
    self.ability_list = data.ability_list
    self.prescriptions = data.prescriptions
    self.setting = data.setting
    self.relation_list = data.relation or {}
    self.agent = data.agent
	if data.exterior then
		self.exterior = data.exterior
		if not self.exterior.poss then
			self.exterior.poss = {}
		end
		if not self.exterior.headinfo then
			self.exterior.headinfo = {}
		end
		if not self.exterior.backinfo then
			self.exterior.backinfo = {}
		end
		if not self.exterior.weapon_visuals then
			self.exterior.weapon_visuals = {}
		end
	else
		self.exterior = {headinfo = {},backinfo = {},poss = {},weapon_visuals = {}}
	end
			--[id] = (exp << 16) | (lv << 8) | id
			--[equip point] = {id = id,finedraw = finedraw}
    -- self.dw_jinjie = data.dw_jinjie or {features = {},effect = {}}
    self.dw_jinjie = data.dw_jinjie or {features = {}}
	self.dw_jinjie.effect = {}
    self.fashion_bag_list = data.fashion_bag_list
    self.chedifulu_data = data.chedifulu_data
    self.double_exp_info = data.double_exp_info
    self.huanhun = data.huanhun or {}
    self:set_char_shop_guids(data.shop_guids or {})
    self.titles = data.titles or {}
    self.id_titles = data.id_titles or {}
    self.mission_data = data.mission_data
    self.dungeonsweep = data.dungeonsweep
    self.week_active = data.week_active
	self.limit_shop = self.limit_shop or {}
    self.mystery_shop_info = data.mystery_shop_info or {}
    self.jiyuan_shop_info = data.jiyuan_shop_info or {}
    self.wanshige_shop_info = data.wanshige_shop_info or {}
    self.rmb_chat_face_info = data.rmb_chat_face_info or { id = 0, dates = {0, 0, 0, 0}}
    -- self.attackers_list = attacker_or_pk_delaction_list.new(data.attackers_list)
    self.pk_declaration_list = attacker_or_pk_delaction_list.new(data.pk_declaration_list)
    self.wild_war_guilds = wild_war_guilds.new()
    self.ai = ai_human.new()
    self.shop = nil
    self.guid_of_call_up_pet = pet_guid.new()
    self.attr_msg_to_team_inteval_count = 0
    self.begin_send_refresh_attrib = false
    self.ai:init(self)
    self:reset_ability_opera()
    self:init_equip_continer(data)
    self:init_pet_container(data)
    self.db = human_db_attr.new(self, data.lv1_attrib, data.attrib)
    -- self.db:init()
    self.impacts = db_impact.new()
    self.impacts:set_obj(self)
    self.impacts:init_from_db_data(data)
    -- print("human:ctor aaaa")
    self:init_contaioners(data)
    -- print("human:ctor bbbb")
    self.team_info = team_info_cls.new(self)
	self.raid_info = raid_info_cls.new(self)
    self.stall_box = stall_bax.new()
    self.stall_box:init(self)
    -- print("human:ctor cccc")
    self.exchange_box = exchange_box_cls.new()
    self.exchange_box:init(self)
    self:fix_skills()
    self:fix_prescription()
    self:fix_abilitys()
    self:fix_mission_flag()
    self:fix_mission_data()
    -- print("human:ctor dddd")
    self:fix_mission_data_ex()
    self:fix_dungeonsweep()
    self:fix_week_active()
    self:fix_talent()
    self:fix_xiulian_list()
    self:fix_id_titles()
    self:fix_titles()
    self:fix_exterior_ranse()
    self:fix_pk_mode_change_times()
    self:fix_cool_down_times()
    self:fix_impact_continuance()
    self.db:init()
    self:check_cur_title_have()
    local r, err = pcall(self.talent_on_active, self)
    if not r then
        skynet.loge("talent_on_active error =", err)
    end
    -- print("human:ctor finish")
end

function human:fix_pk_mode_change_times()
	local limit_pk_mode = define.LIMIT_PK_MODE_ON_SCENE[self:get_scene_id()]
	if limit_pk_mode then
        self.db:set_db_attrib_nil("want_change_pk_mode")
        self.db:set_db_attrib({ pk_mode = limit_pk_mode.pk_id, change_pk_mode_delay = nil})
		-- local msg = string.format("该场景只允许%s模式。",limit_pk_mode.pk_name)
		-- self:notify_tips(msg)
	else
		local now = os.time()
		local logout_time = self:get_logout_time()
		local diff = now - logout_time
		self:check_pk_mode_can_change(diff * 1000)
	end
end

function human:fix_cool_down_times()
    local now = os.time()
    local logout_time = self:get_logout_time()
    local diff = now - logout_time
    self:update_cool_down(diff * 1000)
end

function human:fix_impact_continuance()
    local now = os.time()
    local logout_time = self:get_logout_time()
    local diff = now - logout_time
    if diff > 0 then
        local impactenginer = self:get_scene():get_impact_enginer()
        local delta_time = diff * 1000
        local list = self:get_impact_list()
        for _, imp in ipairs(list) do
            if imp:is_counter_when_offline() then
                local logic = impactenginer:get_logic(imp)
                if logic then
                    if (self:is_unbreakable() and imp:get_stand_flag() == define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_HOSTILITY) then
                    else
                        logic:heart_beat(imp, self, delta_time)
                    end
                end
            end
        end
    end
end

function human:fix_exterior_ranse()
    if not self.exterior.ranse then
        self.exterior.ranse = {}
        for i = 1, 50 do
            self.exterior.ranse[i] = { 0, 0, 0 }
        end
    end
end


function human:fix_id_titles()
    self.id_titles = self.id_titles or {}
end

function human:fix_titles()
    for i, title in ipairs(self.titles) do
        if title.id == define.INVAILD_ID then
            table.remove(self.titles, i)
        end
    end
end

function human:fix_skills()
    do
        local skill_id = 43
        if not self:have_skill(skill_id) then
            self:add_skill(skill_id)
        end
    end
end

function human:fix_prescription()
    do
        local pres_id = 398
        if not self:is_prescription_have_learnd(pres_id) then
            self:study_prescription(pres_id, 1)
        end
    end
    do
        local pres_id = 558
        if not self:is_prescription_have_learnd(pres_id) then
            self:study_prescription(pres_id, 1)
        end
    end
    do
        local pres_id = 559
        if not self:is_prescription_have_learnd(pres_id) then
            self:study_prescription(pres_id, 1)
        end
    end
    do
        local pres_id = 560
        if not self:is_prescription_have_learnd(pres_id) then
            self:study_prescription(pres_id, 1)
        end
    end
end

function human:fix_abilitys()
    do
        local ability_id = 26
        if not self:have_ability(ability_id) then
            self:study_ability(ability_id, 0, 1)
        end
    end
    do
        local ability_id = 51
        if not self:have_ability(ability_id) then
            self:study_ability(ability_id, 0, 1)
        end
    end
end

function human:fix_talent()
    if not self.talent then
        self.talent = {
            type = define.INVAILD_ID,
            understand_point = 0,
            study = {
            }
        }
        for i = 1, 21 do
            table.insert(self.talent.study, { id = define.INVAILD_ID, level = 0})
        end
    end
	if #self.talent.study < 21 then
		for i = #self.talent.study + 1,21 do
            table.insert(self.talent.study, { id = define.INVAILD_ID, level = 0})
		end
	end
    do
        local id_mission = 2025
        local index = (id_mission >> 5) + 1
        self.mission_data.mission_have_done_flags[index] = (self.mission_data.mission_have_done_flags[index] or 0) | (0x00000001 << (id_mission & 0x0000001F))
    end
    do
        local id_mission = 2080
        local index = (id_mission >> 5) + 1
        self.mission_data.mission_have_done_flags[index] = (self.mission_data.mission_have_done_flags[index] or 0) | (0x00000001 << (id_mission & 0x0000001F))
    end
    do
        local id_mission = 2211
        local index = (id_mission >> 5) + 1
        self.mission_data.mission_have_done_flags[index] = (self.mission_data.mission_have_done_flags[index] or 0) | (0x00000001 << (id_mission & 0x0000001F))
    end
    do
        local id_mission = 2359
        local index = (id_mission >> 5) + 1
        self.mission_data.mission_have_done_flags[index] = (self.mission_data.mission_have_done_flags[index] or 0) | (0x00000001 << (id_mission & 0x0000001F))
    end
end

function human:fix_dungeonsweep()
    local dungeonsweep = self.dungeonsweep
    if dungeonsweep == nil then
        self.dungeonsweep = { sweep_counts = {}, campaign_counts = {}}
    end
end

function human:fix_week_active()
    local week_active = self.week_active
    if week_active == nil then
        week_active = {}
        week_active.can_get = {}
        week_active.getd = {}
        for i = 1, 0x26 do
            week_active.can_get[i] = 0
        end
        for i = 1, 0x26 do
            week_active.getd[i] = 0
        end
        week_active.day_get = 0
        week_active.week_get = 0
        week_active.get_award_index = 0
        self.week_active = week_active
    end
    if self.week_active.activity_finish_count == nil then
        week_active.activity_finish_count = {}
        for i = 1, 0x26 do
            week_active.activity_finish_count[i] = 0
        end
    end
end

function human:fix_mission_flag()
    local mission_flag = self.mission_data.mission_flag or {}
    self.mission_data.mission_flag = mission_flag
end

function human:fix_mission_data()
    local mission_datas = self.mission_data.mission_datas
    for i = #mission_datas, define.MAX_CHAR_MISSION_DATA_NUM do
        mission_datas[i] = mission_datas[i] or 0
    end
end

function human:fix_mission_data_ex()
    local mission_datas_ex = self.mission_data.mission_datas_ex 
    mission_datas_ex = mission_datas_ex or {}
    self.mission_data.mission_datas_ex = mission_datas_ex
end

function human:check_cur_title_have()
    local title = self.db:get_db_attrib("title")
    if title and title.id then
        if title.new_title_id then
            local id = title.new_title_id
            if not self:check_have_id_title(id) then
                self:set_current_title( { id = 0, str = ""})
            else
                self:set_current_title(title)
            end
        else
            local id = title.id
            title = self:get_title_by_id(id)
            if title == nil then
                self:set_current_title( { id = 0, str = ""})
            else
                self:set_current_title(title)
            end
        end
    end
end

function human:init_equip_continer(data)
    self.equip_container = item_container.new()
    self.equip_container:init(define.HUMAN_EQUIP.HEQUIP_ALL, data.equip_list,define.CONTAINER_INDEX.HUMAN_SELF)
end

function human:init_pet_container(data)
    self.pet_bag_container = pet_container.new()
    local pet_bag_size = define.DEFAULT_PET_NUM + (data.attrib.pet_num_extra or 0)
    self.pet_bag_container:init(pet_bag_size, data.pet_bag_list,define.CONTAINER_INDEX.HUMAN_PET_BAG,self)
end

function human:init_contaioners(data)
	local sceneId = self.sceneid
	local selfId = data.obj_id
    self.prop_bag_container = human_bag_container.new()
    self.bank_bag_container = item_container.new()
    self.pet_bank_container = pet_container.new()
    self.sold_out_container = item_container.new()
    self.fasion_bag_container = item_container.new()

    self.fasion_bag_container:init(100, data.fashion_bag_list,define.CONTAINER_INDEX.HUMAN_FASION)
    local bag_size = self:get_bag_size()
    local bank_bag_size = self:get_bank_bag_size()
    local pet_bank_bag_size = self:get_pet_bank_bag_size()
    self.prop_bag_container:init(bag_size, data.prop_bag_list,define.CONTAINER_INDEX.HUMAN_BAG)
    self.bank_bag_container:init(bank_bag_size, data.bank_bag_list,define.CONTAINER_INDEX.HUMAN_BANK)
    self.pet_bank_container:init(pet_bank_bag_size, data.pet_bank_list,define.CONTAINER_INDEX.HUMAN_PET_BANK)
    self.sold_out_container:init(define.SOLD_OUT_SIZE, {},define.CONTAINER_INDEX.HUMAN_SOLD_OUT)
end


function human:on_line_check_item_valid_timer()
	local update_fasion = false
	local update_equip = false
	local scene = self:get_scene()
	local name = self:get_name()
	
	local del_msg = "#W您#G%s#W内已过期的#G#{_ITEM%d}#W，已被删除。"
	local curtime = os.time()
	
	local item,ret
	local item_index,guid
	
	local container = self.equip_container
	local delitempos,deltime_tip = container:on_line_check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_SELF]
		for _,pos in ipairs(delitempos) do
			if pos ~= define.HUMAN_EQUIP.HEQUIP_UNKNOW1
			and pos ~= define.HUMAN_EQUIP.HEQUIP_UNKNOW2 then
				item = container:get_item(pos)
				if item then
					item_index = item.item_index
					guid = item.guid
					container:set_item(pos,nil)
					ret = packet_def.GCUnEquipResult.new()
					ret.result = 1
					ret.bagIndex = 255
					ret.equipPoint = pos
					ret.item_guid = guid
					ret.item_index = item_index
					scene:send2client(self, ret)
					local mail = {}
					mail.guid = define.INVAILD_ID
					mail.source = ""
					mail.portrait_id = define.INVAILD_ID
					mail.dest = name
					mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
					mail.create_time = curtime
					mail.content = string.format(del_msg,container_name,item_index)
					skynet.send(".world", "lua", "send_mail", mail)
					if pos == define.HUMAN_EQUIP.HEQUIP_CAP then
						local env = skynet.getenv("env")
						if define.ADD_EQUIP_BUFF[env] then
							for _,dy_info in ipairs(define.ADD_EQUIP_BUFF[env]) do
								if dy_info[define.HUMAN_EQUIP.HEQUIP_CAP] then
									if item_index >= dy_info[define.HUMAN_EQUIP.HEQUIP_CAP].MINID
									and item_index == dy_info[define.HUMAN_EQUIP.HEQUIP_CAP].MAXID then
										self:impact_cancel_impact_in_specific_data_index(dy_info[define.HUMAN_EQUIP.HEQUIP_CAP].BUFFID)
									end
								end
							end
						end
					elseif pos == define.HUMAN_EQUIP.HEQUIP_WEAPON then
						self:set_fashion_depot_index(define.INVAILD_ID)
						update_fasion = true
					elseif equipPoint == define.HUMAN_EQUIP.HEQUIP_ANQI then
						obj_me:impact_clean_all_impact_when_unequip_dark()
					elseif equipPoint == define.HUMAN_EQUIP.HEQUIP_WUHUN then
						obj_me:send_skill_list()
					end
					update_equip = true
				end
			end
		end
	end
	
	container = self.prop_bag_container
	delitempos,deltime_tip = container:on_line_check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_BAG]
		for _,pos in ipairs(delitempos) do
			item = container:get_item(pos)
			if item then
				container:set_item(pos,nil)
				ret = packet_def.GCItemInfo.new()
				ret.bag_type = define.BAG_TYPE.bag
				ret.bagIndex = pos
				ret.item = Item_cls.new():copy_raw_data()
				ret.bag_type = define.BAG_TYPE.bag
				scene:send2client(self, ret)
				local mail = {}
				mail.guid = define.INVAILD_ID
				mail.source = ""
				mail.portrait_id = define.INVAILD_ID
				mail.dest = name
				mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
				mail.create_time = curtime
				mail.content = string.format(del_msg,container_name,item.item_index)
				skynet.send(".world", "lua", "send_mail", mail)
			end
		end
	end
	container = self.fasion_bag_container
	delitempos,deltime_tip = container:on_line_check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_FASION]
		update_fasion = true
		for _,pos in ipairs(delitempos) do
			item = container:get_item(pos)
			if item then
				container:set_item(pos,nil)
				local mail = {}
				mail.guid = define.INVAILD_ID
				mail.source = ""
				mail.portrait_id = define.INVAILD_ID
				mail.dest = name
				mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
				mail.create_time = curtime
				mail.content = string.format(del_msg,container_name,item.item_index)
				skynet.send(".world", "lua", "send_mail", mail)
			end
		end
	end
	
	container = self.bank_bag_container
	delitempos,deltime_tip = container:on_line_check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_BANK]
		for _,pos in ipairs(delitempos) do
			item = container:get_item(pos)
			if item then
				container:set_item(pos,nil)
				local mail = {}
				mail.guid = define.INVAILD_ID
				mail.source = ""
				mail.portrait_id = define.INVAILD_ID
				mail.dest = name
				mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
				mail.create_time = curtime
				mail.content = string.format(del_msg,container_name,item.item_index)
				skynet.send(".world", "lua", "send_mail", mail)
			end
		end
	end
	if update_equip then
		self:item_flush()
		local selfId = self:get_obj_id()
		-- scene:broad_char_equioment(self)
		self:get_scene():ask_char_equipment(selfId,selfId)
	end
	if update_fasion then
		scene:send_char_fashion_depot_data(self)
	end
end


function human:check_item_valid_timer()
	-- skynet.logi("human:check_item_valid_timer()")
	local update_fasion = false
	local update_equip = false
	local scene = self:get_scene()
	local name = self:get_name()
	
	local del_msg = "#W您#G%s#W内已过期的#G#{_ITEM%d}#W，已被删除。"
	local curtime = os.time()
	
	local item,ret
	local item_index,guid
	
	local container = self.equip_container
	local delitempos = container:check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_SELF]
		for _,pos in ipairs(delitempos) do
			if pos ~= define.HUMAN_EQUIP.HEQUIP_UNKNOW1
			and pos ~= define.HUMAN_EQUIP.HEQUIP_UNKNOW2 then
				item = container:get_item(pos)
				if item then
					item_index = item.item_index
					guid = item.guid
					container:set_item(pos,nil)
					ret = packet_def.GCUnEquipResult.new()
					ret.result = 1
					ret.bagIndex = 255
					ret.equipPoint = pos
					ret.item_guid = guid
					ret.item_index = item_index
					scene:send2client(self, ret)
					local mail = {}
					mail.guid = define.INVAILD_ID
					mail.source = ""
					mail.portrait_id = define.INVAILD_ID
					mail.dest = name
					mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
					mail.create_time = curtime
					mail.content = string.format(del_msg,container_name,item_index)
					skynet.send(".world", "lua", "send_mail", mail)
					if pos == define.HUMAN_EQUIP.HEQUIP_CAP then
						local env = skynet.getenv("env")
						if define.ADD_EQUIP_BUFF[env] then
							for _,dy_info in ipairs(define.ADD_EQUIP_BUFF[env]) do
								if dy_info[define.HUMAN_EQUIP.HEQUIP_CAP] then
									if item_index >= dy_info[define.HUMAN_EQUIP.HEQUIP_CAP].MINID
									and item_index == dy_info[define.HUMAN_EQUIP.HEQUIP_CAP].MAXID then
										self:impact_cancel_impact_in_specific_data_index(dy_info[define.HUMAN_EQUIP.HEQUIP_CAP].BUFFID)
									end
								end
							end
						end
					elseif pos == define.HUMAN_EQUIP.HEQUIP_WEAPON then
						self:set_fashion_depot_index(define.INVAILD_ID)
						update_fasion = true
					elseif equipPoint == define.HUMAN_EQUIP.HEQUIP_ANQI then
						obj_me:impact_clean_all_impact_when_unequip_dark()
					elseif equipPoint == define.HUMAN_EQUIP.HEQUIP_WUHUN then
						obj_me:send_skill_list()
					end
					update_equip = true
				end
			end
		end
	
	end
	
	container = self.prop_bag_container
	delitempos = container:check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_BAG]
		for _,pos in ipairs(delitempos) do
			item = container:get_item(pos)
			if item then
				container:set_item(pos,nil)
				ret = packet_def.GCItemInfo.new()
				ret.bag_type = define.BAG_TYPE.bag
				ret.bagIndex = pos
				ret.item = Item_cls.new():copy_raw_data()
				ret.bag_type = define.BAG_TYPE.bag
				scene:send2client(self, ret)
				local mail = {}
				mail.guid = define.INVAILD_ID
				mail.source = ""
				mail.portrait_id = define.INVAILD_ID
				mail.dest = name
				mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
				mail.create_time = curtime
				mail.content = string.format(del_msg,container_name,item.item_index)
				skynet.send(".world", "lua", "send_mail", mail)
			end
		end
	end
	container = self.fasion_bag_container
	delitempos = container:check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_FASION]
		update_fasion = true
		for _,pos in ipairs(delitempos) do
			item = container:get_item(pos)
			if item then
				container:set_item(pos,nil)
				local mail = {}
				mail.guid = define.INVAILD_ID
				mail.source = ""
				mail.portrait_id = define.INVAILD_ID
				mail.dest = name
				mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
				mail.create_time = curtime
				mail.content = string.format(del_msg,container_name,item.item_index)
				skynet.send(".world", "lua", "send_mail", mail)
			end
		end
	end
	
	container = self.bank_bag_container
	delitempos = container:check_item_valid_timer()
	if #delitempos > 0 then
		local container_name = define.CONTAINER_NAME[define.CONTAINER_INDEX.HUMAN_BANK]
		for _,pos in ipairs(delitempos) do
			item = container:get_item(pos)
			if item then
				container:set_item(pos,nil)
				local mail = {}
				mail.guid = define.INVAILD_ID
				mail.source = ""
				mail.portrait_id = define.INVAILD_ID
				mail.dest = name
				mail.flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM
				mail.create_time = curtime
				mail.content = string.format(del_msg,container_name,item.item_index)
				skynet.send(".world", "lua", "send_mail", mail)
			end
		end
	end
	if update_equip then
		self:item_flush()
		local selfId = self:get_obj_id()
		-- scene:broad_char_equioment(self)
		self:get_scene():ask_char_equipment(selfId,selfId)
	end
	if update_fasion then
		scene:send_char_fashion_depot_data(self)
	end
end

function human:get_prop_bag_size()
    local equip_container = self:get_equip_container()
    local prop_bag_equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_UNKNOW1)
    local size = 0
    if prop_bag_equip then
        local base = prop_bag_equip:get_base_config()
        size = base["行囊"]
    end
    return define.DEFAULT_BAG_SIZE + size
end

function human:get_material_bag_size()
    local equip_container = self:get_equip_container()
    local material_bag_equip = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_UNKNOW2)
    local size = 0
    if material_bag_equip then
        local base = material_bag_equip:get_base_config()
        size = base["格箱"]
    end
    return define.DEFAULT_BAG_SIZE + size
end

function human:get_bag_size()
    local size = {}
    size.prop = self:get_prop_bag_size()
    size.material = self:get_material_bag_size()
    size.task = 20
    return size
end

function human:get_bank_bag_size()
    return self.db:get_db_attrib("bank_bag_size") or 20
end

function human:set_bank_bag_size(size)
    self.db:set_db_attrib({bank_bag_size = size})
    local container = self:get_bank_bag_container()
    container:resize(size)
end

function human:get_pet_bank_bag_size()
    return self.db:get_db_attrib("pet_bank_bag_size") or 2
end

function human:set_pet_bank_bag_size(size)
    self.db:set_db_attrib({pet_bank_bag_size = size})
    local container = self:get_pet_bank_container()
    container:resize(size)
end

function human:on_bag_size_changed()
    local size = self:get_bag_size()
    local updates = self.prop_bag_container:set_size(size)
	if updates and #updates > 0 then
		local scene = self:get_scene()
		for i,j in ipairs(updates) do
			local msg = packet_def.GCItemInfo.new()
			msg.unknow_1 = 1
			msg.item = Item_cls.new():copy_raw_data()
			msg.bagIndex = j
			scene:send2client(self, msg)
		end
	end
    self:send_bag_size(size)
end

function human:send_bag_size(size)
    local msg = packet_def.GCBagSizeChange.new()
    msg.prop_size = size.prop
    msg.material_size = size.material
    self:get_scene():send2client(self, msg)
end

function human:get_pet_num_extra()
    return self.db:get_db_attrib("pet_num_extra") or 0
end

function human:set_pet_num_extra(num)
    assert(type(num) == "number", num)
    num = math.floor(num)
    self.db:set_db_attrib({pet_num_extra = num })
end

function human:get_pet_bag_size()
    local extra_num = self:get_pet_num_extra()
    return define.DEFAULT_PET_NUM + extra_num
end

function human:get_cur_target_id()
    return self.cur_target_id
end

function human:set_cur_target_id(id)
    self.cur_target_id = id
end

function human:get_current_pet()
    return self.pet
end

function human:get_bank_save_money()
    return self.db:get_attrib("bank_save_money")
end

function human:get_equip_visuals()
    local equip_visuals = {}
    -- local equip_container = self:get_equip_container()
	
	-- local local_get_equip_visual = function(eq_point,flag)
		-- local equipid,gemid,visual = define.INVAILD_ID,define.INVAILD_ID,0
		-- local gemid2,gemid3 = define.INVAILD_ID,define.INVAILD_ID
        -- local equip = equip_container:get_item(eq_point)
		-- if equip then
			-- local equip_data = equip:get_equip_data()
			-- visual = equip_data:get_visual()
			-- if visual > 0 then
				-- equipid = equip:get_index()
				-- gemid = equip_data:get_slot_gem(1)
				-- if gemid <= 0 then
					-- gemid = define.INVAILD_ID
				-- end
				-- if flag then
					-- gemid2 = equip_data:get_slot_gem(2)
					-- if gemid2 <= 0 then
						-- gemid2 = define.INVAILD_ID
					-- end
					-- gemid3 = equip_data:get_slot_gem(3)
					-- if gemid3 <= 0 then
						-- gemid3 = define.INVAILD_ID
					-- end
				-- end
			-- else
				-- visual = 0
			-- end
		-- end
		-- return equipid,gemid,visual,gemid2,gemid3
	-- end
    do
		local visual,index,gemid = self:get_cur_weapon_visual(self:get_scene_id())
        equip_visuals.weapon = { item_index = index, gem_id = gemid, visual = visual }
    end
    do
		-- local equipid,gemid,visual = local_get_equip_visual(define.HUMAN_EQUIP.HEQUIP_CAP)
        -- equip_visuals.cap = { item_index = equipid, gem_id = gemid, visual = visual }
        equip_visuals.cap = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_CAP)
    end
    do
		-- local equipid,gemid,visual = local_get_equip_visual(define.HUMAN_EQUIP.HEQUIP_ARMOR)
        -- equip_visuals.armour = { item_index = equipid, gem_id = gemid, visual = visual }
        equip_visuals.armour = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_ARMOR)
    end
    do
		-- local equipid,gemid,visual = local_get_equip_visual(define.HUMAN_EQUIP.HEQUIP_GLOVE)
        -- equip_visuals.cuff = { item_index = equipid, gem_id = gemid, visual = visual }
        equip_visuals.cuff = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_GLOVE)
    end
    do
		-- local equipid,gemid,visual = local_get_equip_visual(define.HUMAN_EQUIP.HEQUIP_BOOT)
        -- equip_visuals.foot = { item_index = equipid, gem_id = gemid, visual = visual }
        equip_visuals.foot = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_BOOT)
    end
    do
		-- local equipid,gemid,visual,gemid_2,gemid_3 = local_get_equip_visual(define.HUMAN_EQUIP.HEQUIP_FASHION,true)
        -- equip_visuals.fashion = { item_index = equipid, visual = visual, gem_1 = gemid, gem_2 = gemid_2, gem_3 = gemid_3 }
        equip_visuals.fashion = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_FASHION)
    end
    return equip_visuals
end

function human:set_datura_flower_max(count)
    self.db:set_db_attrib({ datura_flower_max = count })
end

function human:set_bank_save_money(money, reason, extra)
    assert(money >= 0 )
    money = math.floor(money)
    money = money > define.INT32_MAX and define.INT32_MAX or money
    local before = self:get_bank_save_money()
    self.db:set_db_attrib({ bank_save_money = money })
    self:log_money_rec(reason, "银行金币", before, money - before, extra)
end

function human:unlock_exterior_head(id)
    if id == define.INVAILD_ID then
        return false
    end
    local heads = self.exterior.heads
    local find = false
    for _, h in ipairs(heads) do
        if h.id == id then
            find = true
            break
        end
    end
    if not find then
        table.insert(heads, { id = id, term = -1})
        self:send_exterior_info()
        return true
    end
    return false
end

function human:unlock_exterior_face(id)
    if id == define.INVAILD_ID then
        return false
    end
    local faces = self.exterior.faces
    local find = false
    for _, h in ipairs(faces) do
        if h.id == id then
            find = true
            break
        end
    end
    if not find then
        table.insert(faces, { id = id, term = -1})
        self:send_exterior_info()
        return true
    end
    return false
end

function human:unlock_exterior_hair(id)
    if id == define.INVAILD_ID then
        return false
    end
    local hairs = self.exterior.hairs
    local find = false
    for _, h in ipairs(hairs) do
        if h.id == id then
            find = true
            break
        end
    end
    if not find then
        table.insert(hairs, { id = id, term = -1})
        self:send_exterior_info()
        return true
    end
    return false
end

function human:unlock_exterior_poss(id)
    if id == define.INVAILD_ID then
        return false
    end
    local poss = self.exterior.poss
    local find = false
    for _, h in ipairs(poss) do
        if h.id == id then
            find = true
            break
        end
    end
    if not find then
        table.insert(poss, { id = id, term = -1})
        self:send_exterior_poss_info(poss[#poss])
        return true
    end
    return false
end

function human:unlock_exterior_ranse(soul_id, index, color_value, target_id)
    local ranse = self.exterior.ranse
    ranse[soul_id][index] = color_value
    self:send_exterior_ranse(2, target_id)
end

function human:send_exterior_ranse(type, target_id)
    local msg = packet_def.GCPetSoulRanSe.new()
    msg.type = type
    msg.list = self.exterior.ranse
    msg.select = self:get_exterior_ranse_select()
    msg.target_id = target_id or define.INVAILD_ID
    self:get_scene():send2client(self, msg)
    -- local ret = packet_def.GCOrnamentsDataUpdate.new()
	-- ret.op_target = 2
	-- ret.op_code = 1
	-- ret.OrnamentsBackUnit = self:get_exterior_back_info()
	-- ret.OrnamentsBackUnitNum = #ret.OrnamentsBackUnit
	-- ret.OrnamentsHeadUnit = self:get_exterior_head_info()
	-- ret.OrnamentsHeadUnitNum = #ret.OrnamentsHeadUnit
	-- ret.CurOrnamentsBackId,ret.CurOrnamentsBackPos = self:get_exterior_back_visual_id()
	-- ret.CurOrnamentsHeadId,ret.CurOrnamentsHeadPos = self:get_exterior_head_visual_id()
	-- self:get_scene():send2client(self, ret)
end

function human:set_exterior_ranse_id(id)
    self.db:set_db_attrib({ exterior_ranse_id = id})
end

function human:set_exterior_ranse_select_by_ranse_id(pet_soul_id, ranse_id)
    local select = 0
    local ranse = self.exterior.ranse[pet_soul_id]
    for i = 1, 3 do
        if ranse[i] == ranse_id then
            select = i
            break
        end
    end
    self.db:set_db_attrib({ exterior_ranse_select = select })
end

function human:get_exterior_ranse_select()
    return self.db:get_db_attrib("exterior_ranse_select") or 0
end

function human:get_exterior_ranse_id()
    return self.db:get_db_attrib("exterior_ranse_id") or 0
end

function human:send_exterior_poss_info(poss)
    local msg = packet_def.GCExteriorInfo.new()
    msg.extrior_count = 1
    msg.extrior_list = {}
    table.insert(msg.extrior_list, { id = poss.id, remindtime = poss.term, unknow_3 = 0})
    msg.type = 7
    msg.unknow_2 = 1
    self:get_scene():send2client(self, msg)
end

function human:reset_ability_opera()
    self.ability_opera = {
        ability_id = 0,
        pres_id = 0,
        obj = define.INVAILD_ID,
        max_time = 0,
        cur_time = 0,
        mat_index = define.INVAILD_ID,
        mat_bag_index = define.INVAILD_ID
    }
end

function human:get_ability_opera()
    return self.ability_opera
end

function human:get_save_data()
    return {
        lv1_attrib = self.db:get_lv1_attrib(),
        attrib = self.db:get_db_save_attrib(),
        impact_list = self.impacts:get_list(),
        world_pos = self.world_pos,
        sceneid = self.sceneid,
        double_exp_info = self.double_exp_info,
        equip_list = self:get_equip_container():get_save_data(),
        prop_bag_list = self:get_prop_bag():get_save_data(),
        pet_bag_list = self:get_pet_bag_container():get_save_data(),
        pet_bank_list = self:get_pet_bank_container():get_save_data(),
        bank_bag_list = self:get_bank_bag_container():get_save_data(),
        fashion_bag_list = self:get_fasion_bag_container():get_save_data(),
        chedifulu_data = self.chedifulu_data,
        material_bag_size = self.material_bag_size,
        exterior = self.exterior,
        rmb_chat_face_info = self.rmb_chat_face_info,
        skill_list = self:get_skill_list(),
        xinfa_list = self:get_xinfa_list(),
        talent = self:get_talent(),
        xiulian_list = self:get_xiulian_list(),
        ability_list = self:get_ability_list(),
        prescriptions = self:get_prescriptions(),
        mission_data = self.mission_data,
        dungeonsweep = self.dungeonsweep,
        week_active = self.week_active,
        setting = self.setting,
        cool_down_times = self.cool_down_times,
        huanhun = self.huanhun or {},
        -- attackers_list = self.attackers_list:get_save_data() or {},
        pk_declaration_list = self.pk_declaration_list:get_save_data() or {},
        shop_guids = self.shop_guids or {},
        titles = self.titles or {},
        id_titles = self.id_titles or {},
        mystery_shop_info = self.mystery_shop_info,
        jiyuan_shop_info = self.jiyuan_shop_info,
        wanshige_shop_info = self.wanshige_shop_info,
		limit_shop = self.limit_shop,
		-- relation = self.relation_list,
		game_flag = self.game_flag,
		dw_jinjie = self.dw_jinjie,
		
    }
end

function human:update(...)
    self:check_pk_mode_can_change(...)
    self.attr_msg_to_team_inteval_count = self.attr_msg_to_team_inteval_count + 1
    if self.attr_msg_to_team_inteval_count > 9 then
        self.attr_msg_to_team_inteval_count = 0
        self:sync_team_member_info()
        self:sync_raid_member_info()
    end
    self:send_refresh_cool_down_time(...)
    self:update_double_exp_info(...)
    self:update_ve_recover(...)
    self:update_mission_timers(...)
    -- self.attackers_list:on_heart_beat(...)
    self.pk_declaration_list:on_heart_beat(...)
    character.update(self, ...)
	local delta_time = ...
	if self.player_tick > delta_time then
		self.player_tick = self.player_tick - delta_time
	else
		self.player_tick = self.player_tick + 5000
		local selfId = self:get_obj_id()
		self:get_scene():get_script_engienr():call(define.UPDATE_CLIENT_ICON_SRIPTID,"OnPlayerTick",-1 * selfId)
	end
	
	if self.check_item_time > delta_time then
		self.check_item_time = self.check_item_time - delta_time
	else
		self.check_item_time = math.random(60000,120000)
		self:check_item_valid_timer()
	end
	if self.restore_hp_reset_time > 0 then
		if self.restore_hp_tick > delta_time then
			self.restore_hp_tick = self.restore_hp_tick - delta_time
		else
			self.restore_hp_value = 0
			self.restore_hp_tick = self.restore_hp_reset_time * 1000
		end
	end
    --self:log_views()
end

function human:set_restore_hp_reset_time(ntime,nrate)
	if ntime >= 0 and nrate >= 0 then
		self.restore_hp_rate = nrate
		self.restore_hp_reset_time = ntime
	end
end

function human:get_limit_restore_hp()
	return self.restore_hp_rate,self.restore_hp_value,self.restore_hp_reset_time
end

function human:set_restore_hp_value(value)
	self.restore_hp_value = self.restore_hp_value + value
end

function human:log_views()
    local view_obj_count = 0
    for k in pairs(self.view) do
        view_obj_count = view_obj_count + 1
    end
    -- skynet.logi("view_obj_count =", view_obj_count)
end

function human:get_attackers()
    -- return self.attackers_list
    return self.pk_declaration_list
end

function human:get_pk_declaration_list()
    return self.pk_declaration_list
end

function human:get_wild_war_guilds()
    return self.wild_war_guilds
end

function human:get_guild_id()
    return self.db:get_db_attrib("guild_id") or define.INVAILD_ID
end

function human:get_guild_name()
    return self.db:get_db_attrib("guild_name") or ""    
end

function human:get_confederate_id()
    return self.db:get_db_attrib("confederate_id") or define.INVAILD_ID
end

function human:begin_shop(shop)
    self.shop = shop
end

function human:end_shop()
    self.shop = nil
end

function human:buy_back(request)
    local msg = packet_def.GCShopBuy.new()
    msg.result = msg.BUY_RESULT.BUY_BACK_OK
    local sold_out_container = self:get_sold_out_container()
    local index = sold_out_container:get_index_by_guid(request.item_guid)
    local item = sold_out_container:get_item(index)
    assert(item, index)
    local price = item:get_base_config().base_price * item:get_lay_count()
    local money = self:get_money()
    if money >= price then
        local bag_index = self:get_prop_bag_container():get_empty_item_index(item:get_place_bag())
        if bag_index ~= define.INVAILD_ID then
            money = money - price
            self:set_money(money, "从商店买回道具")
            local isdel = sold_out_container:set_item(index, nil)
			if not isdel then
				self:get_prop_bag_container():set_item(bag_index, item)
				
				local collection = "human_buy_back"
				local doc = { 
				name = self:get_name(),
				guid = self:get_guid(),
				param = {act_name = "回购道具",fun_name = "human:buy_back",},
				item_index = item:get_index(),
				item_count = item:get_lay_count(),
				is_bind = item:is_bind(),
				date_time = utils.get_day_time()
				}
				skynet.send(".logdb", "lua", "insert", { collection = collection, doc = doc })
				
				self:send_sold_out_list()
				item = self:get_prop_bag_container():get_item(bag_index)

				local equip_info = packet_def.GCNotifyEquip.new()
				equip_info.bag_index = bag_index
				equip_info.item = item:copy_raw_data()
				self:get_scene():send2client(self, equip_info)

				local item_info = packet_def.GCItemInfo.new()
				item_info.bagIndex = bag_index
				item_info.unknow_1 = item and 0 or 1
				item_info.item = item and item:copy_raw_data() or Item_cls.new():copy_raw_data()
				self:get_scene():send2client(self, item_info)

				msg.index = index
				msg.item_index = item:get_index()
				msg.item_count = item:get_lay_count()
				msg.count = 1
			else
				msg.result = msg.BUY_RESULT.BUY_BAG_FULL
			end
        else
            msg.result = msg.BUY_RESULT.BUY_BAG_FULL
        end
    else
        msg.result = msg.BUY_RESULT.BUY_MONEY_FAIL
    end
    self:get_scene():send2client(self, msg)
end

function human:shop_sell(sell_bag_index)
    local item = self:get_prop_bag_container():get_item(sell_bag_index)
    if item then
        local can_sell = item:can_sell()
        if not can_sell then
            self:notify_tips(string.format("%s不能出售", item:get_name()))
            return
        end
        local extra_config = item:get_extra_config()
        local price = item:get_base_config().sell_price * item:get_lay_count()
        local sold_out_container = self:get_sold_out_container()
        local bag_index = sold_out_container:get_empty_item_index()
        if bag_index == define.INVAILD_ID then
            sold_out_container:remove_item(0)
            bag_index = sold_out_container:get_empty_item_index()
        end
        assert(bag_index ~= define.INVAILD_ID, bag_index)
        local logpram = {}
        human_item_logic:move_item_from_bag_to_container_with_index(logpram, self, sold_out_container, sell_bag_index, bag_index)
        if extra_config and extra_config.sell_money_type == 0 then
            local money = self:get_money()
            money = money + price
            self:set_money(money, "物品出售给商店获得金币", { item = item:copy_raw_data() })
        else
            local money = self:get_jiaozi()
            money = money + price
            self:set_jiaozi(money, "物品出售给商店获得交子", { item = item:copy_raw_data() } )
        end
    
        item = self:get_prop_bag_container():get_item(sell_bag_index)
        local msg = packet_def.GCItemInfo.new()
        msg.bagIndex = sell_bag_index
        msg.unknow_1 = item and 0 or 1
        msg.item = item and item:copy_raw_data() or Item_cls.new():copy_raw_data()
        self:get_scene():send2client(self, msg)
    
        self:send_sold_out_list()
        msg = packet_def.GCShopSell.new()
        msg.result = msg.SELL_RESULT.SELL_OK
        self:get_scene():send2client(self, msg)
    end
end

function human:do_jump()
    if self:is_limit_move() then
        return define.OPERATE_RESULT.OR_LIMIT_MOVE
    end
    actionenginer:interrupt_current_action(self)
    local msg = packet_def.GCCharJump.new()
    msg.m_objID = self:get_obj_id()
    self:get_scene():broadcast(self, msg, false)
    return define.OPERATE_RESULT.OR_OK
end

function human:interrupt_current_ability_opera()

end

function human:do_shop(index, buy_num)
	local scene = self:get_scene()
	local sceneId = scene:get_id()
    local merchandise = self.shop:get_merchadise_by_index(index)
	local itemid = merchandise.id
	local have_count,is_special
	local shop_id = self.shop.shop_id
	local limit_shop_human = define.LIMIT_SHOP_HUMAN[shop_id]
	if limit_shop_human then
		if self:get_game_flag_key(limit_shop_human) == 0 then
			self:notify_tips("该商店你无法购买。")
			return
		end
	end
	local shop_flag = 0
	local buy_name = "商店购买"
	local update_interval = define.REGION_LIMITED_SHOP[shop_id]
	if update_interval then
		shop_flag = 1
		buy_name = "全区限购"
		local ranking_addr = skynet.localname(define.CACHE_NODE)
		if not ranking_addr then
			self:notify_tips("服务未启动，请通知GM处理。")
			return
		elseif define.IS_KUAFU_SCENE[sceneId] then
			self:notify_tips(selfId,"跨服不可购买。")
			return
		end
		if merchandise.pmax ~= -1 then
			local world_id = self:get_server_id()
			local count = skynet.call(define.CACHE_NODE,"lua","get_limit_shop_buy_count",world_id,update_interval,shop_id,itemid)
			if count + buy_num > merchandise.pmax then
				self:notify_tips("可购买次数不足")
				return
			end
		end
	elseif define.LIMIT_SHOP[shop_id] then
		shop_flag = 2
		buy_name = "个人限购"
		local count = self:get_limit_shop_buy_count(shop_id,itemid)
		if not count then
			self:notify_tips("请重新登陆游戏，你尚未初始化该商店数据。")
			return
		elseif merchandise.pmax ~= -1 then
			if count + buy_num > merchandise.pmax then
				self:notify_tips("可购买次数不足")
				return
			end
		end
	else
		have_count,is_special = self:check_shop_goods_buy(shop_id, itemid, merchandise, buy_num)
		if is_special then
			shop_flag = 3
			buy_name = "个人限购"
		end
		if not have_count then
			self:notify_tips("可购买次数不足")
			return
		end
	end
    local shop_type = self.shop.shop_type
    local msg = packet_def.GCShopBuy.new()
    local cost_money = merchandise.price * buy_num
    if self:check_cost_money_by_shop_type(shop_type, cost_money) then
        local is_bind = define.BIND_YUANBAO_SHOPS[shop_id] or false
        local item_count = buy_num * merchandise.pnum
        local logparam = { reason = buy_name, user_name = self:get_name(), user_guid = self:get_guid() }
        local ok = human_item_logic:create_multi_item_to_bag(logparam, self, itemid, item_count, is_bind, shop_type)
        if ok then
            msg.result = msg.BUY_RESULT.BUY_OK
            msg.index = index
            msg.item_index = itemid
            msg.item_count = item_count
            msg.count = item_count
            msg.flag = 1
            msg.price = cost_money
            msg.unknow_11 = 10
            msg.unknow_2 = 0
            msg.shop_id = shop_id
            msg.unknow_8 = -1
            msg.unknow_9 = 100
			local extra = {
				buyitem = itemid,
				buynum = item_count,
			}
            self:cost_money_by_shop_type(shop_type, cost_money,extra)
			if shop_flag == 1 then
				local world_id = self:get_server_id()
				local buy_counts = skynet.call(define.CACHE_NODE,"lua","set_limit_shop_buy_count",world_id,shop_id,itemid,buy_num)
				if buy_counts then
					local msg = packet_def.GCMSShopBuyInfo.new()
					msg.size = 0
					msg.unknow_1 = {}
					msg.unknow_2 = {}
					for id, count in pairs(buy_counts) do
						table.insert(msg.unknow_1, tonumber(id))
						table.insert(msg.unknow_2, count)
						msg.size = msg.size + 1
					end
					scene:send2client(self, msg)
				else
					local collection = "log_error_limit_shops"
					local doc = {
						fun_name = "human:do_shop",
						name = self:get_name(),
						guid = self:get_guid(),
						itemid = itemid,
						buy_num = buy_num,
						prize = cost_money
					}
					skynet.send(".logdb", "lua", "insert", { collection = collection, doc = doc})
				end
			elseif shop_flag == 2 then
				self:set_limit_shop_buy_count(shop_id,itemid,buy_num)
			elseif shop_flag == 3 then
				self:on_shop_goods_buy(shop_id, itemid, buy_num)
			end
        else
            msg.result = msg.BUY_RESULT.BUY_BAG_FULL
        end
    else
        msg.result = msg.BUY_RESULT.BUY_RMB_FAIL
    end
    scene:send2client(self, msg)
end

function human:check_shop_goods_buy(shop_id, goods_id, merchandise, buy_num)
    local this_shop = shopenginer:get_static_shop_mgr():get_shop_by_id(shop_id)
    if this_shop.is_yuanbao_shop == 2 then
        local buy_count = self:get_mystery_shop_count_by_id(goods_id)
        return merchandise.pmax == define.INVAILD_ID or (buy_count + buy_num) <= merchandise.pmax,true
    end
    return true,false
end

function human:on_shop_goods_buy(shop_id, goods_id, buy_num)
    local this_shop = shopenginer:get_static_shop_mgr():get_shop_by_id(shop_id)
    if this_shop.is_yuanbao_shop == 2 then
        local insertd = false
        for _, info in ipairs(self.mystery_shop_info) do
            if info.goods_id == goods_id then
                info.count = info.count + buy_num
                insertd = true
                break
            end
        end
        if not insertd then
            table.insert(self.mystery_shop_info, { goods_id = goods_id, count = buy_num})
        end
        self:send_mystery_shop_info()
    end
end

function human:get_mystery_shop_count_by_id(id)
    for _, msi in ipairs(self.mystery_shop_info) do
        if msi.goods_id == id then
            return msi.count
        end
    end
    return 0
end

function human:on_wanshige_shop_buy(item_id, camp)
    self.wanshige_shop_info.item_list = self.wanshige_shop_info.item_list or {}
    self.wanshige_shop_info.item_list[tostring(item_id)] = (self.wanshige_shop_info.item_list[tostring(item_id)] or 0) + 1
    self:send_shengwang_info(camp)
end

function human:check_reset_wanshige_data()
    local reset_week_day = self.wanshige_shop_info.reset_week_day
    local week_day = os.date("%w") + 1
    if reset_week_day ~= week_day then
        self.wanshige_shop_info.item_list = {}
        self.wanshige_shop_info.reset_week_day = week_day
    end
end

function human:get_wanshige_shop_count_by_id(id)
    return self.wanshige_shop_info.item_list[tostring(id)] or 0
end

function human:on_jiyuan_shop_buy(item_id, targetId)
    item_id = tostring(item_id)
    self.jiyuan_shop_info.item_list = self.jiyuan_shop_info.item_list or {}
    self.jiyuan_shop_info.item_list[item_id] = (self.jiyuan_shop_info.item_list[item_id] or 0) + 1
    self:send_jiyuan_shop_info(targetId)
	return self.jiyuan_shop_info.item_list[item_id]
end

function human:send_jiyuan_shop_info(targetId)
    local item_list = {}
    for item_id, count in pairs(self.jiyuan_shop_info.item_list or {}) do
        table.insert(item_list, { id = tonumber(item_id), count = count})
    end
    local msg = packet_def.GCJiYuanShopInfo.new()
    msg.item_id = item_list[1] and item_list[1].id or 0
    msg.item_count = item_list[1] and item_list[1].count or 0
    msg.m_objID = targetId
    self:get_scene():send2client(self, msg)
end

function human:check_jiyuan_shop_info()
    local reset_week = self.jiyuan_shop_info.reset_week
    local week = os.date("%W")
    if reset_week ~= week then
        self.jiyuan_shop_info.item_list = {}
        self.jiyuan_shop_info.reset_week = week
    end
end

function human:get_jiyuan_shop_count_by_id(id)
    self.jiyuan_shop_info.item_list = self.jiyuan_shop_info.item_list or {}
    return self.jiyuan_shop_info.item_list[tostring(id)] or 0
end

function human:send_shengwang_info(camp)
    local player_camp = self:get_mission_data_by_script_id(854) or 0
    local msg = packet_def.GCShengWangInfo.new()
    msg.unknow_1 = 3
    msg.unknow_10 = 0
    msg.camp = camp
    msg.unknow_3 = 6
    msg.player_camp = player_camp
    msg.show_wanshige = player_camp == camp and 1 or 0
    msg.unknow_6 = 1
    msg.unknow_7 = 0
    msg.list_1 = { 5, 3, 8 }
    msg.list_2 = { 0, 0, 0 }
    msg.item_list = {}
    for id, count in pairs(self.wanshige_shop_info.item_list or {}) do
        --table.insert(msg.item_list, { id = tonumber(id), count = count})
    end
    self:get_scene():send2client(self, msg)
end

function human:send_mystery_shop_info()
    local msg = packet_def.GCMSShopBuyInfo.new()
    msg.size = #self.mystery_shop_info
    msg.unknow_1 = {}
    msg.unknow_2 = {}
    for _, info in ipairs(self.mystery_shop_info) do
        table.insert(msg.unknow_1, info.goods_id)
        table.insert(msg.unknow_2, info.count)
    end
    self:get_scene():send2client(self, msg)
end

function human:send_digong_shop_info()
    local msg = packet_def.GCDiGongShopInfo.new()
    self:get_scene():send2client(self, msg)
end

function human:reset_mystery_shop_info()
    self.mystery_shop_info = {}
end

function human:cal_shop_goods_pmax(shop_id, goods_id, pmax)
    if pmax == define.INVAILD_ID then
        return pmax
    end
    local day = self.shop_goods_buy.day
    local day_shop_buy = day[tostring(shop_id)] or {}
    pmax = pmax - (day_shop_buy[tostring(goods_id)] or 0)
    pmax = pmax < 0 and 0 or pmax
    return pmax
end

function human:check_cost_money_by_shop_type(shop_type, cost)
    if shop_type == 5 then
        local yuanbao = self:get_yuanbao()
        return yuanbao >= cost
    elseif shop_type == 9 then
        local yuanbao = self:get_bind_yuanbao() + self:get_yuanbao()
        return yuanbao >= cost
	elseif shop_type == 21 then
		local haveryd = self:get_mission_data_by_script_id(535)
		if haveryd >= cost then
			return true
		end
		self:notify_tips("荣誉点不足，你当前拥有荣誉点:"..tostring(haveryd).."。")
		return false
    elseif shop_type == 8 then
        return self:check_money_with_priority(cost)
    else
        local money = self:get_money()
        return money >= cost
    end
end

function human:log_money_rec(reason, coin_type, before, num, extra)
    extra = extra or {}
    local collection = "log_money_rec"
    local doc = {
        coin_type = coin_type,
        day_time = utils.get_day_time(),
        unix_time = os.time(),
        guid = self:get_guid(),
        name = self:get_name(),
        reason = reason,
        before = before,
        num = num,
        extra = extra,
        world_id = self:get_server_id(),
        process_id = tonumber(skynet.getenv "process_id")
    }
    skynet.send(".logdb", "lua", "insert", { collection = collection, doc = doc})
end

function human:cost_money_by_shop_type(shop_type, cost, extra)
    extra = extra or {}
    extra.shop_type = extra.shop_type
    if shop_type == 5 then
        local yuanbao = self:get_yuanbao()
        self:set_yuanbao(yuanbao - cost, "商店购买消费", extra)
        local val = self:get_mission_data_by_script_id(389) or 0
        self:set_mission_data_by_script_id(389, val + cost)
        self:add_mission_huoyuezhi(8, cost)
    elseif shop_type == 9 then
        local yuanbao = self:get_bind_yuanbao()
        if yuanbao < cost then
            self:set_bind_yuanbao(0, "商店购买消费", extra)
            local left = cost - yuanbao   
            yuanbao = self:get_yuanbao()
            self:set_yuanbao(yuanbao - left, "商店购买消费-绑元不足支付", extra)
            local val = self:get_mission_data_by_script_id(389) or 0
            self:set_mission_data_by_script_id(389, val + left)
            self:add_mission_huoyuezhi(8, left)
        else
            self:set_bind_yuanbao(yuanbao - cost, "商店购买消费", extra)
        end
        self:add_mission_huoyuezhi(9, cost)
	elseif shop_type == 21 then
		local curvalue = self:get_mission_data_by_script_id(535)
		local subvalue = curvalue - cost
		self:set_mission_data_by_script_id(535, subvalue)
		self:log_money_rec(subvalue, "荣誉点商店购买消费", curvalue,subvalue - curvalue,extra)
    elseif shop_type == 8 then
        self:cost_money_with_priority(cost, "商店购买消费", extra)
    else
        local money = self:get_money()
        self:set_money(money - cost, "商店购买消费", extra)
    end
end

function human:get_impact_list()
    return self.impacts:get_list()
end

function human:get_stall_box()
    return self.stall_box
end

function human:get_exchange_box()
    return self.exchange_box
end

function human:get_prop_bag()
    return self.prop_bag_container
end

function human:get_bank_bag_container()
    return self.bank_bag_container
end

function human:get_pet_bag_container()
    return self.pet_bag_container
end

function human:get_pet_bank_container()
    return self.pet_bank_container
end

function human:get_sold_out_container()
    return self.sold_out_container
end

function human:get_equip_container()
    return self.equip_container
end

function human:get_prop_bag_container()
    return self.prop_bag_container
end

function human:get_fasion_bag_container()
    return self.fasion_bag_container
end

function human:update_fasion_buff(fasionid,buff_flag)
	local env = skynet.getenv("env")
	if define.ADD_EQUIP_BUFF[env] then
		for _,dy_info in ipairs(define.ADD_EQUIP_BUFF[env]) do
			if dy_info[define.HUMAN_EQUIP.HEQUIP_FASHION] then
				local fasion_buff = dy_info[define.HUMAN_EQUIP.HEQUIP_FASHION].BUFFID
				local list = self:get_impact_list()
				local istrue
				if fasionid >= dy_info[define.HUMAN_EQUIP.HEQUIP_FASHION].MINID
				and fasionid <= dy_info[define.HUMAN_EQUIP.HEQUIP_FASHION].MAXID then
					if buff_flag then
						istrue = false
						for _, imp in ipairs(list) do
							if imp:get_data_index() == fasion_buff then
								istrue = true
								break
							end
						end
						if not istrue then
							impactenginer:send_impact_to_unit(self, fasion_buff, self, 100, false, 0)
						end
					else
						for _, imp in ipairs(list) do
							if imp:get_data_index() == fasion_buff then
								self:on_impact_fade_out(imp)
								self:remove_impact(imp)
								break
							end
						end
					end
				end
			end
		end
	end
end

function human:get_menpai()
    return self.db:get_attrib("menpai")
end

function human:get_attack_traits_type()
    return self:get_menpai()
end

function human:get_equip_list()
    return self.equip_container:copy_raw_data()
end

function human:get_equip(equip_point)
    return self.equip_container:get_item(equip_point)
end

function human:get_wuhun_wg()
    return self.huanhun
end

function human:send_wuhun_wg(who, type, id)
    -- type = 2
    local msg = packet_def.GCWuhunWG.new()
	msg.type = type
    -- if type == 2 then
        -- msg.type = 2
        -- msg.huanhun_id = huanhun_id
    -- else
        -- msg.type = 0
        -- msg.wg = 0
    -- end
    local unlocked = table.clone(self.huanhun)
    local huanhun_unlock_count = 0
    msg.unlockd = {}
	local huanhun_id = 0
    for i = 1, 6 do
        i = tostring(i)
        if unlocked[i] then
            unlocked[i].id = tonumber(i)
            table.insert(msg.unlockd, unlocked[i])
            huanhun_unlock_count = huanhun_unlock_count + 1
            huanhun_id = tonumber(i)
        end
    end
    if type == 2 then
        msg.huanhun_id = id or huanhun_id
    else
        msg.wg = id or 0
    end
	
    -- msg.huanhun_id = huanhun_id or 0
    msg.huanhun_unlock_count = huanhun_unlock_count
    self.scene:send2client(who, msg)
end

function human:get_skill_level(skill_id)
    print("get_skill_level skill_id =", skill_id)
    local template = skillenginer:get_skill_template(skill_id)
    assert(template, tostring(skill_id))
    local xinfa_id = template.xinfa
    local xinfa = self:get_xinfa(xinfa_id)
    if xinfa then
        return math.ceil(xinfa.m_nXinFaLevel / 10) + 1
    else
        return character.get_skill_level(self, skill_id)
    end
end

function human:add_lingwu_skill(skill)

end

function human:get_item_bag_list()
    return self.prop_bag_container:copy_raw_data()
end

function human:get_fasion_bag_list()
    return self.fasion_bag_container:copy_raw_data()
end

function human:get_xinfa_list()
    return self.xinfa_list
end

function human:get_talent()
    return self.talent
end

function human:get_xinfa(id)
    for _, xinfa in ipairs(self.xinfa_list) do
        if xinfa.m_nXinFaID == id then
            return xinfa
        end
    end
end

function human:study_xinfa(id, level)
    for _, xinfa in ipairs(self.xinfa_list) do
        if xinfa.m_nXinFaID == id then
            xinfa.m_nXinFaLevel = level
            break
        end
    end
    local learn_new_skill = self:on_study_xinfa(id, level)
    if learn_new_skill then
        self:send_skill_list()
    end
end

function human:on_study_xinfa(id, level)
    local skills = {}
    local learn_new_skill = false
    local menpai = self:get_attrib("menpai")
    if id == define.MENPAI_7_XINFA[menpai] or id == define.MENPAI_8_XINFA[menpai] then
        return
    end
    local templates = skillenginer:get_skill_templates()
    for _, template in pairs(templates) do
        if template.class_by_user == 0 and template.xinfa == id then
            skills[template.id] = true
        end
    end
    for skill in pairs(skills) do
        local find = false
        local exist_skills = self:get_skill_list()
        for _, es in ipairs(exist_skills) do
            if skill == es then
                find = true
                break
            end
        end
        if not find then
            self:add_skill(skill)
            learn_new_skill = true
        end
    end
    return learn_new_skill
end

function human:get_ability_list()
    return self.ability_list
end

function human:get_prescriptions()
    return self.prescriptions
end

function human:have_ability(id)
    return self:get_ability(id) ~= nil
end

function human:get_ability(id)
    for _, ability in ipairs(self.ability_list) do
        if ability.id == id then
            return ability
        end
    end
end

function human:study_ability(id, exp, level)
    local to_set_ability
    for _, ability in ipairs(self.ability_list) do
        if ability.id == id then
            to_set_ability = ability
            break
        end
    end
    if to_set_ability then
        to_set_ability.level = level
    else
        table.insert(self.ability_list, { id = id, exp = exp, level = level})
    end
    self:on_study_ability(id, level)
end

function human:add_ability_exp(id, exp)
    local ability = self:get_ability(id)
    ability.exp = ability.exp + exp
end

function human:set_ability_exp(id, exp, exp_top)
    local ability = self:get_ability(id)
    ability.exp = exp
    local msg = packet_def.GCAbilityExp.new()
    msg.ability = id
    msg.exp = exp
    msg.exp_top = exp_top or 0
    self:get_scene():send2client(self, msg)
end

function human:get_ability_exp(id)
    local ability = self:get_ability(id)
    return ability.exp
end

function human:study_prescription(id, flag)
    if id < 0 or id > define.MAX_ABILITY_PRESCRIPTION_NUM then
        assert(false, id)
        return
    end
    local index = (id >> 3) + 1
    local bit = 0x01 << id % 8
    --print("human:study_prescription id =", id, ";index =", index, ";bit =", bit)
    index = tostring(index)
    if flag then
        self.prescriptions[index] = (self.prescriptions[index] or 0) | bit
    else
        self.prescriptions[index] = (self.prescriptions[index] or 0)  & ~bit
    end
    local msg = packet_def.GCPrescription.new()
    msg.id = id
    msg.learn_or_abandon = flag and 1 or 0
    self.scene:send2client(self, msg)
end

function human:is_prescription_have_learnd(id)
    if id < 0 or id > define.MAX_ABILITY_PRESCRIPTION_NUM then
        assert(false, id)
        return false
    end
    local index = (id >> 3) + 1
    local bit = 0x01 << id % 8
    index = tostring(index)
    return (self.prescriptions[index] or 0) & bit == bit
end

function human:send_ability_list()
    local ability_list = self:get_ability_list()
    local prescriptions = self:get_prescriptions()
    local ret = packet_def.GCDetailAbilityInfo.new()
    ret.m_aAbility = {}
    ret.m_uAbilityIDList = {}
    for _, ability in ipairs(ability_list) do
        local ab = { m_Exp = ability.exp, m_Level = ability.level}
        table.insert(ret.m_aAbility, ab)
        table.insert(ret.m_uAbilityIDList, ability.id)
    end
    ret.m_objID = self:get_obj_id()
    ret.m_wNumAbility = #ability_list
    ret.m_aPrescr = {}
    for i = 1, 0x100 do
        i = tostring(i)
        table.insert(ret.m_aPrescr, prescriptions[i] or 0)
    end
    self:get_scene():send2client(self, ret)
end

function human:stop_character_logic(...)
    self.character_logic_stopped = true
    self:on_stop_character_logic(...)
    self:set_character_logic(define.ENUM_CHARACTER_LOGIC.CHARACTER_LOGIC_IDLE)
end


function human:on_study_ability(id, level)
    local msg = packet_def.GCAbilityLevel.new()
    msg.id = id
    msg.level = level
    self.scene:send2client(self, msg)
end

function human:clear_xinfa_list()
    self.xinfa_list = {}
end

function human:get_skill_list()
    return self.skill_list
end

function human:get_wuhun_skills()
    local skills = {}
    local kfs = self:get_equip_container():get_item(define.HUMAN_EQUIP.HEQUIP_WUHUN)
    if kfs then
        local wh_skills = kfs:get_equip_data():get_wh_skill()
        for i = 1, 3 do
            local skill = wh_skills[i]
            if skill ~= define.INVAILD_ID then
                table.insert(skills, skill)
            end
        end
    end
    return skills
end

function human:get_equip_add_skills()
    local skills = {}
    local equip_add_skills = self.db:get_equip_add_skills()
    for sk in pairs(equip_add_skills) do
        if sk ~= define.INVAILD_ID then
            table.insert(skills, sk)
        end
    end
    return skills
end

function human:get_total_skills_list()
    local total = table.clone(self:get_skill_list())
    local shenbing = self:get_equip_container():get_item(define.HUMAN_EQUIP.SHENBING)
    if shenbing then
        local shenbing_skill = shenbing:get_equip_data():get_fwq_change_skill()
		if shenbing_skill ~= -1 then
			table.insert(total, shenbing_skill)
		end
	end
    local wh_skills = self:get_wuhun_skills()
    local equip_skills = self:get_equip_add_skills()
    for _, sk in ipairs(wh_skills) do
        table.insert(total, sk)
    end
    for _, sk in ipairs(equip_skills) do
        table.insert(total, sk)
    end
    return total
end

function human:have_skill(skill)
    local skills = self:get_total_skills_list()
    for _, id in ipairs(skills) do
        if id == skill then
            return true
        end
    end
    return false
end

function human:clear_menpai_skills()
    for i = #self.skill_list, 1, -1 do
        local skill = self.skill_list[i]
        local template = skillenginer:get_skill_template(skill)
        if template.menpai ~= define.INVAILD_ID then
            table.remove(self.skill_list, i)
        end
    end
end

function human:can_use_skill_now()
    if self:get_action_time() > 0 then
        print("human:can_use_skill_now > 0")
        return false
    end
    if not actionenginer:can_do_next_action(self) then
        print("human:can_use_skill_now can_do_next_action not")
        return false
    end
    return true
end

function human:get_obj_type()
    return "human"
end

function human:get_agent()
    return self.agent
end

function human:get_exterior_list()
    return self.exterior
end

function human:get_db()
    return self.db
end

function human:get_ride()
    return self.db:get_attrib("ride")
end

function human:get_ride_model()
    return self.db:get_attrib("ride_model")
end

function human:get_model_id()
    return self.db:get_attrib("model_id")
end

function human:item_value(ia)
    return self.db:get_item_effect(ia)
end

function human:damage_rate()
    return self.db:get_damage_rate()
end

function human:set_server_id(server_id)
    self.db:set_not_gen_attrib({ server_id = server_id })
end

function human:get_server_id()
    return self.db:get_attrib("server_id")
end

function human:set_guild_id(guild_id)
    self.db:set_db_attrib({ guild_id = guild_id })
end

function human:set_guild_name(guild_name)
    self.db:set_db_attrib({ guild_name = guild_name })
end

function human:set_confederate_id(confederate_id)
    self.db:set_db_attrib({ confederate_id = confederate_id })
end

function human:set_confederate_name(confederate_name)
    self.db:set_db_attrib({ confederate_name = confederate_name })
end

function human:get_confederate_name()
    return self.db:get_db_attrib("confederate_name")
end

function human:get_guild()
    return self.db:get_db_attrib("guild_id")
end

function human:get_guild_uinfo()
    local guinfo = {}
    guinfo.guid = self:get_guid()
    guinfo.name = self:get_name()
    guinfo.level = self:get_level()
    guinfo.menpai = self:get_menpai()
    return guinfo
end

function human:get_honour()
    return self.db:get_db_attrib("honour") or 0
end

function human:set_honour(honour)
    self.db:set_db_attrib({ honour = honour})
end

function human:set_ride(ride)
    -- print("human:set_ride m_objID =", self.m_objID, ";ride =", ride)
    self.db:set_db_attrib({ride = ride})
end

function human:get_ride_model()
    return self.db:get_attrib("ride_model")
end

function human:set_hair_color_ex(hair_color)
	-- if self:get_hair_color() ~= hair_color then
		-- local guid = self:get_guid()
        -- skynet.send(".world", "lua", "update_uinfo", guid, {hair_color = hair_color})
	-- end
    self.db:set_db_attrib({ hair_color = hair_color})
end

function human:add_hair_color(hair_color)
    -- self.db:set_db_attrib({ hair_color = hair_color})
	self:set_hair_color_ex(hair_color)
    self:save_hair_color(hair_color)
end

function human:set_hair_color(hair_index)
    local my_hair_colors = self.exterior.hair_colors or {}
    local hair_color = my_hair_colors[hair_index]
    if hair_color or hair_index == 1 then
        hair_color = hair_color or { value = 0 }
		self:set_hair_color_ex(hair_color.value)
        -- self.db:set_db_attrib({ hair_color = hair_color.value})
        self:set_exterior_hair_color_index(hair_index)
    end
end

function human:get_hair_color_index_by_color_value(color_value)
    local my_hair_colors = self.exterior.hair_colors or {}
    local my_hair_colors = self.exterior.hair_colors or {}
    my_hair_colors[1] = my_hair_colors[1] or { value = 0 }
    for i = 1, 20 do
        local hc = my_hair_colors[i]
        if hc and hc.value == color_value then
            return i
        end
    end
end

function human:save_hair_color(hair_color)
    local index = 1
    local my_hair_colors = self.exterior.hair_colors or {}
    my_hair_colors[1] = my_hair_colors[1] or { value = 0 }
    for i = 1, 20 do
        local hc = my_hair_colors[i]
        if i ~= 1 and (hc == nil or hc.value == 0) then
            index = i
            break
        end
    end
    self.exterior.hair_colors = my_hair_colors
    self.exterior.hair_colors[index] = { value = hair_color }
    self:set_exterior_hair_color_index(index)
    self:send_exterior_info(5)
end

function human:get_weapon_visual_level(visual)
    local my_exterior_weapon_visuals = self.exterior.weapon_visuals or {}
    local visual_data = self:get_exterior_weapon_visual_data(visual)
	if visual_data then
		return visual_data.level
	end
	return -1
end

function human:set_weapon_visual_level(visual,level)
	for i,j in ipairs(self.exterior.weapon_visuals) do
		if j.id == visual then
			j.level = level
			self:send_exterior_info()
			break
		end
	end
end

function human:active_weapon_visual(visual)
    local my_exterior_weapon_visuals = self.exterior.weapon_visuals or {}
    local visual_data = self:get_exterior_weapon_visual_data(visual)
    if visual_data == nil then
        table.insert(my_exterior_weapon_visuals, { id = visual, level = 0, term = define.INVAILD_ID})
    end
    self.exterior.weapon_visuals = my_exterior_weapon_visuals
end


function human:set_exterior_weapon_visual_id(index,level)
    self.db:set_db_attrib({exterior_weapon_visual_id = index})
	level = level or 0
    self.db:set_db_attrib({exterior_weapon_selcet_level = level})
    self:get_scene():broad_char_equioment(self,define.HUMAN_EQUIP.HEQUIP_WEAPON)
	local visual,eqid = 0,-1
	if index > 0 then
		local exterior_weapon_visual = configenginer:get_config("exterior_weapon_visual")
		exterior_weapon_visual = exterior_weapon_visual[index]
		if exterior_weapon_visual then
			local visuals = exterior_weapon_visual["外观ID"]
			if visuals and visuals[level + 1] then
				visual = visuals[level + 1]
				eqid = exterior_weapon_visual["道具ID"]
			end
		end
	end
	self.game_flag.hs_visual = visual
	self.game_flag.hs_index = eqid
end

function human:get_exterior_weapon_visual_id()
    local index = self.db:get_db_attrib("exterior_weapon_visual_id") or 0
	local select_level = self.db:get_db_attrib("exterior_weapon_selcet_level") or 0
    return index,select_level
end

function human:get_exterior_weapon_visual_data(id)
    local my_exterior_weapon_visuals = self.exterior.weapon_visuals or {}
    for _, visual in ipairs(my_exterior_weapon_visuals) do
        if visual.id == id then
            return visual
        end
    end
end

function human:get_exterior_weapon_visual()
    local exterior_weapon_visual = configenginer:get_config("exterior_weapon_visual")
    local id,select_level = self:get_exterior_weapon_visual_id()
    local visual = self:get_exterior_weapon_visual_data(id)
    if visual and select_level <= visual.level then
        exterior_weapon_visual = exterior_weapon_visual[visual.id]
		if exterior_weapon_visual then
			local visuals = exterior_weapon_visual["外观ID"]
			if visuals then
				return visuals[select_level + 1],exterior_weapon_visual["道具ID"]
			end
		end
    end
end

function human:set_shenbind_status(change)
	local scene = self:get_scene()
	local sceneId = scene:get_id()
	local selfId = self:get_obj_id()
	local msg = packet_def.GCSecWeaponAddSkillList.new()
	msg.selfId = selfId
	if change > 0 then
		local shenbing = self:get_equip_container():get_item(define.HUMAN_EQUIP.SHENBING)
		if shenbing then
			self:set_game_flag_key("sb_change",change)
			local equip_data = shenbing:get_equip_data()
			local fwq_passive_skill = equip_data:get_fwq_passive_skill()
			self:set_game_flag_key("fwq_passive_skill",fwq_passive_skill)
			local fwq_skill_list_1 = equip_data:get_fwq_skill_list_1()
			local fwq_skill_list_2 = equip_data:get_fwq_skill_list_2()
			local fwq_list_2 = equip_data:get_fwq_list_2()
			msg.skillId = {
			fwq_passive_skill,
			fwq_skill_list_1[1],
			fwq_skill_list_1[2],
			-1,-1,-1,4435}
			for i,j in ipairs(fwq_skill_list_2) do
				if fwq_list_2[i] == 1 then
					msg.skillId[2 + i] = j
				end
			end
			msg.commonskillA = fwq_skill_list_1[1]
			msg.commonskillB = fwq_skill_list_1[2]
			msg.is_hide = 0
			msg.is_update = 1
			scene:send2client(self, msg)
			self.ai:update_auto_use_skill(fwq_passive_skill)
		else
			self:set_game_flag_key("sb_change",0)
			self:set_game_flag_key("fwq_passive_skill",0)
			msg.skillId = {-1,-1,-1,-1,-1,-1,-1}
			msg.commonskillA = -1
			msg.commonskillB = -1
			msg.is_hide = 1
			msg.is_update = 1
			scene:send2client(self, msg)
			self.ai:update_auto_use_skill()
		end
	else
		self:set_game_flag_key("sb_change",0)
		self:set_game_flag_key("fwq_passive_skill",0)
		msg.skillId = {-1,-1,-1,-1,-1,-1,-1}
		msg.commonskillA = -1
		msg.commonskillB = -1
		msg.is_hide = 1
		msg.is_update = 1
		scene:send2client(self, msg)
		self.ai:update_auto_use_skill()
	end
	-- msg.is_update = 1
	-- scene:send2client(self, msg)
    local ret = packet_def.GCCharEquipment.new()
    ret.m_objID = self:get_obj_id()
    ret.flag = 0
	local visual,item_index,gemid = self:get_cur_weapon_visual(sceneId)
	ret:set_weapon(item_index,gemid,visual)
	scene:send2client(self, ret)
	scene:broadcast(self, ret, true)
end
function human:get_cur_weapon_visual(sceneId)
	local equip_container = self:get_equip_container()
	local sb_change = self:get_game_flag_key("sb_change")
	if sb_change > 0 then
		local sb_is_alive = true
		local sb_on_scene = self:get_game_flag_key("sb_on_scene")
		if sb_on_scene ~= sceneId then
			sb_is_alive = false
			self:set_game_flag_key("sb_on_scene",sceneId)
			local list = self:get_impact_list()
			for _, imp in ipairs(list) do
				if imp:get_data_index() == sb_change then
					sb_is_alive = true
					break
				end
			end
		end
		if sb_is_alive then
			local shenbing = equip_container:get_item(define.HUMAN_EQUIP.SHENBING)
			if shenbing then
				local equip_data = shenbing:get_equip_data()
				local sb_visual = equip_data:get_visual()
				local sb_actid = equip_data:get_action()
				local sb_gem = equip_data:get_slot_gem(1)
				if sb_visual > 0 and sb_actid > 0 then
					self:set_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_WEAPON,
					{
					[define.WG_KEY_A] = sb_actid,
					[define.WG_KEY_B] = sb_gem,
					[define.WG_KEY_C] = sb_visual
					})
					return sb_visual,sb_actid,sb_gem
				end
			else
				sb_is_alive = false
			end
		end
		if not sb_is_alive then
			local msg = packet_def.GCSecWeaponAddSkillList.new()
			msg.selfId = self:get_obj_id()
			msg.skillId = {-1,-1,-1,-1,-1,-1,-1}
			msg.commonskillA = -1
			msg.commonskillB = -1
			msg.is_hide = 1
			msg.is_update = 1
			self:get_scene():send2client(self, msg)
			self.ai:update_auto_use_skill()
		end
	end
	local weapon = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_WEAPON)
	if not weapon then
		self:set_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_WEAPON,
		{
		[define.WG_KEY_A] = -1,
		[define.WG_KEY_B] = -1,
		[define.WG_KEY_C] = 0
		})
		return 0,-1,-1
	end
	local weap_exterior_visual,weapon_id = self:get_exterior_weapon_visual()
	if weap_exterior_visual then
		self:set_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_WEAPON,
		{
		[define.WG_KEY_A] = weapon_id,
		[define.WG_KEY_B] = -1,
		[define.WG_KEY_C] = weap_exterior_visual
		})
		return weap_exterior_visual,weapon_id,-1
	end
	local equip_data = weapon:get_equip_data()
	local visual = equip_data:get_visual()
	local index = weapon:get_index()
	local gemid = equip_data:get_slot_gem(1)
	if gemid == 0 then
		gemid = -1
	end
		self:set_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_WEAPON,
		{
		[define.WG_KEY_A] = index,
		[define.WG_KEY_B] = gemid,
		[define.WG_KEY_C] = visual
		})
	return visual,index,gemid
end

function human:set_exterior_face_style_index(index)
    self.db:set_db_attrib({exterior_face_style_index = index})
end

function human:get_exterior_face_style_index()
    return self.db:get_db_attrib("exterior_face_style_index")
end

function human:set_exterior_hair_style_index(index)
    self.db:set_db_attrib({exterior_hair_style_index = index})
end

function human:get_exterior_hair_style_index()
    return self.db:get_db_attrib("exterior_hair_style_index")
end

function human:set_exterior_hair_color_index(index)
    self.db:set_db_attrib({exterior_hair_color_index = index})
end

function human:get_exterior_hair_color_index()
    local index = self.db:get_db_attrib("exterior_hair_color_index")
    index = index or 0
    index = index == 0 and 1 or index
    return index
end

function human:set_exterior_portrait_index(index)
    self.db:set_db_attrib({exterior_portrait_index = index})
end

function human:get_exterior_portrait_index()
    return self.db:get_db_attrib("exterior_portrait_index")
end

function human:set_exterior_pet_soul_id(id)
    self.db:set_db_attrib({exterior_pet_soul_id = id})
end

function human:get_exterior_pet_soul_id(ids)
    return self.db:get_db_attrib("exterior_pet_soul_id")
end

function human:set_fashion_depot_index(index)
    self.db:set_db_attrib({fashion_depot_index = index})
end

function human:get_fashion_depot_index()
    return self.db:get_attrib("fashion_depot_index")
end

function human:get_pet_soul_melting_level()
    local soul_melting_pet_guid = self.db:get_attrib("soul_melting_pet_guid")
    if soul_melting_pet_guid:is_null() then
        return define.INVAILD_ID
    end
    local pet_detail = self:get_pet_bag_container():get_pet_by_guid(soul_melting_pet_guid)
    if pet_detail == nil then
        return define.INVAILD_ID
    end
    return pet_detail:get_pet_soul_melting_level()
end

function human:set_pet_soul_melting_model(model)
    self.db:set_db_attrib({ pet_soul_melting_model = model})
end


-- self.exterior.headinfo = self.exterior.headinfo or {}
-- self.exterior.backinfo = self.exterior.backinfo or {}
function human:get_exterior_head_info()
	return self.exterior.headinfo
end

function human:get_exterior_head_by_id(id)
	for i,j in ipairs(self.exterior.headinfo) do
		if j.id == id then
			return j
		end
	end
end

function human:get_exterior_back_info()
	return self.exterior.backinfo
end

function human:get_exterior_back_by_id(id)
	for i,j in ipairs(self.exterior.backinfo) do
		if j.id == id then
			return j
		end
	end
end

function human:set_exterior_head_pos(id,posx,posy,posz)
	for i,j in ipairs(self.exterior.headinfo) do
		if j.id == id then
			j.x = posx
			j.y = posy
			j.z = posz
			return true
		end
	end
end

function human:set_exterior_back_pos(id,posx,posy,posz)
	for i,j in ipairs(self.exterior.backinfo) do
		if j.id == id then
			j.x = posx
			j.y = posy
			j.z = posz
			return true
		end
	end
end

function human:set_exterior_head_id(add)
	for i,j in ipairs(self.exterior.headinfo) do
		if j.id == add.id then
			return false
		end
	end
	table.insert(self.exterior.headinfo,add)
	return true
end

function human:set_exterior_back_id(add)
	for i,j in ipairs(self.exterior.backinfo) do
		if j.id == id then
			return false
		end
	end
	table.insert(self.exterior.backinfo,add)
	return true
end

function human:get_exterior_head_visual_id()
    local index = self.db:get_db_attrib("exterior_head_id") or 0
	local pos = self.db:get_db_attrib("exterior_head_pos") or 0
    return index,pos
end

function human:set_exterior_head_visual_id(id,pos)
    self.db:set_db_attrib({exterior_head_id = id})
    self.db:set_db_attrib({exterior_head_pos = pos})
end

function human:get_exterior_back_visual_id()
    local index = self.db:get_db_attrib("exterior_back_id") or 0
	local pos = self.db:get_db_attrib("exterior_back_pos") or 0
    return index,pos
end

function human:set_exterior_back_visual_id(id,pos)
    self.db:set_db_attrib({exterior_back_id = id})
    self.db:set_db_attrib({exterior_back_pos = pos})
end

function human:set_portrait_id(id)
	-- if self:get_portrait_id() ~= id then
		-- local guid = self:get_guid()
        -- skynet.send(".world", "lua", "update_uinfo", guid, {portrait_id = id})
	-- end
    self.db:set_db_attrib({portrait_id = id})
end

function human:get_portrait_id()
    return self.db:get_db_attrib("portrait_id")
end

function human:set_face_style(id)
	-- if self:get_face_style() ~= id then
		-- local guid = self:get_guid()
        -- skynet.send(".world", "lua", "update_uinfo", guid, {face_id = id})
	-- end
    self.db:set_db_attrib({face_style = id})
end

function human:set_hair_style(id)
	-- if self:get_hair_style() ~= id then
		-- local guid = self:get_guid()
        -- skynet.send(".world", "lua", "update_uinfo", guid, {hair_id = id})
	-- end
    self.db:set_db_attrib({hair_style = id})
end

function human:get_money()
    return self:get_attrib("money")
end

function human:get_jiaozi()
    return self:get_attrib("jiaozi")
end

function human:set_mood(mood)
    self.relation_list.mood = mood or "还没想好"
    local cur_title = self:get_cur_title()
    if cur_title and cur_title.id == define.TITILE.MOOD then
        self:set_title(define.TITILE.MOOD, mood)
    end
end

function human:get_mood()
    return self.relation_list.mood or "还没想好"
end

function human:set_money(money, reason, extra)
    if money < 0 then
        return false
    end
    money = math.ceil(money)
    money = money > define.INT32_MAX and define.INT32_MAX or money
    money = money < 0 and 0 or money
    local before = self:get_money()
    self.db:set_db_attrib({money = money})
    self:log_money_rec(reason, "金币", before, money - before, extra)
    return true
end

function human:set_jiaozi(money, reason, extra)
    if money < 0 then
        return false
    end
    money = money > define.INT32_MAX and define.INT32_MAX or money
    money = money < 0 and 0 or money
    money = math.ceil(money)
    local before = self:get_jiaozi()
    self.db:set_db_attrib({jiaozi = money})
    self:log_money_rec(reason, "交子", before, money - before, extra)
    return true
end

function human:get_yuanbao()
    return self:get_attrib("yuanbao")
end

function human:set_yuanbao(yuanbao, reason, extra, top_true)
    if yuanbao < 0 then
		skynet.logi("set_yuanbao = ", yuanbao, "stack =", debug.traceback())
		assert(false,"human:set_yuanbao 设置元宝数为负值。")
        return
    end
    local oldyb = self:get_yuanbao()
    yuanbao = yuanbao > define.INT32_MAX and define.INT32_MAX or yuanbao
    self.db:set_db_attrib({yuanbao = yuanbao})
	local sub_yb = yuanbao - oldyb
    self:log_money_rec(reason, "元宝", oldyb, sub_yb, extra)
	if not top_true and sub_yb < 0 then
		local params = {
			guid = self:get_guid(),
			name = self:get_name(),
			menpai = self:get_menpai(),
			money_yb = -1 * sub_yb,
			money_yb_old = self.game_flag.mingdong_yb or 0,
			need_point = 0,
			need_point_old = self.game_flag.mingdong_point or 0,
			over_date = self.game_flag.mingdong_date or 0,
			end_time = self.game_flag.mingdong_time or 0,
		}
		local world_id = self:get_server_id()
		local ok, loading, money_yb, need_point, over_date, end_time = pcall(function()
			return skynet.call(define.CACHE_NODE, "lua", "update_mingdong_top", world_id, params)
		end)

		if not ok then
			skynet.error("update_mingdong_top 排行服务未成功启动:", loading)
			loading, money_yb, need_point, over_date, end_time = nil, nil, nil, nil, nil
		else
			if loading == 1 then
				self.game_flag.mingdong_yb = money_yb
				self.game_flag.mingdong_point = need_point
				if over_date then
					self.game_flag.mingdong_date = over_date
				end
				if end_time then
					self.game_flag.mingdong_time = end_time
				end
			end
		end
		-- local loading,money_yb,need_point,over_date,end_time = skynet.call(define.CACHE_NODE,"lua","update_mingdong_top",world_id,params)
	end
    return true
end

function human:cost_yuanbao(count, reason, extra,top_true)
	assert(count >= 1,count)
    local yuanbao = self:get_yuanbao()
    if yuanbao < count then
        return false
    end
    yuanbao = yuanbao - count
    self:set_yuanbao(yuanbao, reason, extra,top_true)
    return true
end

function human:add_yuanbao(count, reason, extra)
    if count < 0 then
        return false
    end
    local yuanbao = self:get_yuanbao()
    yuanbao = yuanbao + count
    self:set_yuanbao(yuanbao, reason, extra)
    return true
end

function human:set_menpai(menpai)
    self.db:set_db_attrib({menpai = menpai})
    local reputation = define.MENPAI_REPUTATIONS[menpai]
    self.db:set_db_attrib({reputation = reputation})
    return true
end

function human:set_exp(exp)
    if exp < 0 then
        return false
    end
    exp = exp > define.INT32_MAX and define.INT32_MAX or exp
    self.db:set_db_attrib({exp = exp})
    return true
end

function human:get_exp()
    return self.db:get_db_attrib("exp")
end

function human:update_exp(exp)
    self.db:set_db_attrib({exp = exp})
end

function human:get_team_guid()
    return define.INVAILD_ID
end

function human:add_exp(add_exp, pet_add_exp, is_from_monster)
    local scale = 1
	local count = self:get_today_kill_monster_count()
	local env = skynet.getenv("env")
	local value = define.HEAVY_ANTI_ADDICTION_KILL_MONSTER_COUNT[env] or define.HEAVY_ANTI_ADDICTION_KILL_MONSTER_COUNT["moren"]
	if count >= value then
		return
	end
	value = define.MILD_ANTI_ADDICTION_KILL_MONSTER_COUNT[env] or define.MILD_ANTI_ADDICTION_KILL_MONSTER_COUNT["moren"]
	if count >= value then
		scale = 0.5
	end
    -- add_exp = math.ceil(add_exp * scale)
    add_exp = math.ceil(add_exp * scale)
    pet_add_exp =  math.ceil(pet_add_exp * scale)
    local award_exp = 0
    local pet_award_exp = 0
    if is_from_monster then
		-- local env_exp_rate = define.ADD_EXP_RATE[env] or 0
		local mult = self:get_double_exp_mult()
		-- mult = mult + env_exp_rate
		local pet_exp_mult = self:get_pet_exp_mult()
		-- pet_exp_mult = pet_exp_mult + env_exp_rate
        award_exp = math.ceil(add_exp * mult - add_exp)
        pet_award_exp = math.ceil(pet_add_exp * (mult + pet_exp_mult) - pet_add_exp)
        -- pet_award_exp = math.ceil(pet_add_exp * pet_exp_mult - pet_add_exp)
    end
    self:add_my_exp(add_exp, award_exp)
    local anqi_exp, anqi_award_exp = self:add_aq_exp(math.ceil(add_exp / 100), math.ceil(award_exp / 100))
    if self.pet then
        self.pet:add_exp(pet_add_exp + pet_award_exp)
    end
	local scene = self:get_scene()
	
	-- local showexp_rate = self:get_mission_data_by_script_id(615)
	-- if showexp_rate > 0 then
		-- local env = skynet.getenv("env")
		-- if env == "publish_xrx" then
			-- local sceneId = scene:get_id()
			-- if define.MONSTER_EXP_UP_SCENE[sceneId] then
				-- showexp_rate = showexp_rate + define.MONSTER_EXP_UP_SCENE[sceneId]
			-- end
		-- end
		-- add_exp = math.ceil(add_exp / showexp_rate)
		-- award_exp = math.ceil(award_exp / showexp_rate)
		-- pet_add_exp = math.ceil(pet_add_exp / showexp_rate)
		-- pet_award_exp = math.ceil(pet_award_exp / showexp_rate)
		-- anqi_exp = math.ceil(anqi_exp / showexp_rate)
		-- anqi_award_exp = math.ceil(anqi_award_exp / showexp_rate)
	-- end
    local msg = packet_def.GCDetailExp.new()
    msg.exp = add_exp
    msg.award_exp = award_exp
    msg.bb_exp = pet_add_exp
    msg.bb_award_exp = pet_award_exp
    msg.anqi_exp = anqi_exp
    msg.anqi_award_exp = anqi_award_exp
    scene:send2client(self, msg)
end

function human:add_aq_exp(add_exp, award_exp)
    local container = self:get_equip_container()
    local anqi = container:get_item(define.HUMAN_EQUIP.HEQUIP_ANQI)
    if anqi then
        if anqi:get_equip_data():get_aq_xiulian() >= self:get_level() then
            return 0, 0
        end
        add_exp, award_exp = anqi:get_equip_data():add_exp(add_exp, award_exp)
        local msg = packet_def.GCItemInfo.new()
        msg.bagIndex = define.HUMAN_EQUIP.HEQUIP_ANQI
        msg.item = anqi:copy_raw_data()
        msg.bag_type = define.BAG_TYPE.equip
        self:get_scene():send2client(self, msg)
        local aq_xiulian = anqi:get_equip_data():get_aq_xiulian()
        if add_exp == 0 and (aq_xiulian ~= define.HUMAN_MAX_LEVEL - 1) then
            self:notify_tips("#{FBSJ_081209_04}")
        end
        return add_exp, award_exp
    end
    return 0, 0
end

function human:add_my_exp(add_exp, award_exp)
    local exp = self:get_exp() + add_exp + award_exp
    local player_exp_level = configenginer:get_config("player_exp_level")
    local level = self:get_level()
    local level_exp = player_exp_level[level]
    if exp >= level_exp and level < 10 then
        exp = exp - level_exp
        level = level + 1
        self:set_level(level)
        self:on_level_up(level)
        local hp_max = self:get_attrib("hp_max")
        local mp_max = self:get_attrib("mp_max")
        self:set_hp(hp_max)
        self:set_mp(mp_max)

        local msg = packet_def.GCLevelUpResult.new()
        msg.remind_exp = exp
        msg.result = 0
        self:get_scene():send2client(self, msg)

        msg = packet_def.GCLevelUp.new()
        msg.m_objID = self:get_obj_id()
        msg.level = level
        self:get_scene():broadcast(self, msg, true)
        -- self:on_level_up(level)
    end
    level_exp = player_exp_level[level]
    if exp > 4 * level_exp then
        exp = 4 * level_exp
        self:notify_tips("#{DNS_211124_54}")
    end
    self:update_exp(exp)
end

function human:get_level_up_point_remain_add(level)
    for i = #define.LEVEL_POINT_REMAIN, 1, -1 do
        local p = define.LEVEL_POINT_REMAIN[i]
        if level >= p.level then
            return p.add_point
        end
    end
    return 0
end

function human:on_level_up(level)
    local attr_level_up = configenginer:get_config("attr_level_up_table")
    local menpai = self:get_attrib("menpai")
    local attr_up = attr_level_up[level]
	--attr_up[str][恶人谷] = value
    local chn = define.ENUM_MENPAI_CHN[menpai]
    for attr, v in pairs(attr_up) do
        if v[chn] then
            local v_chn = v[chn]
            local key = attr
            local add = 0
            if type(v_chn) == "table" then
                add = v_chn[1]
            else
                add = v_chn
            end
            local e = self.db:get_lv1_attrib()[key] or 0
            local new = e + add
            self.db:set_lv1_attrib({ [key] = new })
        end
    end
    do
        local key = "point_remain"
        local add_point_remain = self:get_level_up_point_remain_add(level)
        local e = self.db:get_lv1_attrib()[key] or 0
        local new = e + add_point_remain
        self.db:set_lv1_attrib({ [key] = new })
    end
    self:update_vigor_stamina_max()
    self.db:mark_all_attr_dirty()
    self:set_hp(self:get_max_hp())
    self:set_mp(self:get_max_mp())
    self:get_scene():get_script_engienr():call(define.SCENE_SCRIPT_ID, "OnSceneHumanLevelUp", self:get_obj_id(), level)
    local guild_id = self:get_guild_id()
    if guild_id ~= define.INVAILD_ID then
        skynet.send(".Guildmanager", "lua", "on_guild_human_level_up", guild_id, self:get_guid(), level)
    end
end

function human:update_vigor_stamina_max()
    local value = self:get_level() * 6
    value = value > 600 and 600 or value
    self.db:set_db_attrib({ vigor_max = value, stamina_max = value })
end

function human:update_md_value(md)
	local msg = packet_def.GCMissionModify.new()
	msg.m_nFlag = 1
	msg.mission_id = md
	msg.mission_index = self.mission_data.mission_datas[md + 1] or 0
	self:get_scene():send2client(self, msg)
end

function human:on_login()
	self:on_line_check_item_valid_timer()
    local logout_time = self:get_logout_time()
    if logout_time == 0 then
        self:on_fist_login()
    end
    self:get_scene():get_script_engienr():call(define.SCENE_SCRIPT_ID, "OnScenePlayerLogin", self:get_obj_id(), os.time())
	for md,val in pairs(self.mission_data.mission_datas) do
		if md > 0 and val ~= 0 then
			local msg = packet_def.GCMissionModify.new()
			msg.m_nFlag = 1
			msg.mission_id = md - 1
			msg.mission_index = val
			self:get_scene():send2client(self, msg)
		end
	end
end

function human:on_fist_login()
    self:get_scene():get_script_engienr():call(define.SCENE_SCRIPT_ID, "OnScenePlayerFirstLogin", self:get_obj_id(), os.time())
end

function human:get_logout_time()
    return self.db:get_attrib("logout_time") or 0
end

function human:set_logout_time(logout_time)
    self.db:set_db_attrib({ logout_time = logout_time})
end

function human:get_pet()
    return self.pet
end

function human:set_assistant_id()

end

function human:get_assistant_id()

end

function human:create_new_obj_packet()
    if self:is_moving() then
        local msg = packet_def.GCNewPlayer_Move.new()
        msg.m_objID = self:get_obj_id()
        msg.guid = self:get_guid()
        msg.m_posWorld = self:get_world_pos()
        msg.dir = self:get_dir()
        msg.speed = self:get_speed()
        msg.handle = self.move.handle
        msg.path = self.move.targetPos
        msg.m_wEquipVer = 67336
        return msg
    else
        local msg = packet_def.GCNewPlayer.new()
        msg.m_fDir = self:get_dir()
        msg.m_fMoveSpeed = self:get_speed()
        msg.m_objID = self:get_obj_id()
        msg.m_posWorld = self:get_world_pos()
        msg.m_wEquipVer = 67336
        msg.unknow_1 = 280108829
        msg.unknow_2 = 0
        return msg
    end
end

function human:get_name()
    return self.db:get_attrib("name")
end

function human:get_guid()
    return self.db:get_attrib("guid")
end

function human:set_world_pos(world_pos)
    self.db:set_db_attrib({ world_pos = world_pos })
    self:get_scene():char_world_pos_changed(self)
end

function human:set_switch_scene_info(sceneid,world_pos)
    self.db:set_db_attrib({ sceneid = sceneid, world_pos = world_pos })
end


function human:get_world_pos()
    return self.db:get_attrib("world_pos")
end

function human:get_scene_id()
    return self.db:get_attrib("sceneid")
end

function human:set_attrib(...)
    self.db:set_attrib(...)
end

function human:set_cool_down(id, cool_down_time)
	local index = tonumber(id)
	if index < define.OTHER_SKILL_OR_STATUS_COOLDOWN then
		local msg = packet_def.GCCooldownUpdate.new()
		msg.m_nNumCooldown = 1
		msg.m_aCooldowns = {}
		msg.m_aCooldowns[1] = { m_nID = index, m_nCooldown = cool_down_time, m_nCooldownElapsed = 0}
		self:get_scene():send2client(self, msg)
	end
    character.set_cool_down(self, id, cool_down_time)
end

function human:update_cool_down_time(id, value)
    local cool_down_time = self:get_cool_down(id) - value
	if cool_down_time < 0 then
		cool_down_time = 0
	end
	local index = tonumber(id)
	if index < define.OTHER_SKILL_OR_STATUS_COOLDOWN then
		local msg = packet_def.GCCooldownUpdate.new()
		msg.m_nNumCooldown = 1
		msg.m_aCooldowns = {}
		msg.m_aCooldowns[1] = { m_nID = index, m_nCooldown = cool_down_time, m_nCooldownElapsed = 0}
		self:get_scene():send2client(self, msg)
	end
    character.set_cool_down(self, id, cool_down_time)
end

function human:get_skill_combo_operation()
    return self.skill_comb_operation
end

function human:send_default_skill_combo_operation()
    local combo_list = {764, 764, 787, 0, 1}
    local cur_comb = 0
    local tempnum = 0
    local skill_id = 764
    local msg = packet_def.GCComboSkillOperation.new()
    msg.cur_comb = cur_comb
    msg.skill_id = skill_id
    msg.tempnum = tempnum
    msg.combo_list = combo_list
    self:get_scene():send2client(self, msg)
end

function human:add_skill_combo_operation(skill_id)
    if self.skill_comb_operation == nil then
        self.skill_comb_operation = { skill_id = skill_id}
        self.skill_comb_operation.cur_comb = 1
        local msg = packet_def.GCComboSkillOperation.new()
        msg.cur_comb = 1
        msg.skill_id = skill_id
        msg.tempnum = 1
        self:get_scene():send2client(self, msg)
    else
        local msg = packet_def.GCComboSkillOperation.new()
        msg.cur_comb = 4
        msg.skill_id = skill_id
        msg.tempnum = 0
        self:get_scene():send2client(self, msg)
        self.skill_comb_operation = nil
    end
end

function human:combo_skill_cool_downd(skill_id)
    if self.skill_comb_operation and self.skill_comb_operation.cur_comb == 1 then
        local msg = packet_def.GCComboSkillOperation.new()
        msg.cur_comb = 2
        msg.skill_id = skill_id
        msg.tempnum = -1
        self:get_scene():send2client(self, msg)
        self.skill_comb_operation = nil
    end
end

function human:get_hit()
    return self.db:get_attrib("attrib_hit")
end

function human:get_miss()
    return self.db:get_attrib("attrib_miss")
end

function human:get_speed()
    return self.db:get_attrib("speed")
end

function human:get_base_attribs()
    return self.db:get_base_attribs()
end

function human:get_detail_attribs()
    return self.db:get_detail_attribs()
end

function human:get_attrib(attr)
    return self.db:get_attrib(attr)
end

function human:on_damages(damages, caster_obj_id, is_critical, skill_id, imp)
	local effect_value,feature_rate = self:get_dw_jinjie_effect_details(13)
	if effect_value > 0 then
		if math.random(100) <= effect_value / feature_rate then
			damages.flag_immu = true
			self:features_effect_notify_client(13)
			return
		end
	end
	
    local scene = self:get_scene()
    local sender = scene:get_obj_by_id(caster_obj_id)
    if sender and sender:is_character_obj() then
        sender:on_damage_target(self, damages, skill_id, imp)
    end
    self:impact_on_damages(damages, caster_obj_id, is_critical, skill_id, imp)
    local r, err = pcall(self.talent_on_damages, self, damages, caster_obj_id, is_critical, skill_id, imp)
    if not r then
        skynet.loge("talent_on_damages error =", err)
    end
    self:menpai_on_damage(damages.hp_damage)
	if damages.flag_immu then
		self:show_skill_missed(self:get_obj_id(),caster_obj_id,skill_id,self:get_logic_count(),define.MISS_FLAG.FLAG_IMMU)
		return
	elseif damages.imm_dmg_rate then
		if damages.imm_dmg_rate >= 100 then
			self:show_skill_missed(self:get_obj_id(),caster_obj_id,skill_id,self:get_logic_count(),define.MISS_FLAG.FLAG_IMMU)
			return
		end
	end
	
    character.on_damages(self, damages, caster_obj_id, is_critical, skill_id, imp)
end

function human:menpai_on_damage(damage)
    damage = math.abs(damage)
    menpai_logic:on_damage(self, damage)
end


function human:on_damage_target(target, damages, skill_id, imp)
    if target:get_obj_type() == "human" then
        local want_change_pk_mode = self.db:get_db_attrib("want_change_pk_mode")
        if want_change_pk_mode then
            self.db:set_db_attrib({ change_pk_mode_delay = define.PK_MODE_CHANGE_DELAY} )
        end
    end
    self:menpai_on_damage_target(damages.hp_damage)
    local r, err = pcall(self.talent_on_damage_target, self, target, damages, skill_id, imp)
    if not r then
        skynet.loge("talent_on_damage_target skill_id =", skill_id,"error = ",err)
    end
    character.on_damage_target(self, target, damages, skill_id, imp)
end

function human:menpai_on_damage_target(damage)
    damage = math.abs(damage)
    menpai_logic:on_damage_target(self, damage)
end

function human:on_hit_target(reciver, skill)
    if reciver:get_obj_type() == "human" then
        local want_change_pk_mode = self.db:get_db_attrib("want_change_pk_mode")
        if want_change_pk_mode then
            self.db:set_db_attrib({ change_pk_mode_delay = define.PK_MODE_CHANGE_DELAY})
        end
    end
    local r, err = pcall(self.talent_on_hit_target, self, reciver, skill)
    if not r then
        skynet.loge("talent_on_hit_target error =", err)
    end
    character.on_hit_target(self, reciver, skill)
    menpai_logic:on_hit_target(self, skill)
    local weapon_broken = self:on_weapon_abrasion()
    local wh_no_life = self:on_wh_abrasion()
    if weapon_broken or wh_no_life then
        self:item_flush()
    end
end

function human:equip_dur_modify(modify)
    self:on_weapon_abrasion(modify)
    self:on_armor_abrasion(modify)
end

function human:on_weapon_abrasion(point)
    local refresh_attrib = false
    local conifg_info = configenginer:get_config("config_info")
    local equip_container = self:get_equip_container()
    local weapon = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_WEAPON)
    if weapon then
        local damage_point = weapon:get_equip_data():get_damage_point()
        damage_point = damage_point + 1
        local dur = weapon:get_equip_data():get_dur()
        if (damage_point >= conifg_info.Global.EquipmentDamagePoint and dur > 0) or point then
            damage_point = 0
            point = point or 1
            dur = dur - point
            dur = dur < 0 and 0 or dur
            weapon:get_equip_data():set_dur(dur)
            local raw_data = weapon:copy_raw_data()
            local msg = packet_def.GCDetailEquipList.new()
            msg.m_objID = self:get_obj_id()
            msg.m_mode = 1
            msg.itemList = {
                [define.HUMAN_EQUIP.HEQUIP_WEAPON] = raw_data
            }
            self:get_scene():send2client(self, msg)
            if dur == 0 then
                refresh_attrib = true
            end
        end
        weapon:get_equip_data():set_damage_point(damage_point)
    end
    return refresh_attrib
end

function human:on_wh_abrasion()
    local refresh_attrib = false
    local conifg_info = configenginer:get_config("config_info")
    local equip_container = self:get_equip_container()
    local wh = equip_container:get_item(define.HUMAN_EQUIP.HEQUIP_WUHUN)
    if wh then
        local damage_point = wh:get_equip_data():get_damage_point()
        damage_point = damage_point + 1
        local life = wh:get_equip_data():get_wh_life()
        if damage_point >= conifg_info.Global.EquipmentDamagePoint and life > 0 then
            damage_point = 0
            life = life - 1
            life = life < 0 and 0 or life
            wh:get_equip_data():set_wh_life(life)
            local raw_data = wh:copy_raw_data()
            local msg = packet_def.GCDetailEquipList.new()
            msg.m_objID = self:get_obj_id()
            msg.m_mode = 1
            msg.itemList = {
                [define.HUMAN_EQUIP.HEQUIP_WUHUN] = raw_data
            }
            self:get_scene():send2client(self, msg)
            if life == 0 then
                refresh_attrib = true
            end
        end
        wh:get_equip_data():set_damage_point(damage_point)
    end
    return refresh_attrib
end

function human:on_be_hit()
    local armor_broken = self:on_armor_abrasion()
    if armor_broken then
        self:item_flush()
    end
end

function human:on_armor_abrasion(point)
    local modifed = false
    local refresh_attrib = false
    local msg = packet_def.GCDetailEquipList.new()
    msg.m_objID = self:get_obj_id()
    msg.m_mode = 1
    local conifg_info = configenginer:get_config("config_info")
    local equip_container = self:get_equip_container()
    for i = define.HUMAN_EQUIP.HEQUIP_CAP, define.HUMAN_EQUIP.HEQUIP_SHOULDER do
        if not define.NOT_ABRASION_EQUIP[i] then
            local equip = equip_container:get_item(i)
            if equip then
                local damage_point = equip:get_equip_data():get_damage_point()
                damage_point = damage_point + 1
                local dur = equip:get_equip_data():get_dur()
                if (damage_point >= conifg_info.Global.EquipmentDamagePoint and dur > 0) or point then
                    damage_point = 0
                    point = point or 1
                    dur = dur - point
                    dur = dur < 0 and 0 or dur
                    equip:get_equip_data():set_dur(dur)
                    modifed = true
                    local raw_data = equip:copy_raw_data()
                    msg.itemList = {
                        [i] = raw_data
                    }
                    if dur == 0 then
                        refresh_attrib = true
                    end
                end
                equip:get_equip_data():set_damage_point(damage_point)
            end
        end
    end
    if modifed then
        self:get_scene():send2client(self, msg)
    end
    return refresh_attrib
end

function human:on_be_skill(sender, skill_id, behaviortype)
    character.on_be_skill(self, sender, skill_id, behaviortype)
    print("on_be_skill behaviortype =", behaviortype)
    if behaviortype ~= define.ENUM_BEHAVIOR_TYPE.BEHAVIOR_TYPE_HOSTILITY then
        return
    end
    self:on_be_hostility_skill(sender, skill_id, behaviortype)
end

function human:on_be_hostility_skill(sender, skill_id, behaviortype)
    if sender:get_obj_type() ~= "human" and sender:get_obj_type() ~= "pet" then
        return
    end
    if sender:get_obj_type() == "pet" then
        sender = sender:get_owner()
    end
    if sender == self then
        return
    end
    local attack_guid = sender:get_guid()
    local my_guid = self:get_guid()
    local sender_pk_declaration_list = sender:get_pk_declaration_list()
    if sender_pk_declaration_list:is_exist(my_guid) then
        sender_pk_declaration_list:add(my_guid)
    end
    if self:is_enemy(sender) then
        return
    end
    self.db:set_not_gen_attrib({ cur_attacker = attack_guid})
    self.pk_declaration_list:add(attack_guid)
    -- self.attackers_list:add(attack_guid)
    self:notify_tips("遭受到不明攻击，您现在进入自卫状态！")
end

function human:get_riders_max_speed_up()
    local exterior_ride = configenginer:get_config("exterior_ride")
    local rides = self.exterior.rides
    local speed_up = 0
    for _, ride in ipairs(rides) do
        local id = ride.id
        local conf = exterior_ride[id]
        if conf then
            if speed_up < conf.speed_up then
                speed_up = conf.speed_up
            end
        end
    end
    return speed_up
end

function human:modify_setting(key, value)
    key = tostring(key)
    self.setting[key] = { data = value, type = 1}
end

function human:get_setting()
    return self.setting
end

function human:get_setting_by_type(type)
    local st = tostring(type)
    return self.setting[st]
end

function human:setting_flag_is_true(st, shift)
    st = st + 1
    local setting = self:get_setting_by_type(st)
    setting = setting or { data = 0 }
    return (setting.data & (1 << shift) == (1 << shift))
end

function human:get_empty_setting(start, stop, ignore)
    for i = start, stop do
        i = tostring(i)
        if not self.setting[i] then
            return i
        end
        if ignore and self.setting[i].data == ignore.data  and self.setting[i].type == ignore.type then
            return i
        end
    end
end

function human:send_operate_result_msg(result)
    local msg = packet_def.GCOperateResult.new()
    msg.result = result
    self:get_scene():send2client(self, msg)
end

function human:notify_tips(msg)
    local m_nCmdID = 5
    local ret = packet_def.GCScriptCommand.new()
    ret.m_nCmdID = m_nCmdID
    ret.event = {}
    ret.event.str = gbk.fromutf8(msg)
    ret.event.len = string.len(ret.event.str)
    self.scene:send2client(self, ret)
end

function human:use_ident_scroll(ident_bag_index, equip_bag_index)
    local ident = self:get_prop_bag_container():get_item(ident_bag_index)
    local equip = self:get_prop_bag_container():get_item(equip_bag_index)
    assert(ident)
    assert(equip)
    local result
    local quality = ident:get_serial_quality()
    local itype = ident:get_serial_type()
    local is_ident = quality == define.COMMON_ITEM_QUAL.COMITEM_QUAL_MIS and (itype== define.COMMON_ITEM_TYPE.COMITEM_COIDENT or itype == define.COMMON_ITEM_TYPE.COMITEM_WPIDENT
        or itype == define.COMMON_ITEM_TYPE.COMITEM_ARIDENT or itype == define.COMMON_ITEM_TYPE.COMITEM_NCIDENT)
    print(" human:use_ident_scroll quality =", quality, ";itype =", itype)
    if not is_ident then
        return define.USEITEM_RESULT.USEITEM_IDENT_TYPE_FAIL
    end
    if equip:get_serial_class() ~= define.ITEM_CLASS.ICLASS_EQUIP then
        return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
    end
    if not self:is_alive() then
        return define.USEITEM_RESULT.USEITEM_SKILL_FAIL
    end
    if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_COIDENT then
        local equip_point = equip:get_base_config().equip_point
        if equip_point == define.HUMAN_EQUIP.COMITEM_WPIDENT then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_WPIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_CAP then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_ARIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_ARMOR then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_ARIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_CUFF then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_ARIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_BOOT then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_ARIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_SASH then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_ARIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_RING then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_NCIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_NECKLACE then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_NCIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        elseif equip_point == define.HUMAN_EQUIP.HEQUIP_AMULET_1 then
            if ident:get_serial_type() ~= define.COMMON_ITEM_TYPE.COMITEM_NCIDENT then
                return define.USEITEM_RESULT.USEITEM_IDENT_TARGET_TYPE_FAIL
            end
        else
            assert(false)
        end
    end
    local logparam = {}
    local del = human_item_logic:dec_item_lay_count(logparam, self, ident_bag_index, 1)
	if not del then
		self:notify_tips("道具扣除失败。")
	end
	assert(del,"human:use_ident_scroll == cost item fail")
    --[[
    local scroll_level = ident:get_index()
    local equip_level = equip:get_require_level()
    if scroll_level + define.IDENT_LEVEL_RANGE < equip_level then
        return define.USEITEM_RESULT.USEITEM_IDENT_LEVEL_FAIL
    end]]
    equip:set_is_identd(true)
    result = define.USEITEM_RESULT.USEITEM_SUCCESS
    local msg = packet_def.GCItemInfo.new()
    msg.bagIndex = equip_bag_index
    msg.item = equip:copy_raw_data()
    self:get_scene():send2client(self, msg)
    local impactenginer = self:get_scene():get_impact_enginer()
    impactenginer:send_impact_to_unit(self, 18, self, 0, false, 0)
    return result
end

function human:use_yuanbao_piao(bag_index)
    local bag_container = self:get_prop_bag_container()
    local item = bag_container:get_item(bag_index)
    assert(item, bag_index)
	if item:get_index() ~= define.YUANBAO_PIAO then
		self:notify_tips("请使用元宝票。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	end
	local count = item:get_param(0,"uint")
	if count < 1 or count > 50000 then
		self:notify_tips("非法元宝票。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	end
	if item:get_item_record_data_forindex("count") ~= count then
		self:notify_tips("非法元宝票。。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	end
	local change_guid = item:get_item_record_data_forindex("change_guid")
	if not change_guid then
		self:notify_tips("非法元宝票。。。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	end
	local change_name = item:get_item_record_data_forindex("change_name")
	local change_time = item:get_item_record_data_forindex("change_time")
	bag_container:set_item(bag_index, nil)
    local msg = packet_def.GCItemInfo.new()
    msg.bagIndex = bag_index
    msg.unknow_1 = 1
    msg.item = Item_cls.new():copy_raw_data()
    self:get_scene():send2client(self, msg)
    item = bag_container:get_item(bag_index)
	if item then
		self:notify_tips("元宝票扣除失败。")
		return define.USEITEM_RESULT.USEITEM_SUCCESS
	end
	local use_name = self:get_name()
	local use_guid = self:get_guid()
	local use_time = os.date("%y-%m-%d %H:%M:%S")
	skynet.send(".logdb", "lua", "update", {
		collection = "log_yuanbaopiao_value",
		selector = {guid = change_guid},
		update = {["$inc"] = {use_yuanbao = count}},
		upsert = true,
		multi = false,
	})
	self:add_yuanbao(count, "使用元宝票")
	local doc = { 
		logname = "使用元宝票",
		change_name = change_name,
		change_guid = change_guid,
		change_time = change_time,
		use_name = use_name,
		use_guid = use_guid,
		use_time = use_time,
		yuanbao = count,
	}
	skynet.send(".logdb", "lua", "insert", { collection = "log_yuanbaopiao", doc = doc})
	
	self:notify_tips("你获得"..tostring(count).."元宝。")
    return define.USEITEM_RESULT.USEITEM_SUCCESS
end

function human:split_item(split)
    local msg = packet_def.GCSplitItemResult.new()
    msg.container = split.container
    if split.container == packet_def.CGSplitItem.Container.BAG_CON then
        local container = self:get_prop_bag_container()
        local item = container:get_item(split.position)
        if item == nil or item:is_empty() then
            msg.item = Item_cls.new():copy_raw_data()
            msg.result = msg.RESULT.RESULT_FALSE
            self.scene:send2client(self, msg)
            return
        end
        local empty_index = container:get_empty_item_index(item:get_place_bag())
        if empty_index == define.INVAILD_ID then
            msg.item = Item_cls.new():copy_raw_data()
            msg.result = msg.RESULT.RESULT_FALSE
            self.scene:send2client(self, msg)
            return
        end
        local ret = human_item_logic:split_item(container, split.position, split.num, container, empty_index)
        if ret then
            msg.item = container:get_item(empty_index):copy_raw_data()
            msg.result = msg.RESULT.RESULT_SUCCEED
            msg.is_null = 0
            msg.con_index = empty_index
            self.scene:send2client(self, msg)

            msg = packet_def.GCItemInfo.new()
            msg.bagIndex = split.position
            msg.item = item:copy_raw_data()
            self.scene:send2client(self, msg)
        else
            msg.item = Item_cls.new():copy_raw_data()
            msg.result = msg.RESULT.RESULT_FALSE
            self.scene:send2client(self, msg)
        end
    else

    end
end

function human:is_new_player_relive()
    return false
end

function human:set_on_relive_script_id(script_id)
    self.on_relive_script_id = script_id
end

function human:change_scene(to, world_pos)
    self:get_scene():notify_change_scene(self:get_obj_id(), to, world_pos.x, world_pos.y)
end

function human:verify_item()
    local params = self:get_targeting_and_depleting_params()
    local bag_index = params:get_bag_index_of_deplted_item()
    local item = self:get_prop_bag_container():get_item(bag_index)
    local item_index = params:get_item_index_of_deplted_item()
    if item == nil or item:get_index() ~= item_index then
        if human_item_logic:calc_bag_item_count(self, item_index) > 0 then
            local exist_bag_index = human_item_logic:get_item_pos_by_type(self, item_index)
            if exist_bag_index ~= define.INVAILD_ID then
                params:set_bag_index_of_deplted_item(exist_bag_index)
                item = self:get_prop_bag_container():get_item(exist_bag_index)
            end
        end
    end
    if item then
        if item:get_index() == params:get_item_index_of_deplted_item() then
            local this_item_config = item:get_base_config()
            if this_item_config.script_id == params:get_activated_script() then
                if this_item_config.skill_id == params:get_activated_skill() then
                    return 1
                end
            end
        end
    end
    self:send_operate_result_msg(define.OPERATE_RESULT.OR_CAN_NOT_FIND_SPECIFIC_ITEM)
end

function human:depleting_used_item(selfId)
    return self:skill_deplte_item(selfId)
end

function human:skill_deplte_item()
    local skill_info = self:get_skill_info()
    local params = self:get_targeting_and_depleting_params()
    local item_guid = params:get_deplted_item_guid()
    local item_index = params:get_item_index_of_deplted_item()
    local bag_index = params:get_bag_index_of_deplted_item()
    if bag_index == define.INVAILD_ID then
        if item_index ~= define.INVAILD_ID then
            bag_index = human_item_logic:get_item_pos_by_type(item_index)
        end
    end
    if bag_index == define.INVAILD_ID then
        return false
    end
    local item = self:get_prop_bag_container():get_item(bag_index)
    if item == nil then
        return false
    end
    if item:get_index() ~= item_index then
        return false
    end
    if not item:is_ruler(define.ITEM_RULER_LIST.IRL_CANUSE) then
        return false
    end
    if item:is_cos_self() then
        local lay_count = item:get_lay_count()
        if lay_count < 1 then
            return false
        end
        local logparam = {}
        local ret =  human_item_logic:dec_item_lay_count(logparam, self, bag_index, 1)
		return ret
    end
    return true
end

function human:set_temp_pk_mode(mode)
    self.db:set_attrib({ pk_mode = mode})
end

function human:set_pvp_rule(rule)
    self.db:set_not_gen_attrib({ pk_min_level = rule.pk_min_level, pvp_rule = rule.pvp_rule })
end

function human:set_chedifulu_data(index, sceneid, position)
    self.chedifulu_data = self.chedifulu_data or {}
    index = tostring(index)
    self.chedifulu_data[index] = { sceneid = sceneid, x = math.ceil(position.x), y = math.ceil(position.y) }
    self:send_chedifulu_data(index)
end

function human:get_chedifulu_data(index)
    self.chedifulu_data = self.chedifulu_data or {}
    index = tostring(index)
    return self.chedifulu_data[index]
end

function human:send_chedifulu_data(index)
    self.chedifulu_data = self.chedifulu_data or {}
    local msg = packet_def.GCCheDiFuLuData.new()
    msg.list = {}
    if index then
        local data = self.chedifulu_data[index]
        if data then
            local l = {}
            l.index = tonumber(index)
            l.sceneid = data.sceneid
            l.x = data.x
            l.y = data.y
            table.insert(msg.list, l)
        end
    else
        for i = 1, define.CHEDIFULU_DATA_SIZE do
            local data = self.chedifulu_data[tostring(i - 1)]
            if data then
                local l = {}
                l.index = i - 1
                l.sceneid = data.sceneid
                l.x = data.x
                l.y = data.y
                table.insert(msg.list, l)
            end
        end
    end
    msg.size = #msg.list
    self:get_scene():send2client(self, msg)
end

function human:send_rmb_chat_face_info()
    local msg = packet_def.GCRMBChatFaceInfo.new()
    msg.id = self.rmb_chat_face_info.id
    msg.dates = self.rmb_chat_face_info.dates
    self:get_scene():send2client(self, msg)
end

function human:send_rmb_chat_action_info()
    local msg = packet_def.GCRMBChatActionInfo.new()
    msg.list_1 = { 0, 0, 0, 0 }
    msg.list_2 = { 0, 0, 0, 0 }
    msg.unknow_1 = 0
    msg.unknow_2 = 0
    msg.unknow_3 = 0
    self:get_scene():send2client(self, msg)
end

function human:send_mission_list()
    local msg = packet_def.GCMissionList.new()
    msg.m_objID = self:get_obj_id()
    msg.m_uMissionListFlags = 0
    for i = 1, define.MAX_CHAR_MISSION_NUM do
        if self.mission_data.char_missions[i] then 
            msg.m_uMissionListFlags = msg.m_uMissionListFlags | 1 << (i - 1)
        end
    end
    msg.char_missions = self.mission_data.char_missions
    msg.mission_have_done_flags = self.mission_data.mission_have_done_flags
    msg.mission_datas = {}
    for i = 1, 200 do
        local index = define.MD_2_CLIENT[i]
        if index then
            msg.mission_datas[i] = self:get_mission_data_by_script_id(index)
        else
            msg.mission_datas[i] = 0
        end
    end
    self:get_scene():send2client(self, msg)
end

function human:send_setting()
    local msg = packet_def.GCRetSetting.new()
    local setting = self:get_setting()
    for i = 1, 0x60 do
        msg.setting[i] = setting[tostring(i)]
    end
    self:get_scene():send2client(self, msg)
end

function human:get_title_is_hide()
    local type = define.SETTING_TYPE.SETTING_TYPE_SHOW_OR_HIDE_TITLE
    local setting = self.setting[tostring(type + 1)]
    return setting and setting.data == 1
end

function human:set_chedifulu_data_select_index(index)
    self.chedifulu_data = self.chedifulu_data or {}
    self.chedifulu_data.select_index = tostring(index)
end

function human:get_chedifulu_data_select_index()
    self.chedifulu_data = self.chedifulu_data or {}
    return self.chedifulu_data.select_index
end

function human:update_chedifulu_use_times(value)
    self.chedifulu_data = self.chedifulu_data or {}
    local use_times = self.chedifulu_data.use_times or 20
    use_times = use_times + value
    use_times = math.floor(use_times)
    self.chedifulu_data.use_times = use_times
end

function human:get_chedifulu_use_times()
    self.chedifulu_data = self.chedifulu_data or {}
    local use_times = self.chedifulu_data.use_times or 20
    return use_times
end

function human:send_sold_out_list()
    local container = self:get_sold_out_container()
    local msg = packet_def.GCShopSoldList.new()
    msg.item_list = {}
    for i = 0, define.SOLD_OUT_SIZE - 1 do
        local item = container:get_item(i)
        if item then
            local ei = {}
            ei.price = item:get_base_config().base_price * 2 * item:get_lay_count()
            ei.item = item:get_stream()
            table.insert(msg.item_list, ei)
        end
    end
    msg.merchandise_num = #msg.item_list
    self:get_scene():send2client(self, msg)
end

function human:add_xinfa(xinfa_id)
    local xinfa = self:get_xinfa(xinfa_id)
    assert(xinfa == nil, xinfa_id)
    table.insert(self.xinfa_list,  {m_nXinFaID = xinfa_id, m_nXinFaLevel = 1})
    self:send_xinfa_list()
end

function human:send_xinfa_list()
    local xinfa_list = self:get_xinfa_list()
    local msg = packet_def.GCDetailXinFaList.new()
    msg.m_aXinFa = xinfa_list
    msg.m_objID = self:get_obj_id()
    msg.m_wNumXinFa = #xinfa_list
    msg.unknow = 26
    self.scene:send2client(self, msg)
end

function human:add_skill(skill)
    local have_skill = self:have_skill(skill)
    if not have_skill then
        table.insert(self.skill_list, skill)
    end
	-- self:send_skill_list()
end

function human:del_skill(id)
    for i, skill in ipairs(self.skill_list) do
        if skill == id then
            table.remove(self.skill_list, i)
        end
    end
    self:send_skill_list()
end

function human:send_skill_list()
    local skill_list = self:get_total_skills_list()
    local msg = packet_def.GCDetailSkillList.new()
    msg.m_objID = self:get_obj_id()
    msg.m_aSkill = skill_list
    msg.m_wNumSkill = #skill_list
    self.scene:send2client(self, msg)
end

function human:add_money(money, reason, extra)
    assert(money > 0)
    money = math.ceil(money)
    money = self:get_money() + money
    self:set_money(money, reason, extra)
end

function human:add_jiaozi(money, reason, extra)
    assert(money > 0)
    money = math.ceil(money)
    local jiaozi = self:get_jiaozi() or 0
    money = jiaozi + money
    self:set_jiaozi(money, reason, extra)
end

function human:get_lv_max_money()
    local lv_max_money = configenginer:get_config("lv_max_money")
    local level = self:get_level()
    return lv_max_money[level]
end

function human:add_bind_yuanbao(value, reason, extra)
    assert(value > 0)
    value = math.ceil(value)
    value = self:get_bind_yuanbao() + value
    self:set_bind_yuanbao(value, reason, extra)
end

function human:get_bind_yuanbao()
    return self.db:get_db_attrib("bind_yuanbao")
end

function human:set_bind_yuanbao(bind_yuanbao, reason, extra,not_record)
    if bind_yuanbao < 0 then
        return false
    end
    local before = self:get_bind_yuanbao()
    bind_yuanbao = bind_yuanbao > define.INT32_MAX and define.INT32_MAX or bind_yuanbao
    self.db:set_db_attrib({ bind_yuanbao = bind_yuanbao})
    self:log_money_rec(reason, "绑定元宝", before, bind_yuanbao - before, extra)
	if not not_record and bind_yuanbao < before then
		local subvalue = before - bind_yuanbao
		local have = self:get_game_flag_key("cost_bind_yuanbao")
		self:set_game_flag_key("cost_bind_yuanbao",have + subvalue)
	end
end

function human:cost_bind_yuanbao(value, reason, extra,not_record)
    assert(value >= 0)
    value = math.ceil(value)
	local have = self:get_bind_yuanbao()
    local sub_have = have - value
	if sub_have < 0 then
		sub_have = 0
	end
    self:set_bind_yuanbao(sub_have, reason, extra,not_record)
end

function human:is_attackers(other)
    -- return self.attackers_list:is_exist(other:get_guid())
    return self.pk_declaration_list:is_exist(other:get_guid())
end

function human:is_in_pk_declaration_list(other)
    return self.pk_declaration_list:is_exist(other:get_guid())
end

function human:is_wild_war_guild(other)
    return self.wild_war_guilds:is_exist(other:get_guild_id())
end

function human:is_counter_killed(killer)
    if killer:get_obj_type() ~= "human" then
        return false
    end
    local pk_mode = killer:get_pk_mode()
    if pk_mode == define.PK_MODE.PERSONAL 
	or pk_mode == define.PK_MODE.TEAM 
	or pk_mode == define.PK_MODE.RAID 
	or pk_mode == define.PK_MODE.BANG_HUI then
        return false
    end
    if self:is_in_pk_declaration_list(killer) then
        return true
    end
    if self:is_wild_war_guild(killer) then
        return true
    end
    -- if killer:is_attackers(self) then
        -- return true
    -- end
    return false
end

function human:is_enemy_human(other)
    if other:get_level() < self.db:get_attrib("pk_min_level") then
        return false
    end
    -- if self:is_attackers(other) then
        -- return true
    -- end
    if self:is_in_pk_declaration_list(other) then
        return true
    end
    -- if other:is_in_pk_declaration_list(self) then
        -- return true
    -- end
    if self:is_wild_war_guild(other) then
        return true
    end
    if other:is_wild_war_guild(self) then
        return true
    end
    if self:is_enemy_camp(other) then
        return true
    end
    local pk_mode = self.db:get_db_attrib("pk_mode")
    if pk_mode == define.PK_MODE.PERSONAL then
        return true
    elseif pk_mode == define.PK_MODE.TEAM then
        local team_id = other:get_team_id()
        local my_team_id = self:get_team_id()
        if my_team_id == define.INVAILD_ID then
            return true
        else
            return my_team_id ~= team_id
        end
    elseif pk_mode == define.PK_MODE.BANG_HUI then
        if other:get_server_id() ~= self:get_server_id() then
            return true
        end
        local guild_id = other:get_guild_id()
        guild_id = guild_id or define.INVAILD_ID
        local my_guild_id = self:get_guild_id()
        my_guild_id = my_guild_id or define.INVAILD_ID
        local confederate_id = other:get_confederate_id()
        confederate_id = confederate_id or define.INVAILD_ID
        local my_confederate_id = self:get_confederate_id()
        my_confederate_id = my_confederate_id or define.INVAILD_ID
        if my_guild_id == define.INVAILD_ID then
            return true
        end
        if my_guild_id ~= guild_id then
            if my_confederate_id == define.INVAILD_ID then
                return true
            end
            return my_confederate_id ~= confederate_id
        end
    elseif pk_mode == define.PK_MODE.RAID then
        local my_raid_id = self:get_raid_id()
        if my_raid_id == define.INVAILD_ID then
            return true
        else
            return my_raid_id ~= other:get_raid_id()
        end
    elseif pk_mode == define.PK_MODE.GOD_AND_EVIL then
        if other:get_pk_value() > 0 then
            return true
        end
    end
    return false
end

function human:is_enemy(other)
    if self:get_obj_id() == other:get_obj_id() then
        return false
    end
	local obj_type = other:get_obj_type()
    if obj_type == "monster" then
        if other:get_reputation() == 0 then
            return false
        end
    elseif obj_type == "pet" then
        local owner = other:get_owner()
        if owner and owner:get_obj_id() == self:get_obj_id() then
            return false
        end
        if not owner then
            return false
        end
        assert(other ~= owner)
        -- return self:is_enemy(owner)
		return self:is_enemy_human(owner)
    elseif obj_type == "human" then
        return self:is_enemy_human(other)
    end
    return self:is_enemy_camp(other)
end

function human:is_teammate(other)
    if not other then
        return false
    end
    if other:get_obj_type() ~= "human" then
        return false
    end
	local other_raid_id = other:get_raid_id()
	if other_raid_id == define.INVAILD_ID then
		local other_team_id = other:get_team_id()
		if other_team_id == define.INVAILD_ID then
			return false
		end
		return other_team_id == self:get_team_id()
	else
		return other_raid_id == self:get_raid_id()
	end
	return false
end

function human:is_raidmate(other)
    if not other then
        return false
    end
    if other:get_obj_type() ~= "human" then
        return false
    end
	local other_raid_id = other:get_raid_id()
    if other_raid_id == define.INVAILD_ID then
        return false
    end
    return other_raid_id == self:get_raid_id()
end

function human:is_partner(other)
    if self:get_obj_id() == other:get_obj_id() then
        return true
    end
    local team_id = self:get_team_id()
    if team_id == define.INVAILD_ID then
        return false
    end
    local team_id_tar = define.INVAILD_ID
    if other:get_obj_type() == "human" then
        team_id_tar = other:get_team_id()
    elseif other:get_obj_type() == "pet" then
        local owner = other:get_owner()
        if owner and owner:get_obj_type() == "human" then
            team_id_tar = owner:get_team_id()
        end
    end
    if team_id_tar == define.INVAILD_ID then
        return false
    end
    return team_id_tar == team_id
end

function human:get_model()
    return self.db:get_attrib("model")
end

function human:set_model(model)
    self.db:set_db_attrib({ model = model })
end

function human:get_face_style()
    return self.db:get_attrib("face_style")
end

function human:get_hair_style()
    return self.db:get_attrib("hair_style")
end

function human:get_hair_color()
    return self.db:get_attrib("hair_color")
end

function human:get_team_id()
    return self.db:get_attrib("team_id")
end

function human:get_raid_id()
    return self.db:get_attrib("raid_id")
end

function human:get_team_info()
    return self.team_info
end

function human:get_is_team_leader()
    return self.db:get_attrib("is_team_leader") == 1
end

function human:get_team_follow_flag()
    return self.db:get_attrib("team_follow_flag") == 1
end

function human:set_team_follow_flag(flag)
    flag = flag and 1 or 0
    self.db:set_not_gen_attrib({ team_follow_flag = flag})
end

function human:add_team_follow_member(follow_member)
    local teaminfo = self:get_team_info()
    teaminfo:add_followd_member(follow_member)
end

function human:get_team_follow_speed()
    return self.db:get_attrib("team_follow_speed")
end

function human:set_team_follow_speed(speed)
    self.db:set_not_gen_attrib( { team_follow_speed = speed } )
end

function human:get_team_follow_speed_up()
    return self.db:get_attrib("team_follow_speed_up")
end

function human:set_team_follow_speed_up(team_follow_speed_up)
    self.db:set_not_gen_attrib( { team_follow_speed_up = team_follow_speed_up } )
end

function human:out_of_team_follow_range()

end

function human:in_team_follow_range()

end

function human:update_raid_info_by_raid_list(msg)
    local raid_info = self.raid_info
	if not raid_info then
		return
	end
	local sceneId = self.scene:get_id()
	local guid = self:get_guid()
	raid_info:set_raid_id(msg.m_RaidID)
	raid_info:set_my_scene_id(sceneId)
	raid_info:set_my_guid(guid)
	local mb,obj
	for _,list in ipairs(msg.member_list) do
		for _,member in ipairs(list) do
			mb = {
				guid = member.guid,
				m_Position = member.m_Position,
				sceneid = member.sceneid,
				m_objID = define.INVAILD_ID,
			}
			if mb.guid == guid then
				mb.m_objID = self:get_obj_id()
			elseif mb.sceneid == sceneId then
				obj = self.scene:get_obj_by_id(member.m_objID)
				if obj then
					mb.m_objID = obj:get_obj_id()
				end
			end
			raid_info:add_member(mb)
		end
	end
	-- self.attr_msg_to_team_inteval_count = 0
	-- self:sync_raid_member_info()
end

function human:update_raid_info(msg)
	-- skynet.logi("update_raid_info = ",self:get_name(),"msg = ",table.tostr(msg))
    local bNotifyTeamInfoFlag = false
	local raid_info = self.raid_info
	if not raid_info then
		return bNotifyTeamInfoFlag
	end
    local name = self:get_name()
    if msg.return_type == define.RAID_RESULT.RAID_RESULT_MEMBERENTER
        or msg.return_type == define.RAID_RESULT.RAID_RESULT_REFRESH then
        if not raid_info:has_raid() then
            raid_info:set_raid_id(msg.raid_id)
            raid_info:set_my_scene_id(self.scene:get_id())
            raid_info:set_my_guid(self:get_guid())
        end
        local mb = {}
        mb.guid = msg.guid
        mb.m_Position = msg.m_Position
        mb.sceneid = msg.sceneid
        if mb.guid == self:get_guid() then
            mb.m_objID = self:get_obj_id()
        elseif mb.sceneid == self.scene:get_id() then
            local obj = self.scene:get_obj_by_id(msg.m_objID)
            if obj then
                mb.m_objID = obj:get_obj_id()
            end
            bNotifyTeamInfoFlag = true
        else
            mb.m_objID = define.INVAILD_ID
            bNotifyTeamInfoFlag = true
        end
        -- msg.guid_ex = mb.m_objID
        raid_info:add_member(mb)
    elseif msg.return_type == define.RAID_RESULT.RAID_RESULT_ENTERSCENE then
        if msg.guid == self:get_guid() then
			-- if not raid_info:has_raid() then
				-- raid_info:set_raid_id(msg.raid_id)
				-- raid_info:set_my_scene_id(self.scene:get_id())
				-- raid_info:set_my_guid(self:get_guid())
			-- end
            -- raid_info:enter_scene(msg.guid, msg.sceneid , self:get_obj_id())
        else
            local oid = define.INVAILD_ID
            if msg.sceneid == self:get_scene():get_id() then
                local other = self:get_scene():get_obj_by_guid(msg.guid)
                if other then
                    oid = other:get_obj_id()
                end
            end
            raid_info:enter_scene(msg.guid, msg.sceneid, oid)
            bNotifyTeamInfoFlag = true
        end
    elseif msg.return_type == define.RAID_RESULT.RAID_RESULT_MEMBERLEAVE
        or msg.return_type == define.RAID_RESULT.RAID_RESULT_KICK
        or msg.return_type == define.RAID_RESULT.RAID_RESULT_LEADERLEAVE then
            -- if self.raid_info:is_full() then
            -- end
            if self:get_guid() == msg.guid then
                raid_info:dis_miss()
            else
				raid_info:del_member(msg.guid)
                -- if msg.return_type == define.RAID_RESULT.RAID_RESULT_LEADERLEAVE then
                    -- raid_info:change_raid_position()
                -- end
            end
            bNotifyTeamInfoFlag = true
    elseif msg.return_type == define.RAID_RESULT.RAID_RESULT_DISMISS then
		raid_info:dis_miss()
        bNotifyTeamInfoFlag = true
    elseif msg.return_type == define.RAID_RESULT.RAID_RESULT_APPOINT then
        raid_info:appoint(msg.guid_ex,msg.m_Position)
        bNotifyTeamInfoFlag = true
    elseif msg.return_type == define.RAID_RESULT.RAID_RESULT_STARTCHANGESCENE then
        raid_info:start_change_scene(msg.guid)
        if self:get_guid() == msg.guid then
        else
            bNotifyTeamInfoFlag = true
        end
    elseif msg.return_type == define.RAID_RESULT.RAID_RESULT_MEMBEROFFLINE then
        raid_info:member_offline(msg.guid)
        bNotifyTeamInfoFlag = true
    end
    return bNotifyTeamInfoFlag
end


function human:update_team_info(msg)
    local bNotifyTeamInfoFlag = false
	if not self.team_info then
		return bNotifyTeamInfoFlag
	end
    local name = self:get_name()
    if msg.return_type == define.TEAM_RESULT.TEAM_RESULT_MEMBERENTERTEAM
        or msg.return_type == define.TEAM_RESULT.TEAM_RESULT_TEAMREFRESH then
        if not self.team_info:has_team() then
            self.team_info:set_team_id(msg.team_id)
            self.team_info:set_my_scene_id(self.scene:get_id())
            self.team_info:set_my_guid(self:get_guid())
            self.team_info:set_team_leader(msg.leader_guid)
        end
        local mb = {}
        mb.guid = msg.guid
        mb.sceneid = msg.sceneid
        if mb.guid == self:get_guid() then
            mb.m_objID = self:get_obj_id()
        elseif mb.sceneid == self.scene:get_id() then
            local obj = self.scene:get_obj_by_id(msg.guid_ex)
            if obj then
                mb.m_objID = obj:get_obj_id()
            end
            bNotifyTeamInfoFlag = true
        else
            mb.m_objID = define.INVAILD_ID
            bNotifyTeamInfoFlag = true
        end
        msg.guid_ex = mb.m_objID
        self.team_info:add_member(mb)
    elseif msg.return_type == define.TEAM_RESULT.TEAM_RESULT_ENTERSCENE then
        if msg.guid == self:get_guid() then
            if not self.team_info:has_team() then
                self.team_info:set_team_id(msg.team_id)
                self.team_info:set_my_scene_id(self.scene:get_id())
                self.team_info:set_my_guid(self:get_guid())
                self.team_info:set_team_leader(msg.leader_guid)
            end
            self.team_info:enter_scene(msg.guid, msg.sceneid , self:get_obj_id())
        else
            local oid = define.INVAILD_ID
            if msg.sceneid == self:get_scene():get_id() then
                local other = self:get_scene():get_obj_by_guid(msg.guid)
                if other then
                    oid = other:get_obj_id()
                end
            end
            self.team_info:enter_scene(msg.guid, msg.sceneid, oid)
            bNotifyTeamInfoFlag = true
        end
    elseif msg.return_type == define.TEAM_RESULT.TEAM_RESULT_MEMBERLEAVETEAM
        or msg.return_type == define.TEAM_RESULT.TEAM_RESULT_TEAMKICK
        or msg.return_type == define.TEAM_RESULT.TEAM_RESULT_LEADERLEAVETEAM then
            if self.team_info:is_full() then
            end
            if self:get_guid() == msg.guid then
                if self:get_team_follow_flag() then
                    self:stop_team_follow()
                end
                self.team_info:dis_miss()
                self.db:set_not_gen_attrib({is_in_team = 0})
                self.db:set_not_gen_attrib({is_team_leader = 0})
                self.db:set_not_gen_attrib({team_id = define.INVAILD_ID})
            else
                self.team_info:del_member(msg.guid)
                if msg.return_type == define.TEAM_RESULT.TEAM_RESULT_LEADERLEAVETEAM then
                    self.team_info:appoint(msg.leader_guid)
                    if self:get_team_follow_flag() then
                        self:stop_team_follow()
                    end
                end
            end
            bNotifyTeamInfoFlag = true
    elseif msg.return_type == define.TEAM_RESULT.TEAM_RESULT_TEAMDISMISS then
        if self:get_team_follow_flag() then
            self:stop_team_follow()
        end
        local teaminfo = self:get_team_info()
        teaminfo:set_team_id(define.INVAILD_ID)
        teaminfo:set_team_leader(define.INVAILD_ID)
        bNotifyTeamInfoFlag = true
    elseif msg.return_type == define.TEAM_RESULT.TEAM_RESULT_TEAMAPPOINT then
        if self:get_team_follow_flag() then
            self:stop_team_follow()
        end
        self.team_info:appoint(msg.guid_ex)
        bNotifyTeamInfoFlag = true
    elseif msg.return_type == define.TEAM_RESULT.TEAM_RESULT_STARTCHANGESCENE then
        self.team_info:start_change_scene(msg.guid)
        if self:get_guid() == msg.guid then
        else
            bNotifyTeamInfoFlag = true
        end
    elseif msg.return_type == define.TEAM_RESULT.TEAM_RESULT_MEMBEROFFLINE then
        self.team_info:member_offline(msg.guid)
        bNotifyTeamInfoFlag = true
    end
    return bNotifyTeamInfoFlag
end

function human:stop_team_follow()
    local teaminfo = self:get_team_info()
    if not teaminfo:has_team() then
        return
    end
    local team_leader
    if self:get_team_follow_flag() then
        if self:get_is_team_leader() then
            team_leader = self
            local followd_member_count = teaminfo:get_followed_members_count()
            for i = followd_member_count, 1, -1 do
                local followd_member = teaminfo:get_followed_member(i)
                local member = self:get_scene():get_obj_by_guid(followd_member.guid)
                if member then
                    member:get_team_info():clear_followed_members()
                    member:get_ai():push_command_stop_team_follow()
                    member:set_team_follow_flag(false)

                    local msg = packet_def.GCReturnTeamFollow.new()
                    msg.return_type = define.TEAM_FOLLOW_RESULT.TF_RESULT_STOP_FOLLOW
                    msg.guid = member:get_guid()
                    self:get_scene():send2client(member, msg)
                end
            end
        else
            local team_leader_guid = teaminfo:get_team_leader()
            team_leader = self:get_scene():get_obj_by_guid(team_leader_guid)
            local guid = self:get_guid()
            teaminfo:del_followd_member(guid)
            self:get_ai():push_command_stop_team_follow()
            self:set_team_follow_flag(false)

            local followd_member_count = teaminfo:get_followed_members_count()
            for i = followd_member_count, 1, -1 do
                local followd_member = teaminfo:get_followed_member(i)
                local member = self:get_scene():get_obj_by_guid(followd_member.guid)
                if member then
                    member:get_team_info():del_followd_member(guid)
                end
            end
            teaminfo:clear_followed_members()
            local msg = packet_def.GCReturnTeamFollow.new()
            msg.return_type = define.TEAM_FOLLOW_RESULT.TF_RESULT_STOP_FOLLOW
            msg.guid = self:get_guid()
            self:get_scene():send2client(self, msg)
            if team_leader then
                self:get_scene():send2client(team_leader, msg)
            end
        end
    end
    if team_leader then
        local msg = packet_def.GCTeamFollowList.new()
        msg.m_objID = team_leader:get_obj_id()
        local followd_team_member_count = teaminfo:get_followed_members_count()
        for i = 1, followd_team_member_count do
            local followd_member = teaminfo:get_followed_member(i)
            table.insert(msg.guids, followd_member.guid)
        end
        self:get_scene():broadcast(team_leader, msg, true)
    end
    self:get_scene():send_world(self, "lua", "leave_team_follow", self:get_guid())
end

function human:update_team_info_by_team_list(msg)
    local teaminfo = self:get_team_info()
	if not teaminfo then
		return
	end
    teaminfo:set_exp_mode(msg.exp_mode)
    for i = 1, msg.member_size do
        local member = msg.member_list[i]
        teaminfo:add_member(member)
    end
end

function human:update_team_option(msg)
    local teaminfo = self:get_team_info()
	if not teaminfo then
		return
	end
    teaminfo:set_option(msg)
end

function human:item_flush()
    self.db:item_effect_flush()
end

function human:send_refresh_attrib()
    self.db:send_refresh_attrib()
end

function human:mark_data_dirty_flag(param)
    self.db:mark_data_dirty_flag(param)
end

function human:sync_raid_member_info()
    local raid_info = self.raid_info
    if not raid_info then
        return
    end
    if not raid_info:has_raid() then
        return
    end
	local near_count = raid_info:get_scene_member_count()
	-- skynet.logi("near_count = ",near_count)
    if near_count < 1 then
        return
    end
    local msg = packet_def.GCRaidMemberInfo.new()
	msg.flag = 0
	msg.m_RaidID = raid_info:get_raid_id()
    msg.guid = self:get_attrib("guid")
    self.last_sync_raid_member_info = self.last_sync_raid_member_info or {}
    local menpai = self:get_attrib("menpai")
    if self.last_sync_raid_member_info.menpai ~= menpai then
        msg:set_menpai(menpai)
        self.last_sync_raid_member_info.menpai = menpai
    end
    local level = self:get_attrib("level")
    if self.last_sync_raid_member_info.level ~= level then
        msg:set_level(level)
        self.last_sync_raid_member_info.level = level
    end
    local world_pos = self:get_attrib("world_pos")
    self.last_sync_raid_member_info.world_pos = self.last_sync_raid_member_info.world_pos or {}
    if self.last_sync_raid_member_info.world_pos.x ~= world_pos.x or self.last_sync_raid_member_info.world_pos.y ~= world_pos.y then
        msg:set_world_pos(world_pos)
        self.last_sync_raid_member_info.world_pos = world_pos
    end
    local hp = self:get_attrib("hp")
    if self.last_sync_raid_member_info.hp ~= hp then
        msg:set_hp(hp)
        self.last_sync_raid_member_info.hp = hp
    end
    local hp_max = self:get_attrib("hp_max")
    if self.last_sync_raid_member_info.hp_max ~= hp_max then
        msg:set_hp_max(hp_max)
        self.last_sync_raid_member_info.hp_max = hp_max
    end
	
    local die = self:is_die()
    if self.last_sync_raid_member_info.die ~= die then
        msg:set_is_die(die)
        self.last_sync_raid_member_info.die = die
    end
    local hair_id = self:get_attrib("hair_id")
    if self.last_sync_raid_member_info.hair_id ~= hair_id then
        msg:set_hair_id(hair_id)
        self.last_sync_raid_member_info.hair_id = hair_id
    end
    local hair_color = self:get_attrib("hair_color")
    if self.last_sync_raid_member_info.hair_color ~= hair_color then
        msg:set_hair_color(hair_color)
        self.last_sync_raid_member_info.hair_color = hair_color
    end
    local portrait_id = self:get_attrib("portrait_id")
    if self.last_sync_raid_member_info.portrait_id ~= portrait_id then
        msg:set_portrait_id(portrait_id)
        self.last_sync_raid_member_info.portrait_id = portrait_id
    end
	local check_wg = function(tbl1,tbl2)
		if tbl1.visual ~= tbl2.visual then
			return true
		elseif tbl1.item_index ~= tbl2.item_index then
			return true
		end
		return
	end
	local weapon = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_WEAPON)
    if check_wg(self.last_sync_raid_member_info.weapon or {},weapon) then
        msg:set_weapon(weapon)
        self.last_sync_raid_member_info.weapon = weapon
    end
	local cap = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_CAP)
    if check_wg(self.last_sync_raid_member_info.cap or {},cap) then
        msg:set_cap(cap)
        self.last_sync_raid_member_info.cap = cap
    end
	local armour = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_ARMOR)
    if check_wg(self.last_sync_raid_member_info.armour or {},armour) then
        msg:set_armour(armour)
        self.last_sync_raid_member_info.armour = armour
    end
	local cuff = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_GLOVE)
    if check_wg(self.last_sync_raid_member_info.cuff or {},cuff) then
        msg:set_cuff(cuff)
        self.last_sync_raid_member_info.cuff = cuff
    end
	local foot = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_BOOT)
    if check_wg(self.last_sync_raid_member_info.foot or {},foot) then
        msg:set_foot(foot)
        self.last_sync_raid_member_info.foot = foot
    end
	local fashion = self:get_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_FASHION)
    if check_wg(self.last_sync_raid_member_info.fashion or {},fashion) then
        msg:set_fashion(fashion)
        self.last_sync_raid_member_info.fashion = fashion
    end
    if msg.flag ~= 0 then
        msg.data_index = 0
		local scene = self:get_scene()
        for i = near_count, 1, -1 do
            local oid = raid_info:get_scene_member_obj_id(i)
            local raidmate = scene:get_obj_by_id(oid)
            if raidmate then
                scene:send2client(raidmate, msg)
            else
                raid_info:del_scene_member(oid)
            end
        end
    end
end

function human:sync_team_member_info()
    local team_info = self:get_team_info()
    if not team_info then
        return
    end
	-- skynet.logi("sync_team_member_info:has_team = ",team_info:has_team(),"count = ",team_info:get_team_member_count())
    if not team_info:has_team() then
        return
    end
    if team_info:get_scene_member_count() < 1 then
        return
    end
    local msg = packet_def.GCTeamMemberInfo.new()
    msg.guid = self:get_attrib("guid")
    self.last_sync_team_member_info = self.last_sync_team_member_info or {}
    local menpai = self:get_attrib("menpai")
    if self.last_sync_team_member_info.menpai ~= menpai then
        msg:set_menpai(menpai)
        self.last_sync_team_member_info.menpai = menpai
    end
    local level = self:get_attrib("level")
    if self.last_sync_team_member_info.level ~= level then
        msg:set_level(level)
        self.last_sync_team_member_info.level = level
    end
    local world_pos = self:get_attrib("world_pos")
    self.last_sync_team_member_info.world_pos = self.last_sync_team_member_info.world_pos or {}
    if self.last_sync_team_member_info.world_pos.x ~= world_pos.x or self.last_sync_team_member_info.world_pos.y ~= world_pos.y then
        msg:set_world_pos(world_pos)
        self.last_sync_team_member_info.world_pos = world_pos
    end
    local hp = self:get_attrib("hp")
    if self.last_sync_team_member_info.hp ~= hp then
        msg:set_hp(hp)
        self.last_sync_team_member_info.hp = hp
    end
    local hp_max = self:get_attrib("hp_max")
    if self.last_sync_team_member_info.hp_max ~= hp_max then
        msg:set_hp_max(hp_max)
        self.last_sync_team_member_info.hp_max = hp_max
    end
    if msg.flag ~= 0 then
        msg.data_index = 0
        for i = team_info:get_scene_member_count(), 1, -1 do
            local oid = team_info:get_scene_member_obj_id(i)
            local teammate = self:get_scene():get_obj_by_id(oid)
            if teammate then
                self:get_scene():send2client(teammate, msg)
            else
                team_info:del_scene_member(oid)
            end
        end
    end
end

function human:send_refresh_cool_down_time()
    local cool_downd = {}
    for id, cool_down_time in pairs(self.cool_down_times) do
        if cool_down_time < 0 then
            cool_downd[id] = true
        end
    end
    for id in pairs(cool_downd) do
        self.cool_down_times[id] = nil
        self:on_skill_cool_down(id)
    end
end

function human:on_skill_cool_down(id)
    if self.skill_comb_operation and self.skill_comb_operation.skill_id then
        local skill_id = self.skill_comb_operation.skill_id
        local template = skillenginer:get_skill_template(skill_id)
        if template.cool_down_id == tonumber(id) then
            self:combo_skill_cool_downd(skill_id)
        end
    end
end

function human:update_ve_recover(delta_time)
    if self.ve_recover_timer then
        if self.ve_recover_timer > 0 then
            self.ve_recover_timer = self.ve_recover_timer - delta_time
        else
            self.ve_recover_timer = nil
            local vigor = self:get_vigor()
            local vigor_max = self:get_vigor_max()
            vigor = vigor + 1
            vigor = vigor > vigor_max and vigor_max or vigor

            local energy = self:get_stamina()
            local energy_max = self:get_stamina_max()
            energy = vigor + 1
            energy = energy > energy_max and energy_max or energy

            self:set_vigor(vigor)
            self:set_stamina(energy)
        end
    else
        local config_info = configenginer:get_config("config_info")
        self.ve_recover_timer = tonumber(config_info.Human.HumanVERecoverInterval)
    end
end

function human:update_double_exp_info(delta_time)
    local double_exp_info = self.double_exp_info
    if not double_exp_info.is_lock then
        if double_exp_info.free_time > 0 then
            double_exp_info.free_time = double_exp_info.free_time - delta_time / 1000
            return
        else
            double_exp_info.free_time = 0 
        end
        if double_exp_info.money_time > 0 then
            double_exp_info.money_time = double_exp_info.money_time - delta_time / 1000
            return
        else
            double_exp_info.money_time = 0 
        end
    end
end

function human:wash_some_points(ntype, point)
    local base_lv1_attrs = self:get_level_lv1_base_attr()
    local key
    if ntype == 1 then
        key = "str"
    elseif ntype == 2 then
        key = "spr"
    elseif ntype == 3 then
        key = "con"
    elseif ntype == 4 then
        key = "int"
    elseif ntype == 5 then
        key = "dex"
    end
    assert(key, ntype)
    local lv1_attrib = self.db:get_lv1_attrib()
    point = point > (lv1_attrib[key] - base_lv1_attrs[key]) and (lv1_attrib[key] - base_lv1_attrs[key]) or point
    self.db:set_lv1_attrib({ [key] = lv1_attrib[key] - point })
    self.db:set_lv1_attrib({ ["point_remain"] = lv1_attrib["point_remain"] + point })
    self:item_flush()
    return point
end

function human:get_level_lv1_base_attr()
    local level = self:get_level()
    local wash_point_level = define.DEFAULT_WASHPOINT_LEVEL
    local attr_level_up = configenginer:get_config("attr_level_up_table")
    local menpai = self:get_attrib("menpai")
    local chn = define.ENUM_MENPAI_CHN[menpai]
    local lv1_attrs = {}
    for i = 0, level do
        local attr_up = attr_level_up[i]
		--attr_up[力量][恶人谷] = value
        for attr, v in pairs(attr_up) do
            if v[chn] then
                local v_chn = v[chn]
                local key = attr
                local add = 0
                if type(v_chn) == "table" then
                    add = v_chn[1]
                else
                    add = v_chn
                end
                local e = lv1_attrs[key] or 0
                local new = e + add
                lv1_attrs[key] = new
            end
        end
        local key = "point_remain"
        local add_point_remain = self:get_level_up_point_remain_add(i)
        local e = lv1_attrs[key] or 0
        local new = e + add_point_remain
        lv1_attrs[key] = new
    end
    return lv1_attrs
end

function human:wash_points()
    local lv1_attrs = self:get_level_lv1_base_attr()
    for attr, value in pairs(lv1_attrs) do
        self.db:set_lv1_attrib({ [attr] = value })
    end
    self:item_flush()
end

function human:get_lv1_point_remain()
    return self.db:get_lv1_attrib().point_remain
end

function human:set_lv1_point_remain(value)
    self.db:set_lv1_attrib({ ["point_remain"] = value })
end

function human:change_menpai_points()
    self:wash_points()
    self.db:mark_all_attr_dirty()
end

function human:manual_attr(manual)
    assert(manual.str >= 0, manual.str)
    assert(manual.spr >= 0, manual.spr)
    assert(manual.con >= 0, manual.con)
    assert(manual.int >= 0, manual.int)
    assert(manual.dex >= 0, manual.dex)
    local lv1_attribs = self.db:get_lv1_attrib()
    local point_remain = lv1_attribs.point_remain
    local total = manual.str + manual.spr + manual.con + manual.int + manual.dex
    if total > point_remain then
        return define.ATTR_RESUlT.ATTR_RESULT_NOT_ENOUGH_REMAIN_POINT
    end
    self.db:set_lv1_attrib({ point_remain = point_remain - total})
    self.db:set_lv1_attrib({ str = lv1_attribs.str + manual.str })
    self.db:set_lv1_attrib({ spr = lv1_attribs.spr + manual.spr })
    self.db:set_lv1_attrib({ con = lv1_attribs.con + manual.con })
    self.db:set_lv1_attrib({ int = lv1_attribs.int + manual.int })
    self.db:set_lv1_attrib({ dex = lv1_attribs.dex + manual.dex })
    self:send_refresh_attrib()
    return define.ATTR_RESUlT.ATTR_RESUlT_SUCCESS
end

function human:add_ride_buff(ride_buffs)
	local list = self:get_impact_list()
	local istrue
	for buff,flag in pairs(ride_buffs) do
		-- skynet.logi("buff = ",buff)
		-- skynet.logi("flag = ",flag)
		if flag == 1 then
			istrue = false
			for _, imp in ipairs(list) do
				if imp:get_data_index() == buff then
					istrue = true
					break
				end
			end
			if not istrue then
				impactenginer:send_impact_to_unit(self, buff, self, 100, false, 0)
			end
		else
			for _, imp in ipairs(list) do
				if imp:get_data_index() == buff then
					self:on_impact_fade_out(imp)
					self:remove_impact(imp)
					break
				end
			end
		end
	end
end

function human:send_exterior_info(open_type)

    local now = os.time()
	
    local exterior_ride = configenginer:get_config("exterior_ride")
    local mail = {
        guid = define.INVAILD_ID,
        source = "",
        portrait_id = define.INVAILD_ID,
        dest = self:get_name(),
        flag = define.MAIL_TYPE.MAIL_TYPE_SYSTEM,
        create_time = now
    }
	
    local my_exterior_weapon_visuals = self.exterior.weapon_visuals or {}
    local msg = packet_def.GCExteriorInfo.new()
    local msg_term = packet_def.GCExteriorInfo.new()
    msg.type = open_type or 0
    msg.unknow_2 = 0
    msg.unknow_3 = 1
    msg.weapon_visual_count = #my_exterior_weapon_visuals
    msg.list_1 = {}
    msg.weapon_visuals = {}
    msg.hair_colors = {}
    msg.extrior_list = {}
    msg_term.type = open_type
    msg_term.unknow_2 = 0
    msg_term.extrior_list = {}
    for i = 1, msg.weapon_visual_count do
        local visual = my_exterior_weapon_visuals[i] or { id = 0, term = define.INVAILD_ID, level = 0}
        table.insert(msg.weapon_visuals, visual)
    end
    local my_faces = self.exterior.faces
    msg.list_1[define.Exterior_Type.Face] = {list = {}}
    msg.list_1[define.Exterior_Type.Face].size = #my_faces
    for i = 1, msg.list_1[define.Exterior_Type.Face].size do
        local face = my_faces[i]
        table.insert(msg.list_1[define.Exterior_Type.Face].list, {
            unknow_1 = face.id,
            unknow_2 = face.term,
            unknow_3 = 0
        })
    end
    local my_hairs = self.exterior.hairs
    msg.list_1[define.Exterior_Type.Hair] = {list = {}}
    msg.list_1[define.Exterior_Type.Hair].size = #my_hairs
    for i = 1, msg.list_1[define.Exterior_Type.Hair].size do
        local hair = my_hairs[i]
        table.insert(msg.list_1[define.Exterior_Type.Hair].list, {
            unknow_1 = hair.id,
            unknow_2 = hair.term,
            unknow_3 = 0
        })
    end
    local my_heads = self.exterior.heads
    msg.list_1[define.Exterior_Type.Head] = {list = {}}
    msg.list_1[define.Exterior_Type.Head].size = #my_heads
    for i = 1, msg.list_1[define.Exterior_Type.Head].size do
        local head = my_heads[i]
        table.insert(msg.list_1[define.Exterior_Type.Head].list, {
            unknow_1 = head.id,
            unknow_2 = head.term,
            unknow_3 = 0
        })
    end
	local cur_rideid = self:get_ride()
	local del_iscur = false
	
	local ride_dy_info = {}
	local ride_buffs = {}
	local env = skynet.getenv("env")
	if define.ADD_EQUIP_BUFF[env] then
		for _,dy_info in ipairs(define.ADD_EQUIP_BUFF[env]) do
			if dy_info[define.HUMAN_EQUIP.HEQUIP_RIDER] then
				table.insert(ride_dy_info,dy_info[define.HUMAN_EQUIP.HEQUIP_RIDER])
				local buff_id = dy_info[define.HUMAN_EQUIP.HEQUIP_RIDER].BUFFID
				ride_buffs[buff_id] = 0
			end
		end
	end
    local my_rides = self.exterior.rides
    msg.list_1[define.Exterior_Type.Ride] = {list = {}}
	for i = #my_rides,1,-1 do
		local ride = my_rides[i]
		if ride.term == -1 then
			table.insert(msg.list_1[define.Exterior_Type.Ride].list, {
				unknow_1 = ride.id,
				unknow_2 = -1,
				unknow_3 = 0
			})
			for _,have in ipairs(ride_dy_info) do
				if ride.id >= have.MINID and ride.id <= have.MAXID then
					local buff_id = have.BUFFID
					ride_buffs[buff_id] = 1
				end
			end
		elseif ride.term > now then
			table.insert(msg.list_1[define.Exterior_Type.Ride].list, {
				unknow_1 = ride.id,
				unknow_2 = -1,
				unknow_3 = 0
				-- unknow_1 = ride.id,
				-- unknow_2 = ride.term - now,
				-- unknow_3 = 1
			})
            table.insert(msg_term.extrior_list, {id = ride.id, remindtime = ride.term - now, unknow_3 = i})
			for _,have in ipairs(ride_dy_info) do
				if ride.id >= have.MINID and ride.id <= have.MAXID then
					local buff_id = have.BUFFID
					ride_buffs[buff_id] = 1
				end
			end
		else
			local del_ride = table.remove(my_rides,i)
			local del_rideid = del_ride.id
			if del_rideid == cur_rideid then
				del_iscur = true
			end
            if exterior_ride[del_rideid] and exterior_ride[del_rideid].name then
                local del_mail = string.contact_args("#{YXQ_221123_01", exterior_ride[del_ride.id].name) .. "}"
               if del_mail then
					mail.content = del_mail
					skynet.send(".world", "lua", "send_mail", mail)
				end
            end
		end
	end
    msg.list_1[define.Exterior_Type.Ride].size = #my_rides
    -- for i = 1, msg.list_1[define.Exterior_Type.Ride].size do
        -- local ride = my_rides[i]
        -- table.insert(msg.list_1[define.Exterior_Type.Ride].list, {
            -- unknow_1 = ride.id,
            -- unknow_2 = -1,
            -- unknow_3 = 0
        -- })
        -- if ride.term > now then
            -- table.insert(msg_term.extrior_list, {id = ride.id, remindtime = ride.term - now, unknow_3 = i})
        -- end
    -- end
    local my_poss = self.exterior.poss
    msg.list_1[define.Exterior_Type.Poss] = {list = {}}
    msg.list_1[define.Exterior_Type.Poss].size = #my_poss
    for i = 1, msg.list_1[define.Exterior_Type.Poss].size do
        local pos = my_poss[i]
        table.insert(msg.list_1[define.Exterior_Type.Poss].list, {
            unknow_1 = pos.id,
            unknow_2 = -1,
            unknow_3 = 0
        })
    end
    msg.exterior_hair_color_index = self:get_exterior_hair_color_index()
    local my_hair_colors = self.exterior.hair_colors or {}
    for i = 1, 20 do
        local hair_color = my_hair_colors[i] or { value = 0 }
        msg.hair_colors[i] = hair_color
    end
	--flagwg
    if open_type == 6 then
		local visual_id,visual_level = self:get_exterior_weapon_visual_id()
		local BackId,BackPos = self:get_exterior_back_visual_id()
		local HeadId,HeadPos = self:get_exterior_head_visual_id()
		msg.exterior_back_id = BackId
		msg.exterior_back_pos = BackPos
		msg.exterior_head_id = HeadId
		msg.exterior_head_pos = HeadPos
		msg.extrior_weapon_visual_id = visual_id
		msg.extrior_weapon_visual_level = visual_level
	end
    msg.extrior_count = #msg.extrior_list
    self:get_scene():send2client(self, msg)
    if open_type == define.Exterior_Type.Ride then
		-- msg_term.exterior_back_id = BackId
		-- msg_term.exterior_back_pos = BackPos
		-- msg_term.exterior_head_id = HeadId
		-- msg_term.exterior_head_pos = HeadPos
        msg_term.extrior_count = #msg_term.extrior_list
        self:get_scene():send2client(self, msg_term)
    end
	
	
	if del_iscur then
		self.db:set_attrib({ride = -1})
        local imp = self:impact_get_first_impact_of_specific_class_id(99)
		if imp then
			self:on_impact_fade_out(imp)
			self:remove_impact(imp)
		end
	end
	self:add_ride_buff(ride_buffs)
end

function human:have_this_head_image(id)
    local heads = self.exterior.heads
    for _, v in ipairs(heads) do
        if v.id == id then
            return true
        end
    end
    return false
end

function human:have_this_face_style(id)
    local faces = self.exterior.faces
    for _, v in ipairs(faces) do
        if v.id == id then
            return true
        end
    end
    return false
end

function human:have_this_hair_style(id)
    local hairs = self.exterior.hairs
    for _, v in ipairs(hairs) do
        if v.id == id then
            return true
        end
    end
    return false
end

function human:have_this_ride(index)
    local rides = self.exterior.rides
    for _, v in ipairs(rides) do
        if v.id == index then
            return true
        end
    end
    return false
end

function human:reverse_ride(index)
	local isdel
    local rides = self.exterior.rides
    for i, v in ipairs(rides) do
        if v.id == index then
			isdel = table.remove(rides,i)
			break
        end
    end
	if isdel then
		if self:get_ride() == index then
			self.db:set_attrib({ride = -1})
			local imp = self:impact_get_first_impact_of_specific_class_id(99)
			if imp then
				self:on_impact_fade_out(imp)
				self:remove_impact(imp)
			end
		end
		self:send_exterior_info()
	end
    return isdel
end


function human:add_expiration_time(index, add)
    local now = os.time()
    local istrue = false
    local add_finish = false
    local rides = self.exterior.rides
    local function update_ride(ride, add)
        if add == -1 then
            ride.term = -1
            ride.terminable = 0
        else
            if ride.term < now then
                ride.term = now + add
            else
                ride.term = ride.term + add
            end
            ride.terminable = 1
        end
    end
    for i = #rides, 1, -1 do
        local v = rides[i]
        if v.id == index then
            if v.term ~= -1 then
                update_ride(v, add)
                add_finish = true
            end
            istrue = true
        end
    end
    if not istrue then
        local ride = { id = index, term = now + add, terminable = 1 }
        if add == -1 then
            ride.term = -1
            ride.terminable = 0
        end
        table.insert(rides, ride)
        add_finish = true
    end
    return add_finish
end


function human:get_double_exp_info()
    return self.double_exp_info
end

function human:send_double_exp_info()
    local msg = packet_def.GCDoubleExpInfo.new()
    msg.available_hour = self.double_exp_info.available_hour
    msg.is_lock = self.double_exp_info.is_lock and 1 or 0
    msg.money_time = math.floor(self.double_exp_info.money_time)
    msg.total_time = math.floor(self.double_exp_info.money_time) + math.floor(self.double_exp_info.free_time)
    msg.rtime = self.double_exp_info.rtime
    self:get_scene():send2client(self, msg)
end

function human:set_exp_rate(value)
	self.double_exp_info.exp_rate = value
end

function human:get_double_exp_mult()
    local double_exp_info = self.double_exp_info
	local exp_rate = double_exp_info.exp_rate or 0
	if exp_rate > 0 then
		return exp_rate
	end
    if not double_exp_info.is_lock then
        if double_exp_info.free_time > 0 then
            return 2
        end
        if double_exp_info.money_time > 0 then
            return 2
        end
    end
    return 1
end

function human:get_pet_exp_mult()
    local value = self.db:get_attrib("pet_exp_multiple") or 0
    return value
end

function human:add_pet_by_data_id(data_id, is_rmb, growth_rate, pet_guid_low)
    print("human:add_pet_by_data_id data_id =", data_id)
    local guid = pet_guid.new()
    local spouse_guid = pet_guid.new()
    if pet_guid_low then
        guid:set(self:get_guid(), pet_guid_low)
    else
        guid:set(self:get_guid(), skynet.now() * 10 + math.random(10) % 10)
    end
    local attrib = { guid = guid, spouse_guid = spouse_guid, data_id = data_id}
    local lv1_attrib = {}
    local pet = pet_detail.new()
    pet:init_from_data({ skills = {activate = {}, positive = {}}, equips = {}, lv1_attrib = lv1_attrib, attrib = attrib}, self)
    petmanager:make_capture_pet_attrib(pet, is_rmb, growth_rate, false, true)
    self:add_pet(pet)
    return true, guid.m_uHighSection, guid.m_uLowSection
end

function human:add_pet(pet)
    local container = self:get_pet_bag_container()
    local empty_index = container:get_empty_item_index()
    assert(empty_index ~= define.INVAILD_ID)
    container:set_item(empty_index, pet)
    local guid = pet:get_attrib("guid")
    self:send_pets_detail(self)
    self:on_add_pet(pet)
    return true, guid.m_uHighSection, guid.m_uLowSection
end

function human:send_pets_detail(who, type)
    local container = self:get_pet_bag_container()
    local size = container:get_size()
    for i = 0, size - 1 do
        local pet = container:get_item(i)
        if pet then
            self:send_pet_detail(pet, who, type)
        end
    end
end

function human:send_pet_detail(pet, who, type)
    pet:send_refresh_attrib(who, true, type)
end

function human:set_guid_of_call_up_pet(guid)
    self.guid_of_call_up_pet = guid
end

function human:get_guid_of_call_up_pet()
    return self.guid_of_call_up_pet
end

function human:can_take(pet)
    local human_level = self:get_level()
    local take_level = pet:get_take_level()
    if human_level < take_level then
        return false
    end
    local wuxing = pet:get_wuxing()
    local extra_take_level = math.ceil(wuxing / 2)
    local level = pet:get_level()
    return human_level > (level - 5 - extra_take_level)
end

function human:test_call_up_pet(guid)
    local container = self:get_pet_bag_container()
    local pet = container:get_pet_by_guid(guid)
    if pet == nil then
        return define.OPERATE_RESULT.OR_ERROR
    end
    if pet:is_in_exchange() then
        return define.OPERATE_RESULT.OR_ERROR
    end
    if not self:can_use_skill_now() then
        return define.OPERATE_RESULT.OR_BUSY
    end
    if pet:get_hp() <= 0 then
        return define.OPERATE_RESULT.OR_NOT_ENOUGH_HP
    end
    --[[if not self:can_take(pet) then
        return define.OPERATE_RESULT.OR_NEED_HIGH_LEVEL
    end]]
    local config_info = configenginer:get_config("config_info")
    if pet:get_happiness() < config_info.Pet.PetCallUpHappiness then
        return define.OPERATE_RESULT.OR_NEED_HAPPINESS
    end
    if pet:get_life() <= 0 then
        return define.OPERATE_RESULT.OR_NEED_LIFE
    end
    return define.OPERATE_RESULT.OR_OK
end

function human:recall_pet()
    self.guid_of_call_up_pet = pet_guid.new()
    self:set_current_pet_guid(self.guid_of_call_up_pet)
    if self.pet then
        self:impact_clean_all_impact_when_pet_dead(self.pet:get_obj_id())
        self.pet:impact_clean_all_impact_when_pet_dead(self.pet:get_obj_id())
        self.pet:sendmsg_refresh_attrib()
    end
    self:release_pet()
    return define.OPERATE_RESULT.OR_OK
end

function human:set_current_pet_guid(guid)
    self.db:set_db_attrib({pet_guid = guid})
end

function human:get_current_pet_guid()
    return self:get_attrib("pet_guid") or define.INVAILD_ID
end

function human:is_my_spouse()

end

function human:create_pet()
    if self.guid_of_call_up_pet:is_null() then
        return define.OPERATE_RESULT.OR_ERROR
    end
    local container = self:get_pet_bag_container()
    local pet_item = container:get_pet_by_guid(self.guid_of_call_up_pet)
    if pet_item == nil then
        return define.OPERATE_RESULT.OR_ERROR
    end
    local scene = self:get_scene()
    if scene == nil then
        return define.OPERATE_RESULT.OR_ERROR
    end
    local world_pos = table.clone(self:get_world_pos())
    world_pos.x = world_pos.x - 1
    local pet = scene:create_pet(pet_item:get_obj_data(), self:get_obj_id(), world_pos)
    self.pet = pet
    return define.OPERATE_RESULT.OR_OK
end

function human:release_pet()
    if self.pet then
        petmanager:remove_pet(self.pet:get_obj_id())
        self.pet = nil
    end
end

function human:call_up_pet()
    local container = self:get_pet_bag_container()
    local pet = container:get_pet_by_guid(self.guid_of_call_up_pet)
    if pet:is_in_exchange() then
        return define.OPERATE_RESULT.OR_PETINEXCHANGE_CANNOT_GOFIGHT
    end
    self:release_pet()
    local result = self:create_pet()
    if result < 0 then
        return result
    end
    self:set_current_pet_guid(self.guid_of_call_up_pet)
    self:impact_on_call_up_pet_success()
    return define.OPERATE_RESULT.OR_OK
end

function human:test_pet_soul_melting(guid)
    local container = self:get_pet_bag_container()
    local pet = container:get_pet_by_guid(guid)
    if pet == nil then
        return define.OPERATE_RESULT.OR_ERROR
    end
    if pet:is_in_exchange() then
        return define.OPERATE_RESULT.OR_ERROR
    end
    if not self:can_use_skill_now() then
        return define.OPERATE_RESULT.OR_BUSY
    end
    return define.OPERATE_RESULT.OR_OK
end

function human:remelting_pet_soul()
    local soul_melting_pet = self:get_pet_bag_container():get_item_by_guid(self.guid_of_soul_melting_pet)
    if soul_melting_pet then
        self:impact_clean_when_remelting_pet_soul(soul_melting_pet)
    end
    self.guid_of_soul_melting_pet = pet_guid.new()
    self:set_current_soul_melting_pet_guid(self.guid_of_soul_melting_pet)
    self:item_flush()
    return define.OPERATE_RESULT.OR_OK
end

function human:impact_clean_when_remelting_pet_soul(soul_melting_pet)
    if soul_melting_pet then
        local soul = soul_melting_pet:get_equip_container():get_item(define.PET_EQUIP.PEQUIP_SOUL)
        if soul then
            local level = soul:get_pet_equip_data():get_pet_soul_level() + 1
            local base = soul:get_pet_soul_base()
            local skill = base.skill
            local pet_soul_skill = configenginer:get_config("pet_soul_skill")
            local skill_conf = pet_soul_skill[skill]
            for impact_id = 1, 2 do
                local desc = skill_conf.melting_impacts[impact_id].desc
                local values = skill_conf.melting_impacts[impact_id].values
                local iv = values[level]
                if desc ~= define.INVAILD_ID then
                    local ia = define.PET_SOUL_BASE_ATTR_2_IA[desc]
                    assert(ia, desc)
                    if ia == define.ITEM_ATTRIBUTE.IATTRIBUTE_QIONGQI_MELTING_IMPACT then
                        local real_impact_id = define.QIONGQI_IMPACT[level] or define.INVAILD_ID
                        local imp = self:impact_get_first_impact_of_specific_data_index(real_impact_id)
                        if imp then
                            self:on_impact_fade_out(imp)
                            self:remove_impact(imp)
                        end
                    end
                end
            end
        end
    end
end

function human:on_impact_get_combat_result(imp, combat_core, defencer)
    self:impact_on_impact_get_combat_result(imp, combat_core, defencer)
    self:talent_on_impact_get_combat_result(imp, combat_core, defencer)
end

function human:impact_on_impact_get_combat_result(imp, combat_core, defencer)
    local list = self:get_impact_list()
    for _, current in ipairs(list) do
        local logic = impactenginer:get_logic(current)
        if logic then
            logic:on_impact_get_combat_result(current, imp, combat_core, self, defencer)
        end
    end
end

function human:talent_on_impact_get_combat_result(imp, combat_core, defencer)
    local talent = self:get_talent()
    local talent_config = configenginer:get_config("sect_desc")
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local config = talent_config[study_talent.id]
            if config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_impact_get_combat_result(config, level, imp, combat_core, self, defencer)
            end
        end
    end
end

function human:talent_on_impact_fade_out(imp)
    local talent = self:get_talent()
    local talent_config = configenginer:get_config("sect_desc")
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local config = talent_config[study_talent.id]
            if config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_impact_fade_out(config, level, imp, self)
            end
        end
    end
end

function human:set_current_soul_melting_pet_guid(guid)
    self.db:set_db_attrib({soul_melting_pet_guid = guid})
end

function human:get_current_soul_melting_pet_guid()
    return self:get_attrib("soul_melting_pet_guid")
end

function human:set_guid_of_soul_melting_pet(guid)
    self.guid_of_soul_melting_pet = guid
end

function human:get_guid_of_soul_melting_pet()
    return self.guid_of_soul_melting_pet
end

function human:pet_soul_melting()
    local container = self:get_pet_bag_container()
    local pet = container:get_pet_by_guid(self.guid_of_soul_melting_pet)
    if pet == nil then
        return define.OPERATE_RESULT.OR_ERROR
    end
    if pet:is_in_exchange() then
        return define.OPERATE_RESULT.OR_ERROR
    end
    self.db:set_db_attrib({ soul_melting_pet_guid = self.guid_of_soul_melting_pet })
    self:item_flush()
    return define.OPERATE_RESULT.OR_OK
end

function human:baby_to_attack()
    if self.pet == nil then
        return
    end
    if not self.pet:is_alive() then
        return
    end
    local target_id = self:get_cur_target_id()
    self.pet:set_target_id(target_id)
    local pet_ai = self.pet:get_ai()
    pet_ai:baby_to_attack(pet_ai)
end

function human:on_register_to_scene()
    self:set_guid_of_call_up_pet(self:get_current_pet_guid())
    if not self.guid_of_call_up_pet:is_null() then
        local result = self:create_pet()
        if result < 0 then
            self:send_operate_result_msg(result)
        end
    end
    self:set_guid_of_soul_melting_pet(self:get_current_soul_melting_pet_guid())
    if not self.guid_of_soul_melting_pet:is_null() then
        self:pet_soul_melting()
    end
    if not self:is_alive() then
        self:get_ai():relive(false)
    end
end

function human:clean_up_pet()
    self.pet = nil
end

function human:free_pet_to_nature(logparam, guid)
    if guid:is_null() then
        return define.OPERATE_RESULT.OR_ERROR
    end
    if guid == self:get_current_pet_guid() then
        self:recall_pet()
    end
    self:remove_pet(logparam, guid)
    return define.OPERATE_RESULT.OR_OK
end

function human:remove_pet(logparam, guid)
    if self:get_current_pet_guid() == guid then
        self:recall_pet()
    end
    local container = self:get_pet_bag_container()
    local pet_list = container:get_item_data()
    for i = 0, container:get_size() - 1 do
        local pet = pet_list[i]
        if pet and pet:get_guid() == guid then
            container:erase_item(i)
            local msg = packet_def.GCRemovePet.new()
            msg.guid = guid
            self:get_scene():send2client(self, msg)
            return true
        end
    end
    return false
end

function human:set_temp_aq_skills(skills)
    self.temp_aq_skills = skills
end

function human:get_temp_aq_skills()
    return self.temp_aq_skills
end

function human:set_temp_wh_skills(skills)
    self.temp_wh_skills = skills
end

function human:get_temp_wh_skills()
    return self.temp_wh_skills
end

function human:set_temp_pet_soul_attr_data(bag_index, attr)
    self.temp_pet_soul_attr_data = { bag_index = bag_index, attr = attr}
end

function human:get_temp_pet_soul_attr_data()
    return self.temp_pet_soul_attr_data
end

function human:set_temp_super_attrs(super_attrs)
    self.temp_super_attrs = super_attrs
end

function human:get_temp_super_attrs()
    return self.temp_super_attrs
end

function human:set_temp_equip_attrs(item_guid, equip_attrs)
    self.temp_equip_attrs = { item_guid = item_guid, equip_attrs = equip_attrs }
end

function human:get_temp_equip_attrs()
    return self.temp_equip_attrs
end

function human:clear_temp_equip_attrs()
    self.temp_equip_attrs = nil
end

function human:get_pk_mode()
    return self.db:get_db_attrib("pk_mode")
end

function human:change_pk_mode(mode)
	local limit_pk_mode = define.LIMIT_PK_MODE_ON_SCENE[self:get_scene_id()]
	if limit_pk_mode then
        self.db:set_db_attrib_nil("want_change_pk_mode")
        self.db:set_db_attrib({ pk_mode = limit_pk_mode.pk_id, change_pk_mode_delay = nil})
		local msg = string.format("该场景只允许%s模式。",limit_pk_mode.pk_name)
		self:notify_tips(msg)
	else
		local old_mode = self.db:get_db_attrib("pk_mode")
		if (old_mode == define.PK_MODE.TEAM or old_mode == define.PK_MODE.RAID or old_mode == define.PK_MODE.PERSONAL or old_mode == define.PK_MODE.BANG_HUI or old_mode == define.PK_MODE.GOD_AND_EVIL)
			and (mode == define.PK_MODE.PEACE)  then
			self.db:set_db_attrib({ want_change_pk_mode = mode, change_pk_mode_delay = define.PK_MODE_CHANGE_DELAY})
			self:send_operate_result_msg(define.OPERATE_RESULT.OR_PVP_MODE_SWITCH_DELAY)
		else
			self.db:set_db_attrib_nil("want_change_pk_mode")
			self.db:set_db_attrib({ pk_mode = mode, change_pk_mode_delay = nil})
		end
	end
end

function human:check_pk_mode_can_change(delay)
    local want_change_pk_mode = self.db:get_db_attrib("want_change_pk_mode")
    if want_change_pk_mode then
        local change_pk_mode_delay = self.db:get_db_attrib("change_pk_mode_delay")
        change_pk_mode_delay = change_pk_mode_delay - delay
        if change_pk_mode_delay < 0 then
            self.db:set_db_attrib_nil("want_change_pk_mode")
            self.db:set_db_attrib({ pk_mode = want_change_pk_mode, change_pk_mode_delay = 0})
        else
            self.db:set_db_attrib({ change_pk_mode_delay = change_pk_mode_delay })
        end
    end
end
function human:set_huanhun_qk(qk, index)
    assert(index >= 0, index <= 6)
    if qk == 0 then
        if self:get_attrib("huanhun_kun_index") == index then
            self.db:set_db_attrib({ huanhun_kun_index = 0 })
        end
        self.db:set_db_attrib({ huanhun_qian_index = index })
    elseif qk == 1 then
        if self:get_attrib("huanhun_qian_index") == index then
            self.db:set_db_attrib({ huanhun_qian_index = 0 })
        end
        self.db:set_db_attrib({ huanhun_kun_index = index })
    else
        assert(false)
    end
    local wuhun = self:get_equip_container():get_item(define.HUMAN_EQUIP.HEQUIP_WUHUN)
    if wuhun then
        local msg = packet_def.GCCharEquipment.new()
        msg.m_objID = self:get_obj_id()
        msg.flag = 0
        local item_index = wuhun:get_index()
        local visual = self:get_wuhun_visual()
		msg:set_wuhun(item_index,visual)
        self.scene:broadcast(self, msg, true)
        self:item_flush()
    end
end
function human:update_wuhun_visual()
    local wuhun = self:get_equip_container():get_item(define.HUMAN_EQUIP.HEQUIP_WUHUN)
    if wuhun then
        local msg = packet_def.GCCharEquipment.new()
        msg.m_objID = self:get_obj_id()
        msg.flag = 0
        local item_index = wuhun:get_index()
        local visual = self:get_wuhun_visual()
		msg:set_wuhun(item_index,visual)
        self.scene:broadcast(self, msg, true)
    end
end
function human:get_wuhun_visual()
	-- local wh_visual = define.INVAILD_ID
	local wh_id = -1
	local wh_visual = 0
    local wuhun = self:get_equip_container():get_item(define.HUMAN_EQUIP.HEQUIP_WUHUN)
    if wuhun then
		wh_id = wuhun:get_index()
		local index = 0
		local wg_key = "wg_atts"
		if self.db:get_attrib("wuhun_yy_flag") == 1 then
			index = self.db:get_attrib("huanhun_kun_index") or 0
			if index == 0 then
				index = self.db:get_attrib("huanhun_qian_index") or 0
			else
				wg_key = "wg_defs"
			end
		else
			index = self.db:get_attrib("huanhun_qian_index") or 0
			if index == 0 then
				index = self.db:get_attrib("huanhun_kun_index") or 0
				wg_key = "wg_defs"
			end
		end
        if index > 0 then
			local wg_lv = 1
			local str_index = tostring(index)
			if self.huanhun[str_index] then
				if self.huanhun[str_index].level >= 8 then
					wg_lv = 3
				elseif self.huanhun[str_index].level >= 5 then
					wg_lv = 2
				end
			end
            local wuhun_wg = configenginer:get_config("wuhun_wg")
            wuhun_wg = wuhun_wg[index]
			if wuhun_wg then
				wh_visual = wuhun_wg[wg_key][wg_lv]
            end
        end
		if not wh_visual or wh_visual == 0 then
			local eq_data = wuhun:get_equip_data()
			if eq_data:get_wh_hecheng_level() >= 5 then
				local wuhun_wg = configenginer:get_config("kfs_base")
				wuhun_wg = wuhun_wg[wh_id]
				if wuhun_wg then
					wh_visual = wuhun_wg.max_visual
				else
					wh_visual = eq_data:get_visual()
				end
			else
				wh_visual = eq_data:get_visual()
			end
		end
    end
	self:set_game_flag_keys_visual(define.HUMAN_EQUIP.HEQUIP_WUHUN,
	{
	[define.WG_KEY_A] = wh_id,
	[define.WG_KEY_B] = -1,
	[define.WG_KEY_C] = wh_visual
	})
    return wh_visual,wh_id
end

function human:active_wuhun_wg(id)
    id = tostring(id)
    assert(self.huanhun[id] == nil, id)
    self.huanhun[id] = { level = 1, grade = 0, today_count = 0}
    self:item_flush()
end

function human:active_rmb_chat_info(id, date)
    self.rmb_chat_face_info.id = id
    self.rmb_chat_face_info.dates[1] = date
    self:send_rmb_chat_face_info()
end

function human:get_mission_data_by_script_id(id)
    return self.mission_data.mission_datas[id + 1] or 0
end
--0 <= id <= 1279
function human:get_mission_flag_index_and_shift(id)
    local shift
    local script_id
    if id < 0x140 then
        local index
        if id >= 0x28 then
            index = (id - 40) / 0x1C
        else 
            index = id >> 2
        end
        local MF_1 = define.MF[1]
        index = index + 1
        script_id = MF_1[index]
        if id >= 0x28 then
            shift = (id - 40) % 0x1C + 4
        else
            shift = id & 3
        end
    else
        local index
        local MF_2 = define.MF[2]
        shift = (id - 64) & 0x1F
        index = (id - 320) >> 5
        index = index + 1
        script_id = MF_2[index]
    end
    return script_id, shift
end

function human:get_mission_flag_by_script_id(id)
    local script_id, shift = self:get_mission_flag_index_and_shift(id)
    local val = self:get_mission_data_by_script_id(script_id)
    return al & (1 << shift)
end

function human:set_mission_flag_by_script_id(id, val)
    local script_id, shift = self:get_mission_flag_index_and_shift(id)
    local old = self:get_mission_data_by_script_id(script_id)
    if val == 1 then
        old = old | (1 << shift)
    else
        old = old & (~(1 << shift))
    end
    self:set_mission_data_by_script_id(script_id, old)
end

function human:get_mission_data_ex_by_script_id(id)
    local key = tostring(id + 1)
    return self.mission_data.mission_datas_ex[key] or 0 
end

function human:set_mission_data_ex_by_script_id(id, val)
    local key = tostring(id + 1)
    self.mission_data.mission_datas_ex[key] = val
end

function human:set_mission_data_by_script_id(id, val)
	if not id then
		skynet.logi("id = ", id, "stack =", debug.traceback())
		return
	end
    self.mission_data.mission_datas[id + 1] = val
    local msg = packet_def.GCMissionModify.new()
    msg.m_nFlag = 1
    msg.mission_id = id
    msg.mission_index = val
    self:get_scene():send2client(self, msg)
end

function human:send_zdzd_config()
    for i = 1, 7 do
        local mission_id = define.ZDZD_MISSION_ID[i]
        local val = self:get_mission_data_by_script_id(mission_id)
        self:set_mission_data_by_script_id(mission_id, val)
    end
end

function human:mission_abandon(index)
    for i, mission in ipairs(self.mission_data.char_missions) do
        if mission.index == index then
            table.remove(self.mission_data.char_missions, i)
            local msg = packet_def.GCMissionRemove.new()
            msg.id = mission.id
            self:get_scene():send2client(self, msg)
            return
        end
    end
end

function human:save_restore_scene_and_pos(sn)
    local sceneid = self:get_scene_id()
    local world_pos = self:get_world_pos()
    if sceneid < 10000 then
        self.db:set_db_attrib({ restore_scene_and_pos = { sceneid = sceneid, world_pos = world_pos, sn = sn} })
    end
end

function human:change_restore_scene_and_pos(sceneid, world_pos)
    self.db:set_db_attrib({ restore_scene_and_pos = { sceneid = sceneid, world_pos = world_pos } })
    skynet.send(self:get_agent(), "lua", "change_restore_scene_and_pos", sceneid, world_pos)
end

function human:is_have_mission(mission_id)
    return self:get_mission_index(mission_id) ~= define.INVAILD_ID
end

function human:get_mission_index(mission_id)
    for i, mission in ipairs(self.mission_data.char_missions) do
        if mission.id == mission_id then
            return i
        end
    end
    return define.INVAILD_ID
end

function human:get_mission_by_id(mission_id)
    for i, mission in ipairs(self.mission_data.char_missions) do
        if mission.id == mission_id then
            return mission
        end
    end
end

function human:get_mission_param(mission_index, index)
	assert(index,index)
    index = index + 1
    local mission = self.mission_data.char_missions[mission_index]
	assert(mission,mission_index)
    return mission.params[index]
end

function human:set_mission_by_index(mission_index, index, value)
    assert(value)
    index = index + 1
    value = math.floor(value)
    local mission = self.mission_data.char_missions[mission_index]
    mission.params[index] = value
    local msg = packet_def.GCMissionModify.new()
    msg.m_nFlag = 0
    msg.m_aMissionData = mission
    self:get_scene():send2client(self, msg)
end

function human:del_mission(mission_id)
    local index = self:get_mission_index(mission_id)
    if index ~= define.INVAILD_ID then
        local mission = self.mission_data.char_missions[index]
        table.remove(self.mission_data.char_missions, index)
        local msg = packet_def.GCMissionRemove.new()
        msg.id = mission.id
        self:get_scene():send2client(self, msg)
    end
    return true
end

function human:del_all_mission()
    for i = #self.mission_data.char_missions, 1, -1 do
        local mission = self.mission_data.char_missions[i]
        local mission_id = mission.id
        self:del_mission(mission_id)
    end
end

function human:add_mission(id, script_id, killObjEvent, enterAreaEvent, itemChangeEvent)
    if #self.mission_data.char_missions >= define.MAX_CHAR_MISSION_NUM then
        return false, define.OPERATE_RESULT.OR_MISSION_LIST_FULL
    end
    local index = self:get_mission_index(id)
    if index ~= define.INVAILD_ID then
        return false, define.OPERATE_RESULT.OR_MISSION_HAVE
    end
    local char_mission = { id = id, index = script_id, yFlag = 0, params = {0, 0, 0, 0, 0, 0, 0, 0} }
    if killObjEvent == 1 then
        char_mission.yFlag = char_mission.yFlag | 0x1 << 0
    end
    if enterAreaEvent == 1 then
        char_mission.yFlag = char_mission.yFlag | 0x1 << 1
    end
    if itemChangeEvent == 1 then
        char_mission.yFlag = char_mission.yFlag | 0x1 << 2
    end
    table.insert(self.mission_data.char_missions, char_mission)
    index = #self.mission_data.char_missions
    self:on_add_mission(index)
    return true
end

function human:reset_mission_event()

end

function human:get_script_id_by_mission_id(mission_id)
    local char_missions = self.mission_data.char_missions or {}
    for _, cm in ipairs(char_missions) do
        if cm.id == mission_id then
            return cm.index
        end
    end
end

function human:on_add_mission(index)
    local msg = packet_def.GCMissionAdd.new()
    local mission = self.mission_data.char_missions[index]
    msg.id = mission.id
    msg.index = mission.index
    msg.yFlag = mission.yFlag
    msg.params = mission.params
    self:get_scene():send2client(self, msg)
end

function human:set_mission_event(mission_id, event)
    local index = self:get_mission_index(mission_id)
    if index == define.INVAILD_ID then
        return define.OPERATE_RESULT.OR_ERROR
    end
    local mission = self.mission_data.char_missions[index]
    if mission == nil then
        return define.OPERATE_RESULT.OR_ERROR
    end
    if event == define.TASK_EVENT.TASK_EVENT_KILLOBJ then
        mission.yFlag = mission.yFlag | 0x1 << 0
    elseif event == define.TASK_EVENT.TASK_EVENT_ENTERAREA then
        mission.yFlag = mission.yFlag | 0x1 << 1
    elseif event == define.TASK_EVENT.TASK_EVENT_ITEMCHANGED then
        mission.yFlag = mission.yFlag | 0x1 << 2
    elseif event == define.TASK_EVENT.TASK_EVENT_PETCHANGED then
        mission.yFlag = mission.yFlag | 0x1 << 3
    elseif event == define.TASK_EVENT.TASK_EVENT_LOCKTARGET then
        mission.yFlag = mission.yFlag | 0x1 << 4
    end
end

function human:is_mission_full()
    return #self.mission_data.char_missions >= define.MAX_CHAR_MISSION_NUM
end

function human:is_mission_have_done(id_mission)
    local index = (id_mission >> 5)  + 1
    assert(index <= define.MAX_CHAR_MISSION_FLAG_LEN, index)
    if index <= define.MAX_CHAR_MISSION_FLAG_LEN then
        local flag = self.mission_data.mission_have_done_flags[index] or 0
        return ( flag & (0x00000001 << (id_mission & 0x0000001F))) ~= 0
    else
        return false
    end
end

function human:set_mission_have_done(id_mission, done)
    local index = (id_mission >> 5)  + 1
    assert(index <= define.MAX_CHAR_MISSION_FLAG_LEN, index)
    if index <= define.MAX_CHAR_MISSION_FLAG_LEN then
        if done then
            self.mission_data.mission_have_done_flags[index] = (self.mission_data.mission_have_done_flags[index] or 0) | (0x00000001 << (id_mission & 0x0000001F))
        else
            self.mission_data.mission_have_done_flags[index] = (self.mission_data.mission_have_done_flags[index] or 0) & (0x00000000 << (id_mission & 0x0000001F))
        end
    end
    local msg = packet_def.GCMissionHaveDoneFlag.new()
    msg.mission_id = id_mission
    msg.flag = done and 1 or 0
    self:get_scene():send2client(self, msg)
end

function human:get_mission_have_done(id_mission)
    local index = (id_mission >> 5)  + 1
    assert(index <= define.MAX_CHAR_MISSION_FLAG_LEN, index)
    if index <= define.MAX_CHAR_MISSION_FLAG_LEN then
        local value = self.mission_data.mission_have_done_flags[index] or 0
        local bit = (0x00000001 << (id_mission & 0x0000001F))
        return (value & bit) == bit
    end
    return false
end

function human:get_mission_count()
    return #self.mission_data.char_missions
end

function human:on_kill_object(obj)
    assert(self.scene:get_obj_by_id(obj:get_obj_id()), obj:get_obj_id())
    if obj:get_obj_type() ~= "monster" then
        return
    end
    for _, mission in ipairs(self.mission_data.char_missions) do
        if mission.yFlag & 0x1 == 0x1 then
            local toggle = obj.misions_toggle[mission.id] == nil
            if toggle then
                obj.misions_toggle[mission.id] = true
                local script = mission.index
                self:get_scene():get_script_engienr():call(script, "OnKillObject", self:get_obj_id(), obj:get_model(), obj:get_obj_id())
            end
        end
    end
end

function human:on_pick_up_item(item, bag_index)
    for _, mission in ipairs(self.mission_data.char_missions) do
        local script = mission.index
        self:get_scene():get_script_engienr():call(script, "PickupItem", self:get_obj_id(), item:get_index(), bag_index)
    end
end

function human:on_add_pet(pet)
    for _, mission in ipairs(self.mission_data.char_missions) do
        if mission.yFlag & (0x1 << 3) == (0x1 << 3) then
            local script = mission.index
            self:get_scene():get_script_engienr():call(script, "OnPetChanged", self:get_obj_id(), pet:get_data_index())
        end
    end
end

function human:on_lock_target(target_id)
    --[[
    local obj_tar = self:get_scene():get_obj_by_id(target_id)
    if obj_tar and obj_tar:get_obj_type() ~= "human" then
        if target_id ~= define.INVAILD_ID then
            for _, mission in ipairs(self.mission_data.char_missions) do
                if mission.yFlag & (0x1 << 4) == (0x1 << 4) then
                    local script = mission.index
                    self:get_scene():get_script_engienr():call(script, "OnLockedTarget", self:get_obj_id(), target_id)
                end
            end
        end
    end]]
end

function human:get_copy_scene_sn()
    local restore = self.db:get_attrib("restore_scene_and_pos") or {}
    return restore.sn
end

function human:reset_mission_cache_data()
    self.mission_cache_data = {}
end

function human:set_mission_cache_data(id, val)
    self.mission_cache_data[id] = val
end

function human:get_mission_cache_data(id)
    return self.mission_cache_data[id]
end

function human:capture_pet(logparam, pet)
    if pet:get_owner() then
        self:send_operate_result_msg(define.OPERATE_RESULT.OR_INVALID_TARGET)
        return false
    end
    local result = petmanager:create_guid_of_pet(self, pet)
    if not result then
        return false
    end
    result = self:add_pet(pet:get_detail())
    if not result then
        return false
    end
    return true
end

function human:get_shop_guids()
    return self.shop_guids
end

function human:set_shop_guid(index, shg)
    self.shop_guids = self.shop_guids or {}
    local sg = shop_guid.new()
    sg:set(shg)
    self.shop_guids[index] = sg
end

function human:set_char_shop_guids(sgs)
    for i = 1, 2 do
        local sg = sgs[i]
        self:set_shop_guid(i, sg or shop_guid.new())
    end
end

function human:get_shop_guid_by_index(index)
    return self.shop_guids[index]
end

function human:check_have_id_title(id)
    for _, title in ipairs(self.id_titles) do
        if title.id == id then
            return true
        end
    end
    return false
end

function human:get_id_titles()
    return self.id_titles
end

function human:del_conflict_titles(new_id)
    local char_title_new = configenginer:get_config("char_title_new")
    local new_title = char_title_new[new_id]
    for i = #self.id_titles, 1, -1 do
        local id = self.id_titles[i].id
        local title = char_title_new[id]
        if title then
            if new_title["Type"] == title["Type"] then
                table.remove(self.id_titles, i)
            end
        end
    end
end

function human:add_id_title(id)
    self:del_conflict_titles(id)
    table.insert(self.id_titles, { id = id })
    self:set_cur_title_by_id_title(id)
end

function human:have_id_title(id)
    for i = #self.id_titles, 1, -1 do
        if self.id_titles[i].id == id then
            return true
        end
    end
    return false
end

function human:set_title(id, titlestr)
    for _, title in ipairs(self.titles) do
        if title.id == id then
            title.str = titlestr
            self:set_current_title(title)
            return
        end
    end
    if id ~= define.INVAILD_ID then
        local title = { id = id, str = titlestr}
        table.insert(self.titles, title)
    end
    self:set_current_title(title)
end

function human:set_current_title(title)
    self.db:set_db_attrib({ title = title})
end

function human:get_current_title()
    return self.db:get_db_attrib("title")
end

function human:get_title_by_id(id)
    for _, title in ipairs(self.titles) do
        if title.id == id then
            return title
        end
    end
end

function human:set_cur_title_by_id(id)
    local title = self:get_title_by_id(id)
    if title then
        self:set_current_title(title)
    end
end

function human:set_cur_title_by_id_title(id)
    if self:check_have_id_title(id) then
        local char_title_new = configenginer:get_config("char_title_new")
        char_title_new = char_title_new[id]
        local title = { str = string.format("#%d", id), new_title_id = id, id = char_title_new["Type"]}
        self:set_current_title(title)
    end
end

function human:get_cur_title()
    local title = self.db:get_db_attrib("title")
    return title
end

function human:update_titles_to_client()
    local msg = packet_def.GCCharAllTitles.new()
    msg.m_objID = self:get_obj_id()
    msg.m_nTitleId = #self.id_titles
    msg.m_TitleIdList = self.id_titles
    msg.m_nTitleStr = #self.titles
    msg.m_TitleStrList = self.titles
    self:get_scene():send2client(self, msg)
end

function human:up_xinfa_level(level)
    local xinfa_list = self:get_xinfa_list()
    for _, xinfa in ipairs(xinfa_list) do
        self:study_xinfa(xinfa.m_nXinFaID, level)
        local msg = packet_def.GCStudyXinfa.new()
        msg.spare_exp = self:get_attrib("exp")
        msg.spare_money = self:get_attrib("money")
        msg.now_level = level
        msg.xinfa = xinfa.m_nXinFaID
        self:get_scene():send2client(self, msg)
    end
end

function human:get_min_xinfa_level()
    local xinfa_list = self:get_xinfa_list()
    local menpai = self:get_menpai()
    xinfa_list = table.clone(xinfa_list)
    for i = #xinfa_list, 1, -1 do
        local xinfa = xinfa_list[i]
        if xinfa.m_nXinFaID == define.MENPAI_7_XINFA[menpai] or xinfa.m_nXinFaID == define.MENPAI_8_XINFA[menpai] then
            table.remove(xinfa_list, i)
        end
    end
    table.sort(xinfa_list, function(x1, x2) return x1.m_nXinFaLevel < x2.m_nXinFaLevel end )
    if #xinfa_list > 0 then
        return xinfa_list[1].m_nXinFaLevel
    end
    return 0
end

function human:fix_xiulian_list()
    if self.xiulian_list == nil then
        self.xiulian_list = {}
        for i = 1, 11 do
            self.xiulian_list[i] = { level = 0, upper_limit = 10}
        end
    end
end

function human:get_xiulian_list()
    return self.xiulian_list
end

function human:get_xiulian_level(index)
    local xiulian = self.xiulian_list[index]
    assert(xiulian, index)
    return xiulian.level
end

function human:get_max_level_xiulian_level()
    local max_level
    for _, xiulian in pairs(self.xiulian_list) do
        if max_level == nil or max_level < xiulian.level then
            max_level = xiulian.level
        end
    end
    return max_level // 10 + 1
end

function human:get_xiulian_upper_limit(index)
    local xiulian = self.xiulian_list[index]
    assert(xiulian, index)
    return xiulian.upper_limit
end

function human:xiulian_can_level_up(index)
    local level = self:get_xiulian_level(index)
    local upper_limit = self:get_xiulian_upper_limit(index)
    return level < upper_limit
end

function human:xiulian_level_up(index)
    local xiulian = self.xiulian_list[index]
    assert(xiulian, index)
    xiulian.level = xiulian.level + 1
    self:send_xiulian_list()
    self:item_flush()
end

function human:xiulian_upper_limit_up(index, count)
    local xiulian = self.xiulian_list[index]
    assert(xiulian, index)
    xiulian.upper_limit = xiulian.upper_limit + count
    self:send_xiulian_list()
end

function human:send_xiulian_list()
    local ret = packet_def.GCDetailXiulianList.new()
    ret.unknow_2 = 54
    ret.xiulian = self:get_xiulian_list()
    self:get_scene():send2client(self, ret)
end

function human:reset_talent()
    local r, err = pcall(self.talent_on_remove, self)
    if not r then
        skynet.loge("talent_on_remove error =", err)
    end
    local talent = self:get_talent()
    talent.type = define.INVAILD_ID
    talent.study = {}
    for i = 1, 21 do
        talent.study[i] = { id = define.INVAILD_ID, level = 0 }
    end
    talent.study[1].id = define.INVAILD_ID
    talent.study[1].level = 1
    talent.understand_point = talent.understand_point + (talent.cost_point or 0)
    talent.cost_point = 0
	for i = define.MD_WDDAO_FOUR_1,define.MD_WDDAO_FOUR_4 do
		self:set_mission_data_by_script_id(i,0)
	end
    self:send_talent(0)
end

function human:send_talent(show_type)
    show_type = show_type or 2
    local talent = self:get_talent()
    local msg = packet_def.GCSectDetail.new()
    msg.list = talent.study
    msg.understand_point = talent.understand_point
    msg.show_type = show_type
    msg.talent_type = talent.type
    self:get_scene():send2client(self, msg)
end

function human:check_can_study_sect(talent_id)
    local sect_info = configenginer:get_config("sect_info")
    sect_info = sect_info[talent_id]
	if not sect_info then
		self:notify_tips("武道技能不存在")
		return false
	end
    local study = self:find_study_talent(talent_id)
    study = study or { id = talent_id, level = 0 }
    if study.level == sect_info["最大等级"] then
        self:notify_tips("已点满")
        return false
    end
    local cost_point = sect_info["消耗"][study.level + 1]
    local talent = self:get_talent()
    if talent.understand_point < cost_point then
        self:notify_tips("武道领悟点不足")
        return false
    end
    if not self:check_can_study_pre_talent(talent_id) then
        self:notify_tips("需先学习前置武道")
        return false
    end
    if not self:check_talent_level(talent_id) then
        self:notify_tips("武道修行等级不足")
        return false
    end
    if not self:check_talent_conflict(talent_id) then
        self:notify_tips("不可同时修行")
        return false
    end
    return true
end

function human:check_talent_conflict(talent_id)
    local talent = self:get_talent()
    local sect_info = configenginer:get_config("sect_info")
    local cur_sect_info = sect_info[talent_id]
    local cur_layer = cur_sect_info["Layer"]
    for i, study in ipairs(talent.study) do
        local sect = sect_info[study.id]
        if study.id ~= talent_id and study.id ~= define.INVAILD_ID then
            local study_layer = sect["Layer"]
            if study_layer == cur_layer then
                return false
            end
        end
    end
    return true
end

function human:check_talent_level(talent_id)
    local talent = self:get_talent()
    local sect_info = configenginer:get_config("sect_info")
    sect_info = sect_info[talent_id]
    local level_require = sect_info["LevelRequire"]
    local cur_level = self:get_talent_level()
    return cur_level >= level_require
end

function human:check_can_study_pre_talent(talent_id)
    local talent = self:get_talent()
    local sect_info = configenginer:get_config("sect_info")
    sect_info = sect_info[talent_id]
    local pre_talent_id = sect_info["PreTalent"]
    local pre_talent_level = sect_info["PreTalentLevel"]
    local study = self:find_study_talent(pre_talent_id)
    study = study or { id = talent_id, level = 0 }
    if study.level < pre_talent_level then
        return false
    end
    return true
end

function human:study_sect(talent_id)
    if not self:check_can_study_sect(talent_id) then
        return
    end
    local talent = self:get_talent()
    local study = self:get_study_talent(talent_id)
    local sect_info = configenginer:get_config("sect_info")
    sect_info = sect_info[talent_id]
    local cost_point = sect_info["消耗"][study.level + 1]
    talent.understand_point = talent.understand_point - cost_point
    talent.cost_point = (talent.cost_point or 0) + cost_point
    study.level = study.level + 1
	
	if sect_info.Layer > 13 then
		local md_id = sect_info.Layer - 14 + define.MD_WDDAO_FOUR_1
		self:set_mission_data_by_script_id(md_id,talent_id * 10 + study.level)
	end
    self:send_talent(0)
	local selfId = self:get_obj_id()
	self:show_buff_effect(selfId,selfId,-1,self:get_logic_count(),49)
    -- local impactenginer = self:get_scene():get_impact_enginer()
    -- impactenginer:send_impact_to_unit(self, 49, self, 0, false, 0)
    -- local r, err = pcall(self.talent_study_sect, self, talent_id)
    -- if not r then
        -- skynet.loge("talent_study_sect error =", err)
    -- end
end

function human:get_study_talent(talent_id)
    local talent = self:get_talent()
    for _, study in ipairs(talent.study) do
        if study.id == talent_id then
            return study
        elseif study.id == define.INVAILD_ID then
            study.id = talent_id
            return study
        end
    end
end

function human:find_study_talent(talent_id)
    local talent = self:get_talent()
    for _, study in ipairs(talent.study) do
        if study.id == talent_id then
            return study
        end
    end
end

function human:get_talent_level()
    local level = 0
    local talent = self:get_talent()
    for i, study in ipairs(talent.study) do
        if i ~= 1 then
            level = level + study.level
        end
    end
    return level
end

function human:get_talent_level_by_id(talent_id)
    local talent = self:get_talent()
    for _, study in ipairs(talent.study) do
        if study.id == talent_id then
            return study.level
        end
    end
    return 0
end

function human:get_gong_li()
    local gongli = self.db:get_db_attrib("gongli")
    if gongli == nil then
        gongli = 100
        self:set_gong_li(gongli)
    end
    return gongli
end

function human:set_gong_li(gongli)
    self.db:set_db_attrib({ gongli = gongli})
end

function human:cost_gong_li(count)
    local gongli = self:get_gong_li()
    gongli = gongli - count
    gongli = gongli < 0 and 0 or gongli
    self:set_gong_li(gongli)
end

function human:on_team_id_changed()
    self:update_character_view()
end

function human:on_raid_id_changed()
    self:update_character_view()
end

function human:on_detect_level_changed()
    self:update_character_view()
end

function human:get_sweep_count(index)
    return self.dungeonsweep.sweep_counts[tostring(index)] or 0
end

function human:get_sweep_counts()
    return self.dungeonsweep.sweep_counts
end

function human:add_sweep_count(index, count)
    local sweep_count = self:get_sweep_count(index)
    self.dungeonsweep.sweep_counts[tostring(index)] = sweep_count + count
end

function human:cost_sweep_count(index, count)
    local sweep_count = self:get_sweep_count(index)
    self.dungeonsweep.sweep_counts[tostring(index)] = sweep_count - count
end

function human:set_sweep_point(index, count)
    count = count < 0 and 0 or count
    local sweep_count = self:get_sweep_count(index)
    self.dungeonsweep.sweep_counts[tostring(index)] = count
end

function human:set_sec_kill_data(data)
    self.dungeonsweep.sec_kill_data = data
    self:send_sec_kill_data()
end

function human:send_sec_kill_data()
    local sec_kill_data = self.dungeonsweep.sec_kill_data
    local msg = packet_def.GCRetSecKillData.new()
    msg.fuben_index = sec_kill_data.fuben_index
    msg.boss_id = sec_kill_data.boss_id
    msg.have_next = sec_kill_data.have_next
    msg.item_list = sec_kill_data.item_list
    self:get_scene():send2client(self, msg)
end

function human:get_sec_kill_item_by_index(index)
    local item_list = self.dungeonsweep.sec_kill_data.item_list or {}
    for _, item in ipairs(item_list) do
        if item.index == index then
            return item
        end
    end
end

function human:get_sec_kill_item_count()
    local item_list = self.dungeonsweep.sec_kill_data.item_list or {}
    return #item_list
end

function human:get_sec_kill_item_by_i(i)
    local item_list = self.dungeonsweep.sec_kill_data.item_list or {}
    return item_list[i]
end

function human:remove_sec_kill_item(index, is_discard)
    local item_list = self.dungeonsweep.sec_kill_data.item_list or {}
    for i, item in ipairs(item_list) do
        if item.index == index then
            table.remove(item_list, i)
        end
    end
    local msg = packet_def.GCSecKillRemoveItem.new()
    msg.is_discard = is_discard
    msg.index = index
    self:get_scene():send2client(self, msg)
end

function human:remove_all_sec_kill_item()
    self.dungeonsweep.sec_kill_data.item_list = {}
end

function human:get_campaign_count(index)
    return self.dungeonsweep.campaign_counts[tostring(index)] or 0
end

function human:get_campaign_counts()
    return self.dungeonsweep.campaign_counts
end

function human:set_campaign_count(index, count)
    self.dungeonsweep.campaign_counts[tostring(index)] = count
    self:send_campaign_count()
end

function human:reset_campaign_count()
    self.dungeonsweep.campaign_counts = {}
end

function human:get_pk_value()
    return self.db:get_db_attrib("pk_value") or 0
end

function human:set_pk_value(value)
    value = value > define.INT32_MAX and define.INT32_MAX or value
    self.db:set_db_attrib({pk_value = value})
end

function human:send_campaign_count()
    local msg = packet_def.GCRetCampaignCount.new()
    msg.list_1 = self:get_campaign_counts()
    msg.list_2 = {}
    msg.list_3 = {}
    msg.unknow_1 = 3
    self:get_scene():send2client(self, msg)
end

function human:send_week_active()
    local msg = packet_def.GCZhouHuoYueInfo.new()
    msg.can_get = self.week_active.can_get
    msg.getd = self.week_active.getd
    msg.day_get = self.week_active.day_get
    msg.week_get = self.week_active.week_get
    msg.get_award_index = self.week_active.get_award_index
    msg.level = self:get_level()
    msg.unknow_4 = 0
    self:get_scene():send2client(self, msg)
end

function human:get_week_active()
    return self.week_active
end

function human:get_week_active_day()
    return self.week_active.day_get
end

function human:send_cool_down_time()
    local cool_down_times = self.cool_down_times or {}
    local cool_down_times_array = {}
	local index
    for id, time in pairs(cool_down_times) do
		index = tonumber(id)
		if index < define.OTHER_SKILL_OR_STATUS_COOLDOWN then
			table.insert(cool_down_times_array, { m_nID = index, m_nCooldown = time, m_nCooldownElapsed = 0})
		end
	end
	if #cool_down_times_array > 0 then
		local msg = packet_def.GCCooldownUpdate.new()
		msg.m_nNumCooldown = #cool_down_times_array
		msg.m_aCooldowns = cool_down_times_array
		self:get_scene():send2client(self, msg)
	end
end

function human:challenge_refresh_skill_cool_down()
    self.challenge_store_skill_cool_down = table.clone(self.cool_down_times)
    local cool_down_times_array = {}
    self.cool_down_times = {}
	local index
    for id, time in pairs(self.challenge_store_skill_cool_down) do
		index = tonumber(id)
		if index < define.OTHER_SKILL_OR_STATUS_COOLDOWN then
			if time > 0 then
				table.insert(cool_down_times_array, { m_nID = index, m_nCooldown = 0, m_nCooldownElapsed = 0})
			end
		end
    end
	if #cool_down_times_array > 0 then
		local msg = packet_def.GCCooldownUpdate.new()
		msg.m_nNumCooldown = #cool_down_times_array
		msg.m_aCooldowns = cool_down_times_array
		self:get_scene():send2client(self, msg)
	end
end

function human:challenge_restore_skill_cool_down()
    if self.challenge_store_skill_cool_down then
        local cool_down_times_array = {}
		local index
        for id, time in pairs(self.cool_down_times) do
            if time > 0 then
                if self.challenge_store_skill_cool_down[id] == nil then
					index = tonumber(id)
					if index < define.OTHER_SKILL_OR_STATUS_COOLDOWN then
						table.insert(cool_down_times_array, { m_nID = index, m_nCooldown = 0, m_nCooldownElapsed = 0})
                    end
					self.cool_down_times[id] = 0
                end
            end
        end
        for id, time in pairs(self.challenge_store_skill_cool_down) do
            if time > 0 then
				index = tonumber(id)
				if index < define.OTHER_SKILL_OR_STATUS_COOLDOWN then
					table.insert(cool_down_times_array, { m_nID = index, m_nCooldown = time, m_nCooldownElapsed = 0})
                end
				self.cool_down_times[id] = time
            end
        end
		if #cool_down_times_array > 0 then
			local msg = packet_def.GCCooldownUpdate.new()
			msg.m_nNumCooldown = #cool_down_times_array
			msg.m_aCooldowns = cool_down_times_array
			self:get_scene():send2client(self, msg)
			self.challenge_store_skill_cool_down = nil
		end
    end
end

function human:talent_on_hit_target(reciver, skill_id)
	local talent_config = configenginer:get_config("sect_desc")
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talents = talent_config[study_talent.id]
            if talents then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_hit_target(talents, level, self, reciver, skill_id)
            end
        end
    end
end

function human:talent_on_damage_target(target, damages, skill_id, imp)
    if skill_id and target then
		local talent_config = configenginer:get_config("sect_desc")
        local talent = self:get_talent()
        for i = 1, #talent.study do
            local study_talent = talent.study[i]
            local logic = talentenginer:get_logic(study_talent)
            if logic then
                local talents = talent_config[study_talent.id]
                if talents then
                    local level = study_talent.level
                    level = level == 0 and 1 or level
                    logic:on_damage_target(talents, level, study_talent.id, self, target, damages, skill_id, imp)
                end
            end
        end
    end
end

function human:talent_study_sect(talent_id)
	local talent_config = configenginer:get_config("sect_desc")
	local talent = self:get_talent()
	for i = 1, #talent.study do
		local study_talent = talent.study[i]
		if study_talent.id == talent_id then
			local logic = talentenginer:get_logic_id(talent_id)
			if logic then
				local talents = talent_config[talent_id]
				if talents then
					local level = study_talent.level
					level = level == 0 and 1 or level
					logic:study_sect(talents, level, talent_id, self)
				end
			end
		end
	end
end

function human:update_kill_monster_count(count)
    local today_kill_monster_count = self:get_today_kill_monster_count()
    today_kill_monster_count = today_kill_monster_count + count
    self:on_today_kill_monster_count_change(today_kill_monster_count)
    self.db:set_db_attrib({ today_kill_monster_count = today_kill_monster_count })
end

function human:on_today_kill_monster_count_change(count)
	local env = skynet.getenv("env")
	local value = define.HEAVY_ANTI_ADDICTION_KILL_MONSTER_COUNT[env] or define.HEAVY_ANTI_ADDICTION_KILL_MONSTER_COUNT["moren"]
	if count >= value then
		self:notify_tips("#{MPCG_191029_304}")
		return
	end
	local value2 = define.MILD_ANTI_ADDICTION_KILL_MONSTER_COUNT[env] or define.MILD_ANTI_ADDICTION_KILL_MONSTER_COUNT["moren"]
	if count >= value2 then
		local msg = string.format("杀怪数大于%d时将进入沉迷状态，收益减半；杀怪数大于%d时将进入严重沉迷状态，无法获得任何收益。",value2,value)
		self:notify_tips(msg)
		return
	end
end

function human:get_today_kill_monster_count()
    return self.db:get_attrib("today_kill_monster_count") or 0
end

function human:set_today_kill_monster_count(count)
    self:on_today_kill_monster_count_change(count)
    count = count > define.UINT32_MAX and define.UINT32_MAX or count
    self.db:set_db_attrib({ today_kill_monster_count = count })
end

function human:can_be_dispatch_item_box()
	local env = skynet.getenv("env")
	local count = define.MILD_ANTI_ADDICTION_KILL_MONSTER_COUNT[env] or define.MILD_ANTI_ADDICTION_KILL_MONSTER_COUNT["moren"]
    return self:get_today_kill_monster_count() < count
end

function human:get_vigor()
    return self.db:get_db_attrib("vigor") or 0
end

function human:set_vigor(vigor)
    self.db:set_db_attrib({ vigor = vigor})
end

function human:get_vigor_max()
    return self.db:get_db_attrib("vigor_max") or 0
end

function human:get_stamina()
    return self.db:get_db_attrib("stamina") or 0
end

function human:set_stamina(stamina)
    self.db:set_db_attrib({ stamina = stamina})
end

function human:get_stamina_max()
    return self.db:get_db_attrib("stamina_max") or 0
end

function human:change_menpai(menpai)
    if menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUMENPAI then
        return false
    end
    local exist = false
    for key, val in pairs(define.MENPAI_ATTRIBUTE) do
        if val == menpai then
            exist = true
        end
    end
    if not exist then
        return false
    end
    self:change_menpai_change_xinfa(menpai)
    self:change_menpai_change_skills(menpai)
    self:change_menpai_abilitys(menpai)
    self:reset_talent()
    self.db:set_db_attrib({ menpai = menpai })
    self:change_menpai_points()
    self:item_flush()
    self:set_hp(self:get_max_hp())
    self:set_mp(self:get_max_mp())
    self:send_refresh_attrib()
    self:send_xinfa_list()
    self:send_skill_list()
    self:send_ability_list()
    return true
end

function human:change_menpai_change_xinfa(target_menpai)
    local xinfa_v1 = configenginer:get_config("xinfa_v1")
    local menpai = self:get_menpai()
    local xinfa_levels = {}
    for id, v1 in ipairs(xinfa_v1) do
        if v1.menpai == menpai then
            local xinfa = self:get_xinfa(id)
            if xinfa then
                table.insert(xinfa_levels, xinfa.m_nXinFaLevel)
            end
        end
    end
    self.xinfa_list = {}
    for id, v1 in ipairs(xinfa_v1) do
        if v1.menpai == target_menpai then
            if #xinfa_levels > 0 then
                local xinfa = { m_nXinFaID = id , m_nXinFaLevel = table.remove(xinfa_levels, 1) }
                table.insert(self.xinfa_list, xinfa)
            end
        end
    end
end

function human:change_menpai_change_skills(target_menpai)
    local menpai = self:get_menpai()
    local menpai_7_skills = define.MENPAI_7_SKILLS[menpai]
    local convert_qinggong_skill = false
    local skills_7 = {}
    for i = #self.skill_list, 1, -1 do
        local skill = self.skill_list[i]
        local template = skillenginer:get_skill_template(skill)
        if template.menpai == menpai then
            local skill_7_index = menpai_7_skills[skill]
            if skill_7_index then
                skills_7[skill_7_index] = true
            else
                table.remove(self.skill_list, i) 
                if skill == define.QINGGONG_SKILL[menpai] then
                    convert_qinggong_skill = true
                end
            end
        end
    end
    local target_menpai_7_skills = define.MENPAI_7_SKILLS[target_menpai]
    local convert_target_menpai_7_skills = {}
    for skill, index in pairs(target_menpai_7_skills) do
        convert_target_menpai_7_skills[index] = skill
    end
    for i, xinfa in ipairs(self.xinfa_list) do
        if i == 7 then
            for i = 1, 3 do
                if skills_7[i] then
                    self:add_skill(convert_target_menpai_7_skills[i])
                end
            end
        else
            local id = xinfa.m_nXinFaID
            local level = xinfa.m_nXinFaLevel
            self:on_study_xinfa(id, level)
        end
    end
    if convert_qinggong_skill then
        local skill = define.QINGGONG_SKILL[target_menpai]
        self:add_skill(skill)
    end
    table.sort(self.skill_list, function(sk1, sk2)
        return sk1 < sk2
    end)
    local yuangong_skill = define.MENPAI_JINZHAN_YUANGONG_SKILL[target_menpai]
    if yuangong_skill then
        self:add_skill(yuangong_skill)
    end
end

function human:change_menpai_abilitys(target_menpai)
    local menpai = self:get_menpai()
    local ABILITYS = define.MENPAI_ABILITYS[menpai]
    if ABILITYS then
        for i, id in ipairs(ABILITYS) do
            local ability = self:get_ability(id)
            if ability then
                ability.id = define.MENPAI_ABILITYS[target_menpai][i]
            end
        end
    end
end

function human:get_relation_info()
    return skynet.call(self:get_agent(), "lua", "get_relation_list")
end

function human:set_relation_info(realtion_list)
    self.relation_list = relation_list
    skynet.send(self:get_agent(), "lua", "set_realtion_list", realtion_list)
end

function human:set_relation_list_from_agent(relation_list)
    self.relation_list = relation_list
end

function human:relation_on_be_human_kill(killer)
    local agent = self:get_agent()
    skynet.send(agent, "lua", "relation_on_be_human_kill", killer:get_name())
end

function human:check_right_limit_exchange()
    local agent = self:get_agent()
    return skynet.call(agent, "lua", "check_right_limit_exchange")
end

function human:set_agree_swear_list(otherId)
    self.agree_swear_list = self.agree_swear_list or {}
    self.agree_swear_list[otherId] = true
end

function human:get_agree_swear_list()
    return self.agree_swear_list or {}
end

function human:get_master_level()
    return self.db:get_db_attrib("master_level") or 0
end

function human:set_master_level(master_level)
    self.db:set_db_attrib({ master_level = master_level})    
end

function human:get_prentice_supply_exp()
    return self.db:get_db_attrib("prentice_supply_exp") or 0
end

function human:add_prentice_pro_exp(add_exp)
    local exp = self:get_prentice_supply_exp()
    exp = exp + add_exp
    self.db:set_db_attrib({ prentice_supply_exp = exp })
end

function human:get_good_bad_value()
    return self.db:get_db_attrib("good_bad_value") or 0
end

function human:set_good_bad_value(value)
    value = math.floor(value)
    self.db:set_db_attrib({ good_bad_value = value})
end

function human:get_master_moral_point()
    return self.db:get_db_attrib("master_moral_point") or 0
end

function human:set_jiebai_name(jiebai_name)
    self.db:set_db_attrib({ jiebai_name = jiebai_name})
end

function human:get_jiebai_name()
    return self.db:get_db_attrib("jiebai_name") or ""
end

function human:set_meng_hui(meng_hui)
    if meng_hui > 0 and meng_hui < 5 then
        self.db:set_not_gen_attrib({menghui = meng_hui})
    end
end

function human:get_meng_hui()
    return self.db:get_attrib("menghui") or 0
end

function human:set_marry_info(marry_target_guid, is_accept)
    self.marry_info = self.marry_info or {}
    self.marry_info.target_guid = marry_target_guid
    self.marry_info.is_accept = is_accept
end

function human:get_marry_info()
    return self.marry_info
end

function human:on_bus(bus_id)
    self:get_ai():change_state("by_bus")
    self.db:set_attrib({ bus_id = bus_id})
end

function human:off_bus()
    self:get_ai():change_state("idle")
    self.db:set_attrib( { bus_id = define.INVAILD_ID })
end

function human:has_mount()
    return self:impact_get_first_impact_in_specific_collection(66) ~= nil
end

function human:has_dride()
    return false
end

function human:has_change_mode()
    local model_id = self.db:get_attrib("model_id") or define.INVAILD_ID
    return model_id ~= define.INVAILD_ID
end

function human:start_mission_timer(mission_id)
    local mission_timers = self.mission_timers or {}
    self.mission_timers = mission_timers
    table.insert(self.mission_timers, mission_id)
end

function human:stop_mission_timer(mission_id)
    local mission_timers = self.mission_timers or {}
    self.mission_timers = mission_timers
    for i, id in ipairs(self.mission_timers) do
        if id == mission_id then
            table.remove(self.mission_timers, i)
            break
        end
    end
end

function human:update_mission_timers(...)
    if self.mission_timers then
        for i = #self.mission_timers, 1, -1 do
            local mission_id = self.mission_timers[i]
            local mission = self:get_mission_by_id(mission_id)
            local script_id = mission.index or define.INVAILD_ID
            if script_id and script_id ~= define.INVAILD_ID then
                self:get_scene():get_script_engienr():call(script_id, "OnTimer", self:get_obj_id())
            end
        end
    end
end

function human:cost_money_with_priority(cost, reason, extra)
		assert(cost >= 1,cost)
    local money = self:get_money()
    local jiaozi = self:get_jiaozi()
    local cost_jiaozi = 0
    local cost_money = 0
    if jiaozi >= cost then
        self:set_jiaozi(jiaozi - cost, reason, extra)
        cost_jiaozi = cost
    else
        local diff = cost - jiaozi
        self:set_jiaozi(0, reason, extra)
        self:set_money(money - diff, reason, extra)
        cost_jiaozi = jiaozi
        cost_money = diff
    end
    return true, cost_jiaozi, cost_money
end

function human:cost_money(cost, reason, extra)
    local money = self:get_money()
    assert(cost > 0, cost)
    money = money - cost
    money = money < 0 and 0 or money
    self:set_money(money, reason, extra)
end

function human:check_money_with_priority(cost)
    local money = self:get_money()
    local jiaozi = self:get_jiaozi()
    return money + jiaozi >= cost
end

function human:set_wild_war_list(wild_war_list)
    self:get_wild_war_guilds():set_list(wild_war_list)
end

function human:is_friend_relation(other)
    local realtion_list = self.relation_list
    local friend_group = realtion_list.friends
    local relation = self:get_relation_by_guid_in_group(other:get_guid(), friend_group)
    return relation ~= nil
end

function human:is_prentice_relation(other)
    local realtion_list = self.relation_list
    local prentice_guid = realtion_list.prentice_guid or {}
    for _, guid in ipairs(prentice_guid) do
        if guid == other:get_guid() then
            return true
        end
    end
    return false
end

function human:get_relation_by_guid_in_group(guid, group)
    for _, relation in ipairs(group) do
        if relation.guid == guid then
            return relation
        end
    end
end

function human:add_good_bad_value(add)
    if add ~= 0 then
        local value = self:get_good_bad_value()
        value = value + add
        local config_info = configenginer:get_config("config_info")
        local MaxGoodBadValue = config_info.GoodBad.MaxGoodBadValue
        value = value > MaxGoodBadValue and MaxGoodBadValue or value
        self:set_good_bad_value(value)
        local msg = packet_def.GCNotifyGoodBad.new()
        msg.mode = 0
        msg.bonus = add
        self:get_scene():send2client(self, msg)
    end
end

function human:inc_friend_point(other)
    local realtion_list = self.relation_list
    local friend_group = realtion_list.friends
    local relation = self:get_relation_by_guid_in_group(other:get_guid(), friend_group)
    relation.friend_point = (relation.friend_point or 0) + 1
    skynet.send(self:get_agent(), "lua", "set_realtion_list", realtion_list)
end

function human:refix_skill_cool_down_time(skill_info, cool_down_time)
    local r, err = pcall(self.talent_refix_skill_cool_down_time, self, skill_info, cool_down_time)
    if r then
        cool_down_time = err
    else
        skynet.logw("talent_refix_skill_cool_down_time error =", err)
    end
    return cool_down_time
end

function human:talent_refix_skill_cool_down_time(skill_info, cool_down_time)
    local skill_info = self:get_skill_info()
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                cool_down_time = logic:refix_skill_cool_down_time(talent_config, level, study_talent.id, skill_info, cool_down_time)
            end
        end
    end
    return cool_down_time
end

function human:talent_on_use_skill_success_fully(skill_info)
    local skill_info = self:get_skill_info()
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                cool_down_time = logic:on_use_skill_success_fully(talent_config, level, skill_info, self)
            end
        end
    end
end

function human:talent_on_critical_hit_target(skill_id, obj_tar)
    print("talent_on_critical_hit_target")
    local skill_info = self:get_skill_info()
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                cool_down_time = logic:on_critical_hit_target(talent_config, level, self, obj_tar, skill_id)
            end
        end
    end
end

function human:talent_refix_skill_info(skill_info)
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:refix_skill_info(talent_config, level, skill_info, self)
            end
        end
    end
end

function human:impact_forbidden_this_skill(skill_id)
    local impactenginer = self:get_scene():get_impact_enginer()
    local impacts = self:get_impact_list()
    for i = #impacts, 1, -1 do
        local impact = impacts[i]
        local logic = impactenginer:get_logic(impact)
        logic:on_skill_miss(impact, sender)
        if logic:forbidden_this_skill(imp, skill_id) then
            return true
        end
    end
    return false
end

function human:on_skill_miss(sender, skill_id)
    self:impact_on_skill_miss(sender, skill_id)
    local r, err = pcall(self.talent_on_skill_miss, self, sender, skill_id)
    if not r then
        skynet.loge("talent_on_skill_miss error =", err)
    end
end

function human:on_skill_miss_target(reciver, skill_id)
    local r, err = pcall(self.talent_on_skill_miss_target, self, reciver, skill_id)
    if not r then
        skynet.loge("talent_on_skill_miss error =", err)
    end
end

function human:impact_on_skill_miss(sender, skill_id)
    local impactenginer = self:get_scene():get_impact_enginer()
    local impacts = self:get_impact_list()
    for i = #impacts, 1, -1 do
        local impact = impacts[i]
        local logic = impactenginer:get_logic(impact)
        logic:on_skill_miss(impact, sender)
    end
end

function human:impact_on_call_up_pet_success()
    local impactenginer = self:get_scene():get_impact_enginer()
    local impacts = self:get_impact_list()
    for i = #impacts, 1, -1 do
        local impact = impacts[i]
        local logic = impactenginer:get_logic(impact)
        logic:on_call_up_pet_success(impact, self, self.pet)
    end
end

function human:talent_on_skill_miss(sender, skill_id)
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_skill_miss(talent_config, level, sender, self, skill_id)
            end
        end
    end
end

function human:talent_on_skill_miss_target(reciver, skill_id)
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_skill_miss_target(talent_config, level, self, reciver, skill_id)
            end
        end
    end
end

function human:talent_on_damages(damages, caster_obj_id, is_critical, skill_id, imp)
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_damages(talent_config, level, damages, self, caster_obj_id, is_critical, skill_id, imp)
            end
        end
    end
end

function human:talent_on_be_hit(sender, skill)
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_be_hit(talent_config, level, self, sender, skill)
            end
        end
    end
end

function human:talent_on_be_critical_hit(skill_id, sender)
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_be_critical_hit(talent_config, level, self, sender, skill)
            end
        end
    end
end

function human:talent_on_active()
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_active(talent_config, level, self)
            end
        end
    end
end

function human:talent_on_remove()
    local talent = self:get_talent()
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local talent_config = configenginer:get_config("sect_desc")
            talent_config = talent_config[study_talent.id]
            if talent_config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                logic:on_remove(talent_config, level, self)
            end
        end
    end
end

function human:talent_on_stealth_level_update()
    local talent = self:get_talent()
    if talent then
        for i = 1, #talent.study do
            local study_talent = talent.study[i]
            local logic = talentenginer:get_logic(study_talent)
            if logic then
                local talent_config = configenginer:get_config("sect_desc")
                talent_config = talent_config[study_talent.id]
                if talent_config then
                    local level = study_talent.level
                    level = level == 0 and 1 or level
                    logic:on_stealth_level_update(talent_config, level, self)
                end
            end
        end
    end
end

function human:get_skill_template(skill_id)
    local template = human.super.get_skill_template(self, skill_id)
    return self:talent_on_get_skill_template(template)
end

function human:talent_on_get_skill_template(template)
    template = table.clone(template)
    local talent = self:get_talent()
    if talent then
        for i = 1, #talent.study do
            local study_talent = talent.study[i]
            local logic = talentenginer:get_logic(study_talent)
            if logic then
                local talent_config = configenginer:get_config("sect_desc")
                talent_config = talent_config[study_talent.id]
                if talent_config then
                    local level = study_talent.level
                    level = level == 0 and 1 or level
                    logic:on_get_skill_template(talent_config, level, self, template)
                end
            end
        end
    end
    return template
end

function human:set_talent_trigger_time(name)
    local talents_trigger_time = self.talents_trigger_time or {}
    talents_trigger_time[name] = os.time()
    self.talents_trigger_time = talents_trigger_time
end

function human:get_talent_trigger_time(name)
    local talents_trigger_time = self.talents_trigger_time or {}
    return talents_trigger_time[name]
end

function human:get_top_up_point()
    return skynet.call(self:get_agent(), "lua", "get_top_up_point")
end

function human:cost_top_up_point(cost)
    return skynet.call(self:get_agent(), "lua", "cost_top_up_point", cost)
end

function human:get_prerechage_money(...)
    return skynet.call(self:get_agent(), "lua", "get_prerechage_money", ...)
end

function human:on_enter_scene()
    self.begin_send_refresh_attrib = true
end

function human:is_begin_send_refresh_attrib()
    return self.begin_send_refresh_attrib
end

function human:set_near_team_members(members)
    self.near_team_members = members
end

function human:get_near_team_members()
    return self.near_team_members
end

function human:add_mission_huoyuezhi(type, count)
    local week_active = configenginer:get_config("week_active")
    week_active = week_active[type]
    if week_active then
        local data = self:get_week_active()
        local can_get = data.can_get
        local activity_finish_count = data.activity_finish_count[type]
        local num = activity_finish_count + (count or 1)
        data.activity_finish_count[type] = num
        for i, active in ipairs(week_active) do
            if num >= active.target then
                can_get[type] = can_get[type] | (0x1 << ((i - 1) * 8))
            end
        end
    end
end

function human:set_is_first_login(is_first_login)
    self.is_first_login = is_first_login
end

function human:get_is_first_login()
    return self.is_first_login
end

function human:set_enter_scene_time()
    self.enter_scene_time = os.time()
end

function human:get_enter_scene_time()
    return self.enter_scene_time
end

function human:get_enter_scene_time_diff()
    return os.time() - self.enter_scene_time
end

function human:get_talent_by_skill_id(skill_id)
    local talent = self:get_talent()
    local talent_config = configenginer:get_config("sect_desc")
    for i = 1, #talent.study do
        local study_talent = talent.study[i]
        local logic = talentenginer:get_logic(study_talent)
        if logic then
            local config = talent_config[study_talent.id]
            if config then
                local level = study_talent.level
                level = level == 0 and 1 or level
                local add_skill_id = logic:get_add_skill(config, level)
                if add_skill_id == skill_id then
                    return study_talent
                end
            end
        end
    end
end

function human:get_dw_jinjie_features()
	return self.dw_jinjie.features
end
function human:get_dw_jinjie_features_value(id)
	local index = tostring(id)
	return self.dw_jinjie.features[index]
end
function human:set_dw_jinjie_features_value(id,value)
	local index = tostring(id)
	self.dw_jinjie.features[index] = value
	self.db:send_refresh_attrib("dw_jinjie")
end

function human:set_dw_jinjie_feature_details(id,level,nexp)
	local index = tostring(id)
	self.dw_jinjie.features[index] = (nexp << 16) | (level << 8) | id
	self.db:send_refresh_attrib("dw_jinjie")
end

function human:get_dw_jinjie_feature_details(id)
	local idx = tostring(id)
	local value = self.dw_jinjie.features[idx]
	if value then
		local index = value & 0xFF
		local level = (value >> 8) & 0xFF
		local nexp = (value >> 16) & 0xFF
		if index == id then
			return level,nexp
		end
	end
end

function human:set_dw_jinjie_effect_details(equip_point,dw_featuresid,dw_advance_level)
	local index = tostring(equip_point)
	local oldid = 0
	if self.dw_jinjie.effect[index] then
		oldid = self.dw_jinjie.effect[index].id
	end
	if dw_featuresid > 0 then
		dw_advance_level = dw_advance_level // 5
		self.dw_jinjie.effect[index] = {id = dw_featuresid,finedraw = dw_advance_level}
	else
		self.dw_jinjie.effect[index] = nil
	end
	if dw_featuresid == 5
	or dw_featuresid == 11
	or oldid == 5
	or oldid == 11 then
		self:item_flush()
	end
end

function human:set_dw_jinjie_effect(effect)
	self.dw_jinjie.effect = effect or {}
end

function human:get_dw_jinjie_effect_details(id)
	local effect_value = 0
	local level = self:get_dw_jinjie_feature_details(id)
	if level and level > 0 then
		local dw_jinjie_texing = configenginer:get_config("dw_jinjie_texing")
		local texing = dw_jinjie_texing[id]
		if texing then
			local minlv
			for _,j in pairs(self.dw_jinjie.effect) do
				if j.id == id then
					minlv = math.min(level,j.finedraw)
					if minlv > 0 then
						effect_value = effect_value + texing.feature_list[minlv]
						if effect_value >= texing.feature_max then
							effect_value = texing.feature_max
							break
						end
					end
				end
			end
			return effect_value,texing.feature_rate,texing.add_feature_max
		end
	end
	return effect_value
end

function human:features_effect_notify_client(id,objid)
	objid = objid or self:get_obj_id()
	local msg = packet_def.GCDiaowenFeatureSkill.new()
	msg.objId = objid
	msg.effect_id = id
	self:get_scene():broadcast(self, msg, true)
end
-- function human:set_login_user(value)
    -- self.game_flag.login_user = value
-- end
function human:update_game_flag_key_cd(key,ntime)
	local value = (self.game_flag[key] or 0) - ntime
	if value < 0 then
		value = 0
	end
	self.game_flag[key] = value
end
function human:get_game_flag_key(key)
	return self.game_flag[key] or 0
end
function human:set_game_flag_key(key,value)
	self.game_flag[key] = value
end
function human:get_game_flag_keys(keys)
	local values = {}
	for key,value in pairs(keys) do
		values[key] = self.game_flag[key] or 0
	end
	return values
end
function human:set_game_flag_keys(values)
	for key,value in pairs(values) do
		self.game_flag[key] = value
		-- skynet.logi(key," = ",table.tostr(values))
	end
	-- if self.game_flag[key] ~= value then
		-- local guid = self:get_guid()
        -- skynet.send(".world", "lua", "update_uinfo", guid, {[key] = value})
	-- end
	-- self.game_flag[key] = value
end
function human:set_game_flag_keys_visual(eq_point,value)
	local key = string.format("equip_%d_visual",eq_point)
	self.game_flag[key] = value
	-- skynet.logi(key," = ",table.tostr(value))
end
--define.HUMAN_EQUIP_VISUALS_KEY
function human:get_game_flag_keys_visual(eq_point)
	local key = string.format("equip_%d_visual",eq_point)
	local values = {}
	if eq_point == define.HUMAN_EQUIP.HEQUIP_FASHION then
		values = {[define.WG_KEY_A] = -1,[define.WG_KEY_D] = -1,[define.WG_KEY_E] = -1,[define.WG_KEY_F] = -1,[define.WG_KEY_C] = 0}
	else
		values = {[define.WG_KEY_A] = -1,[define.WG_KEY_B] = -1,[define.WG_KEY_C] = 0}
	end
	if self.game_flag[key] then
		for key,value in pairs(self.game_flag[key]) do
			values[key] = value
		end
	end
	return values
end

function human:del_limit_shop(shopid)
	local index = tostring(shopid)
	if self.limit_shop[index] then
		self.limit_shop[index] = nil
	end
end
function human:reset_limit_shop(shopid,ntime)
	local index = tostring(shopid)
	if self.limit_shop[index] then
		if self.limit_shop[index].ntime ~= ntime then
			self.limit_shop[index] = {ntime = ntime,item_buy = {}}
		end
	else
		self.limit_shop[index] = {ntime = ntime,item_buy = {}}
	end
end
function human:get_limit_shop_buy_count(shopid,itemid)
	local index = tostring(shopid)
	if self.limit_shop[index] then
		if self.limit_shop[index].item_buy then
			for _,info in ipairs(self.limit_shop[index].item_buy) do
				if info.goods_id == itemid then
					return info.count
				end
			end
			return 0
		end
	end
end
function human:set_limit_shop_buy_count(shopid,itemid,buy_num)
	local index = tostring(shopid)
	if self.limit_shop[index] then
		if self.limit_shop[index].item_buy then
			local have_date = false
			for _,info in ipairs(self.limit_shop[index].item_buy) do
				if info.goods_id == itemid then
					info.count = info.count + buy_num
					have_date = true
					break
				end
			end
			if not have_date then
				table.insert(self.limit_shop[index].item_buy,{ goods_id = itemid, count = buy_num})
			end
		end
	end
end

function human:update_chonglou_sash(imp)
    local list = self:get_impact_list()
	for i, current in ipairs(list) do
		if current:get_mutex_id() == 5982 then
			local logic = impactenginer:get_logic(current)
			if logic then
				logic:reset_calculate_total_damage_taken(current,0)
			end
		end
	end
end

function human:remove_impact(imp,checking)
    local list = self:get_impact_list()
	local imp_sn = imp:get_sn()
	if not checking then
		local have_chonglou_impact
		local have_control
		for i, current in ipairs(list) do
			if current:get_sn() == imp_sn then
				local logic = impactenginer:get_logic(imp)
				if logic then
					logic:mark_modified_attr_dirty(imp, self)
				end
				table.remove(list, i)
				-- break
			elseif current:get_mutex_id() == 5982 then
				have_chonglou_impact = current
			elseif current:get_chonglou_sash() then
				have_control = true
			end
		end
		if have_chonglou_impact then
			if not have_control then
				local logic = impactenginer:get_logic(have_chonglou_impact)
				if logic then
					logic:set_calculate_total_damage_taken(have_chonglou_impact)
				end
			end
		end
	else
		for i, current in ipairs(list) do
			if current:get_sn() == imp_sn then
				local logic = impactenginer:get_logic(imp)
				if logic then
					logic:mark_modified_attr_dirty(imp, self)
				end
				table.remove(list, i)
				break
			end
		end
	end
end

return human