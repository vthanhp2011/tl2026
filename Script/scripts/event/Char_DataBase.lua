local class = require "class"
local define = require "define"
local script_base = require "script_base"
local Char_DataBase = class("Char_DataBase", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
Char_DataBase.script_id = 999994

function Char_DataBase:GetNewDayRestData(selfId,on_line)
	-- if not selfId or selfId >= 0 then
		-- return
	-- end
	-- selfId = math.abs(selfId)
	if self:GetMissionData(selfId,629) ~= 0 then
		self:SetMissionData(selfId,define.MD_WDDAO_FOUR_4,self:GetMissionData(selfId,629))
		self:SetMissionData(selfId,629,0)
	elseif self:GetMissionData(selfId,630) ~= 0 then
		self:SetMissionData(selfId,define.MD_WDDAO_FOUR_4,self:GetMissionData(selfId,630))
		self:SetMissionData(selfId,630,0)
	end
    local nLastDayTime = self:GetMissionData(selfId, define.MD_ENUM.MD_SERVER_TIME)
    local nLastWeekTime = self:GetMissionData(selfId, define.MD_ENUM.MD_SERVER_WEEK_TIME)
    local nTadayTime = self:GetTime2Day()
    if nLastDayTime ~= nTadayTime then
        self:SetMissionData(selfId, define.MD_ENUM.MD_SERVER_TIME, nTadayTime)
        self:SetGongLi(selfId, 100)
        self:LuaFnResetWeekActiveDay(selfId)
        self:ResetKillMonsterCount(selfId)

        self:ResetCampaignCount(selfId)
        self:SetMissionFlag(selfId, ScriptGlobal.MF_SWEEP_ALL_DAY_CARD, 0)
        self:SetMissionData(selfId, ScriptGlobal.MD_SweepAll_SeckillTequanDayCount, 0)

        self:LuaFnRestMysteryShopInfo(selfId)
        self:LuaFnCheckResetWanShiGeData(selfId)
		self:LuaFnAddMissionHuoYueZhi(selfId, 1)
    end
    local nToWeekTime = self:GetTime2Week()
    if nLastWeekTime ~= nToWeekTime then
        self:SetMissionData(selfId, define.MD_ENUM.MD_SERVER_WEEK_TIME, nToWeekTime)
        self:LuaFnResetWeekActiveWeek(selfId)
        self:LuaFnCheckResetJiYuanShop(selfId)
    end
	if not on_line then
		self:OnPlayerUpdateIconDisplay(selfId)
	end
end
function Char_DataBase:OnPlayerTick(selfId)
	if not selfId or selfId >= 0 then
		return
	end
	selfId = math.abs(selfId)
	local human = self:get_scene():get_obj_by_id(selfId)
	local guid = human:get_guid()
	local sceneId = self:get_scene_id()
	local times = os.date("*t")
	local hour = times.hour
	local minute = times.min
	local cer_week = times.wday - 1
	if cer_week == 0 then
		cer_week = 7
	end
	local scene_name,time_msg = "",""
	if sceneId == 1299 then
		local serverid = self:LuaFnGetServerID(selfId)
		if serverid == 10 or serverid == 11 or serverid == 14 then
			if cer_week == 2 or cer_week == 4 or cer_week == 6 or cer_week == 7 then
				if hour >= 20 or hour < 1 then
					return
				end
			end
			scene_name = "跨服地宫四层"
			time_msg = "周二、周四、周六、周日 20:00-次日01:00"
		else
			if hour >= 20 or hour < 1 then
				return
			end
			scene_name = "跨服地宫四层"
			time_msg = "20:00-次日01:00"
		end
	elseif sceneId == 1303 then
		local serverid = self:LuaFnGetServerID(selfId)
		if serverid == 20  then
			if cer_week == 1 or cer_week == 3 or cer_week == 5 then
				if hour >= 20 or hour < 1 then
					return
				end
			end
			scene_name = "地宫四层"
			time_msg = "周一、周三、周五 20:00-次日01:00"
		--elseif  serverid == 10 or serverid == 13 or serverid == 17 or serverid == 15 or serverid == 16 then
		else
			if hour >= 20 or hour < 1 then
				return
			end
			scene_name = "地宫四层"
			time_msg = "20:00-次日1:00"
		--else
		--	scene_name = "地宫四层"
		--	time_msg = "本服不开放"
		end
	else
		return
	end
	local msg = string.format("%s的开放时间%s。",scene_name,time_msg)
	self:notify_tips(selfId,msg)
	self:NewWorld(selfId,0,nil,160,105)
	
end
function Char_DataBase:OnPlayerUpdateIconDisplay(selfId)
	local hb_migration,hb_ui_flag,jp_migration,md_date = self:GetClientIconDisplay(selfId)
	local hb_uiid = 0
	if not hb_migration or hb_migration < 1 then
		hb_migration = -1
		hb_ui_flag = 0
	else
		if hb_ui_flag == 2 then
			hb_uiid = 89139601
		else
			hb_uiid = 89297401
		end
	end
	self:BeginUICommand()
	self:UICommand_AddInt(hb_uiid)
	self:UICommand_AddInt(hb_migration)
	self:EndUICommand()
	self:DispatchUICommand(selfId,89297401)
	self:BeginUICommand()
	self:UICommand_AddInt(hb_uiid)
	self:UICommand_AddInt(hb_migration)
	self:EndUICommand()
	self:DispatchUICommand(selfId,89139601)
	
	jp_migration = jp_migration or 0
	self:BeginUICommand()
	self:UICommand_AddInt(88881803)
	self:UICommand_AddInt(jp_migration)
	self:EndUICommand()
	self:DispatchUICommand(selfId,88881803)
	
	md_date = md_date or 0
	self:BeginUICommand()
	self:UICommand_AddInt(415052024)
	self:UICommand_AddInt(md_date)
	self:EndUICommand()
	self:DispatchUICommand(selfId,415052024)
	self:CallScriptFunction(888818, "TakeBackYuanBao", selfId, true)
end


return Char_DataBase
