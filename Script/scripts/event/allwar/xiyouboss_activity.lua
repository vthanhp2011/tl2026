local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
-- local packet_def = require "game.packet"
local script_base = require "script_base"
local xiyouboss_activity = class("xiyouboss_activity", script_base)
-- local gbk = require "gbk"
-- local skynet = require "skynet"
xiyouboss_activity.script_id = 999983
xiyouboss_activity.DataValidator = 0
--*********************************
-- 活动添加：（活动图不可定位，不可传送）

-- 大战牛魔王：15:00	开启时长2小时，泡点间隙1分钟，幸运人数13人，
-- 普通幸运都是元宝，分别为100,200，最后一击掉落重楼材料，散落1元充值卡，500元宝票
-- 大战孙悟空：19:45	
-- 大战二郎神：22:30	
--*********************************
--返回位置
xiyouboss_activity.GoBackScene = 0
xiyouboss_activity.GoBackPosx = 160
xiyouboss_activity.GoBackPosz = 105

--开启时间
--[sceneId] = {
	--bossId  BOSSid
	--starthour 开启 小时
	--starthour 开启 分钟
	-- endhour 结束 小时
	-- endminue 结束 分钟

	-- box_fun_name 活动弹窗函数名
	-- boxtime = 弹窗持续时长(单位:秒) 0=不弹窗  > 0 则弹窗有效时长
--}

xiyouboss_activity.timetab = 
{
--[[	[713] = {
		box_fun_name = "niumowang_box",boxtime = 120,actname = "大战牛魔王",
		--开启的星期天数  没有则删掉此键
		openweek = {[1] = true,[4] = true},
		starthour = 20,startminue = 0,endhour = 21,endminue = 0,
		bossId = 52704,posx = 104,posz = 177,bossname = "",bosstitle = "大战牛魔王",
		-- bosshp  此项 > 0 时 修正BOSS血量   = 0 时 默认怪物表血量
		bosshp = 200000000,
	},
	[714] = {
		box_fun_name = "sunwukong_box",boxtime = 120,actname = "大战孙悟空",
		openweek = {[2] = true,[5] = true},
		starthour = 20,startminue = 0,endhour = 21,endminue = 0,
		bossId = 52705,posx = 149,posz = 146,bossname = "",bosstitle = "大战孙悟空",
		-- bosshp  此项 > 0 时 修正BOSS血量   = 0 时 默认怪物表血量
		bosshp = 200000000,
	},--]]
	[715] = {
		box_fun_name = "erlangshen_box",boxtime = 120,actname = "大战二郎神",
		openweek = {[3] = true,[7] = true},
		starthour = 20,startminue = 30,endhour = 22,endminue = 30,
		bossId = 52706,posx = 115,posz = 191,bossname = "",bosstitle = "大战二郎神",
		-- bosshp  此项 > 0 时 修正BOSS血量   = 0 时 默认怪物表血量
		bosshp = 200000000,
	},
}

--结束后N秒后清场   活动初始化时生效  过程修改不生效
-- xiyouboss_activity.backtick = 600
xiyouboss_activity.backtick = 300
--需求等级   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.needlevel = 60
--需求血量   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.needmaxhp = 0
--需求点数   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.needpoint = 0


--泡点间隙 秒  不开写0   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.paodiantime = 0
--幸运泡点 人数  不开写0   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.luckydog = 0
--幸运儿 泡点得奖  元宝  不开写0   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.luckydogaward = 0
--其他泡点得奖  元宝  不开写0   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.paodian_award = 0
--最后一击专属盒子保护时间 秒  不开写0   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.playerboxprotecttime = 0
--所有盒子消失时间 秒  不开写0   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.boxdeltime = 120
--其它掉落盒子数量   不管活动是否在进行中，配置数据实时生效
xiyouboss_activity.boxcount = 10

xiyouboss_activity.act_tick = 1
xiyouboss_activity.act_isopen = 2
xiyouboss_activity.act_open_sceneid = 3
xiyouboss_activity.act_boss_objid = 4
xiyouboss_activity.act_bossmaxhp = 5
xiyouboss_activity.act_paodian_tick = 6
xiyouboss_activity.act_close_flag = 7
xiyouboss_activity.act_close_tick = 8
xiyouboss_activity.act_boss_name = 9
xiyouboss_activity.act_cs_boxtime = 10
xiyouboss_activity.act_name = 11
xiyouboss_activity.act_need_level = 12
xiyouboss_activity.act_need_maxhp = 13
xiyouboss_activity.act_need_point = 14
xiyouboss_activity.act_load_date = 15


xiyouboss_activity.backtopinfo = 
{
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
	{league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = ""},
}

function xiyouboss_activity:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5, param6)
-- skynet.logi("xiyouboss_activity:OnDefaultEvent")
end
function xiyouboss_activity:GetDataValidator(param1,param2)
	self.DataValidator = math.random(1,2100000000)
	return self.DataValidator
end
--*********************************
-- 活动描述
--*********************************
function xiyouboss_activity:GetJingZhuZengLiMsg(selfId)
	local act_name = self:GetActivityParamEx(define.ACTIVITY_XIYOU_ID,self.act_name)
	if act_name ~= 0 then
		local msgtab = 
		{
			"    ",
			act_name,
			"：自身条件达到等级>=",
			self.needlevel,
			"、血量>=",
			self.needmaxhp,
			"、兑换点数>=",
			self.needpoint,
			"的勇士可以参与\n活动期间，在场侠士每隔",
			self.paodiantime,
			"秒进行一次泡点得到",
			self.paodian_award,
			"元宝(幸运儿:",
			self.luckydogaward,
			"元宝)奖励。\n给予BOSS最后一击者将掉落重楼材料专属盒子，保护时间为:",
			self.playerboxprotecttime,
			"秒，同时撒落一地的充值卡、元宝票类盒子，有效时间为:",
			self.boxdeltime,
			"秒。"
		}
		local msg = table.concat(msgtab)
		self:BeginUICommand()
		self:UICommand_AddInt(329042022)
		self:UICommand_AddStr(msg)
		self:EndUICommand()
		self:DispatchUICommand(selfId,329042022)
	end
end
--*********************************
-- 清场
--*********************************
function xiyouboss_activity:CheckActiviyParticipation(selfId)
	local obj = self:get_scene():get_obj_by_id(selfId)
	if obj and obj:is_alive() then
		if obj:get_attrib("level") >= self.needlevel
		and obj:get_attrib("hp_max") >= self.needmaxhp
		and obj:get_mission_data_by_script_id(388) / 3000  >= self.needpoint then
			if obj:get_team_id() == define.INVAILD_ID then
				return 0
			else
				return "    本活动不允许组队参与。"
			end
		else
			local msg = string.format("    本活动需求:等级>=%d级、血量>=%d、兑换点数>=%d方可参与。",self.needlevel,self.needmaxhp,self.needpoint)
			return msg
		end
	end
	return "    你死亡了。"
end
function xiyouboss_activity:CheckPlayerOnActivity(selfId)
	local obj = self:get_scene():get_obj_by_id(selfId)
	if obj and obj:is_alive() then
		if obj:get_attrib("level") >= self.needlevel
		and obj:get_attrib("hp_max") >= self.needmaxhp
		and obj:get_mission_data_by_script_id(388) / 3000  >= self.needpoint then
			if obj:get_team_id() == define.INVAILD_ID then
				return true
			else
				obj:notify_tips("本活动不允许组队参与。")
			end
		else
			local msg = string.format("本活动需求:等级>=%d级、血量>=%d、兑换点数>=%d方可参与。",self.needlevel,self.needmaxhp,self.needpoint)
			obj:notify_tips(msg)
		end
		self:NewWorld(selfId,self.GoBackScene,nil,self.GoBackPosx,self.GoBackPosz)
	end
end
--*********************************
-- 关闭活动  接口
--*********************************
function xiyouboss_activity:CloseActivity(actId)
	if not actId or actId >= 0 then
		return
	end
	local newId = -1 * actId
	if define.ACTIVITY_XIYOU_ID ~= newId then
		return
	elseif not self:CheckActiviyValidity(newId) then
		return
	end
	self:StopOneActivity(newId)
end
--*********************************
-- 开启活动
--*********************************
function xiyouboss_activity:StartActivity(actId)
	if not actId or actId >= 0 then
		return
	end
	local newId = -1 * actId
	if define.ACTIVITY_XIYOU_ID ~= newId then
		return
	elseif self:HaveActivity(newId) then
		return
	end
	self:StartOneActivity(newId,2100000000,0,-1)
end
function xiyouboss_activity:CheckOpen(actId,minute,hminute,hour,today)
	-- skynet.logi("actId = ",actId,"minute = ",minute,"hminute = ",hminute,"hour = ",hour,",today = ",today)
	if not actId or actId >= 0 then
		return
	end
	local newId = -1 * actId
	if define.ACTIVITY_XIYOU_ID ~= newId then
		return
	end
	local week = self:GetWeek()
	local ischeck
	local statrtime,overtime,value
	local load_date = today % 10000
	load_date = load_date * 10000
	local old_date
	for sceneId,info in pairs(self.timetab) do
		ischeck = true
		if info.openweek then
			ischeck = info.openweek[week]
		end
		if ischeck then
			statrtime = info.starthour * 60 + info.startminue
			overtime = info.endhour * 60 + info.endminue
			if hminute >= statrtime and hminute <= overtime then
				value = load_date + statrtime
				old_date = self:GetActivityKey(newId,"load_date",sceneId)
				if old_date and old_date ~= value then
				
					self:SetCsLog(
						"xiyouboss_activity",
						{
							sceneId = sceneId,
							old_date = old_date,
							value = value,
						}
					)
				
				
					self:CallDestSceneFunctionEx(sceneId,self.script_id,"StartActivity",actId)
				end
			end
		end
	end
end
function xiyouboss_activity:CheckActiviyIsOpen()
	if not self:CheckActiviyValidity(define.ACTIVITY_XIYOU_ID) then
		return
	end
	return self:get_scene():get_activity_scene_param_on_key(define.ACTIVITY_XIYOU_ID,self.act_isopen) > 0
end
--*********************************
-- 战场心跳
--*********************************
function xiyouboss_activity:over_notify_ui(actId,actname,bossname,quit_tick)
	if not actId or actId >= 0 then
		return
	end
	self.backtopinfo[1].league_id = 0
	self.backtopinfo[1].guild_id_1 = bossposx
	self.backtopinfo[1].guild_id_2 = bossposz
	self.backtopinfo[1].guild_id_3 = 0
	self.backtopinfo[1].flag_capture_score = 0
	self.backtopinfo[1].crystal_hold_score = 1
	self.backtopinfo[1].league_name = actname
	self.backtopinfo[2].league_id = 0
	self.backtopinfo[2].guild_id_1 = 1
	self.backtopinfo[2].guild_id_2 = quit_tick
	self.backtopinfo[2].flag_capture_score = 0
	self.backtopinfo[2].crystal_hold_score = 0
	self.backtopinfo[2].league_name = bossname
	self:NotifyAllScore(self.backtopinfo)

end
function xiyouboss_activity:OnTimer_Second(actId,minute,hminute,hour)
	if not actId or actId >= 0 then
		return
	end
	local newId = -1 * actId
	if define.ACTIVITY_XIYOU_ID ~= newId then
		return
	end
	local scene = self:get_scene()
	local sceneId = scene:get_id()
	local params = scene:get_activity_scene_param(newId)
	if not params then return end
	local human_count = self:LuaFnGetCopyScene_HumanCount()
	local objId,obj
	--load
	if not params[self.act_isopen] then
		for i = 1,human_count do
			objId = self:LuaFnGetCopyScene_HumanObjId(i)
			if objId ~= -1 then
				self:NewWorld(objId,self.GoBackScene,nil,self.GoBackPosx,self.GoBackPosz)
			end
		end
		local actinfo = self.timetab[sceneId]
		if not actinfo then
			self:StopOneActivity(newId)
			return
		end
		objId = self:LuaFnCreateMonster(actinfo.bossId,actinfo.posx,actinfo.posz,4,0,999982)
		if objId then
			obj = scene:get_obj_by_id(objId)
			if obj then
				local statrtime = actinfo.starthour * 60 + actinfo.startminue
				local overtime = actinfo.endhour * 60 + actinfo.endminue
				local long_minute = overtime - hminute
				local del_time = long_minute * 60 * 1000 + 60000
				obj:set_die_time(del_time)
				obj:set_scene_params(define.MONSTER_KILLBOX_PROTECT_TIME,self.playerboxprotecttime)
				obj:set_scene_params(define.MONSTER_KILLBOX_DELTIME,self.boxdeltime * 1000)
				obj:set_scene_params(define.MONSTER_DROPBOX_COUNT,self.boxcount)
				obj:set_scene_params(define.MONSTER_DROPBOX_DELTIME,self.boxdeltime * 1000)
				local boxdeltime = obj:get_scene_params(define.MONSTER_DROPBOX_DELTIME)
				obj:set_scene_params(define.MONSTER_DATAID,actinfo.bossId)
				if actinfo.bosshp > 0 then
					self:LuaFnSetLifeTimeAttrRefix_MaxHP(objId,actinfo.bosshp)
					self:RestoreHp(objId)
					params[self.act_bossmaxhp] = actinfo.bosshp
				else
					local maxhp = obj:get_attrib("hp_max")
					params[self.act_bossmaxhp] = maxhp
				end
				local bossname = actinfo.bossname
				if bossname ~= "" then
					obj:set_name(bossname)
				else
					bossname = obj:get_name()
				end
				obj:set_title(actinfo.bosstitle)
				obj:set_reputation(29)
				local curtime = os.time()
				params[self.act_cs_boxtime] = curtime + actinfo.boxtime
				params[self.act_name] = actinfo.actname
				params[self.act_boss_name] = bossname
				params[self.act_boss_objid] = objId
				params[self.act_close_flag] = 0
				params[self.act_close_tick] = self.backtick
				params[self.act_paodian_tick] = self.paodiantime
				params[self.act_tick] = long_minute * 60 - 1
				if params[self.act_tick] < 0 then
					params[self.act_tick] = 0
				end
				local today = tonumber(os.date("%Y%m%d"))
				local load_date = today % 10000
				load_date = load_date * 10000 + statrtime
				params[self.act_load_date] = load_date
				params[self.act_open_sceneid] = sceneId
				params[self.act_isopen] = overtime
				local msg = string.format("#PBOSS#B[%s]#P莅临于#B[%d,%d]#P，#G击杀BOSS#P后将有大量#G珍宝撒落#P。",
				bossname,actinfo.posx,actinfo.posz)
				self:MonsterTalk(-1,actinfo.actname,msg)
				local havebox = ""
				if actinfo.boxtime and actinfo.boxtime > 0 then
					self:SetActivityKey(newId,"box_time",actinfo.boxtime + curtime)
					havebox = "#{_NEWMSG_999983"..tostring(actinfo.box_fun_name).."}"
				end
				msg = string.format("%s%s#B%s#P活动开启，#G击杀BOSS#P后将有大量#G珍宝撒落#P(参与条件:等级>=#G%d#P、血量>=#G%d#P、兑换点数>=#G%d#P，本场活动持续#B%d分钟#P)。",
				"@*;SrvMsg;SCA:",havebox,actinfo.actname,self.needlevel,self.needmaxhp,self.needpoint,long_minute)
				self:AddGlobalCountNews(msg)
			end
		end
		return
	end
	if sceneId ~= params[self.act_open_sceneid] then
		self:StopOneActivity(newId)
		return
	end
	local actname = params[self.act_name]
	local bossname = params[self.act_boss_name]
	if params[self.act_close_flag] > 0 then
		if params[self.act_close_tick] > 1 then
			params[self.act_close_tick] = params[self.act_close_tick] - 1
			self:over_notify_ui(actId,actname,bossname,params[self.act_close_tick])
		else
			self:StopOneActivity(newId)
			for i = 1,human_count do
				objId = self:LuaFnGetCopyScene_HumanObjId(i)
				if objId ~= -1 then
					self:NewWorld(objId,self.GoBackScene,nil,self.GoBackPosx,self.GoBackPosz)
				end
			end
		end
		return
	end
	local act_over = false
	if hminute >= params[self.act_isopen] then
		act_over = true
	end
	local bosslive = 0
	local bossmaxhp = params[self.act_bossmaxhp]
	local bossposx,bossposz = 0,0
	objId = params[self.act_boss_objid]
	obj = scene:get_obj_by_id(objId)
	if obj and obj:get_obj_type() == "monster" then
		if act_over then
			scene:delete_temp_monster(obj)
		else
			bosslive = obj:get_attrib("hp")
			if bosslive > 0 then
				local world_pos = obj:get_world_pos()
				bossposx = math.floor(world_pos.x)
				bossposz = math.floor(world_pos.y)
			else
				act_over = true
			end
		end
	else
		act_over = true
		self:NotifyCrystalOne(0,true,true)
	end
	if act_over then
		self:SetActivityKey(newId,"load_date",params[self.act_load_date])
		params[self.act_close_flag] = 1
		self:over_notify_ui(actId,actname,bossname,params[self.act_close_tick])
		local msg = string.format("%s#B%s#P活动结束。","@*;SrvMsg;SCA:",actname)
		self:AddGlobalCountNews(msg)
		return
	end
	if params[self.act_tick] > 0 then
		params[self.act_tick] = params[self.act_tick] - 1
	end
	local human_ids = {}
	for i = 1,human_count do
		objId = self:LuaFnGetCopyScene_HumanObjId(i)
		if objId ~= -1 then
			if self:CheckPlayerOnActivity(objId,-2) then
				table.insert(human_ids,objId)
			end
		end
	end
	local act_paodian_tick = params[self.act_paodian_tick]
	if self.paodiantime > 0 then
		if act_paodian_tick > 1 then
			act_paodian_tick = act_paodian_tick - 1
			params[self.act_paodian_tick] = act_paodian_tick
		else
			act_paodian_tick = self.paodiantime
			params[self.act_paodian_tick] = act_paodian_tick
			if self.luckydog > 0 and self.luckydogaward > 0 then
				local yblog = tostring(actname).."幸运泡点元宝"
				local msg = string.format("你幸运泡点获得%d元宝。",self.luckydogaward)
				local scene_msg = "#P幸运儿~#B[%s]#P得到#G%d#P元宝。"
				local scene_msg_2
				local lucky_id,t_max
				for i = 1,self.luckydog do
					t_max = #human_ids
					if t_max > 0 then
						lucky_id = table.remove(human_ids,math.random(1,t_max))
						obj = scene:get_obj_by_id(lucky_id)
						if obj then
							obj:add_yuanbao(self.luckydogaward,yblog)
							obj:notify_tips(msg)
							scene_msg_2 = string.format(scene_msg,obj:get_name(),self.luckydogaward)
							self:MonsterTalk(-1,actname,scene_msg_2)
						end
					else
						break
					end
				end
			end
			if #human_ids > 0 and self.paodian_award > 0 then
				local yblog = tostring(actname).."泡点元宝"
				local msg = string.format("你泡点获得%d元宝。",self.luckydogaward)
				for _,id in ipairs(human_ids) do
					obj = scene:get_obj_by_id(id)
					if obj then
						obj:add_yuanbao(self.luckydogaward,yblog)
						obj:notify_tips(msg)
					end
				end
			end
		end
	end
	local act_tick = params[self.act_tick] < 0 and 0 or params[self.act_tick]
	self.backtopinfo[1].league_id = self.paodian_award
	self.backtopinfo[1].guild_id_1 = bossposx
	self.backtopinfo[1].guild_id_2 = bossposz
	self.backtopinfo[1].guild_id_3 = self.luckydog
	self.backtopinfo[1].flag_capture_score = bosslive
	self.backtopinfo[1].crystal_hold_score = bossmaxhp
	self.backtopinfo[1].league_name = actname
	self.backtopinfo[2].league_id = self.luckydogaward
	self.backtopinfo[2].guild_id_1 = 0
	self.backtopinfo[2].guild_id_2 = 0
	self.backtopinfo[2].flag_capture_score = act_tick
	self.backtopinfo[2].crystal_hold_score = act_paodian_tick
	self.backtopinfo[2].league_name = bossname
	if bossposx > 0 and bossposz > 0 then
		self:NotifyCrystalOne(1,bossname,{x = bossposx,y = bossposz})
	else
		self:NotifyCrystalOne(0,true,true)
	end
	self:NotifyAllScore(self.backtopinfo)
end
function xiyouboss_activity:closebox(selfId,msg)
	if msg then
		self:notify_tips(selfId,msg)
	end
	self:BeginUICommand()
	self:EndUICommand()
	self:DispatchUICommand(selfId,410142021)
end
function xiyouboss_activity:niumowang_box(selfId,goings)
	local sceneId = -713
	local posx_min = 159
	local posx_max = 178
	local posz_min = 82
	local posz_max = 100
	local posx = math.random(posx_min,posx_max)
	local posz = math.random(posz_min,posz_max)
	self:call_box(sceneId,selfId,posx,posz,goings)
end
function xiyouboss_activity:sunwukong_box(selfId,goings)
	local sceneId = -714
	local posx_min = 46
	local posx_max = 60
	local posz_min = 99
	local posz_max = 128
	local posx = math.random(posx_min,posx_max)
	local posz = math.random(posz_min,posz_max)
	self:call_box(sceneId,selfId,posx,posz,goings)
end
function xiyouboss_activity:erlangshen_box(selfId,goings)
	local sceneId = -715
	local posx_min = 112
	local posx_max = 149
	local posz_min = 60
	local posz_max = 92
	local posx = math.random(posx_min,posx_max)
	local posz = math.random(posz_min,posz_max)
	self:call_box(sceneId,selfId,posx,posz,goings)
end
function xiyouboss_activity:call_box(subsceneid,selfId,posx,posz,goings)
	if not subsceneid or subsceneid >= 0 then return end
	local sceneId = -1 * subsceneid
	local actinfo = self.timetab[sceneId]
	if not actinfo then
		self:closebox(selfId,"传送盒数据异常。")
		return
	end
	local cur_time = os.time()
	local max_time = self:GetActivityKey(define.ACTIVITY_XIYOU_ID,"box_time")
	if cur_time > max_time then
		-- self:closebox(selfId,"传送盒已失效。")
		return
	end
	local mylv = obj:get_attrib("level")
	local myhp = obj:get_attrib("hp_max")
	local mypoint = obj:get_mission_data_by_script_id(388) // 3000
	if goings then
		local exida,exidb = self:LuaFnActivityBoxCheck(sceneId,selfId,max_time,cur_time)
		if not exida or not exidb then
			return
		end
		self:SetMissionDataEx(selfId,exida,sceneId)
		self:SetMissionDataEx(selfId,exidb,max_time)
		self:closebox(selfId)
		if mylv >= self.needlevel
		and myhp >= self.needmaxhp
		and mypoint >= self.needpoint then
			if sceneId == self:get_scene():get_id() then
				self:TelePort(selfId, posx, posz)
			else
				self:NewWorld(selfId, sceneId, nil, posx, posz)
			end
		end
	else
		local act_name = actinfo.actname
		local scenename = self:GetSceneName(sceneId)
		local msgtab = {"#B    ",act_name,"#W活动已开启，"}
		if mylv >= self.needlevel
		and myhp >= self.needmaxhp
		and mypoint >= self.needpoint then
			table.insert(msgtab,"是否前往\n#B[")
			table.insert(msgtab,self:GetSceneName(sceneId))
			table.insert(msgtab,",")
			table.insert(msgtab,posx)
			table.insert(msgtab,",")
			table.insert(msgtab,posz)
			table.insert(msgtab,"]#W。\n#G(小提示:该弹窗有时间限制，请留意左下角的倒计时)")
		else
			table.insert(msgtab,"活动参与需求:\n")
			if mylv >= self.needlevel then
				table.insert(msgtab,"#G等级:")
			else
				table.insert(msgtab,"#cff0000等级:")
			end
			table.insert(msgtab,mylv)
			table.insert(msgtab," / ")
			table.insert(msgtab,self.needlevel)
			if myhp >= self.needmaxhp then
				table.insert(msgtab,"、\n#G血量:")
			else
				table.insert(msgtab,"、\n#cff0000血量:")
			end
			table.insert(msgtab,myhp)
			table.insert(msgtab," / ")
			table.insert(msgtab,self.needmaxhp)
			if mypoint >= self.needpoint then
				table.insert(msgtab,"、\n#G点数:")
			else
				table.insert(msgtab,"、\n#cff0000点数:")
			end
			table.insert(msgtab,mypoint)
			table.insert(msgtab," / ")
			table.insert(msgtab,self.needpoint)
			table.insert(msgtab,"，\n#W你当前的实力不足以参与该活动。")
		end
		local msg = table.concat(msgtab)
		self:BeginUICommand()
		self:UICommand_AddInt(410142022)
		self:UICommand_AddInt(max_time - cur_time)
		self:UICommand_AddInt(self.script_id)
		self:UICommand_AddStr("#ccc33cc"..act_name)
		self:UICommand_AddStr(msg)
		self:UICommand_AddStr(actinfo.box_fun_name)
		self:EndUICommand()
		self:DispatchUICommand(selfId,410142022)
	end
end

return xiyouboss_activity
