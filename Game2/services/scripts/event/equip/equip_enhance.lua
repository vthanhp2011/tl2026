--装备强化
--脚本号
local gbk = require "gbk"
local define = require "define"
local class = require "class"
local script_base = require "script_base"
local equip_enhance = class("equip_enhance", script_base)

local g_QianghualuId = 30900045
local g_QianghualuTime = 11

function equip_enhance:FinishEnhance(selfId, itemidx1, itemidx2 )
	local locked = self:LuaFnIsItemLocked(selfId, itemidx1 )
	if locked then
        self:notify_tips(selfId, "该装备不可用。")
		return
	end
	local ret = self:LuaFnIsItemAvailable(selfId, itemidx2 )
	if not ret then
        self:notify_tips(selfId, "该强化精华或强化露不可用。")
		return
	end
	local equip_level = self:GetBagItemLevel(selfId, itemidx1 )
	local item_index = self:LuaFnGetItemTableIndexByIndex(selfId, itemidx2 )
	if equip_level < 40 then
		if item_index ~= 30900005 then
			--低级强化精华
			local str = string.format( "该装备强化需要%s。", self:GetItemName(30900005))
            self:notify_tips(selfId, str)
			return
		end
	else
		if item_index ~= 30900006 and item_index ~= g_QianghualuId then
			--高级强化精华
            local str = string.format( "该装备强化需要%s。", self:GetItemName(30900006))
            self:notify_tips(selfId, str)
			return
		end
	end
	--检查是否能够强化
	local ret, arg0 = self:LuaFnEquipEnhanceCheck(selfId, itemidx1, itemidx2 )
	local text="装备强化成功！"
	-- zchw
	item_index = self:LuaFnGetItemTableIndexByIndex(selfId, itemidx1)
	if (item_index ==10423024) or (item_index == 10422016) then --重楼玉，重楼戒
		if tonumber(item_index) == 30900006 then --强化精华
			local bindStatus = self:LuaFnGetItemBindStatus(selfId, itemidx2)
			if bindStatus then --绑定
				text = "该装备不能用已绑定的天罡强化精华强化！";
                self:notify_tips(selfId, text)
				return
			end
		end
	end
	if not self:LuaFnIsIdentd(selfId,itemidx1) then
		self:notify_tips(selfId,"未鉴定装备无法参与强化。")
		return
	end
	if ret == 0 then
		--强化消耗检查成功
		self:DoFinishEnhance(selfId, itemidx1, itemidx2)
		local bindStatus = self:LuaFnGetItemBindStatus(selfId, itemidx2)
		if bindStatus then
			self:LuaFnItemBind(selfId, itemidx1)
		end
		return
	end
	if ret == -1 then
		text="未知错误。"
	end
	if ret == -2 then
		text="装备不可用。"
	end
	if ret == -3 then
		--text="强化精华不可用。"
		text="强化精华或强化露不可用。"
	end
	if ret == -4 then
		text="该装备的强化等级已经最大。"
	end

	if ret == -5 then
		text="强化该装备需要#{_EXCHG%d}，您身上的现金不足。" --zchw
		text=string.format( text, arg0 )
	end
	if ret == -7 then
		text="该装备不能被强化。"
	end

	if ret == -6 then
		self:DoFinishEnhance(selfId, itemidx1, itemidx2)
		return
	end
    self:notify_tips(selfId, text)
end

function equip_enhance:DoFinishEnhance(selfId, itemidx1, itemidx2)
	local text="装备强化成功！"
	--强化
    local item_index = self:LuaFnGetItemTableIndexByIndex(selfId, itemidx2 )
	local ret,arg0 = self:LuaFnEquipEnhance(selfId, itemidx1, itemidx2 )
	if ret == 0 then
		if arg0 >= 2 then
			local szTranItm1	= self:GetBagItemTransfer(selfId, itemidx1 )
			local szTranItm2	= self:GetBagItemTransfer(selfId, itemidx2 )
			local name = self:LuaFnGetName(selfId)
			name = gbk.fromutf8(name)
			local szMsg = string.format( "#W#{_INFOUSR%s}#{EQ_1}#{_INFOMSG%s}#{EQ_2}%d#{EQ_3}#{_INFOMSG%s}#{EQ_4}", name, szTranItm2, arg0, szTranItm1 )
			--公告精简，小于5级的强化，不发公告
			if (arg0 >= 5) then
				self:AddGlobalCountNews(szMsg, true)
			end
		end
		if g_QianghualuId == item_index then
			local r, t = self:LuaFnEraseItemTimes(selfId, itemidx2, g_QianghualuTime )
			local szMsg = string.format( "天罡强化露剩余使用次数%d/%d", tonumber(t), tonumber(g_QianghualuTime) );
            self:notify_tips(selfId, szMsg)
		else
			self:LuaFnDecItemLayCount(selfId, itemidx2, 1)
		end
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0);
	end
	if ret == -1 then
		text="未知错误。"
	end
	if ret == -2 then
		text="装备不可用。"
	end
	if ret == -3 then
		text="强化精华不可用。"
	end
	if ret == -4 then
		text="该装备的强化等级已经最大。"
	end

	if ret == -5 then
		text="强化该装备需要#{_EXCHG%d}，您身上的现金不足。" --zchw
		text=string.format( text, arg0 )
	end

	if ret == -6 then
		text="好可惜啊您的装备强化失败了,别灰心!!!"
		if g_QianghualuId == item_index then
			local r, t = self:LuaFnEraseItemTimes(selfId, itemidx2, g_QianghualuTime )
			local szMsg = string.format( "天罡强化露剩余使用次数%d/%d", tonumber(t), tonumber(g_QianghualuTime) );
            self:notify_tips(selfId, szMsg)
		else
			self:LuaFnDecItemLayCount(selfId, itemidx2, 1)
		end
	end
	if self:LuaFnGetItemBindStatus(selfId,itemidx2) then
		--防止重复调用保留性能。
		--if not self:LuaFnGetItemBindStatus(selfId,itemidx1) then
			self:LuaFnItemBind(selfId,itemidx1) --成功后绑定装备
		--end
	end
    self:notify_tips(selfId, text)
end

function equip_enhance:DoQuickQiangHuaByYB(selfId, ItemPos, check)
	local cost = 85626
	if check == 0 then
		self:BeginUICommand()
		self:UICommand_AddInt(ItemPos)
		local BagItem = self:GetBagItem(selfId, ItemPos)
		local level = self:LuaFnGetEquipEnhanceLevel(selfId, ItemPos)
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
		self:LuaFnSetEquipEnhanceLevel(selfId, ItemPos, 9)
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
		self:notify_tips(selfId, "快捷强化成功")
	end
end

function equip_enhance:FinishMoveEnhance(selfId,Item1,Item2)
	if Item2 == Item1 then
	    return
	end
	local ret = self:LuaFnIsItemLocked(selfId, Item1 )
	if ret then
		self:notify_tips(selfId, "#{ZBQH_130521_13}" )
		return
	end
	ret = self:LuaFnIsItemAvailable(selfId, Item2 )
	if not ret then
		self:notify_tips(selfId, "#{ZBQH_130521_20}" )
		return
	end
	local gem_index1 = self:LuaFnGetItemTableIndexByIndex(selfId, Item1 )
	local gem_index2 = self:LuaFnGetItemTableIndexByIndex(selfId, Item2 )
	local equipType1 = self:GetItemEquipPoint(gem_index1 )
	local equipType2 = self:GetItemEquipPoint(gem_index2 )
	local curlevel1  = self:LuaFnGetEquipEnhanceLevel(selfId,Item1)
	local curlevel2  = self:LuaFnGetEquipEnhanceLevel(selfId,Item2)
	local Equip_Level1 = self:GetBagItemLevel(selfId, Item1 )
	local Equip_Level2 = self:GetBagItemLevel(selfId, Item2 )
	local leftItemName = self:GetItemName(gem_index1)
	local systemstringid =""
	if equipType1 == -1 or equipType2 == -1 then
		return
	end
	if equipType1 == define.HUMAN_EQUIP.HEQUIP_ANQI then
		Equip_Level1 = self:GetBagDarkLevel(selfId, Item1)
	end
	if equipType2 == define.HUMAN_EQUIP.HEQUIP_ANQI then
		Equip_Level2 = self:GetBagDarkLevel(selfId, Item2)
	end
	if equipType1 ~= equipType2 then
		if Equip_Level1 < 40 then
			systemstringid = string.format("#H仅可将%s#H的强化等级转移至装备等级不足40级的%s#H之上。",leftItemName, g_EquipName[Equip_Level1].name)
		end
		if Equip_Level1 >= 40 then
			systemstringid =  string.format("#H仅可将%s#H的强化等级转移至装备等级达到40级及以上等级的%s#H之上。",leftItemName, g_EquipName[Equip_Level1].name)
		end
		self:notify_tips(selfId, systemstringid)
		return
	end
	if Equip_Level1 < 40 and Equip_Level2 >= 40 then
		systemstringid = string.format("#H仅可将%s#H的强化等级转移至装备等级不足40级的%s#H之上。",leftItemName, g_EquipName[Equip_Level1].name)
		self:notify_tips(selfId, systemstringid)
		return
	end
    if Equip_Level1 >= 40 and Equip_Level2 < 40 then
		systemstringid = string.format("#H仅可将%s#H的强化等级转移至装备等级达到40级及以上等级的%s#H之上。",leftItemName, g_EquipName[Equip_Level1].name)
		self:notify_tips(selfId, systemstringid)
		return
	end
	if curlevel1 <= curlevel2 then
		systemstringid = string.format("#H该装备的强化等级已达到或超过源装备的强化等级：%s#H级，无法接受转移。",curlevel1)
		self:notify_tips(selfId, systemstringid)
		return
	end
	local NeedMoney = curlevel1*5
	if NeedMoney > 100 then
		NeedMoney = 100
	end
	local nMoneyJZ = self:GetMoneyJZ(selfId)
	local nMoneyJB = self:GetMoney(selfId)
	local nMoneySelf = nMoneyJZ + nMoneyJB
	if nMoneySelf < NeedMoney*10000 then
		self:notify_tips(selfId, "转移强化需要#{_EXCHG%d}，您的金钱不足",NeedMoney*10000)
		return
	end
	--原装备数据清空
	self:LuaFnSetEquipEnhanceLevel(selfId,Item1,0)
	self:LuaFnCostMoneyWithPriority(selfId, NeedMoney*10000 );
	--目标装备数据存储
	self:LuaFnSetEquipEnhanceLevel(selfId,Item2,curlevel1)
	if self:LuaFnGetItemBindStatus(selfId,Item1) then
		--防止重复调用保留性能。
		--if not self:LuaFnGetItemBindStatus(selfId,Item2) then
			self:LuaFnItemBind(selfId,Item2) --成功后绑定装备
		--end
	end
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0);
	self:notify_tips(selfId, "恭喜您，强化转移成功！！")
	local szTranItm2 = self:GetBagItemTransfer(selfId, Item2 )
	local name = self:LuaFnGetName(selfId )
	local szMsg	= string.format( "#W#{_INFOUSR%s}#G花费了#{_EXCHG%d}成功把#Y" .. leftItemName .. "#G上的强化转移到#{_INFOMSG%%s}上", name, NeedMoney*10000)
	szMsg = gbk.fromutf8(szMsg)
	szMsg = string.format(szMsg, szTranItm2)
	self:AddGlobalCountNews(szMsg, true)
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