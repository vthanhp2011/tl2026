local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ScriptGlobal = require "scripts.ScriptGlobal"
local weapon_jinjie = class("weapon_jinjie", script_base)
weapon_jinjie.script_id = 900069

--特殊进阶
weapon_jinjie.open_special_jj = true			--是否开启九星进阶，重洗
weapon_jinjie.special_jj = {
	[10300103] = 10513141,
	[10300104] = 10513142,
	[10300105] = 10513143,
	[10300106] = 10513144,
	[10300107] = 10513145,
	[10300108] = 10513146,
	[10300109] = 10513147,
	[10300110] = 10513148,
	[10300111] = 10513149,
	[10301103] = 10513150,
	[10301104] = 10513151,
	[10301105] = 10513152,
	[10301106] = 10513153,
	[10301107] = 10513154,
	[10301108] = 10513155,
	[10301109] = 10513156,
	[10301110] = 10513157,
	[10301111] = 10513158,
	[10301203] = 10513159,
	[10301204] = 10513160,
	[10301205] = 10513161,
	[10301206] = 10513162,
	[10301207] = 10513163,
	[10301208] = 10513164,
	[10301209] = 10513165,
	[10301210] = 10513166,
	[10301211] = 10513167,
	[10302103] = 10513168,
	[10302104] = 10513169,
	[10302105] = 10513170,
	[10302106] = 10513171,
	[10302107] = 10513172,
	[10302108] = 10513173,
	[10302109] = 10513174,
	[10302110] = 10513175,
	[10302111] = 10513176,
	[10302203] = 10513177,
	[10302204] = 10513178,
	[10302205] = 10513179,
	[10302206] = 10513180,
	[10302207] = 10513181,
	[10302208] = 10513182,
	[10302209] = 10513183,
	[10302210] = 10513184,
	[10302211] = 10513185,
	[10303103] = 10513186,
	[10303104] = 10513187,
	[10303105] = 10513188,
	[10303106] = 10513189,
	[10303107] = 10513190,
	[10303108] = 10513191,
	[10303109] = 10513192,
	[10303110] = 10513193,
	[10303111] = 10513194,
	[10303203] = 10513195,
	[10303204] = 10513196,
	[10303205] = 10513197,
	[10303206] = 10513198,
	[10303207] = 10513199,
	[10303208] = 10513200,
	[10303209] = 10513201,
	[10303210] = 10513202,
	[10303211] = 10513203,
	[10304103] = 10513204,
	[10304104] = 10513205,
	[10304105] = 10513206,
	[10304106] = 10513207,
	[10304107] = 10513208,
	[10304108] = 10513209,
	[10304109] = 10513210,
	[10304110] = 10513211,
	[10304111] = 10513212,
	[10305103] = 10513213,
	[10305104] = 10513214,
	[10305105] = 10513215,
	[10305106] = 10513216,
	[10305107] = 10513217,
	[10305108] = 10513218,
	[10305109] = 10513219,
	[10305110] = 10513220,
	[10305111] = 10513221,
	[10305203] = 10513222,
	[10305204] = 10513223,
	[10305205] = 10513224,
	[10305206] = 10513225,
	[10305207] = 10513226,
	[10305208] = 10513227,
	[10305209] = 10513228,
	[10305210] = 10513229,
	[10305211] = 10513230,
	[10306103] = 10513231,
	[10306104] = 10513232,
	[10306105] = 10513233,
	[10306106] = 10513234,
	[10306107] = 10513235,
	[10306108] = 10513236,
	[10306109] = 10513237,
	[10306110] = 10513238,
	[10306111] = 10513239,
	[10307103] = 10513240,
	[10307104] = 10513241,
	[10307105] = 10513242,
	[10307106] = 10513243,
	[10307107] = 10513244,
	[10307108] = 10513245,
	[10307109] = 10513246,
	[10307110] = 10513247,
	[10307111] = 10513248,
}
weapon_jinjie.special_jj_item_a1 = 30505833
weapon_jinjie.special_jj_item_a2 = 30505834
weapon_jinjie.special_jj_item_count_a = 1960
weapon_jinjie.special_jj_item_b1 = 30505827
weapon_jinjie.special_jj_item_b2 = 30505828
weapon_jinjie.special_jj_item_count_b = 200
weapon_jinjie.special_cx_item_1 = 30505835
weapon_jinjie.special_cx_item_2 = 30505836
weapon_jinjie.special_cx_item_count = 5


--当前最高开放20
--开放装备契合最大等级 这里的需要金钱少 加的属性少   等级尽量整10设置 如 10，9，30
weapon_jinjie.limit_equip_id_1 = {
}

--开放装备契合最大等级 这里的需要金钱中 加的属性中   等级尽量整10设置 如 10，20，30
weapon_jinjie.limit_equip_id_2 = {

}

--开放装备契合最大等级 这里的需要金钱多 加的属性多   等级尽量整10设置 如 10，20，30
weapon_jinjie.limit_equip_id_3 = {
	[10300103] = 20,
	[10300104] = 20,
	[10300105] = 20,
	[10300106] = 20,
	[10300107] = 20,
	[10300108] = 20,
	[10300109] = 20,
	[10300110] = 20,
	[10300111] = 20,

	[10301103] = 20,
	[10301104] = 20,
	[10301105] = 20,
	[10301106] = 20,
	[10301107] = 20,
	[10301108] = 20,
	[10301109] = 20,
	[10301110] = 20,
	[10301111] = 20,

	[10301203] = 20,
	[10301204] = 20,
	[10301205] = 20,
	[10301206] = 20,
	[10301207] = 20,
	[10301208] = 20,
	[10301209] = 20,
	[10301210] = 20,
	[10301211] = 20,

	[10302103] = 20,
	[10302104] = 20,
	[10302105] = 20,
	[10302106] = 20,
	[10302107] = 20,
	[10302108] = 20,
	[10302109] = 20,
	[10302110] = 20,
	[10302111] = 20,

	[10302203] = 20,
	[10302204] = 20,
	[10302205] = 20,
	[10302206] = 20,
	[10302207] = 20,
	[10302208] = 20,
	[10302209] = 20,
	[10302210] = 20,
	[10302211] = 20,

	[10303103] = 20,
	[10303104] = 20,
	[10303105] = 20,
	[10303106] = 20,
	[10303107] = 20,
	[10303108] = 20,
	[10303109] = 20,
	[10303110] = 20,
	[10303111] = 20,

	[10303203] = 20,
	[10303204] = 20,
	[10303205] = 20,
	[10303206] = 20,
	[10303207] = 20,
	[10303208] = 20,
	[10303209] = 20,
	[10303210] = 20,
	[10303211] = 20,

	[10304103] = 20,
	[10304104] = 20,
	[10304105] = 20,
	[10304106] = 20,
	[10304107] = 20,
	[10304108] = 20,
	[10304109] = 20,
	[10304110] = 20,
	[10304111] = 20,

	[10305103] = 20,
	[10305104] = 20,
	[10305105] = 20,
	[10305106] = 20,
	[10305107] = 20,
	[10305108] = 20,
	[10305109] = 20,
	[10305110] = 20,
	[10305111] = 20,

	[10305203] = 20,
	[10305204] = 20,
	[10305205] = 20,
	[10305206] = 20,
	[10305207] = 20,
	[10305208] = 20,
	[10305209] = 20,
	[10305210] = 20,
	[10305211] = 20,

	[10306103] = 20,
	[10306104] = 20,
	[10306105] = 20,
	[10306106] = 20,
	[10306107] = 20,
	[10306108] = 20,
	[10306109] = 20,
	[10306110] = 20,
	[10306111] = 20,

	[10307103] = 20,
	[10307104] = 20,
	[10307105] = 20,
	[10307106] = 20,
	[10307107] = 20,
	[10307108] = 20,
	[10307109] = 20,
	[10307110] = 20,
	[10307111] = 20,
}


--契合三档 需求材料，金钱，数量
weapon_jinjie.equip_qh_cost_1 = {
	[1] = {item_id = 30505821,item_id_bind = 30505822,
			money = {33800,36700,40500,45100,50600,56900,64000,72000},
			count = {5,9,14,22,29,36,43,50}},
	[2] = {item_id = 30505821,item_id_bind = 30505822,
			money = {90500,101000,112300,124500,137500,151400,166100,181600},
			count = {50,54,58,62,66,70,74,78}},
}

weapon_jinjie.equip_qh_cost_2 = {
	[1] = {item_id = 30505821,item_id_bind = 30505822,
			money = {45000,49000,54000,60200,67400,75800,85400,96000},
			count = {5,9,14,22,29,36,43,50}},
	[2] = {item_id = 30505821,item_id_bind = 30505822,
			money = {120600,134600,149800,166000,183400,201800,221400,242200},
			count = {50,54,58,62,66,70,74,78}},
}

weapon_jinjie.equip_qh_cost_3 = {
	[1] = {item_id = 30505821,item_id_bind = 30505822,
			money = {56300,61200,67500,75200,84300,94800,106700,120000},
			count = {5,9,14,22,29,36,43,50}},
	[2] = {item_id = 30505821,item_id_bind = 30505822,
			money = {150800,168300,187200,207500,229200,252300,276800,302700},
			count = {50,54,58,62,66,70,74,78}},
}
--进阶三档 需求材料，数量，金钱，进阶后的契合等级
weapon_jinjie.equip_jinjie_cost_money_1 = {
	[1] = {item_id = 30505827,item_id_bind = 30505828,count = 1,money = 90000,level = 11},
	[2] = {item_id = 30505829,item_id_bind = 30505830,count = 1,money = 210000,level = 20},
}
weapon_jinjie.equip_jinjie_cost_money_2 = {
	[1] = {item_id = 30505827,item_id_bind = 30505828,count = 1,money = 120000,level = 111},
	[2] = {item_id = 30505829,item_id_bind = 30505830,count = 1,money = 280000,level = 120},
}
weapon_jinjie.equip_jinjie_cost_money_3 = {
	[1] = {item_id = 30505827,item_id_bind = 30505828,count = 1,money = 150000,level = 211},
	[2] = {item_id = 30505829,item_id_bind = 30505830,count = 1,money = 350000,level = 220},
}
weapon_jinjie.item_tl = 30505818
weapon_jinjie.item_count_tl = 1
weapon_jinjie.money_tl = 50000

function weapon_jinjie:super_weapon_tl(selfId,bag_pos_equip,bag_pos_item)
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,bag_pos_equip)
	if not equip_qhd then
		return
	elseif equip_qhd > 0 then
		self:notify_tips(selfId, "装备已通灵。")
		return
	elseif not self:CheckEquipTL(selfId,equip_id) then
		return
	end
	local curlv
	if self.limit_equip_id_1[equip_id] then
		curlv = 1
	elseif self.limit_equip_id_2[equip_id] then
		curlv = 101
	elseif self.limit_equip_id_3[equip_id] then
		curlv = 201
	else
		self:notify_tips(selfId, "该装备不开放通灵。")
		return
	end
	if not self:CheckMoney(selfId,self.money_tl) then
		return
	end
	if self:LuaFnGetItemTableIndexByIndex(selfId,bag_pos_item) ~= self.item_tl then
		local msg = string.format("未放入%s",self:GetItemName(self.item_tl))
		self:notify_tips(selfId,msg)
		return
	elseif self:GetBagItemLayCount(selfId,bag_pos_item) < self.item_count_tl then
		self:MaterialNotEnoughTip(selfId,self.item_tl,self.item_count_tl)
		return
	end
	self:LuaFnDecItemLayCount(selfId,bag_pos_item,self.item_count_tl)
	self:LuaFnCostMoneyWithPriority(selfId,self.money_tl)
	self:SetEquipQHD(selfId,bag_pos_equip,curlv,1)
	self:notify_tips(selfId,"通灵成功。")
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
function weapon_jinjie:super_weapon_qh(selfId,bag_pos)
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,bag_pos)
	if not equip_qhd then
		return
	elseif equip_qhd == 0 then
		self:notify_tips(selfId,"装备未通灵。")
		return
	end
	local up_lx = equip_qhd % 100
	local idx = up_lx // 10 + 1
	local tbl
	if self.limit_equip_id_1[equip_id] then
		if up_lx >= self.limit_equip_id_1[equip_id] then
			if not open_special_jj then
				self:notify_tips(selfId,"契合已达上限。")
			else
				self:notify_tips(selfId,"契合已达上限，八星神器可再次进阶成九星王者·神器。")
			end
			return
		end
		tbl = self.equip_qh_cost_1[idx]
	elseif self.limit_equip_id_2[equip_id] then
		if up_lx >= self.limit_equip_id_2[equip_id] then
			if not open_special_jj then
				self:notify_tips(selfId,"契合已达上限。")
			else
				self:notify_tips(selfId,"契合已达上限，八星神器可再次进阶成九星王者·神器。")
			end
			return
		end
		tbl = self.equip_qh_cost_2[idx]
	elseif self.limit_equip_id_3[equip_id] then
		if up_lx >= self.limit_equip_id_3[equip_id] then
			if not open_special_jj then
				self:notify_tips(selfId,"契合已达上限。")
			else
				self:notify_tips(selfId,"契合已达上限，八星神器可再次进阶成九星王者·神器。")
			end
			return
		end
		tbl = self.equip_qh_cost_3[idx]
	end
	if not tbl then
		local msg = string.format("检测到异常:[%d]",equip_qhd)
		self:notify_tips(selfId,msg)
		return
	end
	local qhd = equip_qhd % 10
	if qhd == 9 then
		self:notify_tips(selfId,"需要进阶后方可再契合。")
		return
	end
	local need_id = tbl.item_id
	local need_id_bind = tbl.item_id_bind
	local need_count = tbl.count[qhd]
	local need_money = tbl.money[qhd]
	if not need_id or not need_id_bind or not need_count or not need_money then
		local msg = string.format("检测到异常:[%d][%s][%s][%s][%s]",equip_qhd,
		tostring(need_id),tostring(need_id_bind),tostring(need_count),tostring(need_money))
		self:notify_tips(selfId,msg)
		return
	elseif not self:CheckMoney(selfId,need_money) then
		return
	end
	local num = self:LuaFnGetAvailableItemCount(selfId,need_id)
	local num_bind = self:LuaFnGetAvailableItemCount(selfId,need_id_bind)
	if num + num_bind < need_count then
		self:MaterialNotEnoughTip(selfId,need_id,need_count)
		return
	end
	if num_bind >= need_count then
		self:LuaFnDelAvailableItem(selfId,need_id_bind,need_count)
	else
		if num_bind > 0 then
			self:LuaFnDelAvailableItem(selfId,need_id_bind,num_bind)
			need_count = need_count - num_bind
		end
		self:LuaFnDelAvailableItem(selfId,need_id,need_count)
	end
	self:LuaFnCostMoneyWithPriority(selfId,need_money)
	equip_qhd = equip_qhd + 1
	self:SetEquipQHD(selfId,bag_pos,equip_qhd,1)
	self:notify_tips(selfId,"契合成功。")
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
	self:BeginUICommand()
	self:UICommand_AddInt(0)
	self:UICommand_AddInt(bag_pos)
	self:UICommand_AddInt(equip_qhd)
	self:EndUICommand()
	self:DispatchUICommand(selfId,60000170)
	-- self:LuaFnRefreshItemInfo(selfId, bag_pos)
end

function weapon_jinjie:super_weapon_special_jj(flag,selfId,bag_pos,equip_id,equip_qhd)
	if flag ~= "special_jj" then
		return
	end
	local newid = self.special_jj[equip_id]
	if not newid then
		self:notify_tips(selfId,"该神器未开放九星进阶。")
		return
	end
	local a_num = self:LuaFnGetAvailableItemCount(selfId,self.special_jj_item_a1)
	local a_num_bind = self:LuaFnGetAvailableItemCount(selfId,self.special_jj_item_a2)
	local a_need_count = self.special_jj_item_count_a
	if a_num + a_num_bind < a_need_count then
		self:MaterialNotEnoughTip(selfId,self.special_jj_item_a1,a_need_count)
		return
	end
	local b_num = self:LuaFnGetAvailableItemCount(selfId,self.special_jj_item_b1)
	local b_num_bind = self:LuaFnGetAvailableItemCount(selfId,self.special_jj_item_b2)
	local b_need_count = self.special_jj_item_count_b
	if b_num + b_num_bind < b_need_count then
		self:MaterialNotEnoughTip(selfId,self.special_jj_item_b1,b_need_count)
		return
	end
	if a_num_bind >= a_need_count then
		self:LuaFnDelAvailableItem(selfId,self.special_jj_item_a2,a_need_count)
	else
		if a_num_bind > 0 then
			self:LuaFnDelAvailableItem(selfId,self.special_jj_item_a2,a_num_bind)
			a_need_count = a_need_count - a_num_bind
		end
		self:LuaFnDelAvailableItem(selfId,self.special_jj_item_a1,a_need_count)
	end
	if b_num_bind >= b_need_count then
		self:LuaFnDelAvailableItem(selfId,self.special_jj_item_b2,a_need_count)
	else
		if b_num_bind > 0 then
			self:LuaFnDelAvailableItem(selfId,self.special_jj_item_b2,b_num_bind)
			b_need_count = b_need_count - b_num_bind
		end
		self:LuaFnDelAvailableItem(selfId,self.special_jj_item_b1,b_need_count)
	end
	local ret = self:LuaFnRefreshEquipID_Attr(selfId,bag_pos,newid,1)
	if ret == 0 then
		self:ShowObjBuffEffect(selfId,selfId,-1,18)
		self:notify_tips(selfId,"进阶成功。")
	else
		local msg = string.format("进阶出错:%s",tostring(ret))
		self:notify_tips(selfId,msg)
	end
end

function weapon_jinjie:super_weapon_jj(selfId,bag_pos)
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,bag_pos)
	if not equip_qhd then
		return
	elseif equip_qhd == 0 then
		self:notify_tips(selfId,"装备未通灵。")
		return
	end
	local up_lx = equip_qhd % 100
	local idx = up_lx // 10 + 1
	local tbl
	if self.limit_equip_id_1[equip_id] then
		if up_lx >= self.limit_equip_id_1[equip_id] then
			if not self.open_special_jj then
				self:notify_tips(selfId,"契合已达上限。")
			else
				self:super_weapon_special_jj("special_jj",selfId,bag_pos,equip_id,equip_qhd)
			end
			return
		end
		tbl = self.equip_jinjie_cost_money_1[idx]
	elseif self.limit_equip_id_2[equip_id] then
		if up_lx >= self.limit_equip_id_2[equip_id] then
			if not self.open_special_jj then
				self:notify_tips(selfId,"契合已达上限。")
			else
				self:super_weapon_special_jj("special_jj",selfId,bag_pos,equip_id,equip_qhd)
			end
			return
		end
		tbl = self.equip_jinjie_cost_money_2[idx]
	elseif self.limit_equip_id_3[equip_id] then
		if up_lx >= self.limit_equip_id_3[equip_id] then
			if not self.open_special_jj then
				self:notify_tips(selfId,"契合已达上限。")
			else
				self:super_weapon_special_jj("special_jj",selfId,bag_pos,equip_id,equip_qhd)
			end
			return
		end
		tbl = self.equip_jinjie_cost_money_3[idx]
	end
	if not tbl then
		local msg = string.format("检测到异常:[%d]",equip_qhd)
		self:notify_tips(selfId,msg)
		return
	end
	local qhd = equip_qhd % 10
	if qhd ~= 9 then
		self:notify_tips(selfId,"契合度未达到9。")
		return
	end
	local need_id = tbl.item_id
	local need_id_bind = tbl.item_id_bind
	local need_count = tbl.count
	local need_money = tbl.money
	local new_qhd = tbl.level
	if not need_id or not need_id_bind or not need_count or not need_money then
		local msg = string.format("检测到异常:[%d][%s][%s][%s][%s][%s]",equip_qhd,
		tostring(need_id),tostring(need_id_bind),tostring(need_count),tostring(need_money),tostring(new_qhd))
		self:notify_tips(selfId,msg)
		return
	elseif not self:CheckMoney(selfId,need_money) then
		return
	end
	local num = self:LuaFnGetAvailableItemCount(selfId,need_id)
	local num_bind = self:LuaFnGetAvailableItemCount(selfId,need_id_bind)
	if num + num_bind < need_count then
		self:MaterialNotEnoughTip(selfId,need_id,need_count)
		return
	end
	if num_bind >= need_count then
		self:LuaFnDelAvailableItem(selfId,need_id_bind,need_count)
	else
		if num_bind > 0 then
			self:LuaFnDelAvailableItem(selfId,need_id_bind,num_bind)
			need_count = need_count - num_bind
		end
		self:LuaFnDelAvailableItem(selfId,need_id,need_count)
	end
	self:LuaFnCostMoneyWithPriority(selfId,need_money)
	self:SetEquipJinJie(selfId,bag_pos,new_qhd,new_qhd - equip_qhd)
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
	self:notify_tips(selfId,"进阶成功。")
end
--九星返还暂未开放
function weapon_jinjie:super_weapon_fh(selfId,bag_pos)
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,bag_pos)
	if not equip_qhd then
		return
	elseif equip_qhd == 0 then
		self:notify_tips(selfId,"装备未通灵。")
		return
	end
	local up_lx = equip_qhd % 100
	local tbl,tbl2
	if self.limit_equip_id_1[equip_id] then
		if up_lx > self.limit_equip_id_1[equip_id] then
			self:notify_tips(selfId,"契合度异常。")
			return
		end
		tbl = self.equip_qh_cost_1
		tbl2 = self.equip_jinjie_cost_money_1
	elseif self.limit_equip_id_2[equip_id] then
		if up_lx > self.limit_equip_id_2[equip_id] then
			self:notify_tips(selfId,"契合度异常。")
			return
		end
		tbl = self.equip_qh_cost_2
		tbl2 = self.equip_jinjie_cost_money_2
	elseif self.limit_equip_id_3[equip_id] then
		if up_lx > self.limit_equip_id_3[equip_id] then
			self:notify_tips(selfId,"契合度异常。")
			return
		end
		tbl = self.equip_qh_cost_3
		tbl2 = self.equip_jinjie_cost_money_3
	end
	if not tbl or not tbl2 then
		local msg = string.format("检测到异常:[%d]",equip_qhd)
		self:notify_tips(selfId,msg)
		return
	end
	local nv_wa_1,nv_wa_2,qhd
	local nv_wa_1_count,nv_wa_2_count
	local back_item = {}
	local money = 20000
	if up_lx > 1 then
		if up_lx <= 11 then
			qhd = up_lx
			if up_lx > 9 then
				nv_wa_1 = tbl2[1].item_id_bind
				nv_wa_1_count = tbl2[1].count
				qhd = 9
			end
			local item_id = tbl[1].item_id_bind
			back_item[item_id] = back_item[item_id] or 0
			for i = 2,qhd do
				back_item[item_id] = back_item[item_id] + tbl[1].count[i - 1]
			end
			local tbl = {33800,70500,111000,156100,206700,263600,327600,399600,481600};
			money = tbl[qhd];
		elseif up_lx <= 20 then
			nv_wa_1 = tbl2[1].item_id_bind
			nv_wa_1_count = tbl2[1].count
			local qhds = {9,1}
			if up_lx > 19 then
				nv_wa_2 = tbl2[2].item_id_bind
				nv_wa_2_count = tbl2[2].count
				qhds[2] = 9
			else
				qhds[2] = up_lx % 10
			end
			local item_id
			for n = 1,2 do
				qhd = qhds[n]
				item_id = tbl[n].item_id_bind
				back_item[item_id] = back_item[item_id] or 0
				for i = 2,qhd do
					back_item[item_id] = back_item[item_id] + tbl[n].count[i - 1]
				end
			end
			qhd = qhds[2]
			local tbl = {33800,70500,111000,156100,206700,263600,327600,399600,481600};
			money = tbl[qhd];
		else
			self:notify_tips(selfId,"未开放")
			return
		end
	end
	if not self:CheckMoney(selfId,money) then
		return
	end
	self:BeginAddItem()
	self:AddItem(self.item_tl,self.item_count_tl,true)
	if nv_wa_1 and nv_wa_1_count then
		self:AddItem(nv_wa_1,nv_wa_1_count,true)
	end
	if nv_wa_2 and nv_wa_2_count then
		self:AddItem(nv_wa_2,nv_wa_2_count,true)
	end
	for id,num in pairs(back_item) do
		self:AddItem(id,num,true)
	end
	if not self:EndAddItem(selfId,true) then
		return
	end
	if self:EmptyEquipQHD(selfId,bag_pos) then
		self:LuaFnCostMoneyWithPriority(selfId,money)
		self:BeginAddItem()
		self:AddItem(self.item_tl,self.item_count_tl,true)
		if nv_wa_1 and nv_wa_1_count then
			self:AddItem(nv_wa_1,nv_wa_1_count,true)
		end
		if nv_wa_2 and nv_wa_2_count then
			self:AddItem(nv_wa_2,nv_wa_2_count,true)
		end
		for id,num in pairs(back_item) do
			self:AddItem(id,num,true)
		end
		-- if not self:EndAddItem(selfId) then
			-- return
		-- end
		self:AddItemListToHuman(selfId)
		self:ShowObjBuffEffect(selfId,selfId,-1,18)
		self:notify_tips(selfId,"蜕灵成功。")
	else
		self:notify_tips(selfId,"蜕灵失败。")
	end
end

function weapon_jinjie:DiscardNewEquipAttr(selfId, BagPos)
    self:LuaFnFinishRefreshEquipAttr(selfId, BagPos, false)
end

function weapon_jinjie:SwitchEquipAttr(selfId, BagPos)
    self:LuaFnFinishRefreshEquipAttr(selfId, BagPos, true)
end

function weapon_jinjie:RefreshEquipAttr(selfId,bag_pos)
	local item_id = 30505831
	local item_id_bine = 30505832
	local need_count = 5
	local is_special = false
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,bag_pos)
	if not equip_qhd then
		return
	elseif equip_qhd == 0 then
		self:notify_tips(selfId,"装备未通灵。")
		return
	elseif equip_qhd >= 20 then
		if not self.open_special_jj then
			if not self.special_jj[equip_id] then
				self:notify_tips(selfId,"该神器未开放重洗。")
				return
			end
		else
			if not self.special_jj[equip_id] then
				item_id = self.special_cx_item_1
				item_id_bine = self.special_cx_item_2
				need_count = self.special_cx_item_count
				is_special = true
			end
		end
	end
	if not self:CheckMoney(selfId,50000) then
		return
	end
	local num = self:LuaFnGetAvailableItemCount(selfId,item_id)
	local num_bind = self:LuaFnGetAvailableItemCount(selfId,item_id_bine)
	if num + num_bind < need_count then
		self:MaterialNotEnoughTip(selfId,item_id,need_count)
		return
	end
	if num_bind >= need_count then
		self:LuaFnDelAvailableItem(selfId,item_id_bine,need_count)
	else
		if num_bind > 0 then
			self:LuaFnDelAvailableItem(selfId,item_id_bine,num_bind)
			need_count = need_count - num_bind
		end
		self:LuaFnDelAvailableItem(selfId,item_id,need_count)
	end
	self:LuaFnCostMoneyWithPriority(selfId,50000)
	if is_special then
		self:LuaFnRefreshEquipAttr_SpecialWeapon(selfId,bag_pos)
	else
		self:LuaFnRefreshEquipAttr_QH(selfId,bag_pos)
	end
end
function weapon_jinjie:fetch_item_data(selfId,index,bag_pos)
	local equip_id,equip_qhd = self:GetEquipQHD(selfId,bag_pos)
	if not equip_qhd then
		return
	end
	self:BeginUICommand()
	self:UICommand_AddInt(index)
	self:UICommand_AddInt(bag_pos)
	self:UICommand_AddInt(equip_qhd)
	self:EndUICommand()
	self:DispatchUICommand(selfId,60000170)
end

return weapon_jinjie