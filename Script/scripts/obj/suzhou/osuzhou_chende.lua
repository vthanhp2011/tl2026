local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_chende = class("osuzhou_chende", script_base)
function osuzhou_chende:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{SGCX_20231227_68}")
    self:AddNumText("不能重洗的手工修正", 6, 1)
    self:AddNumText("#{SGCX_20231227_39}", 6, 11)
    self:AddNumText("#{SGCX_20231227_40}", 11, 8888)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end
function osuzhou_chende:OnEventRequest(selfId, targetId, arg, index)
    local nNumText = index
	if nNumText == 0 then
		self:OnDefaultEvent(selfId, targetId)
		return
	end
	if nNumText == 1 then
		self:BeginEvent(self.script_id)
		self:AddText("    请把要修正的手工装备放到道具栏第一格。")
		self:AddNumText("好的，我放好了", 6, 2)
		self:AddNumText("打扰了", 11, 0)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	elseif nNumText == 2 then
		local ret = self:LuaFnRefreshEquipArtisanal(selfId,0)
		if ret == 0 then
			self:BeginEvent(self.script_id)
			self:AddText("修正成功，可以进行手工重洗。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		elseif ret == 1 then
			self:BeginEvent(self.script_id)
			self:AddText("第一格无道具。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		elseif ret == 2 then
			self:BeginEvent(self.script_id)
			self:AddText("第一格位上的道具为手工道具，无需修正。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		elseif ret == 3 then
			self:BeginEvent(self.script_id)
			self:AddText("请把要修正的手工装备放到道具栏第一格。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		elseif ret == 4 then
			self:BeginEvent(self.script_id)
			self:AddText("请把要修正的手工装备放到道具栏第一格。。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		elseif ret == 5 then
			self:BeginEvent(self.script_id)
			self:AddText("道具栏第一格位上不是装备。。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		end
		return
	end
    if nNumText == 11 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 88882001)
        return
    end
    if nNumText == 8888 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SGCX_20231227_41}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end
local wash_equip_config = {
    [7] = 38003056,
    [8] = 38003055
}
local valid_ep = {1, 2, 3, 4, 5, 6, 7, 12, 14, 15}
function osuzhou_chende:RefreshEquipAttr(selfId, BagIndex)
	if not self:LuaFnGetEquipArtisanal(selfId,BagIndex) then
        self:notify_tips(selfId, "#{SGCX_20231227_32}")
        return
    end
    local item_index = self:GetBagItemIndex(selfId, BagIndex)
	local equip_point = self:IsEquipItem(item_index)
	if not equip_point then
        self:notify_tips(selfId, "#{SGCX_20231227_32}")
        return
    end
	local eqlevel = self:GeEquipReqLevel(item_index)
	if eqlevel < 60 then
        self:notify_tips(selfId, "#{SGCX_20231227_32}")
        return
    end
	local open_equip = false
	for i,j in ipairs(valid_ep) do
		if j == equip_point then
			open_equip = true
			break
		end
	end
	if not open_equip then
        self:notify_tips(selfId, "该装备不支持重洗。")
        return
    end
    local quality = self:GetBagItemQuality(selfId, BagIndex)
    local need_item = wash_equip_config[quality]
    if not need_item then
        self:notify_tips(selfId, "#{SGCX_20231227_33}")
        return
    end
	-- if self:LuaFnGetEquipReshuffleCount(selfId,BagIndex) >= 3 then
        -- self:notify_tips(selfId,"#{SGCX_20231227_31}")
        -- return
    -- end
    local item_count = self:LuaFnGetAvailableItemCount(selfId, need_item)
    if item_count < 1 then
        self:notify_tips(selfId, string.format("缺少%s", self:GetItemName(need_item)))
        return
    end
	local HumanMoney = self:GetMoney(selfId ) + self:GetMoneyJZ(selfId)
    if HumanMoney < 200000 then
        self:notify_tips(selfId, "每次重洗需要20交子")
        return
    end
	local del = self:LuaFnDelAvailableItem(selfId, need_item, 1)
	if not del then
        return
    end
	del = self:LuaFnCostMoneyWithPriority(selfId, 200000)
	if not del then
        self:notify_tips(selfId, "金钱扣除失败")
        return
    end
	if not self:GetBagItemIsBind(selfId,BagIndex) then
		self:LuaFnItemBind(selfId,BagIndex)
	end
    self:LuaFnRefreshEquipAttr(selfId,BagIndex)
end

function osuzhou_chende:DiscardNewEquipAttr(selfId, BagPos)
    self:LuaFnFinishRefreshEquipAttr(selfId, BagPos, false)
end

function osuzhou_chende:SwitchEquipAttr(selfId, BagPos)
    -- self:LuaFnFinishRefreshEquipAttr(selfId, BagPos, true, true)			--开放重洗计数
    self:LuaFnFinishRefreshEquipAttr(selfId, BagPos, true)
end

return osuzhou_chende
