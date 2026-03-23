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
    -- self:AddNumText("#{SBFW_20230707_26}", 6, 26)
    self:AddNumText("#{SBFW_20230707_29}", 11, 91)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_ouyean:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_ouyean:OnEventRequest(selfId, targetId, arg, index)
	if index == 0 then
		self:UpdateEventList(selfId, targetId)
		return
	end
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
    -- if index == 26 then
        -- self:BeginUICommand()
        -- self:UICommand_AddInt(targetId)
        -- self:EndUICommand()
        -- self:DispatchUICommand(selfId, 88881205)
        -- return
    -- end
	if index >= 91 and index <= 95 then
		self:BeginEvent(self.script_id)
		if index == 91 then
			self:AddNumText("#{SBFW_20230707_236}", 11, 92)
			self:AddNumText("#{SBFW_20230707_237}", 11, 93)
			self:AddNumText("#{SBFW_20230707_238}", 11, 94)
			self:AddNumText("#{SBFW_20230707_239}", 11, 95)
		elseif index == 92 then
			self:AddText("#{SBFW_20230707_31}")
		elseif index == 93 then
			self:AddText("#{SBFW_20230707_241}")
		elseif index == 94 then
			self:AddText("#{SBFW_20230707_242}")
		elseif index == 95 then
			self:AddText("#{SBFW_20230707_243}")
		end
		self:AddNumText("#{SBFW_20230707_240}", 8, 0)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	end
end

function odali_ouyean:ShenBingLevelUp(selfId, targetId, BagPos)
	if self:FixLegacyShenBinData(selfId,BagPos) then
        self:notify_tips(selfId, "神兵存在旧数据，已自行修正，请重新操作即可。")
        return
    end
	if not self:CheckHnmanLevel(selfId) then
		return
	end
    local zhuqing_level = self:GetShenBingZhuQingLevel(selfId, BagPos)
	if not zhuqing_level then
		return
	end
    local cost_material_id, cost_material_count, cost_money = self:GetShenBingLevelConfig(zhuqing_level)
    if not cost_material_id then
        self:notify_tips(selfId, "七情刃注情等级已满级")
        return
    end
    if self:GetMoneyJZ(selfId) + self:GetMoney(selfId) < cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
	if self:LuaFnGetAvailableItemCount(selfId,cost_material_id) < cost_material_count then
		self:notify_tips(selfId, "#{SBFW_20230707_51}")
		return
	end
	self:LuaFnDelAvailableItem(selfId,cost_material_id,cost_material_count)
    self:LuaFnCostMoneyWithPriority(selfId, cost_money)
    zhuqing_level = zhuqing_level + 1
	self:LuaFnItemBind(selfId,BagPos)
    self:SetShenBinZhuQingLevel(selfId, BagPos, zhuqing_level)
    self:notify_tips(selfId, "#{SBFW_20230707_53}")
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end

local MeltingConfigs = {
    [4] = { id = 38002944, count = 2},
    [5] = { id = 38002945, count = 2 },
    [6] = { id = 38002945, count = 5 },
}
function odali_ouyean:ShenBingMelt(selfId, targetId, BagPos)
	if self:FixLegacyShenBinData(selfId,BagPos) then
        self:notify_tips(selfId, "神兵存在旧数据，已自行修正，请重新操作即可。")
        return
    end
	if not self:CheckHnmanLevel(selfId) then
		return
	end
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
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end

function odali_ouyean:ShenBingTransition(selfId, targetId, BagPosFrom, BagPosTo,box1,box2)
	if self:FixLegacyShenBinData(selfId,BagPosFrom) then
        self:notify_tips(selfId, "源神兵存在旧数据，已自行修正，请重新操作即可。")
        return
	elseif self:FixLegacyShenBinData(selfId,BagPosTo) then
        self:notify_tips(selfId, "源神兵存在旧数据，已自行修正，请重新操作即可。")
        return
    end
	if not BagPosFrom or BagPosFrom == BagPosTo then
		return
	end
	if not self:CheckHnmanLevel(selfId) then
		return
	end
	local cost_money = 100000
    if self:GetMoneyJZ(selfId) + self:GetMoney(selfId) < cost_money then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
	self:CheckShenBinTransition(selfId, BagPosFrom, BagPosTo, cost_money)
    self:notify_tips(selfId, "#{SBFW_20230707_147}")
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
function odali_ouyean:CheckHnmanLevel(selfId)
	if self:GetLevel(selfId) < 65 then
		self:notify_tips(selfId, "#{SBFW_20230707_46}")
		return
	end
	return true
end

return odali_ouyean
