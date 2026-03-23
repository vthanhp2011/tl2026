--云深深

local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_yunshenshen = class("osuzhou_yunshenshen", script_base)
local SoulBombSkill = 3547
function osuzhou_yunshenshen:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
    self:AddText("#{SHXT_20211230_47}")
    self:AddNumText("#{SHXT_20211230_48}", 6, 101)
    self:AddNumText("#{SHCX_20211229_01}", 6, 108)
    self:AddNumText("#{SHCX_20211229_53}", 6, 160)
    self:AddNumText("#{SHXT_20211230_50}", 6, 102)
    self:AddNumText("#{SHXT_20211230_276}", 6, 103)
    if not self:HaveSkill(selfId, SoulBombSkill) then
        self:AddNumText("#{SHXT_20211230_240}", 6, 109)
    end
    self:AddNumText("#{SHXT_20211230_55}", 11, 107)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_yunshenshen:OnEventRequest(selfId, targetId, arg, index)
    if index == 101 then
        self:BeginUICommand()
		self:UICommand_AddInt(1)
        self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 80012701)
        return
    end
    if index == 108 then
        local cost_chu_hun_ye = self:GetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_YE)
        local cost_chu_hun_sui = self:GetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_SUI)
        self:BeginUICommand()
		self:UICommand_AddInt(1)
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(1)
        self:UICommand_AddInt(0)
        self:UICommand_AddInt(0)
        self:UICommand_AddInt(cost_chu_hun_ye)
        self:UICommand_AddInt(cost_chu_hun_sui)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 80012708)
        return
    end
    if index == 160 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHCX_20211229_54}")
        self:AddNumText("#{SHCX_20211229_55}", 6, 161)
        self:AddNumText("#{SHCX_20211229_56}", 6, 162)
        self:AddNumText("#{SHCX_20211229_75}", 11, 170)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 161 then
        local cost_chu_hun_sui = self:GetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_SUI)
        local getd_shen_shou_jia_count = self:GetMissionData(selfId, define.MD_ENUM.MD_GETD_SHEN_SHOU_JIA_COUNT)
        local getd_shen_shou_zhen_count = self:GetMissionData(selfId, define.MD_ENUM.MD_GETD_SHEN_SHOU_ZHEN_COUNT)
        local getd_shen_shou_jue_count = self:GetMissionData(selfId, define.MD_ENUM.MD_GETD_SHEN_SHOU_JUE_COUNT)
        self:BeginEvent(self.script_id)
        local jia = (cost_chu_hun_sui - getd_shen_shou_jia_count * 200) // 200
        local zhen = (cost_chu_hun_sui - getd_shen_shou_zhen_count * 1000) // 1000
        local jue = (cost_chu_hun_sui - getd_shen_shou_jue_count * 4000) // 4000
        jia = jia < 0 and 0 or jia
        zhen = zhen < 0 and 0 or zhen
        jue = jue < 0 and 0 or jue
        self:BeginEvent(self.script_id)
        local str = self:ContactArgs("#{SHCX_20211229_57", cost_chu_hun_sui, jia, zhen, jue)
        self:AddText(str .. "}")
        self:AddNumText("#{SHCX_20211229_58}", 6, 163)
        self:AddNumText("#{SHCX_20211229_59}", 6, 164)
        self:AddNumText("#{SHCX_20211229_60}", 6, 165)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 162 then
        local cost_chu_hun_ye = self:GetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_YE)
        local getd_shen_shou_jia_count = self:GetMissionData(selfId, define.MD_ENUM.MD_GETD_HUANG_SHOU_JIA_COUNT)
        local getd_shen_shou_zhen_count = self:GetMissionData(selfId, define.MD_ENUM.MD_GETD_HUANG_SHOU_ZHEN_COUNT)
        local getd_shen_shou_jue_count = self:GetMissionData(selfId, define.MD_ENUM.MD_GETD_HUANG_SHOU_JUE_COUNT)
        self:BeginEvent(self.script_id)
        local jia = (cost_chu_hun_ye - getd_shen_shou_jia_count * 150) // 150
        local zhen = (cost_chu_hun_ye - getd_shen_shou_zhen_count * 750) // 750
        local jue = (cost_chu_hun_ye - getd_shen_shou_jue_count * 3000) // 3000
        jia = jia < 0 and 0 or jia
        zhen = zhen < 0 and 0 or zhen
        jue = jue < 0 and 0 or jue
        local str = self:ContactArgs("#{SHCX_20211229_61", cost_chu_hun_ye, jia, zhen, jue)
        self:AddText(str .. "}")
        self:AddNumText("#{SHCX_20211229_62}", 6, 166)
        self:AddNumText("#{SHCX_20211229_63}", 6, 167)
        self:AddNumText("#{SHCX_20211229_64}", 6, 168)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 163 then
        self:AwardSuoHunFu(selfId, define.MD_ENUM.MD_COST_CHU_HUN_SUI, define.MD_ENUM.MD_GETD_SHEN_SHOU_JIA_COUNT, 200, 38002633)
        self:OnEventRequest(selfId, targetId, arg, 161)
        return
    end
    if index == 164 then
        self:AwardSuoHunFu(selfId, define.MD_ENUM.MD_COST_CHU_HUN_SUI, define.MD_ENUM.MD_GETD_SHEN_SHOU_ZHEN_COUNT, 1000, 38002634)
        self:OnEventRequest(selfId, targetId, arg, 161)
        return
    end
    if index == 165 then
        self:AwardSuoHunFu(selfId, define.MD_ENUM.MD_COST_CHU_HUN_SUI, define.MD_ENUM.MD_GETD_SHEN_SHOU_JUE_COUNT, 4000, 38002635)
        self:OnEventRequest(selfId, targetId, arg, 161)
        return
    end
    if index == 166 then
        self:AwardSuoHunFu(selfId, define.MD_ENUM.MD_COST_CHU_HUN_YE, define.MD_ENUM.MD_GETD_HUANG_SHOU_JIA_COUNT, 150, 38002636)
        self:OnEventRequest(selfId, targetId, arg, 162)
        return
    end
    if index == 167 then
        self:AwardSuoHunFu(selfId, define.MD_ENUM.MD_COST_CHU_HUN_YE, define.MD_ENUM.MD_GETD_HUANG_SHOU_ZHEN_COUNT, 750, 38002637)
        self:OnEventRequest(selfId, targetId, arg, 162)
        return
    end
    if index == 168 then
        self:AwardSuoHunFu(selfId, define.MD_ENUM.MD_COST_CHU_HUN_YE, define.MD_ENUM.MD_GETD_HUANG_SHOU_JUE_COUNT, 3000, 38002638)
        self:OnEventRequest(selfId, targetId, arg, 162)
        return
    end
    if index == 170 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHCX_20211229_76}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 102 then
        self:BeginUICommand()
		self:UICommand_AddInt(1)
        self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 80012702)
        return
    end
    if index == 103 then
        self:BeginUICommand()
		self:UICommand_AddInt(1)
        self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 80012702)
        return
    end
    if index == 109 then
        self:AddSkill(selfId, SoulBombSkill)
        return
    end
    if index == 107 then
        self:BeginEvent(self.script_id)
        self:AddNumText("#{SHXT_20211230_143}", 11, 111)
        self:AddNumText("#{SHXT_20211230_144}", 11, 112)
        self:AddNumText("#{SHXT_20211230_145}", 11, 113)
        self:AddNumText("#{SHXT_20211230_146}", 11, 114)
        self:AddNumText("#{SHXT_20211230_147}", 11, 115)
        self:AddNumText("#{SHXT_20211230_148}", 11, 116)
        self:AddNumText("#{SHXT_20211230_192}", 11, 119)
        self:AddNumText("#{SHXT_20211230_227}", 11, 120)
        self:AddNumText("#{SHXT_20211230_217}", -1, 130)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 111 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_151}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 112 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_152}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 113 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_153}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 114 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_154}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 115 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_155}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 116 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_156}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 119 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_193}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 120 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SHXT_20211230_228}")
        self:AddNumText("#{SHXT_20211230_217}", -1, 107)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function osuzhou_yunshenshen:AwardSuoHunFu(selfId, xi_key, get_key, sub_value, item_id)
    local cost_chu_hun_sui = self:GetMissionData(selfId, xi_key)
    local get_count = self:GetMissionData(selfId, get_key)
    local count = (cost_chu_hun_sui - get_count * sub_value) // sub_value
    if count > 0 then
        self:BeginAddItem()
        self:AddItem(item_id, count)
        local r = self:EndAddItem(selfId)
        if r then
            self:AddItemListToHuman(selfId)
            self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 149, 0)
            self:SetMissionData(selfId, get_key, get_count + count)
            self:notify_tips(selfId, "领取成功")
        else
            self:notify_tips(selfId, "背包空间不足")
        end
    else
        self:notify_tips(selfId, "可领取次数不足")
    end
    return
end

local PetSoulLevelUpItem = 38002530
function osuzhou_yunshenshen:OnPetSoulLevelUp(selfId, targetId, BagPos)
    print("osuzhou_yunshenshen:OnPetSoulLevelUp", selfId, targetId, BagPos)
    local equip_type = self:GetPetEquipType(selfId, BagPos)
    if equip_type ~= define.PET_EQUIP_TYPE.SOUL then
        self:notify_tips(selfId, "仅可对兽魂操作")
        return
    end
    local level = self:GetPetSoulLevel(selfId, BagPos)
    local quanlity = self:GetPetSoulQuanlity(selfId, BagPos)
    local cost_count, cost_money = self:GetPetSoulLevelUpCost(level, quanlity)
    local count = self:LuaFnGetAvailableItemCount(selfId, PetSoulLevelUpItem)
    if count < cost_count then
        self:notify_tips(selfId, "升魂丹数量不足")
        return
    end
    local PlayerMoney = self:GetMoney(selfId ) +  self:GetMoneyJZ(selfId)
    if PlayerMoney < cost_money then
        self:notify_tips(selfId, "金币不足")
        return
    end
    self:LuaFnDelAvailableItem(selfId, PetSoulLevelUpItem, cost_count)
    self:LuaFnCostMoneyWithPriority(selfId, cost_money) --扣钱
    local ret = self:PetSoulLevelUp(selfId, BagPos)
    if ret then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
    else
        self:notify_tips(selfId, "内部异常")
    end
end

local PetSoulXiShuXingItems = {
    [0] = { 38002534, 38002534 },
    [1] = { 38002533, 38002541 },
    [2] = { 38002532, 38002540 },
    [3] = { 38002532, 38002540 }
}

local PetXiShuXingLockToCount = {
    [0] = 1,
    [1] = 2,
    [2] = 2,
    [3] = 3,
    [4] = 3,
    [5] = 4,
    [6] = 5
}

local PetXiShuXingLockColorCount = {
    [38002633] = { [2] = 3, [3] = 3 },
    [38002634] = { [2] = 4, [3] = 4 },
    [38002635] = { [2] = 5, [3] = 5 },
    [38002636] = { [1] = 3 },
    [38002637] = { [1] = 4 },
    [38002638] = { [1] = 5 },
}

function osuzhou_yunshenshen:OnPetSoulXiShuXing(selfId, BagPosSoul, BagPosM, BagPosL, LockValue)
    print("osuzhou_yunshenshen:OnPetSoulXiShuXing", selfId, BagPosSoul, BagPosM)
    local equip_type = self:GetPetEquipType(selfId, BagPosSoul)
    if equip_type ~= define.PET_EQUIP_TYPE.SOUL then
        self:notify_tips(selfId, "仅可对兽魂操作")
        return
    end
    local quanlity = self:GetPetSoulQuanlity(selfId, BagPosSoul)
    local Item_Index = self:GetBagItemIndex(selfId, BagPosM)
    if Item_Index ~= PetSoulXiShuXingItems[quanlity][1] and Item_Index ~= PetSoulXiShuXingItems[quanlity][2] then
        self:notify_tips(selfId, "材料不正确")
        return
    end
    local cost_count, cost_money = self:GetXiShuXingCostMaterialCount(LockValue), 50000
    local count = self:GetBagItemLayCount(selfId, BagPosM)
    if count < cost_count then
        self:notify_tips(selfId, "材料数量不足")
        return
    end
    local PlayerMoney = self:GetMoney(selfId ) +  self:GetMoneyJZ(selfId)
    if PlayerMoney < cost_money then
        self:notify_tips(selfId, "金币不足")
        return
    end
    local cost_chu_hun_ye = self:GetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_YE)
    local cost_chu_hun_sui = self:GetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_SUI)
    if quanlity == 3 or quanlity == 2 then
        cost_chu_hun_sui = cost_chu_hun_sui + cost_count
    elseif quanlity == 1 then
        cost_chu_hun_ye = cost_chu_hun_ye + cost_count
    end
    local LockColorCount = 0
    if BagPosL ~= define.INVAILD_ID then
        local item_index = self:GetItemTableIndexByIndex(selfId, BagPosL)
        local level_count = PetXiShuXingLockColorCount[item_index]
        if level_count then
            if level_count[quanlity] then
                LockColorCount = level_count[quanlity]
            end
        end
    end
    self:SetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_YE, cost_chu_hun_ye)
    self:SetMissionData(selfId, define.MD_ENUM.MD_COST_CHU_HUN_SUI, cost_chu_hun_sui)
    self:LuaFnDecItemLayCount(selfId, BagPosM, cost_count)
    self:LuaFnCostMoneyWithPriority(selfId, cost_money) --扣钱
    if BagPosL ~= define.INVAILD_ID then
        self:LuaFnDecItemLayCount(selfId, BagPosL, 1)
    end
    local ret = self:PetSoulXiShuXing(selfId, BagPosSoul, LockValue, LockColorCount)
    if ret then
		self:BeginUICommand()
		    self:UICommand_AddInt(2)
            self:UICommand_AddInt(BagPosSoul)
            self:UICommand_AddInt(0)
            self:UICommand_AddInt(0)
            self:UICommand_AddInt(0)
            self:UICommand_AddInt(cost_chu_hun_sui)
		self:EndUICommand( )
		self:DispatchUICommand(selfId, 80012708)
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
    else
        self:notify_tips(selfId, "内部异常")
    end
end

function osuzhou_yunshenshen:GetXiShuXingCostMaterialCount(value)
    local count = 0
    local values =  { string.match(tostring(value), "(%d?)(%d?)(%d?)(%d?)(%d?)(%d?)") }
    for _, v in ipairs(values) do
        if v == "1" then
            count = count + 1
        end
    end
    return PetXiShuXingLockToCount[count]
end

function osuzhou_yunshenshen:DoRefreshPetSoulAttr(selfId, BagPos)
    self:RefreshPetSoulAttr(selfId, BagPos)
end

local PetSoulMaterials = {
    [38002525] = 0,
    [38002526] = 0,
    [38002527] = 0,
    [38002528] = 0,
    [38002529] = 0,

    [38002520] = 1,
    [38002521] = 1,
    [38002522] = 1,
    [38002523] = 1,
    [38002524] = 1,

    [38002515] = 2,
    [38002516] = 2,
    [38002517] = 2,
    [38002518] = 2,
    [38002519] = 2,

    [38002732] = 3,
    [38002741] = 2,
    [38002742] = 2,
}

function osuzhou_yunshenshen:OnPetSoulBloodLevelUp(selfId, targetId, BagPosSoul, BagPosM)
    print("osuzhou_yunshenshen:OnPetSoulLevelUp", selfId, targetId, BagPosSoul, BagPosM)
    local equip_type = self:GetPetEquipType(selfId, BagPosSoul)
    if equip_type ~= define.PET_EQUIP_TYPE.SOUL then
        self:notify_tips(selfId, "仅可对兽魂操作")
        return
    end
    local quanlity = self:GetPetSoulQuanlity(selfId, BagPosSoul)
    local Item_Index_M = self:GetBagItemIndex(selfId, BagPosM)
    local material_is_bind = self:GetBagItemIsBind(selfId, BagPosM)
    local quanlity_m  = PetSoulMaterials[Item_Index_M]
    if quanlity_m ~= quanlity and not ( quanlity_m == 2 and quanlity == 3) and not (Item_inde) then
        self:notify_tips(selfId, "材料不正确")
        return
    end
    local add_exp
    if Item_Index_M == 38002741 then
        add_exp = 10
    elseif Item_Index_M == 38002742 then
        add_exp = 100
    else
        add_exp = self:GetPetSoulBloodAddExp(selfId, BagPosSoul, BagPosM)
    end
    if add_exp < 0 then
        self:notify_tips(selfId, "内部错误")
        return
    end
    local count_m = self:GetBagItemLayCount(selfId, BagPosM)
    self:LuaFnDecItemLayCount(selfId, BagPosM, count_m)
    local all_add_exp = add_exp * count_m
    local ret = self:PetSoulAddExp(selfId, BagPosSoul, all_add_exp)
    if ret then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
        if material_is_bind then
            self:LuaFnItemBind(selfId, BagPosSoul)
        end
    else
        self:notify_tips(selfId, "内部异常")
    end
end

return osuzhou_yunshenshen