local class = require "class"
local define = require "define"
local condition_delplete_core = class("condition_delplete_core")
local ConDepLogic_T = class("ConDepLogic_T")
local CD_ManaByValue_T = class("CD_ManaByValue_T", ConDepLogic_T)
local CD_ManaByRate_T = class("CD_ManaByRate_T", ConDepLogic_T)
local CD_RageByRate_T = class("CD_RageByRate_T", ConDepLogic_T)
local CD_StrikePointBySegment_T = class("CD_StrikePointBySegment_T", ConDepLogic_T)
local D_AllRage_T = class("D_AllRage_T", ConDepLogic_T)
local C_TargetLevelMustLessThanByValues_T = class("C_TargetLevelMustLessThanByValues_T", ConDepLogic_T)
local C_UnitHaveImpact_T = class("C_UnitHaveImpact_T", ConDepLogic_T)
local C_UnitHpLessThanByRate_T = class("C_UnitHpLessThanByRate_T", ConDepLogic_T)
local C_TargetMustHaveImpact_T = class("C_TargetMustHaveImpact_T", ConDepLogic_T)
local D_CancelSpecialImpact_T = class("D_CancelSpecialImpact_T", ConDepLogic_T)
local C_TargetMustBeMySpouse_T = class("C_TargetMustBeMySpouse_T", ConDepLogic_T)
local CD_HpByRate_T = class("CD_HpByRate_T", ConDepLogic_T)
local C_HpByRate_T = class("C_HpByRate_T", ConDepLogic_T)
local CD_FlowerByValue_T = class("CD_FlowerByValue_T", ConDepLogic_T)
local CD_HPByValue_T = class("CD_HPByValue_T", ConDepLogic_T)
local C_UnitNotHaveImpact_T = class("C_UnitNotHaveImpact_T", ConDepLogic_T)

ConDepLogic_T.ID = define.ConditionAndDepleteID.CD_INVALID
function ConDepLogic_T:ConditionCheck()
    return true
end

function ConDepLogic_T:Deplete()
    return true
end

C_UnitNotHaveImpact_T.ID = define.ConditionAndDepleteID.C_TARGET_MUST_NOT_HAVE_IMPACT
function C_UnitNotHaveImpact_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local collection = data.params[1]
    if obj_me:impact_have_impact_in_specific_collection(collection) then
        params:set_errcode(define.OPERATE_RESULT.OR_U_CANNT_DO_THIS_RIGHT_NOW)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function C_UnitNotHaveImpact_T:Deplete()
    return true
end

C_TargetMustHaveImpact_T.ID = define.ConditionAndDepleteID.C_TARGET_MUST_HAVE_IMPACT
function C_TargetMustHaveImpact_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local collection = data.params[1]
    local tar = obj_me:get_scene():get_obj_by_id(params:get_target_obj())
    if tar == nil then
        params:set_errcode(define.OPERATE_RESULT.OR_INVALID_TARGET)
        return false
    end
    if not tar:impact_have_impact_in_specific_collection(collection) then
        params:set_errcode(define.OPERATE_RESULT.OR_U_CANNT_DO_THIS_RIGHT_NOW)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function C_TargetMustHaveImpact_T:Deplete()
    return true
end


C_UnitHpLessThanByRate_T.ID = define.ConditionAndDepleteID.C_UNIT_HP_MUST_LESS_THAN_BY_RATE
function C_UnitHpLessThanByRate_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local rate = data.params[1]
    local hp = obj_me:get_max_hp()
    hp = math.floor(hp * rate / 100)
    if obj_me:get_hp() > hp then
        params:set_errcode(define.OPERATE_RESULT.OR_TOO_MUCH_HP)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function C_UnitHpLessThanByRate_T:Deplete()
    return true
end

C_TargetLevelMustLessThanByValues_T.ID = define.ConditionAndDepleteID.C_TARGET_LEVEL_MUST_LESS_THAN_BY_VALUE
function C_TargetLevelMustLessThanByValues_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local level = data.params[1]
    local tar = obj_me:get_scene():get_obj_by_id(params:get_target_obj())
    if tar == nil then
        params:set_errcode(define.OPERATE_RESULT.OR_INVALID_TARGET)
        return false
    end
    print("tar:get_level() =", tar:get_level(), "level =", level)
    if tar:get_level() > level then
        params:set_errcode(define.OPERATE_RESULT.OR_NO_LEVEL)
        return false
    end
    return true
end

function C_TargetLevelMustLessThanByValues_T:Deplete()
    return true
end

C_UnitHaveImpact_T.ID = define.ConditionAndDepleteID.C_UNIT_MUST_HAVE_IMPACT
function C_UnitHaveImpact_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local collection = data.params[1]
    if not obj_me:impact_have_impact_in_specific_collection(collection) then
        params:set_errcode(define.OPERATE_RESULT.OR_U_CANNT_DO_THIS_RIGHT_NOW)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function C_UnitHaveImpact_T:Deplete()
    return true
end

CD_ManaByValue_T.ID = define.ConditionAndDepleteID.CD_MANA_BY_VALUE
function CD_ManaByValue_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local need = data.params[1]
    local mana = obj_me:get_mp()
    need = need < 0 and 0 or need
    if mana < need then
        params:set_errcode(define.OPERATE_RESULT.OR_LACK_MANA)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function CD_ManaByValue_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local need = data.params[1]
    need = need < 0 and 0 or need
    obj_me:mana_increment(-need, obj_me)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

CD_ManaByRate_T.ID = define.ConditionAndDepleteID.CD_MANA_BY_RATE
function CD_ManaByRate_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local rate = data.params[1]
    local mana = obj_me:get_max_mp()
    local need = math.floor(mana * rate / 100)
    need = need < 0 and 0 or need
    if obj_me:get_mp() < need then
        params:set_errcode(define.OPERATE_RESULT.OR_LACK_MANA)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function CD_ManaByRate_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local rate = data.params[1]
    local mana = obj_me:get_max_mp()
    local need = math.floor(mana * rate / 100)
    need = need < 0 and 0 or need
    obj_me:mana_increment(-need, obj_me)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

CD_RageByRate_T.ID = define.ConditionAndDepleteID.CD_RAGE_BY_RATE
function CD_RageByRate_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local rate = data.params[1]
    local rage = obj_me:get_max_rage()
    local need = math.floor(rage * rate / 100)
    need = need < 0 and 0 or need
    if obj_me:get_rage() < need then
        params:set_errcode(define.OPERATE_RESULT.OR_NOT_ENOUGH_RAGE)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function CD_RageByRate_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local rate = data.params[1]
    local rage = obj_me:get_max_rage()
    local need
    if data.params[2] == 0 then
        need = math.floor(rage * rate / 100)
    else
        need = obj_me:get_rage()
    end
    need = need < 0 and 0 or need
    obj_me:rage_increment(-need, obj_me)
    params:set_deplete_rage(need)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

CD_StrikePointBySegment_T.ID = define.ConditionAndDepleteID.CD_STRIKE_POINT_BY_SEGMENT
function CD_StrikePointBySegment_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local segment = data.params[1]
    if obj_me:get_strike_point() < segment * define.STRIKE_POINT_SEGMENT_SIZE then
        params:set_errcode(define.OPERATE_RESULT.OR_NOT_ENOUGH_STRIKE_POINT)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function CD_StrikePointBySegment_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local segment = obj_me:get_strike_point() / define.STRIKE_POINT_SEGMENT_SIZE
    local point = segment * define.STRIKE_POINT_SEGMENT_SIZE
    obj_me:strike_point_increment(-point, obj_me)
    obj_me:on_deplete_strike_points()
    params:set_deplete_strike_point(point)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

D_AllRage_T.ID = define.ConditionAndDepleteID.D_ALL_RAGE
function D_AllRage_T:ConditionCheck(obj_me, data)
    return true
end

function D_AllRage_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local rate = data.params[1]
    local rage = obj_me:get_max_rage()
    rage = math.floor(rage * rate / 100)
    obj_me:rage_increment(-rage)
    params:set_deplete_rage(rage)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

C_TargetMustBeMySpouse_T.ID = define.ConditionAndDepleteID.C_TARGET_MUST_BE_MY_SPOUSE
function C_TargetMustBeMySpouse_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_INVALID_TARGET)
        return false
    end
    local tar = obj_me:get_scene():get_obj_by_id(params:get_target_obj())
    if tar == nil then
        params:set_errcode(define.OPERATE_RESULT.OR_INVALID_TARGET)
        return false
    end
    if tar:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_INVALID_TARGET)
        return false
    end
    if not obj_me:is_my_spouse(tar) or not tar:is_my_spouse(obj_me) then
        params:set_errcode(define.OPERATE_RESULT.OR_INVALID_TARGET)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function C_TargetMustBeMySpouse_T:Deplete()
    return true
end

D_CancelSpecialImpact_T.ID = define.ConditionAndDepleteID.D_CANCEL_SPECIFIC_IMPACT
function D_CancelSpecialImpact_T:ConditionCheck()
    return true
end

function D_CancelSpecialImpact_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local collection = data.params[1]
    obj_me:impact_cancel_impact_in_specific_collection(collection)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

CD_HpByRate_T.ID = define.ConditionAndDepleteID.CD_HP_BY_RATE
function CD_HpByRate_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local rate = data.params[1]
    local hp = obj_me:get_max_hp()
    hp = math.floor(hp * rate / 100)
    if obj_me:get_hp() < hp then
        params:set_errcode(define.OPERATE_RESULT.OR_NOT_ENOUGH_HP)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function CD_HpByRate_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local rate = data.params[1]
    local hp = obj_me:get_max_hp()
    hp = math.floor(hp * rate / 100)
    obj_me:health_increment(-hp, obj_me)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

C_HpByRate_T.ID = define.ConditionAndDepleteID.C_HP_BY_RATE
function C_HpByRate_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    local rate = data.params[1]
    local hp = obj_me:get_max_hp()
    hp = math.floor(hp * rate / 100)
    if obj_me:get_hp() < hp then
        params:set_errcode(define.OPERATE_RESULT.OR_NOT_ENOUGH_HP)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function C_HpByRate_T:Deplete()
    return true
end


CD_FlowerByValue_T.ID = define.ConditionAndDepleteID.CD_FLOWER_BY_VALUE
function CD_FlowerByValue_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local need = data.params[1]
    local flower = obj_me:get_datura_flower()
    need = need < 0 and 0 or need
    if flower < need then
        params:set_errcode(define.OPERATE_RESULT.OR_LACK_MANA)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function CD_FlowerByValue_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local need = data.params[1]
    need = need < 0 and 0 or need
    obj_me:datura_flower_increment(-need, obj_me)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

CD_HPByValue_T.ID = define.ConditionAndDepleteID.CD_HP_BY_VALUE
function CD_HPByValue_T:ConditionCheck(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local need = data.params[1]
    local hp = obj_me:get_hp()
    need = need < 0 and 0 or need
    if hp < need then
        params:set_errcode(define.OPERATE_RESULT.OR_ERROR)
        return false
    end
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function CD_HPByValue_T:Deplete(obj_me, data)
    local skill_info = obj_me:get_skill_info()
    local params = obj_me:get_targeting_and_depleting_params()
    if obj_me:get_obj_type() ~= "human" then
        params:set_errcode(define.OPERATE_RESULT.OR_OK)
        return true
    end
    local need = data.params[1]
    need = need < 0 and 0 or need
    obj_me:health_increment(-need, obj_me)
    params:set_errcode(define.OPERATE_RESULT.OR_OK)
    return true
end

function condition_delplete_core:condition_check(obj_me, data)
    local type = data.type
    local logic = self.logics[type]
    assert(logic, type)
    print("condition_delplete_core:condition_check type =", type)
    return logic:ConditionCheck(obj_me, data)
end

function condition_delplete_core:deplete(obj_me, data)
    local type = data.type
    local logic = self.logics[type]
    assert(logic, type)
    return logic:Deplete(obj_me, data)
end

condition_delplete_core.logics = {}
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_INVALID]                            = ConDepLogic_T
condition_delplete_core.logics[define.ConditionAndDepleteID.C_UNIT_MUST_HAVE_IMPACT]               = C_UnitHaveImpact_T
condition_delplete_core.logics[define.ConditionAndDepleteID.C_UNIT_HP_MUST_LESS_THAN_BY_RATE]      = C_UnitHpLessThanByRate_T
condition_delplete_core.logics[define.ConditionAndDepleteID.C_TARGET_LEVEL_MUST_LESS_THAN_BY_VALUE]= C_TargetLevelMustLessThanByValues_T
condition_delplete_core.logics[define.ConditionAndDepleteID.C_TARGET_MUST_HAVE_IMPACT]             = C_TargetMustHaveImpact_T
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_MANA_BY_VALUE]                      = CD_ManaByValue_T
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_MANA_BY_RATE]                       = CD_ManaByRate_T
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_STRIKE_POINT_BY_SEGMENT]            = CD_StrikePointBySegment_T
condition_delplete_core.logics[define.ConditionAndDepleteID.D_ALL_RAGE]                            = D_AllRage_T
condition_delplete_core.logics[define.ConditionAndDepleteID.D_CANCEL_SPECIFIC_IMPACT]              = D_CancelSpecialImpact_T
condition_delplete_core.logics[define.ConditionAndDepleteID.C_TARGET_MUST_BE_MY_SPOUSE]            = C_TargetMustBeMySpouse_T
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_HP_BY_RATE]                         = CD_HpByRate_T
condition_delplete_core.logics[define.ConditionAndDepleteID.C_HP_BY_RATE]                          = C_HpByRate_T
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_FLOWER_BY_VALUE]                    = CD_FlowerByValue_T
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_RAGE_BY_RATE]                       = CD_RageByRate_T
condition_delplete_core.logics[define.ConditionAndDepleteID.CD_HP_BY_VALUE]                        = CD_HPByValue_T
condition_delplete_core.logics[define.ConditionAndDepleteID.C_UNIT_MUST_NOT_HAVE_IMPACT]           = C_UnitNotHaveImpact_T

return condition_delplete_core