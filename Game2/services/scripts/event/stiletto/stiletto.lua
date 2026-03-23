--装备打孔
--普通
local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local stiletto = class("stiletto", script_base)
local tEquipGemTable	= {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true,
    [5] = true, [6] = true, [7] = true, [11] = true, [12] = true,
    [13] = true, [14] = true, [15] = true, [17] = true, [18] = true
}
function stiletto:StilettoEx_3(selfId, idBagPos, idBagPosStuff )
    print("stiletto:StilettoEx_3 =", selfId, idBagPos, idBagPosStuff)
	local BagItem = self:GetBagItem(selfId, idBagPos)
    if BagItem == nil then
        self:notify_tips(selfId, "装备打孔失败")
        return
    end
    local Bore_Count = BagItem:get_equip_data():get_slot_count()
	local nLevel = BagItem:get_level()
	local EquipType =  BagItem:get_equip_data():get_equip_point()
    if not tEquipGemTable[EquipType] then
        self:notify_tips(selfId, "该装备不支持打孔")
        return
    end
    local ret = self:LuaFnStilettoCostExe(selfId, nLevel*100+1+Bore_Count, idBagPosStuff, 1 )
	if ret == -1 then
		self:notify_tip(selfId, "查表错误，问问策划。" )
		return
	elseif ret == -2 then
		self:notify_tip(selfId, "你没有合适的材料，无法进行此操作。" )
		return
	elseif ret == -3 then
		self:notify_tip(selfId,  "你没有足够的金钱，无法进行此操作。" )
		return
	elseif ret == -4 then
		self:notify_tip(selfId, "你没有足够的材料，无法进行此操作。" )
		return
	elseif ret == 0 then
		self:notify_tip(selfId, "扣钱失败！" );
		return
	end
    ret = self:AddBagItemSlot(selfId, idBagPos)
    if ret == -3 then
        self:notify_tips(selfId, "需要放入一件装备")
        return
    end
    if ret == -4 then
        self:notify_tips(selfId, "此处只能打前3个孔")
        return
    end
    if ret == 1 then
        self:notify_tips(selfId, "装备打孔成功")
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    end
end

function stiletto:StilettoEx_Yuanbao_Pay(selfId, ItemIndex, check)
	local index, merchadise = self:GetMerchadiseByItemIndex(selfId, ItemIndex)
	if index == nil then
		return
	end
	local item_name = self:GetItemName(merchadise.id)
	self:BeginUICommand()
	self:UICommand_AddInt(check)
	self:UICommand_AddInt(10)
	self:UICommand_AddInt(5)
	self:UICommand_AddInt(merchadise.price)
	self:UICommand_AddInt(index - 1)
	self:UICommand_AddInt(0)
	self:UICommand_AddInt(-1)
	local str = self:ContactArgs("#{BSLCYH_130529_29", item_name, merchadise.price, item_name) .. "}"
	self:UICommand_AddStr(str)
	self:EndUICommand()
	self:DispatchUICommand(selfId, 2013060604)
end

function stiletto:StilettoEx_4(selfId, idBagPos, idBagPosStuff, type)
    --可打孔的装备
	--0武器，1帽子，2衣服，3手套，4鞋
	--5腰带，6戒指，7项链，12护符，14护腕
	--15护肩
	local szCailiao = self:GetBagItemTransfer(selfId, idBagPosStuff)

	--装备是否是绑定
	local isequipbind = self:LuaFnGetItemBindStatus(selfId, idBagPos )
	--材料是否是绑定
	local isstuffbind = self:LuaFnGetItemBindStatus(selfId, idBagPosStuff )
	 if type ~= 1 and type ~= 2 then
	    self:notify_tips(selfId, "错误的消耗类型。" )
		return
	 end
	local Bore_Count = self:GetBagGemCount(selfId, idBagPos)
	local nLevel = self:GetBagItemLevel(selfId, idBagPos)
	--打孔消耗
	local ret	= self:LuaFnStilettoCostExe(selfId, nLevel*100+1+Bore_Count, idBagPosStuff, type)
	if ret == -1 then
        self:notify_tips(selfId, "查表错误，问问策划。" )
		return
	elseif ret == -2 then
		if type == 1 then
            self:notify_tips(selfId, "#{XQC_20080509_07}" )
		else
            self:notify_tips(selfId, "#{JCDK_80905_07}" )
		end
		return
	elseif ret == -3 then
		if type == 1 then
			self:notify_tips(selfId, "#{XQC_20080509_08}" )
		else
			self:notify_tips(selfId, "#{JCDK_80905_08}" )
		end
		return
	elseif ret == -4 then
		if type == 1 then
			self:notify_tips(selfId, "#{XQC_20080509_07}" )
		else
			self:notify_tips(selfId, "#{JCDK_80905_07}" )
		end
		return
	elseif ret == 0 then --zchw
		self:notify_tips(selfId, selfId, "扣钱失败！" );
		return
	end

	--打孔执行
	ret	= self:AddBagItemSlotFour(selfId, idBagPos )
	if ret == -1 then
		self:notify_tips(selfId, "装备打孔失败" )
	elseif ret == -2 then
		self:notify_tips(selfId, "严重错误" )
	elseif ret == -3 then
		self:notify_tips(selfId, "#{XQC_20080509_06}" )
	elseif ret == -4 then
		self:notify_tips(selfId, "#{XQC_20080509_04}" )
	elseif ret == 1 then
        self:notify_tips(selfId, "装备打孔成功" )
		--if isequipbind == 0 and isstuffbind == 1 and type == 2 then
			self:LuaFnItemBind(selfId,idBagPos)
		--end

        --成功公告
        local transfer = self:GetBagItemTransfer(selfId,idBagPos)
        local str = ""
		local name = self:GetName(selfId)
		name = gbk.fromutf8(name)
        if type == 1 then
			str = string.format( "#{_INFOUSR%s}#{AQ_11}#{_INFOMSG%s}#{AQ_32}#{_INFOMSG%s}#{AQ_12}", name, szCailiao,transfer )
		    self:AddMoney(selfId, -30000000)
        else
            str = string.format( "#{_INFOUSR%s}#{AQ_11}#{_INFOMSG%s}#{AQ_31}#{_INFOMSG%s}#{AQ_12}", name, szCailiao,transfer )
        end
        self:BroadMsgByChatPipe(selfId, str, 4 )

		--增加特效
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0);
	end
end

function stiletto:notify_tip(selfId, msg)
	self:BeginEvent()
        self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return stiletto