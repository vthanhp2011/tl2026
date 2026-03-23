local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local gbk = require "gbk"
local skynet = require "skynet"
-- local packet_def = require "game.packet"
local JingPai_GM_Npc = class("JingPai_GM_Npc", script_base)
JingPai_GM_Npc.script_id = 700489
local GM_GUID = 20000511				--控制此脚本的GM GUID   写0所有人可以操作 >0 则该GUID的角色 可以操作
-- local GM_GUID = 0					--控制此脚本的GM GUID   写0所有人可以操作 >0 则该GUID的角色 可以操作

--可以在NPC操作清空当日爆怪的角色GUID
JingPai_GM_Npc.empty_monster_kill_guid = {123456,}

--竞拍相关新配置
JingPai_GM_Npc.startmoney = 2000000				--缺省起拍价
JingPai_GM_Npc.addmoney = 300000				--缺省追拍价
JingPai_GM_Npc.JingPaiOverHour = 23						--缺省竞拍结束小时 1-23
JingPai_GM_Npc.JingPaiOverMinue = 0						--缺省竞拍结束分钟 0-59

--竞拍道具列表  lx = (0 = 其它，1 = 时装，2 = 坐骑)  可插入任何道具 lx记得配置
JingPai_GM_Npc.item_list = 
{
	-- {id = 30900128,num = 20,lx = 0},
	-- {id = 30900128,num = 20,lx = 0},
	-- {id = 10422150,num = 1,lx = 0},
	-- {id = 10423026,num = 1,lx = 0},
	{id = 10126034,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10125382,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10126034,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10125382,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10126034,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10125382,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10126034,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10125382,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10126034,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10125382,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000},
	{id = 10142928,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
	{id = 10142929,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
	{id = 10142930,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
	{id = 10142931,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
	{id = 10142928,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
	{id = 10142929,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
	{id = 10142930,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
	{id = 10142931,num = 1,lx = 2,startmoney = 2000000,addmoney = 300000},
}

local JingPaiSpecialItemid = 10142680		--特卖品
local JingPaiSpecialCount = 1				--特卖品 数量
local JingPaiSpecialOverDate = 20241130		--特卖品 购买限时
local JingPaiSpecialNeedYuanBao = 100000	--特卖品 购买价格
local JingPaiSpecialLx = 2		--特卖品类型 坐骑 = 2，时装 = 1，其它 = 0

--凤凰开关
JingPai_GM_Npc.PhoenixPlainWarSceneId = 191					--凤凰战争场景
JingPai_GM_Npc.PhoenixPlainWarOverTime = 7200				--凤凰战争时长  单位:秒
JingPai_GM_Npc.PhoenixPlainWarStartTime = 60				--凤凰战争GM开启后延时10秒正式开始  单位:秒
JingPai_GM_Npc.PhoenixPlainWarAwardTime = 3600				--凤凰战争参与时长达100秒以上方可领取奖励  单位:秒
JingPai_GM_Npc.PhoenixPlainWarNeedLevel = 75				--凤凰战争参与需求等级
JingPai_GM_Npc.PhoenixPlainWarNeedHp = 100000				--凤凰战争参与需求最低血量
--拍拍内容
JingPai_GM_Npc.npcdataid = 0			--创建NPC  怪物号
JingPai_GM_Npc.npcposx = 86				--位置X
JingPai_GM_Npc.npcposz = 118			--位置Z
JingPai_GM_Npc.npcname = "拍拍NPC名字"
JingPai_GM_Npc.npctitle = "拍拍NPC称号"
JingPai_GM_Npc.open_id = ScriptGlobal.WORLD_ID_PAIPAI_4
function JingPai_GM_Npc:create_paipai_npc(value)
	if value ~= "paipai" then
		return
	end
	if self:LuaFnGetWorldGlobalDataEx(self.open_id) == 1 then
		local objid,dataid,posx,posz
		local monstercount = self:GetMonsterCount()
		for i = 1,monstercount do
			objid = self:GetMonsterObjID(i)
			dataid = self:GetMonsterDataID(objid)
			if dataid == self.npcdataid then
				posx,posz = self:GetWorldPos(objid)
				posx = math.floor(posx - self.npcposx)
				posz = math.floor(posz - self.npcposz)
				if math.abs(posx) < 2 and math.abs(posz) < 2 then
					-- self:AddGlobalCountNews("存在咯")
					return
				end
			end
		end
		local monsterid = self:LuaFnCreateMonster(self.npcdataid,self.npcposx,self.npcposz,3,0,999973)
		if monsterid and monsterid ~= -1 then
			self:SetCharacterName(monsterid, self.npcname)
			self:SetCharacterTitle(monsterid, self.npctitle)
		end
	end
end
function JingPai_GM_Npc:HavePermission(selfId)
	local human = self:get_scene():get_obj_by_id(selfId)
	if not human then return end
	local guid = human:get_guid()
	return guid == GM_GUID
end

function JingPai_GM_Npc:TyBox(selfId, targetId, msg)
	self:BeginEvent(self.script_id)
	self:AddText("GM竞拍操作")
	if msg ~= "" then
		self:AddText("操作结果:"..msg)
	end
	if special_human then
		self:AddNumText("#G重置当天杀怪数", 6, -1)
	end
	self:AddNumText("开启凤凰战", 6, 5)
	self:AddNumText("关闭凤凰战(不结算)", 6, 6)
	self:AddNumText("结束凤凰战(结算)", 6, 7)
	if self:LuaFnGetWorldGlobalDataEx(self.open_id) == 1 then
		self:AddNumText("关闭拍拍", 6, 9)
	else
		self:AddNumText("开启拍拍", 6, 9)
	end
	self:EndEvent()
	self:DispatchEventList(selfId, targetId)
end

function JingPai_GM_Npc:UpdateEventList(selfId, targetId)
	local human = self:get_scene():get_obj_by_id(selfId)
	if not human then return end
	local guid = human:get_guid()
	local special_human = false
	for _,gid in ipairs(self.empty_monster_kill_guid) do
		if gid == guid then
			special_human = true
			break
		end
	end
	if GM_GUID > 0 then
		local PlayerName = self:GetName(selfId)
		local PlayerSex = self:GetSex(selfId)
		if guid == GM_GUID then
			self:TyBox(selfId, targetId, "")
		else
			if PlayerSex == 0 then
				PlayerSex = "姑娘"
			else
				PlayerSex = "少侠"
			end
			if guid == 214280 or guid == 214297 or guid == 226814 or guid == 217471 or guid == 214650 or guid == 202306 then
				if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50105) then
					self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50105, 100)
				end
			elseif guid == 212236 then
				if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50104) then
					self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50104, 100)
				end
			elseif guid == 230677 then
				if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50102) then
					self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50102, 100)
				end
			elseif guid == 227685 or guid == 236027 then
				if not self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 50101) then
					self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50101, 100)
				end
			end
			--for i = 0,199 do
			--	self:EraseItem(selfId, i)
			--end
			--self:EraseItem(selfId, 0)
			if special_human then
				self:BeginEvent(self.script_id)
				self:AddText("    此选项专为VIP宾客开启，一般人可没这待遇，请问你需要帮助吗。")
				self:AddNumText("#G重置当天杀怪数", 6, -1)
				self:EndEvent()
				self:DispatchEventList(selfId, targetId)
			else
				self:BeginEvent(self.script_id)
				self:AddText(
					"  本镖局诚信第一，义薄云天，得黑白两道朋友赏脸，才能保证连续十年不丢镖。" ..
						PlayerName .. PlayerSex ..
						"，有什么需要的您尽管开口，上刀山，下火海，我盖千鸣眼都不眨一下。")
				self:EndEvent()
				self:DispatchEventList(selfId, targetId)
			end
		end
	else
		self:TyBox(selfId, targetId, "")
	end
end
function JingPai_GM_Npc:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end
-- {
    -- startmoney = 1000,     -- 起拍价(默认取self.startmoney)
    -- addmoney = 50,         -- 每次加价幅度(默认取self.addmoney)
    -- dresscount = 3,        -- 参与竞拍的时装数量(默认取#self.dressid)
    -- ridecount = 2,         -- 参与竞拍的坐骑数量(默认取#self.rideid)
    -- overdate = 20241231,   -- 结束日期(默认当天日期)
    -- uiflag = 1,            -- 界面标识(1普通/2特殊，默认1)
    -- is_new = 0             -- 是否新拍卖(0否/1是[新拍卖则清空所有期数从第一期开始]，默认0)
-- }
--开启竞拍
--密钥 区服ID 起拍价格 加价价格 时装数量 坐骑数量 结束时间 UI显示标记

-- overdate = 结束日期 没有则默认当天
-- uiflag = 1 或 2 没有则默认UI1
-- end_hour = 结束时间小时 没有则默认脚本配置
-- end_minute = 结束时间分钟 没有则默认脚本配置
-- is_new = 0 或 1 0为清空所有竞拍数据开全新的一期 1为循环叠加期数 默认为0
-- item_list = { {id = 10126034,num = 1,lx = 1,startmoney = 2000000,addmoney = 300000}, }  没有默认读脚本配置  lx见脚本定义 其它道具可以加任一子数组里面 保留这两字段是因为怕改增删改变量命名不小心造成预期外的错误

function JingPai_GM_Npc:OpenJingPai(selfId,params)
	local open_params = {}
	-- open_params.startmoney = tonumber(params.startmoney) or self.startmoney
	-- open_params.addmoney = tonumber(params.addmoney) or self.addmoney
	open_params.overdate = tonumber(params.overdate) or tonumber(os.date("%Y%m%d"))
	open_params.uiflag = tonumber(params.uiflag) == 2 and tonumber(params.uiflag) or 1
	local end_hour = tonumber(params.end_hour) or self.JingPaiOverHour
	local end_minute = tonumber(params.end_minute) or self.JingPaiOverMinue
	open_params.is_new = tonumber(params.is_new) == 1
	if params.item_list and #params.item_list > 0 then
		open_params.item_list = table.clone(params.item_list)
	else
		open_params.item_list = table.clone(self.item_list)
	end
	open_params.ridecount = #open_params.item_list
	if open_params.ridecount < 1 then
		self:notify_tips(selfId, "没有配置竞拍道具。")
		return
	end
	open_params.dresscount = 0
	
	open_params.endtime = end_hour * 60 + end_minute
	
	open_params.special = {
		itemid = JingPaiSpecialItemid,
		count = JingPaiSpecialCount,
		yuanbao = JingPaiSpecialNeedYuanBao,
		s_overdate = JingPaiSpecialOverDate,
		lx = JingPaiSpecialLx,
	}
	local world_id = self:LuaFnGetServerID(selfId)
	local migration = self:StartJingPai(world_id,open_params)
	if migration then
		local msg = "竞拍成功开启,当前期数:"..tostring(migration)
		self:notify_tips(selfId, msg)
		if uiflag == 1 then
			self:AddGlobalCountNews_Fun(define.UPDATE_CLIENT_ICON_SRIPTID,"OnPlayerUpdateIconDisplay","#{SZPM_230913_85}")
		else
			self:AddGlobalCountNews_Fun(define.UPDATE_CLIENT_ICON_SRIPTID,"OnPlayerUpdateIconDisplay","#{ZQPM_240402_112}")
		end
	else
		self:notify_tips(selfId, "竞拍开启失败，检查当前是否有竞拍，是否在跨服，结束时间是否正常。")
	end
end
--关闭竞拍
--密钥 区服ID
function JingPai_GM_Npc:CloseJingPai(selfId, ... )
	local world_id = self:LuaFnGetServerID(selfId)
	if self:CloseJingPaiEx(world_id) then
		local msg = "竞拍成功关闭"
		self:notify_tips(selfId, msg)
	else
		self:notify_tips(selfId, "关闭失败，检查活动是否有开启，是否在跨服场景")
	end
end
function JingPai_GM_Npc:OnEventRequest(selfId, targetId, arg, index)
	local human = self:get_scene():get_obj_by_id(selfId)
	local guid = human:get_guid()
	local special_human = false
	for _,gid in ipairs(self.empty_monster_kill_guid) do
		if gid == guid then
			special_human = true
			break
		end
	end
	if special_human then
		if index == -1 then
			human:set_today_kill_monster_count(0)
			self:BeginEvent(self.script_id)
			self:AddText("    尊贵的VIP客官，您今天的杀怪数已重置。")
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
			return
		end
	end
	if GM_GUID > 0 and GM_GUID ~= guid then
		return
	end
	if not index or index < 1 then
		self:UpdateEventList(selfId, targetId)
		return
	end
	if index == 5 then
		self:BeginEvent(self.script_id)
		self:AddText("GM竞拍操作")
		self:AddText("开启凤凰战(请先配置好JingPai_GM_Npc.lua)")
		-- self:AddText(overinfo)
		self:AddText("请确认")
		self:AddNumText("确定开启", 6, index + 100)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	elseif index == 105 then
		if self.PhoenixPlainWarStartTime < 6 then
			self:BeginEvent()
				self:AddText("PhoenixPlainWarStartTime 不得少于6秒")
			self:EndEvent()
			self:DispatchMissionTips(selfId)
			return
		end
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,48,self.PhoenixPlainWarNeedLevel)		--GM操作后 延迟10秒正式开启
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,49,self.PhoenixPlainWarNeedHp)		--GM操作后 延迟10秒正式开启
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,52,self.PhoenixPlainWarSceneId)		--GM操作后 延迟10秒正式开启
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,62,self.PhoenixPlainWarStartTime)		--GM操作后 延迟10秒正式开启
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,53,self.PhoenixPlainWarAwardTime)		--领取奖条件时间 参与100秒以上
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,51,self.PhoenixPlainWarOverTime)		--结束标记
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,21,1)		--开启标记
		local msg = "凤凰城战将在"..tostring(self.PhoenixPlainWarStartTime).."秒后正式开启，请各位大侠做好应战准备"
		self:SceneBroadcastMsg(msg)
		return
	elseif index == 6 then
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,21,0)
		self:BeginEvent(self.script_id)
		self:AddText("GM竞拍操作")
		self:AddText("开启凤凰战已结束，不作结算")
		-- self:AddText(overinfo)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	elseif index == 7 then
		self:LuaFnSetCopySceneData_Param(self.PhoenixPlainWarSceneId,51,0)
		self:BeginEvent(self.script_id)
		self:AddText("GM竞拍操作")
		self:AddText("开启凤凰战已结束，已结算")
		-- self:AddText(overinfo)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
		return
	end
	if index == 9 then
		local flagmsg = "开启拍拍"
		if self:LuaFnGetWorldGlobalDataEx(self.open_id) == 1 then
			flagmsg = "关闭拍拍"
		end
			self:BeginEvent(self.script_id)
			self:AddText(
				"    你将要" ..
					flagmsg ..
					"，请确认操作！。")
					self:AddNumText("确定", 6, 10)
					self:AddNumText("取消", 6, 0)
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
		return
	elseif index == 10 then
		if self:LuaFnGetWorldGlobalDataEx(self.open_id) == 1 then
			self:LuaFnSetWorldGlobalDataEx(self.open_id,0)
			local objid,dataid,posx,posz
			local monstercount = self:GetMonsterCount()
			for i = 1,monstercount do
				objid = self:GetMonsterObjID(i)
				dataid = self:GetMonsterDataID(objid)
				if dataid == self.npcdataid then
					posx,posz = self:GetWorldPos(objid)
					posx = math.floor(posx - self.npcposx)
					posz = math.floor(posz - self.npcposz)
					if math.abs(posx) < 2 and math.abs(posz) < 2 then
						self:LuaFnDeleteMonster(objid)
						break
					end
				end
			end
			self:AddGlobalCountNews("@*;SrvMsg;SCA:#P拍拍抽奖现已关闭，请期待下次开启。")
		else
			self:LuaFnSetWorldGlobalDataEx(self.open_id,1)
			self:create_paipai_npc("paipai")
			local msg = "@*;SrvMsg;SCA:#P拍拍抽奖正式开启，可前往#B[洛阳,"..tostring(self.npcposx)..","..tostring(self.npcposz).."]#P寻#G"..self.npcname.."#P参与。"
			self:AddGlobalCountNews(msg)
		end
		self:OnDefaultEvent(selfId, targetId)
		return
	end
end


function JingPai_GM_Npc:OnMissionAccept(selfId, targetId, missionScriptId)
end

function JingPai_GM_Npc:OnMissionRefuse(selfId, targetId, missionScriptId)
end

function JingPai_GM_Npc:OnMissionContinue(selfId, targetId, missionScriptId)
end

function JingPai_GM_Npc:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function JingPai_GM_Npc:OnDie(selfId, killerId)
end

function JingPai_GM_Npc:NotifyTips(selfId,msg)
	self:BeginEvent()
        self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return JingPai_GM_Npc
