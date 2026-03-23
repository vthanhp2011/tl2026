local class = require "class"
local define = require "define"
local configs = require "scene.configs"
local configenginer = require "configenginer":getinstance()
local damage_impact_logic = require "scene.skill.impact_logic.std_impact_003"
local enum_damage_type = damage_impact_logic.enum_DAMAGE_TYPE
local combat_core = class("combat_core")
combat_core.enum_DamageSEID = {
    DAMAGE_SPECIAL_EFFECT_PHYSICAL=0,
    DAMAGE_SPECIAL_EFFECT_MAGIC=1,
    DAMAGE_SPECIAL_EFFECT_COLD=2,
    DAMAGE_SPECIAL_EFFECT_FIRE=3,
    DAMAGE_SPECIAL_EFFECT_LIGHT=4,
    DAMAGE_SPECIAL_EFFECT_POISON=5
}

function combat_core:ctor()
    self:reset()
end

function combat_core:reset()
    self.additional_attac_physics = 0
    self.additional_attack_magic = 0
    self.additional_attack_cold = 0
    self.additional_attack_fire = 0
    self.additional_attack_light = 0
    self.additional_attack_poison = 0
    self.additional_defence_physics = 0
    self.additional_defence_magic = 0
    self.additional_defence_cold = 0
    self.additional_defence_fire = 0
    self.additional_defence_light = 0
    self.additional_defence_poison = 0
    self.additional_attack_direct = 0
end

function combat_core:set_additional_defence_physics(additional_defence_physics)
    self.additional_defence_physics = additional_defence_physics
end

function combat_core:set_additional_defence_magic(additional_defence_magic)
    self.additional_defence_magic = additional_defence_magic
end

function combat_core:set_additional_attack_magic(additional_attack_magic)
    self.additional_attack_magic = additional_attack_magic
end

function combat_core:get_additional_attack_magic()
    return self.additional_attack_magic
end

function combat_core:calculate_hit_rate(hit, miss)
	if hit == 0 and miss == 0 then
		return 0.5
	end
    return hit / (hit + miss)
end

function combat_core:calculate_critical_rate(mind_attack, mind_defend)
	if not mind_defend or mind_defend == 0 then
		mind_defend = 1
	end
    return mind_attack / (mind_defend * 20)
    -- return mind_attack / (mind_defend + mind_attack)
end

function combat_core:is_hit(accuracy, rand)
    return  rand < accuracy * 100
end
function combat_core:is_critical_hit(critical_rate, rand)
	if critical_rate >= 1 then
		return true
	end
    return rand <= critical_rate * 100
end

function combat_core:get_result_impact(attacker, defencer, imp)
    if not attacker then
        return
    end
    if imp then
        attacker:on_impact_get_combat_result(imp, self, defencer)
    end
    local damage
    local max_damage
    local specific_effect_id
    local logic = damage_impact_logic.new()
    local attck_traits = configenginer:get_config("attck_traits")
    local atype = attacker:get_attack_traits_type()
    local traits = attck_traits[atype]
    self.additional_attac_physics = self.additional_attac_physics + logic:get_attack_phy(imp)
    self.additional_attack_magic  = self.additional_attack_magic + logic:get_attack_magic(imp)
    self.additional_attack_cold	  = self.additional_attack_cold + logic:get_attack_cold(imp)
    self.additional_attack_fire	  = self.additional_attack_fire + logic:get_attack_fire(imp)
    self.additional_attack_light  = self.additional_attack_light + logic:get_attack_light(imp)
    self.additional_attack_poison = self.additional_attack_poison + logic:get_attack_posion(imp)
    self.additional_attack_direct = self.additional_attack_direct + logic:get_attack_direct(imp)
    local fluctuation = configs:get_fluctuation()
    if attacker:get_obj_type() == "human" then
        local menpai = attacker:get_menpai()
        fluctuation = configs:get_menpai_fluctuation(menpai)
		if atype >= 10 then
			atype = atype + 4
			traits = attck_traits[atype]
		end
    end
    local rand = 50
    rand = rand - math.random(100)
    fluctuation = 2 * fluctuation * rand / 100
    damage = self:physical_damage(attacker, defencer, self.additional_attac_physics, self.additional_defence_physics, traits)
    damage = damage + damage * fluctuation / 100
    logic:set_damage_phy(imp, damage)
    max_damage = damage
    specific_effect_id = self.enum_DamageSEID.DAMAGE_SPECIAL_EFFECT_PHYSICAL;

    damage = self:magic_damage(attacker, defencer, self.additional_attack_magic, self.additional_defence_magic, traits)
    damage	= damage + damage * fluctuation / 100
    logic:set_damage_magic(imp, damage)
    if damage > max_damage then
        max_damage = damage
        specific_effect_id = self.enum_DamageSEID.DAMAGE_SPECIAL_EFFECT_MAGIC;
    end

    damage = self:cold_damage(attacker, defencer, self.additional_attack_cold, self.additional_defence_cold, traits)
    damage = damage + damage * fluctuation / 100
    logic:set_damage_cold(imp, damage)
    if damage > max_damage then
        max_damage = damage
        specific_effect_id = self.enum_DamageSEID.DAMAGE_SPECIAL_EFFECT_COLD;
    end

    damage = self:fire_damage(attacker, defencer, self.additional_attack_fire, self.additional_defence_fire, traits)
    damage = damage + damage * fluctuation / 100
    logic:set_damage_fire(imp, damage)
    if damage > max_damage then
        max_damage = damage
        specific_effect_id = self.enum_DamageSEID.DAMAGE_SPECIAL_EFFECT_FIRE;
    end

    damage = self:light_damage(attacker, defencer, self.additional_attack_light, self.additional_defence_light, traits)
    damage = damage + damage * fluctuation / 100
    logic:set_damage_light(imp, damage)
    if damage > max_damage then
        max_damage = damage
        specific_effect_id = self.enum_DamageSEID.DAMAGE_SPECIAL_EFFECT_LIGHT;
    end

    damage = self:posion_damage(attacker, defencer, self.additional_attack_poison, self.additional_defence_poison, traits)
    damage = damage + damage * fluctuation / 100
    logic:set_damage_posion(imp, damage)
    if damage > max_damage then
        specific_effect_id = self.enum_DamageSEID.DAMAGE_SPECIAL_EFFECT_POISON;
    end

    damage = self:direct_damage(attacker, defencer, self.additional_attack_direct)
    damage = damage + damage * fluctuation / 100
    logic:set_damage_direct(imp, damage)
    --imp:set_impact_id(specific_effect_id)
    return imp
end

function combat_core:physical_damage(attacker, defencer, addition_attack, addition_defence, traits)
    local damage
    local attack = attacker:get_attack_physics() + addition_attack
    local defence = defencer:get_defence_physics() + addition_defence
    local ignorerate = 0
    local trait = traits[enum_damage_type.IDX_DAMAGE_PHY]
    if defencer:get_obj_type() == "human" then
        ignorerate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_IMMUNITY_P)
    end
    local skill_info = attacker:get_skill_info()
	if skill_info and skill_info.id then
		local ignore_defence = skill_info:get_is_ignore_defence()
		if ignore_defence then
			defence = 0
		end
	end
    local kfs_wg_attack_rate = 0
    local kfs_wg_defence_rate = 0
    if attacker:get_obj_type() == "human" then
        kfs_wg_attack_rate = attacker:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_ATTACK_PHYSIC_DAMAGE_RATE)
    end
    if defencer:get_obj_type() == "human" then
        kfs_wg_defence_rate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_PHYSIC_DEFENCE_RATE)
    end
    kfs_wg_attack_rate = kfs_wg_attack_rate - kfs_wg_defence_rate
    kfs_wg_attack_rate = kfs_wg_attack_rate < 0 and 0 or kfs_wg_attack_rate
    if attack + defence == 0 then
        damage = 0
    else
        damage = attack * attack / (attack + defence) * trait / 1000000
    end
    ignorerate = ignorerate < 0 and 0 or ignorerate
    ignorerate = ignorerate > 100 and 100 or ignorerate
    damage = damage - damage * ignorerate / 100
    damage = damage * (10000 + kfs_wg_attack_rate) / 10000
    damage = damage < 0 and 0 or damage
    return damage
end

function combat_core:magic_damage(attacker, defencer, addition_attack, addition_defence, traits)
    local damage
    local attack = attacker:get_attack_magic() + addition_attack
    local defence = defencer:get_defence_magic() + addition_defence
    local ignorerate = 0
    local trait = traits[enum_damage_type.IDX_DAMAGE_MAGIC]
    if defencer:get_obj_type() == "human" then
        ignorerate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_IMMUNITY_P)
    end
    local kfs_wg_attack_rate = 0
    local kfs_wg_defence_rate = 0
    if attacker:get_obj_type() == "human" then
        kfs_wg_attack_rate = attacker:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_ATTACK_MAGIC_DAMAGE_RATE)
    end
    if defencer:get_obj_type() == "human" then
        kfs_wg_defence_rate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_MAGIC_DEFENCE_RATE)
    end
    kfs_wg_attack_rate = kfs_wg_attack_rate - kfs_wg_defence_rate
    kfs_wg_attack_rate = kfs_wg_attack_rate < 0 and 0 or kfs_wg_attack_rate
    if attack + defence == 0 then
        damage = 0
    else
        damage = attack * attack / (attack + defence) * trait / 1000000
    end
    ignorerate = ignorerate < 0 and 0 or ignorerate
    ignorerate = ignorerate > 100 and 100 or ignorerate
    damage = damage - damage * ignorerate / 100
    damage = damage * (10000 + kfs_wg_attack_rate) / 10000
    damage = damage < 0 and 0 or damage
    return damage
end

function combat_core:cold_damage(attacker, defencer, addition_attack, addition_defence, traits)
    local damage
    local attack = attacker:get_attack_cold() + addition_attack
    local reduce_def = attacker:get_reduce_def_cold() + addition_defence
    local reduce_def_low_limit = attacker:get_reduce_def_cold_low_limit()
    local defence = defencer:get_defence_cold()
	if reduce_def > defence then
		local subdef = reduce_def - defence
		local effect_value,feature_rate = attacker:get_dw_jinjie_effect_details(22)
		if effect_value > 0 then
			effect_value = effect_value / feature_rate / 200 * subdef
			reduce_def_low_limit = reduce_def_low_limit + effect_value
			-- attacker:features_effect_notify_client(22)
		end
	end
    local trait = traits[enum_damage_type.IDX_DAMAGE_COLD]
    local resit = defence - reduce_def
    local real_reduce_def_low_limit = (-1 * reduce_def_low_limit + (defence > 0 and 0 or defence))
    resit = resit < real_reduce_def_low_limit and (real_reduce_def_low_limit) or resit
    print("cold_damage resit =", resit, ", defence =", defence)
    local kfs_wg_attack_rate = 0
    local kfs_wg_defence_rate = 0
    if attacker:get_obj_type() == "human" then
        kfs_wg_attack_rate = attacker:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_ATTACK_COLD_DAMAGE_RATE)
    end
    if defencer:get_obj_type() == "human" then
        kfs_wg_defence_rate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_COLD_DEFENCE_RATE)
    end
    kfs_wg_attack_rate = kfs_wg_attack_rate - kfs_wg_defence_rate
    kfs_wg_attack_rate = kfs_wg_attack_rate < 0 and 0 or kfs_wg_attack_rate
    if resit >= 100 then
        damage = 0
    else
        damage = attack * (100 - resit) / 100 * trait / 1000000
    end
    damage = damage * (10000 + kfs_wg_attack_rate) / 10000
    damage = damage < 0 and 0 or damage
    return damage
end

function combat_core:fire_damage(attacker, defencer, addition_attack, addition_defence, traits)
    local damage
    local attack = attacker:get_attack_fire() + addition_attack
    local reduce_def = attacker:get_reduce_def_fire() + addition_defence
    local reduce_def_low_limit = attacker:get_reduce_def_fire_low_limit()
    local defence = defencer:get_defence_fire()
	if reduce_def > defence then
		local subdef = reduce_def - defence
		local effect_value,feature_rate = attacker:get_dw_jinjie_effect_details(23)
		if effect_value > 0 then
			effect_value = effect_value / feature_rate / 200 * subdef
			reduce_def_low_limit = reduce_def_low_limit + effect_value
			-- attacker:features_effect_notify_client(23)
		end
	end
    local trait = traits[enum_damage_type.IDX_DAMAGE_FIRE]
    local resit = defence - reduce_def
    local real_reduce_def_low_limit = (-1 * reduce_def_low_limit + (defence > 0 and 0 or defence))
    resit = resit < real_reduce_def_low_limit and (real_reduce_def_low_limit) or resit
    print("fire_damage resit =", resit, ", defence =", defence)
    if resit >= 100 then
        damage = 0
    else
        damage = attack * (100 - resit) / 100 * trait / 1000000
    end
    local kfs_wg_attack_rate = 0
    local kfs_wg_defence_rate = 0
    if attacker:get_obj_type() == "human" then
        kfs_wg_attack_rate = attacker:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_ATTACK_FIRE_DAMAGE_RATE)
    end
    if defencer:get_obj_type() == "human" then
        kfs_wg_defence_rate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_FIRE_DEFENCE_RATE)
    end
    kfs_wg_attack_rate = kfs_wg_attack_rate - kfs_wg_defence_rate
    kfs_wg_attack_rate = kfs_wg_attack_rate < 0 and 0 or kfs_wg_attack_rate
    damage = damage * (10000 + kfs_wg_attack_rate) / 10000
    damage = damage < 0 and 0 or damage
    return damage
end

function combat_core:light_damage(attacker, defencer, addition_attack, addition_defence, traits)
    local damage
    local attack = attacker:get_attack_light() + addition_attack
    local reduce_def = attacker:get_reduce_def_light() + addition_defence
    local reduce_def_low_limit = attacker:get_reduce_def_light_low_limit()
    local defence = defencer:get_defence_light()
	if reduce_def > defence then
		local subdef = reduce_def - defence
		local effect_value,feature_rate = attacker:get_dw_jinjie_effect_details(24)
		if effect_value > 0 then
			effect_value = effect_value / feature_rate / 200 * subdef
			reduce_def_low_limit = reduce_def_low_limit + effect_value
			-- attacker:features_effect_notify_client(24)
		end
	end
    local trait = traits[enum_damage_type.IDX_DAMAGE_LIGHT]
    local resit = defence - reduce_def
    local real_reduce_def_low_limit = (-1 * reduce_def_low_limit + (defence > 0 and 0 or defence))
    resit = resit < real_reduce_def_low_limit and (real_reduce_def_low_limit) or resit
    print("light_damage resit =", resit, ", defence =", defence)
    if resit >= 100 then
        damage = 0
    else
        damage = attack * (100 - resit) / 100 * trait / 1000000
    end
    local kfs_wg_attack_rate = 0
    local kfs_wg_defence_rate = 0
    if attacker:get_obj_type() == "human" then
        kfs_wg_attack_rate = attacker:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_ATTACK_LIGHT_DAMAGE_RATE)
    end
    if defencer:get_obj_type() == "human" then
        kfs_wg_defence_rate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_LIGHT_DEFENCE_RATE)
    end
    kfs_wg_attack_rate = kfs_wg_attack_rate - kfs_wg_defence_rate
    kfs_wg_attack_rate = kfs_wg_attack_rate < 0 and 0 or kfs_wg_attack_rate
    damage = damage * (10000 + kfs_wg_attack_rate) / 10000
    damage = damage < 0 and 0 or damage
    return damage
end

function combat_core:posion_damage(attacker, defencer, addition_attack, addition_defence, traits)
    local damage
    local attack = attacker:get_attack_posion() + addition_attack
    local reduce_def = attacker:get_reduce_def_posion() + addition_defence
    local reduce_def_low_limit = attacker:get_reduce_def_posion_low_limit()
    local defence = defencer:get_defence_posion()
	if reduce_def > defence then
		local subdef = reduce_def - defence
		local effect_value,feature_rate = attacker:get_dw_jinjie_effect_details(25)
		if effect_value > 0 then
			effect_value = effect_value / feature_rate / 200 * subdef
			reduce_def_low_limit = reduce_def_low_limit + effect_value
			-- attacker:features_effect_notify_client(25)
		end
	end
    local trait = traits[enum_damage_type.IDX_DAMAGE_POISON]
    local resit = defence - reduce_def
    local real_reduce_def_low_limit = (-1 * reduce_def_low_limit + (defence > 0 and 0 or defence))
    resit = resit < real_reduce_def_low_limit and (real_reduce_def_low_limit) or resit
    if resit >= 100 then
        damage = 0
    else
        damage = attack * (100 - resit) / 100 * trait / 1000000
    end
    local kfs_wg_attack_rate = 0
    local kfs_wg_defence_rate = 0
    if attacker:get_obj_type() == "human" then
        kfs_wg_attack_rate = attacker:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_ATTACK_POISION_DAMAGE_RATE)
    end
    if defencer:get_obj_type() == "human" then
        kfs_wg_defence_rate = defencer:item_value(define.ITEM_ATTRIBUTE.IATTRIBUTE_POINT_ADD_POISION_DEFENCE_RATE)
    end
    kfs_wg_attack_rate = kfs_wg_attack_rate - kfs_wg_defence_rate
    kfs_wg_attack_rate = kfs_wg_attack_rate < 0 and 0 or kfs_wg_attack_rate
    damage = damage * (10000 + kfs_wg_attack_rate) / 10000
    damage = damage < 0 and 0 or damage
    return damage
end

function combat_core:direct_damage(attacker, defencer, addition_attack)
    local damage = addition_attack
    return damage
end


return combat_core