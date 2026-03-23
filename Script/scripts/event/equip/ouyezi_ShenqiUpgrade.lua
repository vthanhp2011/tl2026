local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ouyezi_ShenqiUpgrade = class("ouyezi_ShenqiUpgrade", script_base)
ouyezi_ShenqiUpgrade.script_id = 500505
ouyezi_ShenqiUpgrade.UpgradeMoney = 50000
ouyezi_ShenqiUpgrade.ShenBingFu_Need = 5

function ouyezi_ShenqiUpgrade:DoRefreshSuperAttr(selfId, nEquipPos)
    self:RefreshSuperAttr(selfId, nEquipPos)
    self:NotifysTip(selfId, "#{CXYH_140813_48}")
    self:BeginUICommand()
    self:UICommand_AddInt(nEquipPos)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 198311141)
end

function ouyezi_ShenqiUpgrade:ShenQiConfirm(selfId, nEquipPos, nTargetID)
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,nEquipPos)
	if equip_qhd and equip_qhd > 0 then
		self:notify_tips(selfId,"通灵装备不可在此操作。")
		return
	end
    if nEquipPos == nil or nTargetID == nil then
        return
    end
    local nMenPaiID = self:GetMenPai(selfId)
    if nMenPaiID == -1 or nMenPaiID == 9 then
        self:NotifysTip(selfId, "门派数据异常，请检查您的角色状态！")
        return
    end
    local nOldWeaponID = self:LuaFnGetItemTableIndexByIndex(selfId, nEquipPos)
    local nNewItemID, nNeedMoney, nMaterial_1 = self:LuaFnGetShenqiUpgradeInfo(nOldWeaponID, nMenPaiID)
    if nNewItemID == nil or nNewItemID == nil then
        self:NotifysTip(selfId, "#{CXYH_140813_37}")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < nNeedMoney then
        self:NotifysTip(selfId, "#{CXYH_140813_40}")
        return
    end
    local nMaterialNum = 0
    if nMaterial_1 ~= -1 then
        nMaterialNum = self:LuaFnGetAvailableItemCount(selfId, nMaterial_1)
    end
    if nMaterialNum < self.ShenBingFu_Need then
        self:NotifysTip(selfId, "#{CXYH_140813_39}")
        return
    end
    local nRet = false
    if nMaterial_1 ~= -1 then
        -- nRet = self:LuaFnMtl_CostMaterial(selfId, self.ShenBingFu_Need, { nMaterial_1 })
		nRet = self:LuaFnDelAvailableItem(selfId, nMaterial_1, self.ShenBingFu_Need)
    end
    if not nRet then
        self:BeginEvent(self.script_id)
        self:AddText("神兵符不足")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    self:LuaFnRewashEquipAttr(selfId, nEquipPos, nNewItemID)
    self:NotifysTip(selfId, "神器属性炼魂成功")
end

function ouyezi_ShenqiUpgrade:OnShenqiUpgrade(selfId, nEquipPos)
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,nEquipPos)
	if equip_qhd and equip_qhd > 0 then
		self:notify_tips(selfId,"通灵装备不可在此操作。")
		return
	end
    local nOldWeaponID = self:LuaFnGetItemTableIndexByIndex(selfId, nEquipPos)
    local nMenPaiID = self:GetMenPai(selfId)
    if nMenPaiID == -1 or nMenPaiID == 9 then
        self:NotifysTip(selfId, "门派数据异常，请检查您的角色状态！")
        return
    end
    local nNewItemID, nNeedMoney, nMaterial_1 = self:LuaFnGetShenqiUpgradeInfo(nOldWeaponID, nMenPaiID)
    if nNewItemID == nil or nNewItemID == nil then
        self:NotifysTip(selfId, "#{CXYH_140813_37}")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < nNeedMoney then
        self:NotifysTip(selfId, "#{CXYH_140813_40}")
        return
    end
    local nMaterialNum = 0
    if nMaterial_1 ~= -1 then
        -- nMaterialNum = self:LuaFnMtl_GetCostNum(selfId, { nMaterial_1 })
        nMaterialNum = self:LuaFnGetAvailableItemCount(selfId, nMaterial_1)
    end
    if nMaterialNum < self.ShenBingFu_Need then
        self:NotifysTip(selfId, "#{CXYH_140813_39}")
        return
    end
    local nRet = false
    if nMaterial_1 ~= -1 then
        -- nRet = self:LuaFnMtl_CostMaterial(selfId, self.ShenBingFu_Need, { nMaterial_1 })
		nRet = self:LuaFnDelAvailableItem(selfId, nMaterial_1, self.ShenBingFu_Need)
    end
    if not nRet then
        self:BeginEvent(self.script_id)
        self:AddText("扣除神兵符失败")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, nNeedMoney)
    self:LuaFnRewashEquipAttr(selfId, nEquipPos, nNewItemID)
    self:NotifysTip(selfId, "#{CXYH_140813_41}")
    return
end

function ouyezi_ShenqiUpgrade:NotifysTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return ouyezi_ShenqiUpgrade
