local class = require "class"
local define = require "define"
local Item_cls = require "item"
local packet_def = require "game.packet"
local configenginer = require "configenginer":getinstance()
local impactenginer = require "impactenginer":getinstance()
local skillenginer = require "skillenginer":getinstance()
local pet_guid = require "pet_guid"
local pet_attrib = class("pet_attrib")

local must_be_positive = {
    attrib_att_magic = true,
    attrib_att_physics = true,
    attrib_def_magic = true,
    attrib_def_physics = true,
    attrib_hit = true,
    attrib_miss = true,
    hp = true,
    hp_max = true,
    mp = true,
    mp_max = true,
    point_remain = true,
    mind_attack = true,
    mind_defend = true,
    rage = true,
    strike_point = true,
    datura_flower = true,
    att_cold = true,
    reduce_def_cold = true,
    reduce_def_cold_low_limit = true,
    att_fire = true,
    reduce_def_fire = true,
    reduce_def_fire_low_limit = true,
    att_light = true,
    reduce_def_light = true,
    reduce_def_light_low_limit = true,
    att_poison = true,
    reduce_def_poison = true,
    reduce_def_poison_low_limit = true,
    vigor = true,
    stamina = true,
    str = true,
    spr = true,
    con = true,
    int = true,
    dex = true,
    exp = true,
    hp_re_speed = true,
    mp_re_speed = true,
}

local lv1_attribs = {
    str = true,
    spr = true,
    con = true,
    int = true,
    dex = true,
    addstr = true,
    addspr = true,
    addcon = true,
    addint = true,
    adddex = true,
	
    point_remain = true
}

local IA = define.ITEM_ATTRIBUTE
local item_effct_shift = {
    str =  { point = IA.IATTRIBUTE_STR },
    spr =  { point = IA.IATTRIBUTE_SPR },
    con =  { point = IA.IATTRIBUTE_CON },
    int =  { point = IA.IATTRIBUTE_INT },
    dex =  { point = IA.IATTRIBUTE_DEX },

    str_perception =  { rate = IA.IATTRIBUTE_RATE_STR_PERCEPTION },
    spr_perception =  { rate = IA.IATTRIBUTE_RATE_SPR_PERCEPTION },
    con_perception =  { rate = IA.IATTRIBUTE_RATE_CON_PERCEPTION },
    dex_perception =  { rate = IA.IATTRIBUTE_RATE_DEX_PERCEPTION },
    int_perception =  { rate = IA.IATTRIBUTE_RATE_INT_PERCEPTION },

    hp_max = { point = IA.IATTRIBUTE_POINT_MAXHP, rate = IA.IATTRIBUTE_RATE_MAXHP, restore =  IA.IATTRIBUTE_RESTORE_HP},
    mp_max = { point = IA.IATTRIBUTE_POINT_MAXMP, rate = IA.IATTRIBUTE_RATE_MAXMP, restore =  IA.IATTRIBUTE_RESTORE_MP},
    attrib_att_physics = { point = IA.IATTRIBUTE_ATTACK_P, rate = IA.IATTRIBUTE_RATE_ATTACK_P, base = IA.IATTRIBUTE_BASE_ATTACK_P},
    attrib_att_magic = { point = IA.IATTRIBUTE_ATTACK_M, rate = IA.IATTRIBUTE_RATE_ATTACK_M, base = IA.IATTRIBUTE_BASE_MAGIC_P},
    attrib_def_physics = { point = IA.IATTRIBUTE_DEFENCE_P, rate = IA.IATTRIBUTE_RATE_DEFENCE_P, base = IA.IATTRIBUTE_BASE_DEFENCE_P},
    attrib_def_magic = { point = IA.IATTRIBUTE_DEFENCE_M, rate = IA.IATTRIBUTE_RATE_DEFENCE_M, base = IA.IATTRIBUTE_BASE_DEFENCE_P},
    attrib_hit =  { point = IA.IATTRIBUTE_HIT, base = IA.IATTRIBUTE_BASE_HIT },
    attrib_miss =  { point = IA.IATTRIBUTE_MISS, base = IA.IATTRIBUTE_BASE_MISS },
    mind_attack = { point = IA.IATTRIBUTE_2ATTACK_RATE },
    mind_defend = { point = IA.IATTRIBUTE_2ATTACK_DEFENCE },

    att_cold  = { point = IA.IATTRIBUTE_COLD_ATTACK },
    att_fire  = { point = IA.IATTRIBUTE_FIRE_ATTACK },
    att_light = { point = IA.IATTRIBUTE_LIGHT_ATTACK },
    att_poison  = { point = IA.IATTRIBUTE_POISON_ATTACK },

    att_def_cold  = { point = IA.IATTRIBUTE_COLD_RESIST },
    att_def_fire  = { point = IA.IATTRIBUTE_FIRE_RESIST },
    att_def_light = { point = IA.IATTRIBUTE_LIGHT_RESIST },
    att_def_poison  = { point = IA.IATTRIBUTE_POISON_RESIST },

    reduce_def_cold = { point = IA.IATTRIBUTE_REDUCE_TARGET_COLD_RESIST },
    reduce_def_fire = { point = IA.IATTRIBUTE_REDUCE_TARGET_FIRE_RESIST },
    reduce_def_light = { point = IA.IATTRIBUTE_REDUCE_TARGET_LIGHT_RESIST },
    reduce_def_poison = { point = IA.IATTRIBUTE_REDUCE_TARGET_POISON_RESIST },
}

local perception_table = {
    str_perception = true,
    spr_perception = true,
    con_perception = true,
    dex_perception = true,
    int_perception = true,
}

local attrib_influences = {
    str = { attrib_att_physics = true},
    spr = { attrib_att_magic = true},
    con = { hp_max = true, attrib_def_physics = true},
    int = { mp_max = true, attrib_def_magic = true},
    dex = { attrib_hit = true, attrib_miss = true, mind_attack = true, mind_defend = true},

    str_perception = { attrib_att_physics = true},
    con_perception = { hp_max = true, attrib_def_physics = true},
    dex_perception = { attrib_hit = true, attrib_miss = true, mind_attack = true, mind_defend = true},
    spr_perception = { attrib_att_magic = true},
    int_perception = { mp_max = true, attrib_def_magic = true},

    move_mode = { speed = true },
    lingxing = { str_perception = true, con_perception = true, dex_perception = true, spr_perception = true, int_perception = true,
        soul_add_str_perception = true, soul_add_spr_perception = true, soul_add_con_perception = true, soul_add_dex_perception = true, 
        soul_add_int_perception = true,
    },
    wuxing = { str_perception = true, con_perception = true, dex_perception = true, spr_perception = true, int_perception = true,
        soul_add_str_perception = true, soul_add_spr_perception = true, soul_add_con_perception = true, soul_add_dex_perception = true, 
        soul_add_int_perception = true
    }
}

local base_attribs = {
    name = true,
    title = true,
    model = true,
    -- face_style = true,
    -- hair_style = true,
    pet_soul_item_index = true,
    model_id = true,
    level = true,
    owner_id = true,
    -- team_id = true,
    -- menpai = true,
    speed = true,
    rage = true,
    stealth_level = true,
    is_sit = true,
    hp = true,
    mp = true,
    hp_max = true,
    mp_max = true,
    current_title = true,
}

local detail_attribs = {
    guid = true,
    spouse_guid = true,
    data_id = true,
    name = true,
    ai_type = true,
    attack_type = true,
    level = true,
    exp = true,
    hp = true,
    hp_max = true,
    life_span = true,
    generation = true,
    happiness = true,
    wuxing = true,
    lingxing = true,
    gengu = true,
    growth_rate = true,
    growth_rate_queryd = true,

    str_perception = true,
    con_perception = true,
    dex_perception = true,
    spr_perception = true,
    int_perception = true,
    main_perception = true,

    soul_add_str_perception = true,
    soul_add_con_perception = true,
    soul_add_dex_perception = true,
    soul_add_spr_perception = true,
    soul_add_int_perception = true,

    attrib_att_magic = true,
    attrib_att_physics = true,
    attrib_def_magic = true,
    attrib_def_physics = true,
    attrib_hit = true,
    attrib_miss = true,
    point_remain = true,
    mind_attack = true,
    mind_defend = true,
    att_cold = true,
    def_cold = true,
    reduce_def_cold = true,
    att_fire = true,
    def_fire = true,
    reduce_def_fire = true,
    att_light = true,
    def_light = true,
    reduce_def_light = true,
    att_poison = true,
    def_poison = true,
    reduce_def_poison = true,
    speed = true,
    str = true,
    spr = true,
    con = true,
    int = true,
    dex = true,
    hp_re_speed = true,
    mp_re_speed = true,
    used_procreate_count = true,
    current_title = true
}

local db_attribs = {
    data_id = true,
    wuxing = true,
    growth_rate = true,
    attack_type = true,
    camp_id = true,
    str_perception = true,
    con_perception = true,
    dex_perception = true,
    spr_perception = true,
    int_perception = true,

    stealth_level = true,
    attack_speed = true,
    can_action_1 = true,
    can_action_2 = true,
    can_move = true,
    unbreakable = true,
    can_ignore_disturb = true,
    detect_level = true,
    used_procreate_count = true,
    current_title = true,
}

local db_save_attribs = {
    name = true,
    title = true,
    data_id = true,
    guid = true,
    spouse_guid = true,
    owner_id = true,
    level = true,
    hp = true,
    exp = true,
    ai_type = true,
    attack_type = true,
    wuxing = true,
    lingxing = true,
    gengu = true,
    growth_rate = true,
    happiness = true,
    life_span = true,
    take_level = true,
    type = true,

    str_perception = true,
    con_perception = true,
    dex_perception = true,
    spr_perception = true,
    int_perception = true,

    world_pos = true,
    sceneid = true,
    reputation =true,
    speed = true,
    move_mode = true,
    propagate_level = true,
    growth_rate_queryd = true,
    used_procreate_count = true,
}

local not_gen_attribs = {
    pet_soul_item_index = true,
}

local pet_attr_influnce = {
    hp_max = {
        init = "BaseHP",
        con =  { pram = "Con_HP_Pram", perception = "con_perception" },
        level = { pram = "Level_HP_Pram"},
    },
    attrib_att_physics = {
        init = "BasePhyAttack",
        str = { pram = "Str_PhyAttack_Pram", perception = "str_perception" },
        level = { pram = "Level_PhyAttack_Pram"},
    },
    attrib_att_magic = {
        init = "BaseMgcAttack",
        spr = { pram = "Spr_MgcAttack_Pram", perception = "spr_perception" },
        level = { pram = "Level_MgcAttack_Pram"},
    },
    attrib_def_physics = {
        init = "BasePhyDefence",
        con = { pram = "Con_PhyDefence_Pram", perception = "con_perception" },
        level = { pram = "Level_PhyDefence_Pram"},
    },
    attrib_def_magic = {
        init = "BaseMgcDefence",
        int = { pram = "Int_MgcDefence_Pram", perception = "int_perception" },
        level = { pram = "Level_MgcDefence_Pram"},
    },
    attrib_hit = {
        init = "BaseHit",
        dex = { pram = "Dex_Hit_Pram", perception = "dex_perception" },
        level = { pram = "Level_Hit_Pram"},
    },
    attrib_miss = {
        init = "BaseMiss",
        dex = { pram = "Dex_Miss_Pram", perception = "dex_perception" },
        level = { pram = "Level_Miss_Pram"},
    },
    mind_attack = {
        init = "BaseCriticalAttack",
        dex = { pram = "Dex_CriticalAttack_Pram", perception = "dex_perception" },
        level = { pram = "Level_CriticalAttack_Pram"},
    },
    mind_defend = {
        init = "BaseCriticalDefence",
        dex = { pram = "Dex_CriticalDefence_Pram", perception = "dex_perception" },
        level = { pram = "Level_CriticalDefence_Pram"},
    },
}

local wuxing_bonus = {
    10,
    15,
    21,
    30,
    80,
    110,
    145,
    235,
    300,
    393
}

local lingxing_bonus = {
    [1] = { 10, 20, 40, 70, 110, 140, 180, 220, 260, 310},
    [2] = { 10, 30, 50, 70, 120, 150, 200, 240, 280, 340},
}

local refix_by_other = {
    hp = function(self, value)
        local hp_max = self:get_attrib("hp_max")
        --print("hp_max =", hp_max, ";value =", value)
        if hp_max < value then
            value = hp_max
        end
        self:set_db_attrib( { hp = value} )
        return value
    end,
    speed = function(self, value)
        local move_mode = self:get_attrib("move_mode")
        --print("move_mode =", move_mode, ";value =", value)
        if move_mode == define.ENUM_MOVE_MODE.MOVE_MODE_RUN then
            value = value * 1.5
        elseif move_mode == define.ENUM_MOVE_MODE.MOVE_MODE_SPRINT then
            value = value * 5
        end
        return value
    end,
    soul_add_str_perception = function(self)
        local str_perception = self:get_attrib("str_perception")
        local ie = self:get_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_STR_PERCEPTION)
        local orgin = math.ceil(str_perception / (1 + ie / 100))
        return str_perception - orgin
    end,
    soul_add_spr_perception = function(self)
        local spr_perception = self:get_attrib("spr_perception")
        local ie = self:get_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_SPR_PERCEPTION)
        local orgin = math.ceil(spr_perception / (1 + ie / 100))
        return spr_perception - orgin
    end,
    soul_add_con_perception = function(self)
        local con_perception = self:get_attrib("con_perception")
        local ie = self:get_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_CON_PERCEPTION)
        local orgin = math.ceil(con_perception / (1 + ie / 100))
        return con_perception - orgin
    end,
    soul_add_dex_perception = function(self)
        local dex_perception = self:get_attrib("dex_perception")
        local ie = self:get_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_DEX_PERCEPTION)
        local orgin = math.ceil(dex_perception / (1 + ie / 100))
        return dex_perception - orgin
    end,
    soul_add_int_perception = function(self)
        local int_perception = self:get_attrib("int_perception")
        local ie = self:get_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_INT_PERCEPTION)
        local orgin = math.ceil(int_perception / (1 + ie / 100))
        return int_perception - orgin
    end,
    main_perception = function(self)
        local wuxing = self:get_db_attrib("wuxing")
        local w_bonus = wuxing_bonus[wuxing] or 0
        local main_str_perception = math.ceil(self:get_db_attrib("str_perception") * (1 + w_bonus / 1000))
        local main_spr_perception = math.ceil(self:get_db_attrib("spr_perception") * (1 + w_bonus / 1000))
        local main_con_perception = math.ceil(self:get_db_attrib("con_perception") * (1 + w_bonus / 1000))
        local main_dex_perception = math.ceil(self:get_db_attrib("dex_perception") * (1 + w_bonus / 1000))
        local main_int_perception = math.ceil(self:get_db_attrib("int_perception") * (1 + w_bonus / 1000))
        local perceptions = { main_str_perception, main_spr_perception, main_con_perception, main_dex_perception, main_int_perception }
        table.sort(perceptions, function(p1, p2) return p1 > p2 end)
        return perceptions[1]
    end
}

function pet_attrib:ctor(lv1, db)
    db.can_move = 1
    db.can_action_1 = 1
    db.can_action_2 = 1
    db.unbreakable = 0
    db.used_procreate_count = db.used_procreate_count or 0
    self.db_attribs = db
    self.lv1_attribs = lv1
    self.attribs = {}
    self.attribs_refix = {}
    self.dirty_flags = {}
    self.refix_dirty_flags = {}
    self.item_effect = {}
    self.dirty_datas = {}
    self.not_gen_attribs = {}
    self:mark_all_attr_dirty()
end

function pet_attrib:mark_all_attr_dirty()
    for key in pairs(detail_attribs) do
        self.dirty_flags[key] = true
    end
    for key in pairs(base_attribs) do
        self.dirty_flags[key] = true
    end
end

function pet_attrib:mark_attrib_dirty(key)
    self.dirty_flags[key] = true
    local influence = attrib_influences[key]
    if influence then
        for skey in pairs(influence) do
            self:mark_attrib_dirty(skey)
        end
    end
end

function pet_attrib:get_dirty_flags (key)
    return self.dirty_flags[key] ~= nil or self.refix_dirty_flags[key] ~= nil
end

function pet_attrib:clear_dirty_flags(key)
    self.dirty_flags[key] = nil
end

function pet_attrib:mark_all_data_dirty_flag()
    for key in pairs(detail_attribs) do
        self.dirty_datas[key] = true
    end
    for key in pairs(base_attribs) do
        self.dirty_datas[key] = true
    end
end

function pet_attrib:mark_data_dirty_flag(key)
    --print("pet_attrib:mark_data_dirty =", key)
    self.dirty_datas[key] = true
end

function pet_attrib:get_dirty_datas_flag(key)
    return self.dirty_datas[key]
end

function pet_attrib:clear_data_dirty_flag(key)
    --print("pet_attrib:clear_data_dirty_flag =", key)
    self.dirty_datas[key] = nil
end


function pet_attrib:get_item_effect(shift)
    return self.item_effect[shift] or 0
end

function pet_attrib:cal_item_effect(ia, iv, equip_point, item_type)
    if ia == IA.IATTRIBUTE_BASE_ATTACK_P or ia == IA.IATTRIBUTE_BASE_ATTACK_M or ia == IA.IATTRIBUTE_BASE_DEFENCE_P or ia == IA.IATTRIBUTE_BASE_DEFENCE_M then
        self.item_effect[ia] = (self.item_effect[ia] or 0) + iv
    elseif ia == IA.IATTRIBUTE_ALL then
        self.item_effect[IA.IATTRIBUTE_STR] = (self.item_effect[IA.IATTRIBUTE_STR] or 0) + iv
        self.item_effect[IA.IATTRIBUTE_SPR] = (self.item_effect[IA.IATTRIBUTE_SPR] or 0) + iv
        self.item_effect[IA.IATTRIBUTE_CON] = (self.item_effect[IA.IATTRIBUTE_CON] or 0) + iv
        self.item_effect[IA.IATTRIBUTE_INT] = (self.item_effect[IA.IATTRIBUTE_INT] or 0) + iv
        self.item_effect[IA.IATTRIBUTE_DEX] = (self.item_effect[IA.IATTRIBUTE_DEX] or 0) + iv
    elseif ia == IA.IATTRIBUTE_POINT_ATTACK_P_ATTACK_M then
        self.item_effect[IA.IATTRIBUTE_ATTACK_P] = (self.item_effect[IA.IATTRIBUTE_ATTACK_P] or 0) + iv
        self.item_effect[IA.IATTRIBUTE_ATTACK_M] = (self.item_effect[IA.IATTRIBUTE_ATTACK_M] or 0) + iv
    else
        self.item_effect[ia] = (self.item_effect[ia] or 0) + iv
    end
end

function pet_attrib:item_effect_flush()
    self.item_effect = {}
    self.pet_soul_skill = define.INVAILD_ID
    local container = self:get_pet():get_equip_container()
    local equip_base = configenginer:get_config("pet_equip_base")
    local equip_sets = {}
    for i = define.PET_EQUIP.PEQUIP_CAP, define.PET_EQUIP.PEQUIP_AMULET do
        local equip = container:get_item(i)
        if equip then
            local raw_data = equip:copy_raw_data()
            local item_type = equip:get_serial_type()
            for j = 1, raw_data.attr_count do
                local ef = raw_data.attr_types[j]
                local ev = raw_data.attr_values[j]
                self:cal_item_effect(ef, ev, i, item_type)
            end
            local base = equip_base[equip:get_index()]
            for chn, ia in pairs(define.EQUIP_BASE_ATTRIB) do
                local iv = base.base_attrs[chn]
                if iv and iv ~= define.INVAILD_ID then
                    assert(iv, chn)
                    self:cal_item_effect(ia, iv, i, item_type)
                end
            end
            local base_config = equip:get_base_config()
            local set_id = base_config.set_id
            if set_id ~= define.INVAILD_ID then
                equip_sets[set_id] = (equip_sets[set_id] or 0) + 1
            end
        end
    end
    local pet_equip_set_attr = configenginer:get_config("pet_equip_set_attr")
    for set_id, count in pairs(equip_sets) do
        local set = pet_equip_set_attr[set_id]
        if set then
            for i = 1, count do
                local ia = set.IAS[i]
                if ia ~= define.INVAILD_ID then
                    self:cal_item_effect(ia.IA, ia.IV)
                end
            end
        end
    end
    local pet_soul = container:get_item(define.PET_EQUIP.PEQUIP_SOUL)
    local pet_soul_item_index = pet_soul and pet_soul:get_index() or define.INVAILD_ID
    self:set_not_gen_attrib({ pet_soul_item_index = pet_soul_item_index })
    if pet_soul then
        local raw_data = pet_soul:copy_raw_data()
        local item_index = raw_data.item_index
        local soul_level = raw_data.level
        local pet_soul_level_up_info = configenginer:get_config("pet_soul_level_up_info")
        local config = pet_soul_level_up_info[item_index][soul_level]

        self:cal_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_STR_PERCEPTION, config.add_str_perception / 100)
        self:cal_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_SPR_PERCEPTION, config.add_spr_perception / 100)
        self:cal_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_CON_PERCEPTION, config.add_con_perception / 100)
        self:cal_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_DEX_PERCEPTION, config.add_dex_perception / 100)
        self:cal_item_effect(define.ITEM_ATTRIBUTE.IATTRIBUTE_RATE_INT_PERCEPTION, config.add_int_perception / 100)

        local pet_soul_attrs = raw_data.pet_soul_attr
        soul_level = soul_level > 6 and 6 or soul_level
        for i = 1, soul_level do
            local attr = pet_soul_attrs[i]
            local type = attr.type
            local value = attr.value
            if type ~= define.INVAILD_ID then
                local ia = define.PET_SOUL_EXTENSION_2_IA[type]
                assert(ia, type)
                self:cal_item_effect(ia, value)
            end
        end

        local level = pet_soul:get_pet_equip_data():get_pet_soul_level() + 1
        local base = pet_soul:get_pet_soul_base()
        local skill = base.skill
        local pet_soul_skill = configenginer:get_config("pet_soul_skill")
        local skill_conf = pet_soul_skill[skill]
        local skill_id = skill_conf.fight_skills[level]
        self.pet_soul_skill = skill_id
    end
    self:mark_all_attr_dirty()
end

function pet_attrib:get_pet_soul_skill()
    return self.pet_soul_skill
end

function pet_attrib:item_std_impact_effect()
    local ia = define.ITEM_ATTRIBUTE.IATTRIBUTE_PET_EQUIP_SET_STD_IMPACT
    local iv = self:get_item_effect(ia)
    --print("pet_attrib:item_std_impact_effect", ia, iv)
    if iv and iv ~= 0 then
        local pet = self:get_pet()
        impactenginer:send_impact_to_unit(pet, iv, pet, 0, false, 0)
    end
end

function pet_attrib:get_lv1_attrib()
    return self.lv1_attribs
end

function pet_attrib:get_base_attrib(key)
    if lv1_attribs[key] then
        return self.lv1_attribs[key]
    elseif not_gen_attribs[key] and self.not_gen_attribs[key] ~= nil then
        return self.not_gen_attribs[key]
    elseif db_save_attribs[key] then
        return self.db_attribs[key]
    elseif db_attribs[key] then
        return self.db_attribs[key]
    elseif key == "model_id" then
        return define.INVAILD_ID
    elseif key == "ride_model" then
        return define.INVAILD_ID
    else
        local base = 0
        local influence = pet_attr_influnce[key]
        local pet_config_table = configenginer:get_config("pet_config_table")
        if influence then
            local init_key = influence.init
            local init_value = pet_config_table.System[init_key]
            for k, value in pairs(pet_attr_influnce[key] or {}) do
                if k == "init" then
                    base = base + init_value
                elseif k == "level" then
                    local influce_key = value.pram
                    local influce_value = pet_config_table.System[influce_key]
                    local level = self:get_attrib("level")
                    local growth_rate = self:get_attrib("growth_rate")
                    base = base + math.ceil(level * growth_rate * 1000 * influce_value / 1000000)
                else
                    local influce_key = value.pram
                    local perception = value.perception
                    local influce_value = pet_config_table.System[influce_key]
                    local attrib_value = self:get_attrib(k)
                    local perception_value = self:get_attrib(perception)
                    base = base + math.ceil(attrib_value * perception_value * influce_value / 100 / 10000)
                end
            end
            if must_be_positive[key] then
                assert(base >= 0)
            end
        end
        return base
    end
end

function pet_attrib:set_attrib_refix(key, value)
    self.attribs_refix[key] = value
end

function pet_attrib:get_exist_attrib_refix(key)
    return self.attribs_refix[key]
end

function pet_attrib:get_attrib_refix_dirty(key)
    return self.refix_dirty_flags[key]
end

function pet_attrib:clear_attrib_refix_dirty(key)
    self.refix_dirty_flags[key] = nil
end

function pet_attrib:mark_attrib_refix_dirty(key)
    self.refix_dirty_flags[key] = true
    local influence = attrib_influences[key]
    if influence then
        for skey in pairs(influence) do
            self:mark_attrib_refix_dirty(skey)
        end
    end
end

function pet_attrib:imp_get_attrib_refix(key)
    local value = {}
    local pet = self:get_pet()
    local impacts = pet:get_impact_list()
    for _, imp in ipairs(impacts) do
        local logic = impactenginer:get_logic(imp)
        if logic then
            logic:get_refix(imp, key, value, pet)
        end
    end
    return value
end

function pet_attrib:get_attrib_refix(key)
    if self:get_attrib_refix_dirty(key) then
        local value = self:imp_get_attrib_refix(key)
        self:set_attrib_refix(key, value)
        self:clear_attrib_refix_dirty(key)
    end
    return self:get_exist_attrib_refix(key)
end

function pet_attrib:get_attrib(key)
    ----print("pet_attrib:get_attrib(key)", key)
    if self:get_dirty_flags(key) then
        local value
        local base = self:get_base_attrib(key)
        value = base
        if type(base) == "number" then
            if perception_table[key] then
                local lingxing = self:get_db_attrib("lingxing")
                local wuxing = self:get_db_attrib("wuxing")
                lingxing = lingxing % 100
                local l_bonus = lingxing_bonus[2][lingxing] or 0
                local w_bonus = wuxing_bonus[wuxing] or 0
                base = math.ceil(base * (1 + w_bonus / 1000) * (1 + l_bonus / 1000))
            end
            local item_point_base = 0
            local item_point_refix = 0
            local item_rate_refix = 0
            local impact_skill_refix
            local ie_shfit = item_effct_shift[key]
            if ie_shfit and ie_shfit.base then
                local ie = self:get_item_effect(ie_shfit.base)
                if ie then
                    item_point_base = ie
                end
            end
            if ie_shfit and ie_shfit.point then
                local ie = self:get_item_effect(ie_shfit.point)
                if ie then
                    item_point_refix = ie
                end
            end
            if ie_shfit and ie_shfit.rate then
                local ie = self:get_item_effect(ie_shfit.rate)
                if ie then
                    item_rate_refix = math.ceil(base * (ie / 100))
                end
            end
            impact_skill_refix = self:get_attrib_refix(key)
            if impact_skill_refix and impact_skill_refix.rate then
                base = math.ceil(base * (100 + impact_skill_refix.rate) / 100)
            end
            if impact_skill_refix and impact_skill_refix.point then
                impact_skill_refix.point = impact_skill_refix.point
                base = base + impact_skill_refix.point
            end
            if impact_skill_refix and impact_skill_refix.replace then
                value = impact_skill_refix.replace
            else
                value = base + item_point_base + item_point_refix + item_rate_refix
            end
        end
        if refix_by_other[key] then
            value = refix_by_other[key](self, value)
        end
        if must_be_positive[key] and value < 0 then
            value = 0
        end
        self:set_attrib({[key] = value})
        self:clear_dirty_flags(key)
    end
    return self:get_exist_attrib(key)
end

function pet_attrib:get_exist_attrib(key)
    local value = self.attribs[key] or self.db_attribs[key]
    return value
end

function pet_attrib:set_attrib(set_list)
    for key, value in pairs(set_list) do
        local old = self:get_exist_attrib(key)
        if old ~= value or self.attribs[key] == nil then
            self:mark_data_dirty_flag(key)
        end
        self.attribs[key] = value
        if base_attribs[key] and self.base_attribs then
            self.base_attribs[key] = value
        end
        if detail_attribs[key] and self.detail_attribs then
            self.detail_attribs[key] = value
        end
    end
end

function pet_attrib:get_base_attribs()
    if self.base_attribs == nil then
        self.base_attribs = self:full_get_base_attribs()
    end
    return self.base_attribs
end

function pet_attrib:full_get_base_attribs()
    local ret = {}
    for key in pairs(base_attribs) do
        ret[key] = self:get_attrib(key)
    end
    return ret
end

function pet_attrib:get_detail_attribs()
    if self.detail_attribs == nil then
        self.detail_attribs = self:full_get_detail_attribs()
    end
    return self.detail_attribs
end

function pet_attrib:full_get_detail_attribs()
    local ret = {}
    for key in pairs(detail_attribs) do
        ret[key] = self:get_attrib(key)
    end
    return ret
end

function pet_attrib:get_db_attrib(key)
    return self.db_attribs[key]
end

function pet_attrib:get_db_save_attrib()
    return self.db_attribs
end

function pet_attrib:set_pet(pet)
    self.pet = pet
end

function pet_attrib:get_pet()
    return self.pet
end

function pet_attrib:set_lv1_attrib(set_list)
    for key, value in pairs(set_list) do
        self:mark_attrib_dirty(key)
        self.lv1_attribs[key] = value
    end
end

function pet_attrib:set_db_attrib(set_list)
    for key, value in pairs(set_list) do
        self:mark_attrib_dirty(key)
        local old = self:get_exist_attrib(key)
        if old ~= value then
            self:mark_data_dirty_flag(key)
        end
        self.db_attribs[key] = value
    end
end

function pet_attrib:set_not_gen_attrib(set_list)
    for key, value in pairs(set_list) do
        self:mark_attrib_dirty(key)
        local old = self:get_exist_attrib(key)
        if old ~= value then
            self:mark_data_dirty_flag(key)
        end
        self.not_gen_attribs[key] = value
    end
end

function pet_attrib:refresh_dirty_attribs()
    local dirty_flags = {}
    for key in pairs(self.dirty_flags) do
        dirty_flags[key] = true
    end
    for key in pairs(self.refix_dirty_flags) do
        dirty_flags[key] = true
    end
    for key in pairs(dirty_flags) do
        self:get_attrib(key)
    end
end

function pet_attrib:mark_skill_dirty()
    self.skill_dirty = true
end

function pet_attrib:get_skill_dirty()
    return self.skill_dirty
end

function pet_attrib:clear_skill_dirty()
    self.skill_dirty = false
end

function pet_attrib:send_refresh_attrib(who, send_all, skills, type)
 -- local skynet = require "skynet"
	-- skynet.logi("send_refresh_attrib",who,send_all,skills,type)
    --print("pet_attrib:send_refresh_attrib =", send_all, skills, type)
    if send_all then
        self:mark_all_attr_dirty()
        self:mark_skill_dirty()
        self:mark_all_data_dirty_flag()
    else
        self:refresh_dirty_attribs()
    end
    local send_refresh_base_attrib = false
    local send_refresh_detail_attrib = false
    local refresh_base_attrib
    local refresh_detail_attrib
    if next(self.dirty_datas) then
        refresh_base_attrib = packet_def.GCCharBaseAttrib.new()
        refresh_detail_attrib = packet_def.GCDetailAttrib_Pet.new()
        refresh_detail_attrib.guid = self:get_attrib("guid")
        refresh_detail_attrib.m_nTradeIndex = 0
        for key in pairs(self.dirty_datas) do
            local fn = string.format("set_%s", key)
            local f
            f = refresh_base_attrib[fn]
            if f then
                f(refresh_base_attrib, self:get_attrib(key))
                send_refresh_base_attrib = true
            end
            if self.dirty_datas.hp or self.dirty_datas.hp_max then
                local hp_percent = math.ceil(self:get_attrib("hp") / self:get_attrib("hp_max") * 100)
                refresh_base_attrib:set_hp_percent(hp_percent)
            end
            if self.dirty_datas.mp or self.dirty_datas.mp_max then
                local mp_percent = 0
                refresh_base_attrib:set_mp_percent(mp_percent)
            end
            f = refresh_detail_attrib[fn]
            if f then
                f(refresh_detail_attrib, self:get_attrib(key))
                send_refresh_detail_attrib = true
            end
            if self.dirty_datas.growth_rate or self.dirty_datas.growth_rate_queryd then
                if not self:get_attrib("growth_rate_queryd") then
                    refresh_detail_attrib:set_growth_rate(-1)
                end
            end
            if self.dirty_datas.stealth_level then
                self:get_pet():stealth_level_update()
            end
            self:clear_data_dirty_flag(key)
        end
    end
    local pet = self:get_pet()
    if send_refresh_detail_attrib and send_all then
        local equips = pet:get_equips()
        local empty_equip = Item_cls.new()
        refresh_detail_attrib:set_equip_1(equips[0] or empty_equip)
        refresh_detail_attrib:set_equip_2(equips[1] or empty_equip)
        refresh_detail_attrib:set_equip_3(equips[2] or empty_equip)
        refresh_detail_attrib:set_equip_4(equips[3] or empty_equip)
        refresh_detail_attrib:set_equip_5(equips[4] or empty_equip)
        refresh_detail_attrib:set_equip_6(equips[5] or empty_equip)
    end
    if send_refresh_detail_attrib and self:get_skill_dirty() then
        refresh_detail_attrib:set_activate_skill_1(skills.activate[1])
        refresh_detail_attrib:set_activate_skill_2(skills.activate[2])

        refresh_detail_attrib:set_positive_skill_1(skills.positive[1])
        refresh_detail_attrib:set_positive_skill_2(skills.positive[2])
        refresh_detail_attrib:set_positive_skill_3(skills.positive[3])
        refresh_detail_attrib:set_positive_skill_4(skills.positive[4])
        refresh_detail_attrib:set_positive_skill_5(skills.positive[5])
        refresh_detail_attrib:set_positive_skill_6(skills.positive[6])
        refresh_detail_attrib:set_positive_skill_7(skills.positive[7])
        refresh_detail_attrib:set_positive_skill_8(skills.positive[8])
        refresh_detail_attrib:set_positive_skill_9(skills.positive[9])
        refresh_detail_attrib:set_positive_skill_10(skills.positive[10])
        refresh_detail_attrib:set_positive_skill_11(skills.positive[11])

        self:clear_skill_dirty()
    end
    local creator = pet:get_creator()
    if creator then
        who = who or creator
    end
    if who then
        if pet:get_scene() then
            if send_refresh_base_attrib then
                local data_id = pet:inc_data_id()
                refresh_base_attrib:set_data_id(data_id)
                refresh_base_attrib:set_owner_id(self.pet:get_owner_obj_id())
                refresh_base_attrib:set_guid(define.INVAILD_ID)
                refresh_base_attrib:set_model(self:get_attrib("data_id"))
                refresh_base_attrib.m_objID = pet:get_obj_id()
                pet:get_scene():broadcast(pet, refresh_base_attrib, true)
            end
        end
        if send_refresh_detail_attrib then
            refresh_detail_attrib:set_obj_id(pet:get_obj_id())
            refresh_detail_attrib:set_unknow_2(-1)
            refresh_detail_attrib:set_unknow_5(2)
            refresh_detail_attrib:set_unknow_6(type == nil and 0 or 1)
            refresh_detail_attrib:set_unknow_7({ type })
            local titles = pet:get_titles()
            refresh_detail_attrib:set_titles(titles)
            refresh_detail_attrib:set_current_title(self:get_attrib("current_title"))
            refresh_detail_attrib:set_unknow_10(0)
            refresh_detail_attrib:set_unknow_11(2569)
            refresh_detail_attrib:set_unknow_13(0)
            who:get_scene():send2client(who, refresh_detail_attrib)
        end
    end
end

function pet_attrib:get_chuanci()
	return 0
end

function pet_attrib:get_fangchuan()
	return 0
end


return pet_attrib
