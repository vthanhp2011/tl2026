local class = require "class"
local gbk = require "gbk"
local define = require "define"
local script_base = require "script_base"
local scene = class("scene", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
local configenginer = require "configenginer":getinstance()
local g_defaultRelive_SceneID_1 = 77
local g_HanYuBed_SceneId = 194
-- 玩家升级时可以完成的任务
scene.FullLevel_MissionList	=	{}
scene.FullLevel_MissionList[28] = { MissionId = 403, MissionIndex = 500606, LevelLimit = 28, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_188}" }
scene.FullLevel_MissionList[30] = { MissionId = 409, MissionIndex = 500602, LevelLimit = 30, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_181}" }												-- 任务ID,任务索引号,需求等级,任务完成标志在任务参数第几位,任务跟踪标志在任务参数第几位
scene.FullLevel_MissionList[32] = { MissionId = 412, MissionIndex = 500603, LevelLimit = 32, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_183}" }
scene.FullLevel_MissionList[35] = { MissionId = 415, MissionIndex = 500605, LevelLimit = 35, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_186}" }
scene.FullLevel_MissionList[38] = { MissionId = 418, MissionIndex = 500608, LevelLimit = 38, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_191}" }
scene.FullLevel_MissionList[40] = { MissionId = 428, MissionIndex = 500612, LevelLimit = 40, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_196}" }
scene.FullLevel_MissionList[42] = { MissionId = 433, MissionIndex = 500613, LevelLimit = 42, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_198}" }
scene.FullLevel_MissionList[45] = { MissionId = 437, MissionIndex = 500614, LevelLimit = 45, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_200}" }
scene.FullLevel_MissionList[48] = { MissionId = 476, MissionIndex = 500615, LevelLimit = 48, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_202}" }
scene.FullLevel_MissionList[50] = { MissionId = 480, MissionIndex = 500616, LevelLimit = 50, CompleteIdx = 0, RecordIdx = 1, MsgStr = "#{YD_20080421_204}" }

-- 玩家升级时可以自动添加的任务
scene.AutoAccept_MissionList = {}
scene.AutoAccept_MissionList[26] = { MissionId = 400, MissionIndex = 1018700, PreMissionId = 0,   pKill = 0, pArea = 0, pItem = 0, EventId = 4 }
scene.AutoAccept_MissionList[28] = { MissionId = 403, MissionIndex = 500606, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }			-- 任务ID,任务索引号,前续任务ID,任务类型参数(3),脚本任务时MissionIndex为ScriptId
scene.AutoAccept_MissionList[30] = { MissionId = 409, MissionIndex = 500602, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[32] = { MissionId = 412, MissionIndex = 500603, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[35] = { MissionId = 415, MissionIndex = 500605, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[38] = { MissionId = 418, MissionIndex = 500608, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[40] = { MissionId = 428, MissionIndex = 500612, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[42] = { MissionId = 433, MissionIndex = 500613, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[45] = { MissionId = 437, MissionIndex = 500614, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[48] = { MissionId = 476, MissionIndex = 500615, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }
scene.AutoAccept_MissionList[50] = { MissionId = 480, MissionIndex = 500616, PreMissionId = 0, pKill = 0, pArea = 0, pItem = 0, EventId = 0 }

scene.titleinfo = 
{
    1204,1286,1073,-1,1234,1235,1236
}
scene.menpaititle = 
{
    1096,1108,1117,1099,1102,1105,1111,1120,1114,-1,1219
}
scene.payinfo = 
{
    250000,500000,1500000,2500000,5000000,15000000,25000000
}

function scene:LuaFnGetSceneSafeLevel()
    local sceneid = self.scene:get_id()
    local scene_attr = configenginer:get_config("scene_attr")
	local attr = scene_attr[sceneid]
    return attr and attr.safe_level or 0
end

function scene:DelPayTitleData(selfId)
    local HaveYuanBao = self:GetMissionData(selfId, 388)
    local menpai = self:GetMenPai(selfId)
    local titleidx = 0
    for i = 1,#self.payinfo do
        if HaveYuanBao < self.payinfo[i] then
            titleidx = i;
        end
        if titleidx > 0 and titleidx ~= 4 then
            if self:LuaFnHaveAgname(selfId, self.titleinfo[titleidx]) then
                self:LuaFnDelNewAgname(selfId, self.titleinfo[titleidx])
            end
        else
            if titleidx > 0 then
                for k = 1,#self.menpaititle do
                    if k ~= 10 then
                        if self:LuaFnHaveAgname(selfId, self.menpaititle[k]) then
							self:LuaFnDelNewAgname(selfId, self.menpaititle[k])
                        end
                    end
                end
            end
        end
    end
end

function scene:OnScenePlayerEnter(selfId)
    local sceneId = self:GetSceneID()
    self:SetPlayerDefaultReliveInfo(selfId, 1, 1, 0.1, g_defaultRelive_SceneID_1, 20, 38 )
    local nSafeLevel = self:LuaFnGetSceneSafeLevel()
    -- 玩家进入非安全场景，给个无敌BUFF
    if nSafeLevel == 0 then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 54, 100 )
    end
	local nSceneType = self:LuaFnGetSceneType()
	if nSceneType == 1 then
		local copyscenetype = self:LuaFnGetCopySceneData_Param(0)
		local copyscenescript = self:LuaFnGetCopySceneData_Param(1)
		if not self:CheckTimer(0) then
			self:SetTimer(selfId, copyscenescript, "OnCopySceneTimer", 1000)
		end
	end
    if sceneId == g_HanYuBed_SceneId then
		if not self:CheckTimer(0) then
			self:SetTimer(selfId, 808072, "OnSceneTimer",12000)
		end
	end
    if sceneId == 191 then
        print("CheckTimer 191 OnSceneTimer")
		if not self:CheckTimer(0) then
            print("SetTimer 191 OnSceneTimer")
			self:SetTimer(selfId,403005,"OnSceneTimer",1000)
		end
        self:CallScriptFunction((403005), "OnPlayerEnter",selfId)
	end
    if sceneId == 5 then
		if not self:CheckTimer(0) then
			self:SetTimer(selfId,005116,"OnSceneTimer",60000)
		end
	end
	if sceneId == 1299 then
		if not self:CheckTimer(0) then
			self:SetTimer(selfId,3000003,"OnSceneTimer",60000)
		end
	end
	if sceneId == 1289 then
		if not self:CheckTimer(0) then
			self:SetTimer(selfId,3000008,"OnSceneTimer",30000)
		end
	end
	if sceneId == 181 then
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 50074, 0)
	end
	if sceneId == 151 and self:LuaFnGetHumanPKValue(selfId) > 4 then
		self:SetPlayerDefaultReliveInfo(selfId, 0.1, -1,0, 151, 48, 30 )
		return
	end
    if sceneId == 0 then
		self:SetTimer(selfId,900019,"OnSceneTimer", 60000)
	end
    self:CallScriptFunction(999994, "GetNewDayRestData", selfId)
    self:CallScriptFunction(892666, "OnScenePlayerEnter", selfId)
	self:FixDungeonSweep(selfId)
	self:CheckYuanGongSkillOK(selfId)
	self:CallScriptFunction(891062, "OnScenePlayerEnter", selfId)
	self:DelPayTitleData(selfId)
	self:ShowChunJieQianDao(selfId)
	self:ShowLoveTimeIcon(selfId)
end

function scene:ShowChunJieQianDao(selfId)
	self:BeginUICommand()
    self:UICommand_AddInt(1)
	self:UICommand_AddInt(1)
    self:EndUICommand()
    self:DispatchUICommand(selfId,89297502)
end

function scene:ShowLoveTimeIcon(selfId)
	self:BeginUICommand()
    self:UICommand_AddInt(1)
    self:EndUICommand()
    self:DispatchUICommand(selfId,89297401)
end

function scene:FixDungeonSweep(selfId)
	local human = self:get_scene():get_obj_by_id(selfId)
	human.dungeonsweep.sec_kill_data = human.dungeonsweep.sec_kill_data or {}
end

function scene:CheckYuanGongSkillOK(selfId)
	local menpai = self:GetMenPai(selfId)
	local yuangong_skill = define.MENPAI_JINZHAN_YUANGONG_SKILL[menpai]
	if not self:HaveSkill(selfId, yuangong_skill) then
		self:AddSkill(selfId, yuangong_skill)
	end
end

function scene:OnScenePlayerLeave(selfId)
	local sceneId = self:GetSceneID()
	if sceneId == 181 then
		self:LuaFnCancelSpecificImpact(selfId,50074)
	end
end

function scene:OnSceneHumanLevelUp(objId,level)
    --对十年任务的检测
    local misIndex
	if self:IsHaveMission(objId,1424) then
        misIndex = self:GetMissionIndexByID(objId,1424)
        self:SetMissionByIndex(objId,misIndex,1,level)
        if level >= 10 then
            self:SetMissionByIndex(objId,misIndex,0,1)
        end
    end
	if level <= 10 then
        local mission_id = 1424
        if self:IsHaveMission(objId, mission_id) then
            misIndex = self:GetMissionIndexByID(objId, mission_id)
            self:SetMissionByIndex(objId,misIndex,1, level)
        end
    end
	-- 给达到等级要求的玩家添加任务
	self:OnAutoAcceptMission(objId,level)
	-- 给满足完成条件的任务设置任务完成标志
	self:OnSetCompleteMission(objId,level)
end

function scene:OnAutoAcceptMission(objId,level)
	-- 检测任务接受条件
	if self:OnAcceptCheck(objId,level) > 0 then
		local missioninfo = self.AutoAccept_MissionList[level]
		if missioninfo ~= nil then
			local ret = self:AddMission(objId, missioninfo.MissionId, missioninfo.MissionIndex, missioninfo.pKill, missioninfo.pArea, missioninfo.pItem)	-- kill、area、item
			if ret and missioninfo.EventId ~= 0 then
				self:SetMissionEvent(objId, missioninfo.MissionId, missioninfo.EventId )
			end
		end
	end
end

function scene:OnAcceptCheck(objId,level)
	-- 任务是否已满
	if self:IsMissionFull(objId ) then
		return 0
	end
	local missioninfo = self.AutoAccept_MissionList[level]
	--检测等级
	if not missioninfo then
		return 0
	end
	--已经接过则不符合条件
	if self:IsHaveMission(objId, missioninfo.MissionId ) then
		return 0
	end

	--已经做过则不符合条件
	if self:IsMissionHaveDone(objId, missioninfo.MissionId) then
		return 0
	end

	--检测前续任务
	if missioninfo.PreMissionId > 0 then
		if not self:IsMissionHaveDone(objId, missioninfo.PreMissionId) then
			return 0
		end
	end
	return 1
end
--玩家角色登陆游戏事件, 此事件会在玩家调用x888888_OnScenePlayerEnter事件之后调用
function scene:OnScenePlayerLogin(selfId,nowtime)
	local ShenBingTime = self:LuaFnGetWorldGlobalData(99)
	local NowTime = self:GetMissionData(selfId,522)
	local NewTime = self:GetDayTime()
	--每日第一个玩家登录记录今日七情类型全局类
	if ShenBingTime ~= tonumber(NewTime) then
		self:LuaFnSetWorldGlobalData(100,math.random(0,6))
		self:LuaFnSetWorldGlobalData(99,tonumber(NewTime))
	end
	--七日豪礼登陆
	local nSevenDay = self:GetMissionData(selfId,520)
	local Feek800Day = self:GetMissionDataEx(selfId,137)
	if NowTime ~= tonumber(NewTime) then
		if nSevenDay < 7 then
			self:SetMissionData(selfId,520,nSevenDay + 1) --记录登陆天数
		end
		if Feek800Day < 7 then
			self:SetMissionDataEx(selfId,137,Feek800Day + 1) --记录登陆天数
		end
		self:SetMissionData(selfId,522,tonumber(NewTime))
	end
	self:CallScriptFunction(892679,"CheckGetFullPrize",selfId)
	--新手七日礼结束
	--新手上线倒计时领奖
	self:CallScriptFunction(889103,"OpenFreshManTime",selfId)
	--添加任务十年 初涉江湖
	if not self:IsMissionHaveDone(selfId,1424) then
		local ret = self:AddMission(selfId,1424,210238,1,0,0)
		if ret then
        local misIndex = self:GetMissionIndexByID(selfId,1424)
        self:SetMissionByIndex(selfId,misIndex,1,self:GetLevel(selfId))
			if self:GetLevel(selfId) >= 10 then
				self:SetMissionByIndex(selfId,misIndex,0,1)
			end
		end
    end
	if not self:IsMissionHaveDone(selfId,1400) then
		local ret = self:AddMission(selfId,1400,210262,1,0,0)
		if ret then
        	local misIndex = self:GetMissionIndexByID(selfId,1400)
			self:SetMissionByIndex(selfId,misIndex,0,1)
        	self:SetMissionByIndex(selfId,misIndex,1,1)
		end
    end
end
--玩家创建角色后第一次登陆游戏事件, 此事件会在玩家调用x888888_OnScenePlayerEnter事
--件之后、x888888_OnScenePlayerLogin事件之前调用
function scene:OnScenePlayerFirstLogin(selfId,nowtime)
	if self:GetMissionDataEx(selfId,130) > 0 then
		return
	end
	self:AddMoneyJZ(selfId,15000000)
	self:AddBindYuanBao(selfId,60000)
	self:SetMissionDataEx(selfId,130,130130)
end


function scene:OnSetCompleteMission(objId,level)
	-- 检测任务完成条件
	if self:OnCompleteCheck(objId,level) > 0 then
		local missioninfo = self.FullLevel_MissionList[level]
		if missioninfo ~= nil then
			local misIndex = self:GetMissionIndexByID(objId,missioninfo.MissionId)
			self:SetMissionByIndex(objId, misIndex, missioninfo.CompleteIdx, 1 )
			self:SetMissionByIndex(objId, misIndex, missioninfo.RecordIdx, 1 )
			self:BeginEvent()
                self:AddText(missioninfo.MsgStr)
			self:EndEvent()
			self:DispatchMissionTips(objId)
		end
	end
end

function scene:OnCompleteCheck(objId,level)
	local missioninfo = self.FullLevel_MissionList[level]
	--检测等级
	if not missioninfo then
		return 0
	end
	if not self:IsHaveMission(objId, missioninfo.MissionId ) then
		return 0
	end
	-- 是否达到需求等级
	local Playerlvl = self:GetLevel(objId)
	if Playerlvl < missioninfo.LevelLimit then
		return 0
	end
	local misIndex = self:GetMissionIndexByID(objId,missioninfo.MissionId)
	-- 检测任务是否完成	
	if self:GetMissionParam(objId, misIndex, missioninfo.CompleteIdx) then
		return 1
	end
	return 0
end

function scene:AskTheWay(...)
    local args = { ... }
    local selfId, sceneNum, x, y, tip
    if #args == 4 then
        selfId, x, y, tip = table.unpack(args)
        sceneNum = self:get_scene_id()
    else
        selfId, sceneNum, x, y, tip = table.unpack(args)
    end
    print("scene:AskTheWay", selfId, sceneNum, x, y, tip)
    self:Msg2Player(selfId, "@*;flagNPC;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(selfId, "@*;flashNPC;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
end

function scene:AskThePos(...)
    local args = { ... }
    local selfId, sceneNum, x, y, tip
    if #args == 4 then
        selfId, x, y, tip = table.unpack(args)
        sceneNum = self:get_scene_id()
    else
        selfId, sceneNum, x, y, tip = table.unpack(args)
    end
    print("scene:AskThePos", selfId, sceneNum, x, y, tip)
	self:Msg2Player(selfId, "@*;flagPOS;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA )
	self:Msg2Player(selfId, "@*;flashPOS;" .. sceneNum .. ";" .. x .. ";" .. y .. ";" .. tip, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA )
end

function scene:CheckSubmit(selfId, missionId )
	local bHave = self:IsHaveMission(selfId, missionId )
	local bHaveDone = self:IsMissionHaveDone(selfId, missionId )
	-- 没有接
	if not bHave then
		return 0
	end
	-- 已经完成过
	if bHaveDone then
		return 0
	end
	return 1
end

function scene:PlaySoundEffect(selfId, soundId)
    self:BeginUICommand()
    self:UICommand_AddInt(soundId)
    self:EndUICommand()
    self:DispatchUICommand(selfId,1234)
end

--判断是否是帮会主力
function scene:IsGuildVip(Guildpos)
    if (   (Guildpos == 9) 
	    or (Guildpos == 8)
	    or (Guildpos == 7)
	    or (Guildpos == 6)
	    or (Guildpos == 5)
	    or (Guildpos == 4) 
	    or (Guildpos == 3) 
	   )then
        return 1;
		end
		return 0;
end

function scene:OnSceneHumanDie(selfId, killerId)
    local sceneId = self:GetSceneID()
	local SceneType = self:LuaFnGetSceneType()
	if SceneType == 1 then
		local copyscenescript = self:LuaFnGetCopySceneData_Param(1) ; --取得脚本号
		self:CallScriptFunction( copyscenescript, "OnHumanDie",selfId,killerId )
	end
    if sceneId == 191 then
        self:CallScriptFunction(403005,"OnSceneHumanDie",selfId,killerId)
    end
	--设置杀气达到8进入监狱
	local Vaule = self:LuaFnGetHumanPKValue(killerId)
	self:LOGI("KillId = ",self:GetName(killerId))
	self:LOGI("selfId = ",self:GetName(selfId))
	self:LOGI("KillVaule = ",self:LuaFnGetHumanPKValue(killerId))
	self:LOGI("selfVaule = ",self:LuaFnGetHumanPKValue(selfId))
	if Vaule >= 8 then
		self:LuaFnSendSpecificImpactToUnit(killerId,killerId,killerId,42,0)
		self:CallScriptFunction((400900), "TransferFunc", killerId,151,48,30)
	end
	self:OnGuildPvpChatPipe(selfId, killerId)
end

function scene:OnGuildPvpChatPipe(selfId,killerId)
	--判断击杀玩家和死亡玩家是否拥有帮会。
	local killer = self:get_scene():get_obj_by_id(selfId)
	if killer:get_obj_type() ~= "human" then
		return
	end
	local nSelfGuildPos = self:GetGuildPos(selfId)
	local nKillGuildPos = self:GetGuildPos(killerId)
	if self:IsGuildVip(nSelfGuildPos) > 0 then
		local selfName = self:GetName(selfId);
		local killerName = self:GetName(killerId);
		local guildName_killer = self:LuaFnGetGuildName(killerId);
		local sMessage = string.format(gbk.fromutf8("@*;SrvMsg;GLD:#W本帮主力#R%s#W在帮战中浴血奋战，不敌#G%s#W帮会的#R%s#W，为帮会英勇献身！"), gbk.fromutf8(selfName),gbk.fromutf8(guildName_killer),gbk.fromutf8(killerName));
		if guildName_killer == "" then
			sMessage = string.format(gbk.fromutf8("@*;SrvMsg;GLD:#W本帮主力#R%s#W在帮战中浴血奋战，不敌#R%s#W，为帮会英勇献身！"), gbk.fromutf8(selfName),gbk.fromutf8(killerName));
		end
		self:BroadMsgByChatPipe(selfId,sMessage,6);
	end
	if self:IsGuildVip(nKillGuildPos) > 0 then
		local sMessage = ""
		local selfName = self:GetName(selfId);
		local guildName_self = self:LuaFnGetGuildName(selfId);
		local killerName = self:GetName(killerId);
		if guildName_self ~= "" then
			sMessage = string.format(gbk.fromutf8("@*;SrvMsg;GLD:#R%s#W在帮战中大展身手，成功击杀#G%s#W帮会主力#R%s#W，扞卫了帮会的荣誉！"), gbk.fromutf8(killerName), gbk.fromutf8(guildName_self), gbk.fromutf8(selfName));
			self:BroadMsgByChatPipe(killerId,sMessage,6);
		end
	end
end

function scene:OnInitScene(...)
    local sceneId = self:get_scene_id()
    if sceneId == 414 then
        self:CallScriptFunction((125020), "OnInitScene", ...)
	end
end

function scene:OnNewDay(selfId)
    self:CallScriptFunction(999994, "GetNewDayRestData", selfId)
end

function scene:LuaFnDelNewAgname(selfId, del_id)
    local human = self:get_scene():get_obj_by_id(selfId)
    local id_titles = human.id_titles
	for i = #id_titles, 1, -1 do
		local title = id_titles[i]
		if title.id == del_id then
			table.remove(id_titles, i)
			break
		end
	end
    human:update_titles_to_client()
end

function scene:GetFreeObjCount()
	local objs = self.scene.objs
	local free_count = 0
	for i = 1, define.MAX_OBJ_ID do
		if objs[i] == nil then
			free_count = free_count + 1
		end
	end
	local skynet = require "skynet"
	skynet.logi("GetFreeObjCount free_count =", free_count)
end

function scene:LogPetObjStatus()
	local objs = self.scene.objs
	for i = 1, define.MAX_OBJ_ID do
		local obj = objs[i]
		if obj then
			local otype = obj:get_obj_type()
			if otype == "pet" then
				local owner = obj:get_owner()
				if owner and owner:get_obj_type() ~= "human" then
					local skynet = require "skynet"
					skynet.logi("LogPetObjStatus wrong error obj_type =", owner:get_obj_type(), ", error obj_id =", owner:get_obj_id(), ", pet world pos =", table.tostr(obj:get_world_pos()))
				end
			end
		end
	end
end

function scene:DebugMode()
	local skynet = require "skynet"
	_ENV.print = skynet.logi
end

function scene:LogObjStatus()
	local obj_id_status = {}
	local objs = self.scene.objs
	for i = 1, define.MAX_OBJ_ID do
		if objs[i] then
			obj_id_status[i] = true
		end
	end
	local skynet = require "skynet"
	skynet.logi("LogObjStatus obj_id_status =", table.tostr(obj_id_status), ", now_obj_id =", self.scene.now_obj_id)
end

function scene:HotFix_GenObjID()
	local scenecore = self.scene
	scenecore.gen_obj_id = function(core)
		while true do
			core.now_obj_id = core.now_obj_id + 1
			local now = core.now_obj_id
			if now >= define.MAX_OBJ_ID then
				core.now_obj_id = 1
			elseif core.objs[now] == nil then
				return now
			end
		end
	end
end

function scene:HotUpdateClientRes()
	local s = self:get_scene()
	s.client_res = 242
end

function scene:BanPiaoPiaoTuOwners()
	local skynet = require "skynet"
	local objs = self.scene.objs
	for i = 1, define.MAX_OBJ_ID do
		local obj = objs[i]
		if obj and obj:get_obj_type() == "human" then
			local current_pet_guid = obj:get_current_pet_guid()
			if current_pet_guid ~= define.INVAILD_ID then
				local current_pet = obj:get_pet_bag_container():get_pet_by_guid(current_pet_guid)
				if current_pet then
					local data_index = current_pet:get_data_index()
					local ride_model = obj:get_ride_model()
					local team_id = obj:get_team_id()
					if (data_index == 559 or data_index == 3069) and (ride_model == 45 or ride_model) and (team_id ~= define.INVAILD_ID) then
						local str = skynet.call(".gamed", "lua", "query_roler_account", string.format("%x", obj:get_guid()))
						local _, account = string.match(str, "GUID是(%d+)的玩家的账号是 (.+)")
						self:LOGI("BanPiaoPiaoTuOwners account =", account)
						if account then
							skynet.send(".gamed", "lua", "ban_user", account)
						end
					end
				end
			end
		end
	end
end

function scene:KickAllUsers()
	local skynet = require "skynet"
	local objs = self.scene.objs
	for i = 1, define.MAX_OBJ_ID do
		local obj = objs[i]
		if obj and obj:get_obj_type() == "human" then
			local guid = obj:get_guid()
			skynet.send(".gamed", "lua", "kick", guid, 0, "maintenance")
		end
	end
end

return scene