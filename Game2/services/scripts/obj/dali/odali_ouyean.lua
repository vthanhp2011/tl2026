local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local odali_ouyean = class("odali_ouyean", script_base)
odali_ouyean.script_id = 002053
odali_ouyean.g_eventList = {713511, 713570, 713610}

function odali_ouyean:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{SBFW_20230707_20}")
    self:AddNumText("领取五蕴天缘匣", 6, 121)
    self:AddNumText("#{SBFW_20230707_21}", 6, 21)
    self:AddNumText("#{SBFW_20230707_256}", 6, 22)
    self:AddNumText("#{SBFW_20230707_257}", 6, 23)
    self:AddNumText("#{SBFW_20230707_26}", 6, 26)
    self:AddNumText("#{SBFW_20230707_29}", 11, 91)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_ouyean:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_ouyean:OnEventRequest(selfId, targetId, arg, index)
    if index == 121 then
        local val = self:GetMissionDataEx(selfId, ScriptGlobal.MDEX_GET_QIQINGREN_GIFT)
        if val == 0 then
            self:BeginAddItem()
            self:AddItem(38002985, 1)
            local ret = self:EndAddItem(selfId)
            if ret then
                self:AddItemListToHuman(selfId)
                self:SetMissionDataEx(selfId, ScriptGlobal.MDEX_GET_QIQINGREN_GIFT, 1)
            else
                self:notify_tips(selfId, "背包空间不足")
            end
        else
            self:notify_tips(selfId, "你已经领取过五蕴天缘匣")
        end
        return
    end
    if index == 21 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 88881201)
        return
    end
    if index == 22 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 88881202)
        return
    end
    if index == 23 then
        self:BeginEvent(self.script_id)
        local str = self:ContactArgs("#{SBFW_20230707_260", 2, 3) .. "}"
        self:AddText(str)
        self:AddNumText("#{SBFW_20230707_261}", 6, 24)
        self:AddNumText("#{SBFW_20230707_262}", 6, 25)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 24 then
        local cost_material_ids = { 38002944 }
        if self:LuaFnMtl_GetCostNum(selfId, cost_material_ids) < 10 then
            self:notify_tips(selfId, "七情残片数量不足")
            return
        end
        self:BeginAddItem()
        self:AddItem(38002985, 1 , true)
        local ret = self:EndAddItem(selfId)
        if not ret then
            self:MsgBox(selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
            return
        end
        self:LuaFnMtl_CostMaterial(selfId, 10, cost_material_ids)
        self:AddItemListToHuman(selfId)
        return
    end
    if index == 25 then
        local cost_material_ids = { 38002945 }
        if self:LuaFnMtl_GetCostNum(selfId, cost_material_ids) < 20 then
            self:notify_tips(selfId, "七情石数量不足")
            return
        end
        self:BeginAddItem()
        self:AddItem(38002986, 1 , true)
        local ret = self:EndAddItem(selfId)
        if not ret then
            self:MsgBox(selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
            return
        end
        self:LuaFnMtl_CostMaterial(selfId, 20, cost_material_ids)
        self:AddItemListToHuman(selfId)
        return
    end
    if index == 26 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 88881205)
        return
    end
end

function odali_ouyean:ShenBingLevelUp(selfId, targetId, BagPos)
    local zhuqing_level = self:GetShenBingZhuQingLevel(selfId, BagPos)
    local cost_material_id, cost_material_count, cost_money = self:GetShenBingLevelConfig(zhuqing_level)
    if cost_material_id == nil then
        self:notify_tips(selfId, "七情刃注情等级已满级")
        return
    end
    local cost_material_ids = { cost_material_id }
	if self:LuaFnMtl_GetCostNum(selfId, cost_material_ids) < cost_material_count then
		self:notify_tips(selfId, "破级石数量不足")
		return
	end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, cost_money)
    self:LuaFnMtl_CostMaterial(selfId, cost_material_count, cost_material_ids)
    zhuqing_level = zhuqing_level + 1
    self:SetShenBinZhuQingLevel(selfId, BagPos, zhuqing_level)
    self:notify_tips(selfId, "提升注情等级成功!")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

local MeltingConfigs = {
    [4] = { id = 38002944, count = 2},
    [5] = { id = 38002945, count = 2 },
    [6] = { id = 38002945, count = 5 },
}
function odali_ouyean:ShenBingMelt(selfId, targetId, BagPos)
    if self:LuaFnIsBagItemExpensive(selfId, BagPos) then
        self:notify_tips(selfId, "贵重物品不能分解")
        return
    end
    local zhuqing_level = self:GetShenBingZhuQingLevel(selfId, BagPos)
    if zhuqing_level > 1 then
        self:notify_tips(selfId, "注情等级大于1不能分解")
        return
    end
    local star = self:GetShenBingStar(selfId, BagPos)
    local Config = MeltingConfigs[star]
    if Config == nil then
        self:notify_tips(selfId, "分解七情刃,请检查配置")
        return
    end
    self:BeginAddItem()
    self:AddItem(Config.id, Config.count , true)
    local ret = self:EndAddItem(selfId)
    if not ret then
        self:MsgBox(selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
        return
    end
    self:LuaFnEraseItem(selfId, BagPos)
    self:AddItemListToHuman(selfId)
    self:notify_tips(selfId, "分解副武器成功")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

function odali_ouyean:ShenBingTransition(selfId, targetId, BagPosFrom, BagPosTo)
    local zhuqing_level = self:GetShenBingZhuQingLevel(selfId, BagPosFrom)
    if zhuqing_level <= 1 then
        self:notify_tips(selfId, "注情等级大于1才能转移")
        return
    end
    self:SetShenBinZhuQingLevel(selfId, BagPosFrom, 1)
    self:SetShenBinZhuQingLevel(selfId, BagPosTo, zhuqing_level)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    self:notify_tips(selfId, "七情刃转移成功")
end

return odali_ouyean
