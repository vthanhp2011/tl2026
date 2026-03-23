local class = require "class"
local packet = require "game.packet"
local define = require "define"
local iostream = require "iostream"
local configenginer = require "configenginer":getinstance()
local skillenginer = require "skillenginer":getinstance()
local item_container = require "item_container"
local Item_cls = require "item"
local pet_db_attr = require "db.pet_attrib"
local pet_guid_cls = require "pet_guid"
local pet_detail = class("pet_detail")

function pet_detail:ctor()
end

function pet_detail:init_from_data(data, owner)
    self.owner = owner
    self.titles = data.titles or {}
    self.skill_list = data.skills
    self.cool_down_times = self.cool_down_times or {}
    self.equip_container = item_container.new()
    self.equip_container:init(define.PET_EQUIP.PEQUIP_SOUL + 1, data.equips,define.CONTAINER_INDEX.HUMAN_PET_EQUIP)
    self.db = pet_db_attr.new(data.lv1_attrib, data.attrib)
    self.db:set_pet(self)
    self:item_flush()
end

function pet_detail:get_db()
    return self.db
end

function pet_detail:get_obj_data()
    return {
        skill_list = self.skill_list,
        titles = self.titles,
        db = self.db,
        equip_container = self.equip_container,
        onwer_obj_id = self.owner and self.owner:get_obj_id() or define.INVAILD_ID,
        cool_down_times = self.cool_down_times
    }
end

function pet_detail:get_attrib(key)
    return self.db:get_attrib(key)
end

function pet_detail:set_db_attrib(set_list)
    return self.db:set_db_attrib(set_list)
end

function pet_detail:set_lv1_attrib(set_list)
    self.db:set_lv1_attrib(set_list)
end

function pet_detail:get_detail_attribs()
    return self.db:get_detail_attribs()
end

function pet_detail:get_db_save_attrib()
    return self.db:get_db_save_attrib()
end

function pet_detail:get_skills()
    return self.skill_list
end

function pet_detail:add_skill(skill)
    local skill_template = configenginer:get_config("skill_template")
    local template = skill_template[skill]
    local is_passive = template.is_passive
    local list = self.skill_list.activate
    if is_passive then
        list = self.skill_list.positive
    end
    local find = false
    for _, sk in ipairs(list) do
        if sk == skill then
            find = true
            break
        end
    end
    if not find then
        table.insert(list, skill)
    end
end

function pet_detail:manual_attr(manual)
 -- local skynet = require "skynet"
	-- skynet.logi("manual_attr",manual)
    if manual.name then
        self:set_db_attrib({name = manual.name})
    end
    if manual.current_title then
        self:set_current_title(manual.current_title)
    end
    local point_remain_expend = 0
    if manual.str_increment then
        point_remain_expend = point_remain_expend + manual.str_increment
    end
    if manual.con_increment then
        point_remain_expend = point_remain_expend + manual.con_increment
    end
    if manual.dex_increment then
        point_remain_expend = point_remain_expend + manual.dex_increment
    end
    if manual.spr_increment then
        point_remain_expend = point_remain_expend + manual.spr_increment
    end
    if manual.int_increment then
        point_remain_expend = point_remain_expend + manual.int_increment
    end
    local lv1_attribs = self.db:get_lv1_attrib()
    if point_remain_expend > lv1_attribs.point_remain then
        return
    end
    if manual.str_increment then
        self.db:set_lv1_attrib( { str = lv1_attribs.str + manual.str_increment })
		lv1_attribs.addstr = lv1_attribs.addstr or 0
        self.db:set_lv1_attrib( { addstr = lv1_attribs.addstr + manual.str_increment })
    end
    if manual.con_increment then
        self.db:set_lv1_attrib({ con = lv1_attribs.con + manual.con_increment })
		lv1_attribs.addcon = lv1_attribs.addcon or 0
        self.db:set_lv1_attrib({ addcon = lv1_attribs.addcon + manual.con_increment })
    end
    if manual.dex_increment then
        self.db:set_lv1_attrib({ dex = lv1_attribs.dex + manual.dex_increment })
		lv1_attribs.adddex = lv1_attribs.adddex or 0
        self.db:set_lv1_attrib({ adddex = lv1_attribs.adddex + manual.dex_increment })
    end
    if manual.spr_increment then
        self.db:set_lv1_attrib({ spr = lv1_attribs.spr + manual.spr_increment })
		lv1_attribs.addspr = lv1_attribs.addspr or 0
        self.db:set_lv1_attrib({ addspr = lv1_attribs.addspr + manual.spr_increment })
    end
    if manual.int_increment then
        self.db:set_lv1_attrib({ int = lv1_attribs.int + manual.int_increment })
		lv1_attribs.addint = lv1_attribs.addint or 0
        self.db:set_lv1_attrib({ addint = lv1_attribs.addint + manual.int_increment })
    end
    self.db:set_lv1_attrib({ point_remain = lv1_attribs.point_remain - point_remain_expend })
    self:send_refresh_attrib(nil, false)
end
function pet_detail:petaddpoint()
	local addpoint = 0
    local lv1_attribs = self.db:get_lv1_attrib()
	lv1_attribs.addstr = lv1_attribs.addstr or 0
	lv1_attribs.addcon = lv1_attribs.addcon or 0
	lv1_attribs.adddex = lv1_attribs.adddex or 0
	lv1_attribs.addspr = lv1_attribs.addspr or 0
	lv1_attribs.addint = lv1_attribs.addint or 0
	if lv1_attribs.addstr then
		addpoint = addpoint + lv1_attribs.addstr
	end
	if lv1_attribs.addcon then
		addpoint = addpoint + lv1_attribs.addcon
	end
	if lv1_attribs.adddex then
		addpoint = addpoint + lv1_attribs.adddex
	end
	if lv1_attribs.addspr then
		addpoint = addpoint + lv1_attribs.addspr
	end
	if lv1_attribs.addint then
		addpoint = addpoint + lv1_attribs.addint
	end
	return addpoint
end
function pet_detail:reseting_attr()
	local resetpoint = 0
    local lv1_attribs = self.db:get_lv1_attrib()
	lv1_attribs.addstr = lv1_attribs.addstr or 0
	if lv1_attribs.addstr > 0 and lv1_attribs.str > lv1_attribs.addstr then
		resetpoint = resetpoint + lv1_attribs.addstr
		lv1_attribs.str = lv1_attribs.str - lv1_attribs.addstr
		lv1_attribs.addstr = 0
        self.db:set_lv1_attrib( { str = lv1_attribs.str })
        self.db:set_lv1_attrib( { addstr = lv1_attribs.addstr })
	end
	lv1_attribs.addcon = lv1_attribs.addcon or 0
	if lv1_attribs.addcon > 0 and lv1_attribs.con > lv1_attribs.addcon then
		resetpoint = resetpoint + lv1_attribs.addcon
		lv1_attribs.con = lv1_attribs.con - lv1_attribs.addcon
		lv1_attribs.addcon = 0
        self.db:set_lv1_attrib( { con = lv1_attribs.con })
        self.db:set_lv1_attrib( { addcon = lv1_attribs.addcon })
	end
	lv1_attribs.adddex = lv1_attribs.adddex or 0
	if lv1_attribs.adddex > 0 and lv1_attribs.dex > lv1_attribs.adddex then
		resetpoint = resetpoint + lv1_attribs.adddex
		lv1_attribs.dex = lv1_attribs.dex - lv1_attribs.adddex
		lv1_attribs.adddex = 0
        self.db:set_lv1_attrib( { dex = lv1_attribs.dex })
        self.db:set_lv1_attrib( { adddex = lv1_attribs.adddex })
	end
	lv1_attribs.addspr = lv1_attribs.addspr or 0
	if lv1_attribs.addspr > 0 and lv1_attribs.spr > lv1_attribs.addspr then
		resetpoint = resetpoint + lv1_attribs.addspr
		lv1_attribs.spr = lv1_attribs.spr - lv1_attribs.addspr
		lv1_attribs.addspr = 0
        self.db:set_lv1_attrib( { spr = lv1_attribs.spr })
        self.db:set_lv1_attrib( { addspr = lv1_attribs.addspr })
	end
	lv1_attribs.addint = lv1_attribs.addint or 0
	if lv1_attribs.addint > 0 and lv1_attribs.int > lv1_attribs.addint then
		resetpoint = resetpoint + lv1_attribs.addint
		lv1_attribs.int = lv1_attribs.int - lv1_attribs.addint
		lv1_attribs.addint = 0
        self.db:set_lv1_attrib( { int = lv1_attribs.int })
        self.db:set_lv1_attrib( { addint = lv1_attribs.addint })
	end
	if resetpoint > 0 then
		local curlv = self:get_attrib("level") - 1
		if curlv < 0 then
			curlv = 0
		end
		curlv = curlv * 5
		lv1_attribs.point_remain = lv1_attribs.point_remain + resetpoint
		if lv1_attribs.point_remain > curlv then
			lv1_attribs.point_remain = curlv
		end
		self.db:set_lv1_attrib({ point_remain = lv1_attribs.point_remain })
		self:send_refresh_attrib(nil, false)
		return 0
	end
	return -1
end
function pet_detail:send_refresh_attrib(who, mark_all_dirty, type)
    self.db:send_refresh_attrib(who, mark_all_dirty, self.skill_list, type)
end

function pet_detail:get_equip_container()
    return self.equip_container
end

function pet_detail:get_equips()
    return self.equip_container:copy_raw_data()
end

function pet_detail:is_in_exchange()
    return false
end

function pet_detail:get_guid()
    return self:get_attrib("guid")
end

function pet_detail:get_hp()
    return self:get_attrib("hp")
end

function pet_detail:set_hp(hp)
    self:set_db_attrib({ hp = hp })
end

function pet_detail:get_max_hp()
    return self:get_attrib("hp_max")
end

function pet_detail:get_level()
    return self:get_attrib("level")
end

function pet_detail:get_sex()
    local guid = self:get_attrib("guid")
    return guid.m_uLowSection % 2
end

function pet_detail:set_propagate_level(level)
    self:set_db_attrib({ propagate_level = level })
end

function pet_detail:get_propagate_level()
    return self:get_attrib("propagate_level")
end

function pet_detail:can_set_title(id)
    local max_title
    for _, title in ipairs(self.titles) do
        if max_title == nil or title > max_title then
            max_title = title
        end
    end
    return max_title == nil or id > max_title
end

function pet_detail:set_title(id)
    if self:can_set_title(id) then
        self.titles[1] = id
        self:set_current_title(id)
        return true
    end
end

function pet_detail:get_titles()
    return self.titles
end

function pet_detail:set_current_title(id)
    self.db:set_db_attrib({ current_title = id })
end

function pet_detail:get_current_title()
    return self:get_attrib("current_title")
end

function pet_detail:set_spouse_guid(guid)
    self:set_db_attrib({ spouse_guid = guid })
end

function pet_detail:get_spouse_guid()
    local guid = self:get_attrib("spouse_guid")
    local spouse_guid = pet_guid_cls.new()
    spouse_guid:set(guid.m_uHighSection, guid.m_uLowSection)
    return spouse_guid
end

function pet_detail:get_happiness()
    return self:get_attrib("happiness")
end

function pet_detail:set_happiness(happiness)
    self:set_db_attrib({ happiness = happiness })
end

function pet_detail:get_life()
    return self:get_attrib("life_span")
end

function pet_detail:set_life(life_span)
    self:set_db_attrib({ life_span = life_span })
end

function pet_detail:get_wuxing()
    return self:get_attrib("wuxing")
end

function pet_detail:set_wuxing(wuxing)
    self:set_db_attrib({ wuxing = wuxing })
end

function pet_detail:get_take_level()
    return self:get_attrib("take_level")
end

function pet_detail:get_by_type()
    return self:get_attrib("by_type")
end

function pet_detail:get_growth_rate()
    return self:get_attrib("growth_rate")
end

function pet_detail:get_data_index()
    return self:get_attrib("data_id")
end

function pet_detail:have_huan_hua()
    local lingxing = self:get_attrib("lingxing")
    return math.floor(lingxing / 100) == 1
end

function pet_detail:set_huan_huad()
    local lingxing = self:get_attrib("lingxing")
    local v_lingxing = lingxing % 100
    self:set_db_attrib({ lingxing = v_lingxing + 100 })
end

function pet_detail:set_data_index(data_id)
    self:set_db_attrib({ data_id = data_id })
end

function pet_detail:get_ling_xing()
    local lingxing = self:get_attrib("lingxing")
    local v_lingxing = lingxing % 100
    return v_lingxing
end

function pet_detail:set_ling_xing(lingxing)
    self:set_db_attrib({ lingxing = 100 + lingxing })
end

function pet_detail:item_flush()
    self.db:item_effect_flush()
end

function pet_detail:copy_raw_data()
    return {
        skills = self.skill_list,
        titles = self.titles,
        lv1_attrib = self.db:get_lv1_attrib(),
        attrib = self.db:get_db_save_attrib(),
        equips = self:get_equip_container():get_save_data(),
        cool_down_times = self.cool_down_times
    }
end

function pet_detail:get_owner()
    return self.owner
end

function pet_detail:get_creator()
    return self:get_owner()
end

function pet_detail:get_obj_id()
    return nil
end

function pet_detail:get_scene()
    return nil
end

function pet_detail:get_skill_max_control_by_ai()
    return 10
end

function pet_detail:get_skill_max_control_by_player()
    return 2
end

function pet_detail:get_activate_skill(index)
    return self.skill_list.activate[index]
end

function pet_detail:get_positive_skill(index)
    return self.skill_list.positive[index]
end

function pet_detail:set_activate_skill(index, skill_id)
    self.skill_list.activate[index] = skill_id
end

function pet_detail:set_positive_skill(index, skill_id)
    self.skill_list.positive[index] = skill_id
end

function pet_detail:get_skill_by_index(index)
    if index < 2 then
        return self:get_activate_skill(index + 1)
    else
        index = index - 2
        return self:get_positive_skill(index + 1)
    end
end

function pet_detail:set_skill_by_index(index, skill_id)
    assert(skill_id)
    if index < 2 then
        return self:set_activate_skill(index + 1, skill_id)
    else
        index = index - 2
        return self:set_positive_skill(index + 1, skill_id)
    end
end

function pet_detail:skill_modify_study(skillid)
    local template = skillenginer:get_skill_template(skillid)
    if template == nil then
        return false
    end
    local max_ai_skill_num = self:get_skill_max_control_by_ai()
    local max_player_skill_num = self:get_skill_max_control_by_player()
    for i = 1, max_ai_skill_num do
        local id = self:get_activate_skill(i)
        if id == skillid then
            return false
        end
    end
    for i = 1, max_player_skill_num do
        local id = self:get_positive_skill(i)
        if id == skillid then
            return false
        end
    end
    if template.operate_mode == define.PET_SKILL_OPERATEMODE.PET_SKILL_OPERATE_NEEDOWNER then
        for i = 1, max_player_skill_num do
            local skill = self:get_activate_skill(i)
            if skill then
                local skill_template = skillenginer:get_skill_template(skill)
                if skill_template.group_id == template.group_id then
                    return self:skill_register(i, skillid, self.skill_list.activate)
                end
            end
        end
        for i = 1, max_player_skill_num do
            local skill = self:get_activate_skill(i)
            if skill == nil then
                return self:skill_register(i, skillid, self.skill_list.activate)
            end
        end
    else
        for i = 1, max_ai_skill_num do
            local skill = self:get_positive_skill(i)
            if skill then
                local skill_template = skillenginer:get_skill_template(skill)
                if skill_template.group_id == template.group_id then
                    return self:skill_register(i, skillid, self.skill_list.positive)
                end
            end
        end
        local non_skill_num = 0
        for i = 1, max_ai_skill_num do
            local id = self:get_positive_skill(i)
            if id == nil then
                non_skill_num = non_skill_num + 1
            end
        end
        local pet_study_config
        local pet_study_skill_table = configenginer:get_config("pet_study_skill_table")
        for _, config in pairs(pet_study_skill_table) do
            if config.max_skill_count == max_ai_skill_num and config.non_skill_count == non_skill_num then
                pet_study_config = config
                break
            end
        end
        if pet_study_config then
            local percent = math.random(1000)
            if percent < pet_study_config.odd then
                for i = 1, max_ai_skill_num do
                    local skill = self:get_positive_skill(i)
                    if skill == nil then
                        return self:skill_register(i, skillid, self.skill_list.positive)
                    end
                end
            else
                local ai_skill_num = max_ai_skill_num - non_skill_num
                if ai_skill_num > 0 then
                    local replace_index = math.random(ai_skill_num)
                    return self:skill_register(replace_index, skillid, self.skill_list.positive)
                end
            end
        end
    end
    return false
end

function pet_detail:skill_register(index, skillid, skills)
    local template = skillenginer:get_skill_template(skillid)
    if template == nil then
        return false
    end
    if template.operate_mode == define.PET_SKILL_OPERATEMODE.PET_SKILL_OPERATE_NEEDOWNER then
        local max = self:get_skill_max_control_by_player()
        if index > max then
            return false
        end
        skills[index] = skillid
    else
        local max = self:get_skill_max_control_by_ai()
        if index > max then
            return false
        end
        skills[index] = skillid
    end
    self.db:mark_skill_dirty()
    return true
end

function pet_detail:have_equip()
    local equip_container = self:get_equip_container()
    for i = define.PET_EQUIP.PEQUIP_CAP, define.PET_EQUIP.PEQUIP_SOUL do
        local equip = equip_container:get_item(i)
        if equip then
            return true
        end
    end
    return false
end

function pet_detail:get_pet_soul_melting_model()
    local soul = self:get_equip_container():get_item(define.PET_EQUIP.PEQUIP_SOUL)
    if soul == nil then
        return define.INVAILD_ID
    end
    local pet_soul_base = configenginer:get_config("pet_soul_base")
    pet_soul_base = pet_soul_base[soul:get_index()]
    if pet_soul_base == nil then
        return define.INVAILD_ID
    end
    local pet_soul_level = soul:get_pet_equip_data():get_pet_soul_level()
    local model = pet_soul_base.soul_melting_models[pet_soul_level + 1]
    return model or define.INVAILD_ID
end

function pet_detail:get_pet_soul_melting_level()
    local soul = self:get_equip_container():get_item(define.PET_EQUIP.PEQUIP_SOUL)
    if soul == nil then
        return define.INVAILD_ID
    end
    local pet_soul_base = configenginer:get_config("pet_soul_base")
    pet_soul_base = pet_soul_base[soul:get_index()]
    if pet_soul_base == nil then
        return define.INVAILD_ID
    end
    local pet_soul_level = soul:get_pet_equip_data():get_pet_soul_level()
    return pet_soul_level + 1
end

function pet_detail:get_growth_rate_queryd()
    return self:get_attrib("growth_rate_queryd")
end

function pet_detail:set_growth_rate_queryd()
    self:set_db_attrib({ growth_rate_queryd = true})
end

function pet_detail:get_growth_rate_level()
    local growth_rate = math.floor(self:get_attrib("growth_rate") * 1000)
    local data_id = self:get_attrib("data_id")
    local configs = configenginer:get_config("pet_attr_table")
    local config = configs[data_id]
    assert(config, data_id)
    for i = 1, 5 do
        if config.growth_rate[i] == growth_rate then
            return i
        end
    end
    assert(false, growth_rate)
end

function pet_detail:set_used_procreate_count(count)
    self:set_db_attrib({ used_procreate_count = count })
end

function pet_detail:get_used_procreate_count()
    return self:get_attrib("used_procreate_count")
end

function pet_detail:get_remain_procreate_count()
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

function pet_detail:set_remain_procreate_count(remain_count)
    local level = self:get_level()
    local count = 0
    for _, target_level in ipairs(define.ProCreateTargetLevel) do
        if level >= target_level then
            count = count + 1
        end
    end
    local used_count = count - remain_count
    used_count = used_count >= 0 and used_count or 0
    self:set_used_procreate_count(used_count)
end

function pet_detail:get_max_perception_in_collection(collection)
    local perceptions = {}
    for _, attr in ipairs(collection) do
        table.insert(perceptions, self:get_attrib(attr))
    end
    table.sort(perceptions, function(a, b)  return a > b end)
    return perceptions[1]
end

function pet_detail:get_base_config()
    local data_index = self:get_attrib("data_id")
    local pet_attr_table = configenginer:get_config("pet_attr_table")
    return pet_attr_table[data_index]
end

function pet_detail:get_transfer()
    local ostream = iostream.bostream
    local os = ostream.new()
    local attibs = self:get_detail_attribs()
    packet.PetGUID.bos(attibs.guid, os)
    os:writeushort(attibs.data_id)
    os:writeuchar(attibs.ai_type)
    os:writeuchar(attibs.level)
    os:writeuint(attibs.hp)
    os:writeuint(attibs.hp_max)
    os:writeuint(attibs.life_span)
    os:writeuchar(attibs.lingxing)
    os:writeuchar(attibs.happiness)
    packet.PetGUID.bos(attibs.spouse_guid, os)
    os:writeuchar(0xff)
    os:writeuchar(0xff)
    os:writeuint(attibs.attrib_att_physics)
    os:writeuint(attibs.attrib_att_magic)
    os:writeuint(attibs.attrib_def_physics)
    os:writeuint(attibs.attrib_def_magic)
    os:writeushort(attibs.attrib_hit)
    os:writeushort(attibs.attrib_miss)
    os:writeushort(attibs.mind_attack)
    os:writeushort(attibs.mind_defend)
    os:writeushort(attibs.str_perception)
    os:writeushort(attibs.spr_perception)
    os:writeushort(attibs.con_perception)
    os:writeushort(attibs.int_perception)
    os:writeushort(attibs.dex_perception)

    os:writeushort(attibs.str)
    os:writeushort(attibs.con)
    os:writeushort(attibs.dex)
    os:writeushort(attibs.spr)
    os:writeushort(attibs.int)

    os:writeuchar(0)
    os:writeuchar(0)
    os:writeuchar(0)
    os:writeuchar(0)

    os:writeuchar(attibs.wuxing)
    local growth_rate = attibs.growth_rate
    if not attibs.growth_rate_queryd then
        growth_rate = -1
    end
    os:writefloat(growth_rate)
    os:writeuchar(attibs.attack_type)

    os:writeuchar(0)

    os:writeshort(self.skill_list.activate[1] or define.INVAILD_ID)
    os:writeshort(self.skill_list.activate[2] or define.INVAILD_ID)

    os:writeshort(self.skill_list.positive[1] or define.INVAILD_ID)
    os:writeshort(self.skill_list.positive[2] or define.INVAILD_ID)
    os:writeshort(self.skill_list.positive[3] or define.INVAILD_ID)
    os:writeshort(self.skill_list.positive[4] or define.INVAILD_ID)
    os:writeshort(self.skill_list.positive[5] or define.INVAILD_ID)

    local s = os:get()
    s = string.gsub(s, string.char(0x5C), string.char(0x5C) .. string.char(0x5C))
    s = string.gsub(s, string.char(0), "\\0")
    s = "p" .. s
    local len = string.len(s)
    return string.format("%03d%s", len, s)
end

function pet_detail:calculate_pet_detail_attrib(msg)
    msg.m_nTradeIndex = 0
    local attrib = self.db:get_detail_attribs()
    msg:set_guid(attrib.guid)
    msg:set_data_id(attrib.data_id)
    msg:set_name(attrib.name)
    msg:set_ai_type(attrib.ai_type)
    msg:set_spouse_guid(attrib.spouse_guid)
    msg:set_level(attrib.level)
    msg:set_exp(attrib.exp)
    msg:set_hp(attrib.hp)
    msg:set_hp_max(attrib.hp_max)
    msg:set_life_span(attrib.life_span)
    msg:set_lingxing(attrib.lingxing)
    msg:set_happiness(attrib.happiness)
    msg:set_attrib_att_physics(attrib.attrib_att_physics)
    msg:set_attrib_att_magic(attrib.attrib_att_magic)
    msg:set_attrib_def_physics(attrib.attrib_def_physics)
    msg:set_attrib_def_magic(attrib.attrib_def_magic)
    msg:set_attrib_hit(attrib.attrib_hit)
    msg:set_attrib_miss(attrib.attrib_miss)
    msg:set_mind_attack(attrib.mind_attack)
    msg:set_mind_defend(attrib.mind_defend)
    msg:set_attack_type(attrib.attack_type)
    local main_perception = attrib.con_perception
    msg:set_main_perception(main_perception)

    msg:set_str(attrib.str)
    msg:set_con(attrib.con)
    msg:set_dex(attrib.dex)
    msg:set_spr(attrib.spr)
    msg:set_int(attrib.int)
    msg:set_point_remain(attrib.point_remain)

    msg:set_str_perception(attrib.str_perception)
    msg:set_con_perception(attrib.con_perception)
    msg:set_dex_perception(attrib.dex_perception)
    msg:set_spr_perception(attrib.spr_perception)
    msg:set_int_perception(attrib.int_perception)

    msg:set_soul_add_str_perception(attrib.soul_add_str_perception)
    msg:set_soul_add_con_perception(attrib.soul_add_con_perception)
    msg:set_soul_add_dex_perception(attrib.soul_add_dex_perception)
    msg:set_soul_add_spr_perception(attrib.soul_add_spr_perception)
    msg:set_soul_add_int_perception(attrib.soul_add_int_perception)

    local skills = self.skill_list
    msg:set_activate_skill_1(skills.activate[1])
    msg:set_activate_skill_2(skills.activate[2])

    msg:set_positive_skill_1(skills.positive[1])
    msg:set_positive_skill_2(skills.positive[2])
    msg:set_positive_skill_3(skills.positive[3])
    msg:set_positive_skill_4(skills.positive[4])
    msg:set_positive_skill_5(skills.positive[5])
    msg:set_positive_skill_6(skills.positive[6])
    msg:set_positive_skill_7(skills.positive[7])
    msg:set_positive_skill_8(skills.positive[8])
    msg:set_positive_skill_9(skills.positive[9])
    msg:set_positive_skill_10(skills.positive[10])
    msg:set_positive_skill_11(skills.positive[11])

    local equips = self:get_equips()
    local empty_equip = Item_cls.new()
    msg:set_equip_1(equips[0] or empty_equip)
    msg:set_equip_2(equips[1] or empty_equip)
    msg:set_equip_3(equips[2] or empty_equip)
    msg:set_equip_4(equips[3] or empty_equip)
    msg:set_equip_5(equips[4] or empty_equip)
    msg:set_equip_6(equips[5] or empty_equip)

    msg:set_wuxing(attrib.wuxing)
    msg:set_gengu(attrib.gengu)
    msg:set_growth_rate(attrib.growth_rate)

    msg:set_att_cold(attrib.att_cold)
    msg:set_def_cold(attrib.def_cold)
    msg:set_reduce_def_cold(attrib.reduce_def_cold)
    msg:set_att_fire(attrib.att_fire)
    msg:set_def_fire(attrib.def_fire)
    msg:set_reduce_def_fire(attrib.reduce_def_fire)
    msg:set_att_light(attrib.att_light)
    msg:set_def_light(attrib.def_light)
    msg:set_reduce_def_light(attrib.reduce_def_light)
    msg:set_att_poison(attrib.att_poison)
    msg:set_def_poison(attrib.def_poison)
    msg:set_reduce_def_poison(attrib.reduce_def_poison)

    msg:set_unknow_2(-1)
    msg:set_unknow_5(2)
    msg:set_titles(self:get_titles())
    msg:set_current_title(self:get_current_title())
    msg:set_unknow_10(0)
    msg:set_unknow_11(5399)
    msg:set_unknow_13(0)
end

function pet_detail:set_in_exchange()

end

function pet_detail:stealth_level_update()

end

return pet_detail