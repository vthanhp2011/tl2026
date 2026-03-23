local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ScriptGlobal = require "scripts.ScriptGlobal"
local CDK = class("CDK", script_base)
CDK.script_id = 900067

CDK.create_cdk_ini_doc = "cdk_250328_design"
CDK.create_cdk_ini_doc_claimed = "cdk_250328_design_claimed"

--[[CDK.create_cdk_ini = {
	{item_id = 38008168,item_num = 1,cdk_count = 500,cdk_price = 20},
	{item_id = 38008169,item_num = 1,cdk_count = 286,cdk_price = 20},
	{item_id = 38008170,item_num = 1,cdk_count = 150,cdk_price = 20},
	{item_id = 38008172,item_num = 1,cdk_count = 30,cdk_price = 20},
	{item_id = 38008174,item_num = 1,cdk_count = 15,cdk_price = 20},
	{item_id = 38008179,item_num = 1,cdk_count = 10,cdk_price = 20},
	{item_id = 38008180,item_num = 1,cdk_count = 5,cdk_price = 20},
	{item_id = 38008181,item_num = 1,cdk_count = 3,cdk_price = 20},
	{item_id = 38008183,item_num = 1,cdk_count = 1,cdk_price = 20},
	{item_id = 38002834,item_num = 1,cdk_count = 1000,cdk_price = 1},
}--]]
CDK.create_cdk_ini = {
	{item_id = 38008170,item_num = 1,cdk_count = 100,cdk_price = 50},
	{item_id = 38008172,item_num = 1,cdk_count = 60,cdk_price = 50},
	{item_id = 38008173,item_num = 1,cdk_count = 20,cdk_price = 50},
	{item_id = 38008174,item_num = 1,cdk_count = 10,cdk_price = 50},
	{item_id = 38008179,item_num = 1,cdk_count = 5,cdk_price = 50},
	{item_id = 38008180,item_num = 1,cdk_count = 2,cdk_price = 50},
	{item_id = 38008181,item_num = 1,cdk_count = 2,cdk_price = 50},
	{item_id = 38008184,item_num = 1,cdk_count = 1,cdk_price = 50},
}

--新增  CDK
function CDK:AddMoneyCardCount(selfId,count)
	
	
	local isgm = self:CallScriptFunction(900066, "IsGM", selfId)
	if isgm >= 3 then
		if #self.create_cdk_ini < 1 then
			return 0
		end
		local createstr = function()
			local value = math.random(6666)
			if value % 2 == 1 then
				value = math.random(65,90)
			else
				value = math.random(97,122)
			end
			return string.char(value)
		end
		local ndate = os.date("%Y-%m-%d %H:%M:%S")
		local add_data = {
					docindex = "null",
					createtimer = ndate.."(创建)",
					item_id = 0,
					item_name = "",
					item_num = 0,
					cdk_price = 0,
					playerguid = 0,
					playername = "",
					accountname = "",
					-- claim_time = "xxxxx(领取)",
					-- buy_time = "xxxxx(购买)"
					claim_time = "",
					buy_time = ""
		}
		
		
		local ok_msg = {"集合(",self.create_cdk_ini_doc,")生成结果:"}
		
		local add = 0
		local num,str = 0,0
		local index,cdkinfo,istrue,istrue2
		local datalx = {"","","","","",""}
		
		for _,ct_info in ipairs(self.create_cdk_ini) do
		
			local ct_num = ct_info.cdk_count
			local ct_num_ing = 0
			add_data.item_id = ct_info.item_id
			add_data.item_name = self:GetItemName(add_data.item_id)
			add_data.item_num = ct_info.item_num
			add_data.cdk_price = ct_info.cdk_price
			table.insert(ok_msg,"\n")
			table.insert(ok_msg,add_data.item_name)
			table.insert(ok_msg," X ")
			table.insert(ok_msg,ct_num)
			table.insert(ok_msg,"(价格:")
			table.insert(ok_msg,add_data.cdk_price)
			table.insert(ok_msg,")")
			for ct_load = 1,ct_num do
				for n_error = 1,20 do
					num,str = 0,0
					for i = 1,6 do
						index = math.random(6666) % 2
						if index == 1 then
							if num < 3 then
								num = num + 1
							else
								str = str + 1
								index = 0
							end
						else
							if str < 3 then
								str = str + 1
							else
								num = num + 1
								index = 1
							end
						end
						if index == 1 then
							index = math.random(111111,999999)
							datalx[i] = tostring(index)
						else
							datalx[i] = createstr()
						end
					end
					if num == 3 and str == 3 then
						cdkinfo = table.concat(datalx)
						istrue = self:LuaFnGetDocData(".char_db",self.create_cdk_ini_doc,cdkinfo,"findOne")
						if istrue then
							istrue = self:LuaFnGetDocData(".char_db",self.create_cdk_ini_doc_claimed,cdkinfo,"findOne")
							if not istrue then
								add_data.docindex = cdkinfo
								ct_num_ing = ct_num_ing + 1
								self:LuaFnSetAddDocData(".char_db",self.create_cdk_ini_doc,add_data)
								break
							end
						else
							add_data.docindex = cdkinfo
							ct_num_ing = ct_num_ing + 1
							self:LuaFnSetAddDocData(".char_db",self.create_cdk_ini_doc,add_data)
							break
						end
					end
				end
			end
			table.insert(ok_msg,"  ")
			table.insert(ok_msg,ct_num_ing)
			table.insert(ok_msg,"条")
		end
		local msg = table.concat(ok_msg)
		self:BeginUICommand()
		self:UICommand_AddInt(426042021)
		self:UICommand_AddStr(msg)
		self:EndUICommand()
		self:DispatchUICommand(selfId,426042021)
		return -1
		-- return add,"tlbb 库 money_card 表"
	end
	return 0,"tlbb 库 "..self.create_cdk_ini_doc
end

function CDK:DelLimitChange(selfId,params)
	if not params.str or params.str ~= "limit_change" then
		self:notify_tips(selfId, "出错。")
		return
	-- elseif params.guid ~= self:LuaFnGetGUID(selfId) then
		-- self:notify_tips(selfId, "出错。。")
		-- return
	end
	self:SetHumanGameFlag(selfId,"un_limit_change",1)
	--self:SetHumanGameFlag(selfId,"limit_change",0)
	self:SetHumanGameFlag(selfId,params.str,0)
end

function CDK:ReceiveCdkAward(selfId, ... )
	if ScriptGlobal.is_internal_test then
		self:notify_tips(selfId, "内测期间不开放CDK兑换，请于公测后使用。")
		return
	end
	local curtime = os.time()
	local datatime = self:GetMissionDataEx(selfId,ScriptGlobal.MDEX_CDK_CD)
	if datatime >= curtime then
		local msg = "操作过于频繁("..(datatime - curtime + 1).."后可再次操作)。"
		self:notify_tips(selfId, msg)
		return
	end
	self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_CDK_CD,curtime + 1)
	local paramx = { ... }
	if #paramx ~= 6 then
		self:notify_tips(selfId, "CDK异常。")
		return
	end
	local paramz = {"","","","","",""}
	for i = 1,6 do
		if not paramx[i] then
			self:notify_tips(selfId, "CDK异常。。")
			return
		elseif paramx[i] >= 65 and paramx[i] <= 90
		or paramx[i] >= 97 and paramx[i] <= 122 then
			paramz[i] = string.char(paramx[i])
		elseif paramx[i] >= 111111 and paramx[i] <= 999999 then
			paramz[i] = tostring(paramx[i])
		else
			self:notify_tips(selfId, "CDK异常。。。")
			return
		end
	end
	local ServerID = self:LuaFnGetServerID(selfId)
	local cdkinfo = table.concat(paramz)
	local istrue = self:LuaFnGetDocData(".char_db",self.create_cdk_ini_doc,cdkinfo,"findOne",nil,nil,{_id = 0})
	if not istrue then
		self:notify_tips(selfId, "CDK不存在。")
		return
	-- elseif not istrue.buy_time or istrue.buy_time == "" then
		-- self:notify_tips(selfId, "CDK未被购买。")
		-- return
	elseif istrue.playerguid ~= 0 then
		self:notify_tips(selfId, "CDK已领取过。")
		return
	end
	if istrue.cdk_price == 1 then
		if ServerID == 20  then --这里限制老区是否开放 10是1区 依次类推
			self:notify_tips(selfId, "本区暂未开放。")
			return
		elseif self:GetMissionDataEx(selfId, ScriptGlobal.MD_TUIGUANG) ~= 0 then
			self:notify_tips(selfId, "该类型CDK只能激活一次。")
			return
		elseif self:GetHumanGameFlag(selfId,"un_limit_change") ~= 0 then
			--self:notify_tips(selfId, "该类型CDK只能激活一次。")
			--return
		end
	end
	
	
	self:BeginAddItem()
	self:AddItem(istrue.item_id,istrue.item_num,true)
	if not self:EndAddItem(selfId,true) then
		return
	end
	local playerguid = self:LuaFnGetGUID(selfId)
	local playername = self:GetName(selfId)
	local skynet = require "skynet"
	local _,accountname = skynet.call(".gamed", "lua", "query_roler_account", string.format("%x", playerguid))
	
	istrue.playerguid = playerguid
	istrue.playername = playername
	istrue.accountname = accountname
	istrue.serverid = ServerID
	istrue.playerguid = playerguid
	istrue.claim_time = os.date("%Y-%m-%d %H:%M:%S").."(领取)"
	-- local updatedata = {
		-- playerguid = playerguid,
		-- playername = playername,
		-- accountname = accountname,
		-- serverid = ServerID,
		-- claim_time = os.date("%Y-%m-%d %H:%M:%S").."(领取)"
	-- }
	local ServerName = {
	[10] = "CX-CJ-10",
	[11] = "CX-CJ-11",
	[12] = "CX-CJ-12",
	[13] = "CX-CJ-13",
	[14] = "CX-CJ-14",
	[15] = "CX-CJ-15",
	[16] = "CX-CJ-16",
	[17] = "CX-CJ-17",
	}
	-- self:LuaFnUpdateDocData(".char_db",self.create_cdk_ini_doc,cdkinfo,updatedata)
	skynet.call(".char_db", "lua", "delete", {collection = self.create_cdk_ini_doc, selector = {docindex = cdkinfo}})
	local ishave = self:LuaFnGetDocData(".char_db",self.create_cdk_ini_doc,cdkinfo,"findOne")
	-- if istrue and istrue.playerguid == playerguid then
	if not ishave then 
		self:LuaFnSetAddDocData(".char_db",self.create_cdk_ini_doc_claimed,istrue)
		local on_backend = false
		if istrue.cdk_price == 666 then
			self:SetHumanGameFlag(selfId,"zhu_bo_flag",istrue.cdk_price)
		elseif istrue.cdk_price == 1 then  --推广卡CDK控制 
			--self:SetHumanGameFlag(selfId,"limit_change",istrue.cdk_price)  --限制交易接口
			self:SetMissionDataEx(selfId, ScriptGlobal.MD_TUIGUANG, 1)
			self:BeginAddItem()
			-- self:AddItem(20501003,20,true)
			-- self:AddItem(20502003,20,true)
			-- self:AddItem(20500003,20,true)
			-- self:AddItem(38003055,10,true)
			-- self:AddItem(38008160,300,true)
			self:EndAddItem(selfId)
			self:AddItemListToHuman(selfId)
		else
			on_backend = true
		end
		self:BeginAddItem()
		self:AddItem(istrue.item_id,istrue.item_num,true)
		self:EndAddItem(selfId)
		self:AddItemListToHuman(selfId)
		if on_backend then
			local sql = string.format([[
				INSERT INTO `webpay`.`player_rechange` 
				(player_id, proxy_id, money, pay_time, player_account, group_name, order_number, title, game_id) 
				SELECT 
				id, proxy_id, '%d', NOW(), '%s', '%s', 
				(DATE_FORMAT(NOW(), '%%Y%%m%%d%%H%%i%%s')), 
				(CONCAT('WJ:', '%s', 'CZ:', '%d')), 
				game_id 
				FROM `webpay`.`player_user` 
				WHERE account='%s' AND game_id IN ('5UE','CZ0') LIMIT 1
			]], istrue.cdk_price, accountname,ServerName[ServerID],accountname, istrue.cdk_price, accountname)
			skynet.send(".mysqldb", "lua", "query", sql)
		end
		self:notify_tips(selfId,"激活成功。")
		--local msg = string.format("#{_INFOUSR%s}#{CWWSK_Text01}",playername)
		--self:AddGlobalCountNews(msg)
	end
end

function CDK:MoveCdk(selfId)
	local query_x = {
		playerguid = { ["$ne"] = 0 }
	}
	local skynet = require "skynet"
	local backdata = skynet.call(".char_db", "lua", "findAll", {
		collection = self.create_cdk_ini_doc,
		query = query_x,
		selector = {_id = 0}
	})
	if backdata then
		for _,data in ipairs(backdata) do
			local cdkinfo = data.docindex
			skynet.call(".char_db", "lua", "delete", {collection = self.create_cdk_ini_doc, selector = {docindex = cdkinfo}})
			local ishave = self:LuaFnGetDocData(".char_db",self.create_cdk_ini_doc,cdkinfo,"findOne")
			if not ishave then
				self:LuaFnSetAddDocData(".char_db",self.create_cdk_ini_doc_claimed,data)
			end
		end
	end
end

--第一次激活奖励
--cdk奖励配置 (至少给一种道具) isbind = true 给予绑定  isbind = false 给予不绑定
--不给称号 把 Titleid TitleName TitleFlag 注掉
--不给绑元把 BindYuanBao 注掉
CDK.AwardInfo = 
{
	--[[称号注释：有 Titleid 时 TitleName 与 TitleFlag 必带
	TitleFlag = 逻辑类型(程序用)  适用于char_title.txt 的称号
	TitleFlag = -1 适用于 char_title_new.txt 的称号]]
	 Titleid = 1073,
	 TitleName = "称号:竹涧轻觞会知交",
	 TitleFlag = -1,
	--BindYuanBao = 500000,
	{itemid = 10124519,count = 1,isbind = true},
	{itemid = 10142793,count = 1,isbind = true},
	{itemid = 38000220,count = 1,isbind = true},
	{itemid = 38008160,count = 666,isbind = true},


}
--第二次激活奖励
--cdk奖励配置 (至少给一种道具) isbind = true 给予绑定  isbind = false 给予不绑定
--不给称号 把 Titleid TitleName TitleFlag 注掉就好
--不给绑元把 BindYuanBao 注掉
CDK.AwardInfoTwo = 
{
	--[[称号注释：有 Titleid 时 TitleName 与 TitleFlag 必带
	TitleFlag = 逻辑类型(程序用)  适用于char_title.txt 的称号
	TitleFlag = -1 适用于 char_title_new.txt 的称号]]
	--BindYuanBao = 1000000,
	--{itemid = 38000205,count = 1,isbind = true},
	--{itemid = 38003135,count = 10,isbind = true},
}


function CDK:ReceiveCdkAward_bff(selfId, ... )
	local paramx = { ... }
	if #paramx ~= 6 then
		self:notify_tips(selfId, "CDK异常。")
		return
	end
	local paramz = {"","","","","",""}
	for i = 1,6 do
		if not paramx[i] then
			self:notify_tips(selfId, "CDK异常。。")
			return
		elseif paramx[i] >= 65 and paramx[i] <= 90
		or paramx[i] >= 97 and paramx[i] <= 122 then
			paramz[i] = string.char(paramx[i])
		elseif paramx[i] >= 111111 and paramx[i] <= 999999 then
			paramz[i] = tostring(paramx[i])
		else
			self:notify_tips(selfId, "CDK异常。。。")
			return
		end
	end
	local cdkinfo = table.concat(paramz)
	local istrue = self:LuaFnGetDocData(".char_db","money_card","moneycard","findOne","cardguid",cdkinfo)
	if not istrue then
		self:notify_tips(selfId, "CDK不存在。")
		return
	end
	if istrue.playerguid ~= 0 
	and istrue.awardtimer and istrue.awardtimer ~= "" then
	-- and istrue.awardtimer_two and istrue.awardtimer_two ~= "" then
		self:notify_tips(selfId, "该CDK已经激活过。")
		return
	end
	local ndate = os.date("%Y-%m-%d/%X")
	local playername = self:GetName(selfId)
	local playerguid = self:LuaFnGetGUID(selfId)
	local isokmsg = ""
	local awardinfo
	local updatedata
	local selfcount = self:GetMissionDataEx(selfId,ScriptGlobal.MDEX_MONEYCARDFLAG)
	if istrue.playerguid == 0 then
		if selfcount > 0 then
			awardinfo = self.AwardInfoTwo
		else
			awardinfo = self.AwardInfo
		end
			updatedata = {
				playerguid = playerguid,
				playername = playername,
				awardtimer = ndate.."(第1重激活时间)",
				awardinfo = "已激活"
			}
		isokmsg = "CDK重激活成功，奖励已放至您背包，请注意查收。"
		-- isokmsg = "CDK第一重激活成功，奖励已放至您背包，请注意查收，还可进行激活第二重奖励。"
	-- elseif istrue.playerguid == playerguid then
		-- awardinfo = self.AwardInfoTwo
		-- updatedata = {
			-- playerguid = playerguid,
			-- playername = playername,
			-- awardtimer_two = ndate.."(第2重激活时间)",
			-- awardinfo = "已激活"
		-- }
		-- isokmsg = "CDK已完全激活，请期待后续开放激活重数(CDK不要丢弃哦~)。"
	else
		local msg = istrue.playername.."于["..istrue.awardtimer.."]进行了该CDK第一次激活，二次激活也需要本人激活，请知悉。"
		self:notify_tips(selfId,msg)
		return
	end
	if not awardinfo then
		self:notify_tips(selfId,"error")
	end
	self:BeginAddItem()
	for i,j in ipairs(awardinfo) do
		self:AddItem(j.itemid,j.count,j.isbind)
	end
	if not self:EndAddItem(selfId) then
		self:notify_tips(selfId,"背包空间不足。")
		return
	end
	self:LuaFnUpdateDocData(".char_db","money_card","moneycard",updatedata,"cardguid",cdkinfo)
	istrue = self:LuaFnGetDocData(".char_db","money_card","moneycard","findOne","cardguid",cdkinfo)
	if istrue and istrue.playerguid == playerguid then
		self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MONEYCARDFLAG,1)
		self:AddItemListToHuman(selfId)
		if awardinfo.BindYuanBao and awardinfo.BindYuanBao > 0 then
			self:AddBindYuanBao(selfId, awardinfo.BindYuanBao)
			self:notify_tips(selfId,"您得到"..tostring(awardinfo.BindYuanBao).."绑定元宝。")
		end
		if awardinfo.Titleid and awardinfo.TitleName and awardinfo.TitleFlag then
			if awardinfo.TitleFlag == -1 then
				if not self:LuaFnHaveAgname(selfId,awardinfo.Titleid) then
					self:LuaFnAddNewAgname(selfId,awardinfo.Titleid)
				end
			else
				self:LuaFnAwardTitle(selfId,awardinfo.TitleFlag,awardinfo.Titleid)
				self:LuaFnDispatchAllTitle(selfId)
			end
			self:notify_tips(selfId,"您得到称号"..awardinfo.TitleName.."。")
		end
		self:notify_tips(selfId,isokmsg)
		local msg = string.format("#{_INFOUSR%s}#{CWWSK_Text01}",playername)
		self:AddGlobalCountNews(msg)
		
		
	else
		self:notify_tips(selfId,"CDK激活失败。")
	end
	
end
--新增 count 个 CDK
function CDK:AddMoneyCardCount_bff(selfId,count)
	if not count or count < 1 then return 0 end
	local isgm = self:CallScriptFunction(900066, "IsGM", selfId)
	if isgm >= 3 then
		local createstr = function()
			local value = math.random(6666)
			if value % 2 == 1 then
				value = math.random(65,90)
			else
				value = math.random(97,122)
			end
			return string.char(value)
		end
		local ndate = os.date("%Y-%m-%d/%X")
		local addData = {
					docindex = "moneycard",
					createtimer = ndate.."(创建)",
					cardguid = "",
					playerguid = 0,
					playername = "",
					awardtimer = "",
					awardtimer_two = "",
					awardinfo = "尚未激活"
		}
		local add = 0
		local num,str = 0,0
		local index,cdkinfo,istrue
		local datalx = {"","","","","",""}
		for m = 1,count do
			for j = 1,20 do
				num,str = 0,0
				for i = 1,6 do
					index = math.random(6666) % 2
					if index == 1 then
						if num < 3 then
							num = num + 1
						else
							str = str + 1
							index = 0
						end
					else
						if str < 3 then
							str = str + 1
						else
							num = num + 1
							index = 1
						end
					end
					if index == 1 then
						index = math.random(111111,999999)
						datalx[i] = tostring(index)
					else
						datalx[i] = createstr()
					end
				end
				if num > 3 or str > 3 then
					return add,"异常了"
				end
				cdkinfo = table.concat(datalx)
				istrue = self:LuaFnGetDocData(".char_db","money_card","moneycard","findOne","cardguid",cdkinfo)
				if not istrue then
					addData.cardguid = cdkinfo
					add = add + 1
					self:LuaFnSetAddDocData(".char_db","money_card",addData)
					break
				end
			end
		end
		return add,"tlbb 库 money_card 表"
	end
	return 0,"tlbb 库 money_card 表"
end
return CDK