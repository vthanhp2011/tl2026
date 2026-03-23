--装备强化
--脚本号
local gbk = require "gbk"
local define = require "define"
local class = require "class"
local script_base = require "script_base"
local equip_enhance = class("equip_enhance", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
local g_QianghualuId = 30900045
local g_QianghualuTime = 11

-- local packet_def = require "game.packet"
-- local configenginer = require "configenginer":getinstance()
-- local human_item_logic = require "human_item_logic"


function equip_enhance:FinishEnhanceEx(selfId, itemidx1, itemidx2 )
	self:FinishEnhance(selfId, itemidx1, itemidx2 )
end
function equip_enhance:FinishEnhance(selfId, itemidx1, itemidx2 )
	if not itemidx1 or not itemidx2 then return end
	-- local equip_point = self:LuaFnGetBagEquipType(selfId, itemidx1)
	-- if equip_point == 七情编号 then
		-- self:notify_tips(selfId,"七情刃不开放强化")
		-- return
	-- end

	local curlv = self:LuaFnGetEquipEnhanceLevel(selfId, itemidx1)
	local ServerID = self:LuaFnGetServerID(selfId)
	if ScriptGlobal.is_internal_test then
		if curlv >= 60 then
			self:notify_tips(selfId,"当前仅开放60级强化")
			return
		end
	elseif ServerID == 10 then
		if curlv >= 99 then
			self:notify_tips(selfId,"当前仅开放99级强化")
			return
		end
	else
		if curlv >= 99 then
			self:notify_tips(selfId,"当前仅开放99级强化")
			return
		end
	end
	local tip = ""
	local ret,value,isok = self:LuaFnEquipEnhance(selfId, itemidx1, itemidx2, g_QianghualuTime)
	if ret == 0 then
		if isok then
			self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0);
			tip = "装备强化成功！"
		else
			tip = "好可惜啊您的装备强化失败了,别灰心!!!"
		end
	elseif ret == 1 then
		tip = "异常装备位。"
	elseif ret == 2 then
		tip = "装备已加锁。"
	elseif ret == 3 then
		tip = "该装备的强化等级已经最大。"
	elseif ret == 4 then
		tip = "下一级强化信息获取异常。"
	elseif ret == 5 then
		tip = "异常材料位。"
	elseif ret == 6 then
		tip = "道具不可用。"
	elseif ret == 7 then
		tip = string.format( "该装备强化需要%s。",self:GetItemName(30900005))
	elseif ret == 8 then
		tip = string.format( "%s扣除失败。",self:GetItemName(30900005))
	elseif ret == 9 then
		tip = string.format( "%s扣除失败。",self:GetItemName(30900006))
	elseif ret == 10 then
		tip = string.format( "%s已无可用次数。",self:GetItemName(30900045))
	elseif ret == 11 then
		tip = string.format( "该装备强化需要%s或%s。",self:GetItemName(30900006),self:GetItemName(30900045))
	elseif ret == 12 then
		tip = "该装备不能用已绑定的道具强化！"
	elseif ret == 13 then
		tip = string.format( "强化该装备需要#{_EXCHG%d}，您身上的现金不足。", value )
	elseif ret == 14 then
		tip = string.format( "该装备强化需要%s。",self:GetItemName(38008160))
	elseif ret == 15 then
		tip = string.format( "%s扣除失败。",self:GetItemName(38008160))
	elseif ret == 16 then
		tip = "金钱扣除失败。"
	elseif ret == 17 then
		tip = "该装备没有开放强化，请不要非法操作。"
	elseif ret == 18 then
		tip = "请放入要强化的装备。"
	end
	self:notify_tips(selfId,tip)
	
end
function equip_enhance:FinishMoveEnhance(selfId,equippos1,equippos2)
	if not equippos1 or not equippos2 then return end
	if equippos1 == equippos2 then return end
	local ret,value = self:MoveEnhanceLevel(selfId,equippos1,equippos2)
	if ret == 0 then
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0);
		tip = "恭喜您，强化转移成功！！"
	elseif ret == 1 then
		tip = "异常装备位1。"
	elseif ret == 2 then
		tip = "异常装备位2。"
	elseif ret == 3 then
		tip = "位置1非装备。"
	elseif ret == 4 then
		tip = "位置2非装备。"
	elseif ret == 5 then
		tip = "主装备没有强化。"
	elseif ret == 6 then
		tip = string.format( "转移该装备强化等级需要#{_EXCHG%d}，您身上的现金不足。", value )
	elseif ret == 7 then
		tip = "继承装备强化等级不能高于主装备的强化等级。"
	elseif ret == 8 then
		tip = "两装备的等级阶段不一致，需两者同是40级以下或都是40级以上。"
	elseif ret == 9 then
		tip = "两装备类型不一致。"
	elseif ret == 10 then
		tip = "金钱扣除失败。"
	end
	self:notify_tips(selfId, tip )
	-- local szTranItm2 = self:GetBagItemTransfer(selfId, Item2 )
	-- local name = self:LuaFnGetName(selfId )
	-- local szMsg	= string.format( "#W#{_INFOUSR%s}#G花费了#{_EXCHG%d}成功把#Y" .. leftItemName .. "#G上的强化转移到#{_INFOMSG%%s}上", name, NeedMoney*10000)
	-- szMsg = gbk.fromutf8(szMsg)
	-- szMsg = string.format(szMsg, szTranItm2)
	-- self:AddGlobalCountNews(szMsg, true)
end


function equip_enhance:GetEquipCurStrong(selfId,itemidx1)
	if not itemidx1 then
		return
	end
	local equip_index = self:LuaFnGetItemTableIndexByIndex(selfId, itemidx1)
	if equip_index == -1 or self:LuaFnIsItemExists(equip_index) ~= 1 then
		return
	end
	self:LuaFnUpdateEquipEnhanceInfo(selfId, itemidx1)
end

function equip_enhance:DoFinishEnhance(selfId, itemidx1,itemidx2, equip_index,item_index)
end
function equip_enhance:DoQuickQiangHuaByYB(selfId, ItemPos, check)
	if not ItemPos then return end
	local equipid = self:GetItemTableIndexByIndex(selfId, ItemPos)
	if equipid == define.INVAILD_ID then
		return
	end
	if self:LuaFnIsItemExists(equipid) ~= 1 then
		self:notify_tips(selfId, "该道具并非装备")
		return
	end
	local point = self:GetItemEquipPoint(equipid)
	if point == define.HUMAN_EQUIP.HEQUIP_RIDER
	or point == define.HUMAN_EQUIP.HEQUIP_UNKNOW1
	or point == define.HUMAN_EQUIP.HEQUIP_UNKNOW2
	or point == define.HUMAN_EQUIP.HEQUIP_FASHION
	or point == define.HUMAN_EQUIP.HEQUIP_WUHUN
	or point == define.HUMAN_EQUIP.LINGWU_JING
	or point == define.HUMAN_EQUIP.LINGWU_CHI
	or point == define.HUMAN_EQUIP.LINGWU_JIA
	or point == define.HUMAN_EQUIP.LINGWU_GOU
	or point == define.HUMAN_EQUIP.LINGWU_DAI
	or point == define.HUMAN_EQUIP.LINGWU_DI then
	-- or point == define.HUMAN_EQUIP.SHENBING
	-- or point == define.HUMAN_EQUIP.HEQUIP_ALL
		self:notify_tips(selfId, "不开放强化的装备")
		return
	end
	local level = self:LuaFnGetEquipEnhanceLevel(selfId, ItemPos)
	if level >= 9 then
		self:notify_tips(selfId, "该装备强化等级已超过9级")
		return
	end
	local cost = 92300
	if check == 0 then
		self:BeginUICommand()
		self:UICommand_AddInt(ItemPos)
		local BagItem = self:GetBagItem(selfId, ItemPos)
		local str = self:ContactArgs("#{QHTS_200710_04", BagItem:get_base_config().name, level, cost)
		self:UICommand_AddStr(str .. "}")
		self:EndUICommand()
		self:DispatchUICommand(selfId, 80926201)
	else
		if self:GetYuanBao(selfId) < cost then
			self:notify_tips(selfId, "元宝不足!")
			return
		end
		self:LuaFnCostYuanBao(selfId, cost)
		self:SetBagItemParam(selfId, ItemPos, 9, 0, "ushort")
		self:LuaFnSetEquipEnhanceLevel(selfId, ItemPos, 9)
		self:LuaFnUpdateEquipEnhanceInfo(selfId, ItemPos)
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
		self:notify_tips(selfId, "快捷强化成功")
	end
end

function equip_enhance:GetBagDarkLevel(selfId, BagPos)
    local obj = self.scene:get_obj_by_id(selfId)
    assert(obj, selfId)
    local anqi = obj:get_prop_bag_container():get_item(BagPos)
    assert(anqi, BagPos)
	local level = self:GetBagItemLevel(selfId, BagPos)
	local xiulian_level = anqi:get_equip_data():get_aq_xiulian()
    return (xiulian_level > level) and xiulian_level or level
end

return equip_enhance