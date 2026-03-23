local gbk = require "gbk"
local class = require "class"
local ScriptGlobal = require "scripts.ScriptGlobal"
local define = require "define"
local script_base = require "script_base"
local eDynamicNPC_ThiefSoldier = class("eDynamicNPC_ThiefSoldier", script_base)
eDynamicNPC_ThiefSoldier.script_id = 050013
eDynamicNPC_ThiefSoldier.g_ClientRes = 170
eDynamicNPC_ThiefSoldier.g_CopySceneType = ScriptGlobal.FUBEN_ZEIBINGRUQIN
eDynamicNPC_ThiefSoldier.g_LimitMembers = 1
eDynamicNPC_ThiefSoldier.g_TickTime = 5
eDynamicNPC_ThiefSoldier.g_LimitTotalHoldTime = 360
eDynamicNPC_ThiefSoldier.g_LimitTimeSuccess = 500
eDynamicNPC_ThiefSoldier.g_CloseTick = 6
eDynamicNPC_ThiefSoldier.g_NoUserTime = 300
eDynamicNPC_ThiefSoldier.g_Fuben_X = 76
eDynamicNPC_ThiefSoldier.g_Fuben_Z = 110
eDynamicNPC_ThiefSoldier.g_BossGroupID = 1
eDynamicNPC_ThiefSoldier.g_TotalNeedKillBoss = 31
eDynamicNPC_ThiefSoldier.g_keySD = {}

eDynamicNPC_ThiefSoldier.g_keySD["typ"] = 0
eDynamicNPC_ThiefSoldier.g_keySD["spt"] = 1
eDynamicNPC_ThiefSoldier.g_keySD["tim"] = 2
eDynamicNPC_ThiefSoldier.g_keySD["scn"] = 3
eDynamicNPC_ThiefSoldier.g_keySD["cls"] = 4
eDynamicNPC_ThiefSoldier.g_keySD["dwn"] = 5
eDynamicNPC_ThiefSoldier.g_keySD["tem"] = 6
eDynamicNPC_ThiefSoldier.g_keySD["x"] = 7
eDynamicNPC_ThiefSoldier.g_keySD["z"] = 8
eDynamicNPC_ThiefSoldier.g_keySD["ObjKilled"] = 9
eDynamicNPC_ThiefSoldier.g_keySD["MyLevel"] = 10
eDynamicNPC_ThiefSoldier.g_keySD["FlagThielf"] = 11
eDynamicNPC_ThiefSoldier.paramonce = 28
eDynamicNPC_ThiefSoldier.g_minLevel = 20
eDynamicNPC_ThiefSoldier.g_typMonster0 = 3650
eDynamicNPC_ThiefSoldier.g_typMonster1 = 3659
eDynamicNPC_ThiefSoldier.Monster_Boss = {
    3650, 3651, 3652, 3653, 3654, 3655, 3656, 3657, 3658, 3659
}

eDynamicNPC_ThiefSoldier.NianShou_Boss = {
    12200, 12201, 12202, 12203, 12204, 12205, 12206, 12207, 12208, 12209, 12210,
    12211
}

eDynamicNPC_ThiefSoldier.NianShou_Pos = {
    {["x"] = 83, ["z"] = 45}, {["x"] = 93, ["z"] = 34},
    {["x"] = 53, ["z"] = 30}, {["x"] = 27, ["z"] = 24}, {["x"] = 34, ["z"] = 41}
}

function eDynamicNPC_ThiefSoldier:OnDefaultEvent(selfId, targetId)
    self:BeginUICommand()
    self:UICommand_AddInt(targetId)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
    local CanAccept = self:OnAccept(selfId,targetId)
    if (1 == CanAccept) then self:LuaFnDeleteMonster(targetId) end
end

function eDynamicNPC_ThiefSoldier:OnEnumerate(caller, selfId, targetId, arg,index)
	-- if not self:LuaFnIsActivityMonster(selfId,targetId,true)
		-- return
	-- end

    local lev = self:GetLevel(selfId)
    if lev < self.g_minLevel then
        caller:BeginEvent(self.script_id)
        caller:AddText("你的等级太低了，根本不够我看的，还是20级之后再来找我吧。")
        caller:EndEvent()
        caller:DispatchEventList(selfId, targetId)
        return
    end
    if not self:LuaFnHasTeam(selfId) then
        caller:BeginEvent(self.script_id)
        caller:AddText("区区一个人就想来挑战我，我根本不屑与你动手。")
        caller:EndEvent()
        caller:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetTeamSize(selfId) < self.g_LimitMembers then
        caller:BeginEvent(self.script_id)
        caller:AddText("想要挑战我至少也得上来三个吧，就这点人？也太瞧不起我了。")
        caller:EndEvent()
        caller:DispatchEventList(selfId, targetId)
        return
    end
    if not self:LuaFnIsTeamLeader(selfId) then
        caller:BeginEvent(self.script_id)
        caller:AddText("想要挑战我？叫你们的队长来吧。")
        caller:EndEvent()
        caller:DispatchEventList(selfId, targetId)
        return
    end
    local leaderObjId = selfId
    local NearCount = self:GetNearTeamCount(leaderObjId)
    local namenum = 0
    local notifyString = "您队伍中有成员("
    for i = 1, NearCount do
        local nPlayerId = self:GetNearTeamMember(selfId, i)
        local lev = self:GetLevel(nPlayerId)
        local nam = self:GetName(nPlayerId)
        if (lev < 20) then
            notifyString = notifyString .. nam .. " "
            namenum = 1
        end
    end
    notifyString = notifyString .. ")等级不足。"
    if (namenum > 0) then
        caller:BeginEvent(self.script_id)
        caller:AddText(notifyString)
        caller:EndEvent()
        caller:DispatchEventList(selfId, targetId)
        return
    end
    for i = 1, NearCount do
        local TeammateID = self:GetNearTeamMember(leaderObjId, i)
        if (-1 == TeammateID) then return end
        local Level = self:GetLevel(TeammateID)
        if (Level < 20) then
            caller:BeginEvent(self.script_id)
            caller:AddText("你的队伍中有队员的等级不足20级！")
            caller:EndEvent()
            caller:DispatchEventList(selfId, targetId)
            return
        end
    end
    caller:BeginEvent(self.script_id)
    caller:AddText("既然你们不怕死，我也就没有必要留什么情面了，小的们，过来给他们点厉害尝尝。")
    caller:AddNumTextWithTarget(self.script_id, "难道我还怕你不成……", 10, -1)
    caller:EndEvent()
    caller:DispatchEventList(selfId, targetId)
end

function eDynamicNPC_ThiefSoldier:CheckAccept(selfId) return 1 end

function eDynamicNPC_ThiefSoldier:OnAccept(selfId, targetId)
	if not self:LuaFnIsActivityMonster(selfId,targetId,true) then return -1 end
    local lev = self:GetLevel(selfId)
    if lev < self.g_minLevel then
        self:NotifyTip(selfId, "你的等级太低了")
        return -1
    end
    if self:LuaFnHasTeam(selfId) == 0 then
        self:NotifyTip(selfId, "你还没有队伍")
        return -1
    end
    if self:GetTeamSize(selfId) < self.g_LimitMembers then
        self:NotifyTip(selfId, "队伍不足" .. (self.g_LimitMembers) .. "人")
        return -1
    end
    if not self:LuaFnIsTeamLeader(selfId) then
        self:NotifyTip(selfId, "你不是队长")
        return -1
    end
    local NearCount = self:GetNearTeamCount(selfId)
    local TeammateCount = self:GetTeamMemberCount(selfId)
    if (NearCount < TeammateCount) then
        self:BeginEvent(self.script_id)
        local strText = "您有队友没在附近"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return -1
    end
    for i = 1, TeammateCount do
        local TeammateID = self:GetNearTeamMember(selfId, i)
        if (-1 == TeammateID) then return -1 end
        local Level = self:GetLevel(TeammateID)
        if (Level < 20) then
            self:BeginEvent(self.script_id)
            self:AddText("您的队伍中有队员的等级不足20级！")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return -1
        end
    end
    local numMem = self:GetNearTeamCount(selfId)
    self:MakeCopyScene(selfId, numMem,targetId)
    return 1
end

function eDynamicNPC_ThiefSoldier:OnAbandon(selfId) end

function eDynamicNPC_ThiefSoldier:CreateBoss(iniLevel)
    if (iniLevel < self.g_minLevel) then iniLevel = self.g_minLevel end
    local PlayerMaxLevel = self:GetHumanMaxLevelLimit()
    if (iniLevel > PlayerMaxLevel) then iniLevel = PlayerMaxLevel end
    local ini = math.floor(iniLevel / 10)
    if ini <= 0 then
        ini = 1
    elseif ini > 10 then
        ini = 10
    end
    local typ = self.Monster_Boss[ini]
    local objId = self:LuaFnCreateMonster(typ, 19.4121, 102.2840, 14, 76, 50013)
    self:SetMonsterGroupID(objId, self.g_BossGroupID)
    self:SetLevel(objId, iniLevel)
    local szName = self:LuaFnGetName(objId)
    if szName == "贼兵头目" then
        self:SetCharacterTitle(objId, "“围而不死”")
    end
    local DataID = self:GetMonsterDataID(objId)
    local strMonsterName = self:GetMonsterNamebyDataId(DataID)
    self:CallScriptFunction((200060), "Paopao", strMonsterName, "贼寇营地",
                            "天堂有路你不走，地狱无门你闯进来！既然来了，就别想再出去了，明年的今天就是你的忌日。")
end

function eDynamicNPC_ThiefSoldier:MakeCopyScene(selfId, nearmembercount,targetId)
	if not self:LuaFnIsActivityMonster(selfId,targetId,true) then return end
    local param0 = 4
    local param1 = 3
    local mems = {}

    local level0 = 0
    local level1 = 0
    for i = 1, nearmembercount do
        mems[i] = self:GetNearTeamMember(selfId, i)
        local tempMemlevel = self:GetLevel(mems[i])
        level0 = level0 + (tempMemlevel ^ param0)
        level1 = level1 + (tempMemlevel ^ param1)
    end
    local mylevel
    if level1 == 0 then
        mylevel = self.g_minLevel
    else
        mylevel = level0 / level1
    end
    local PlayerMaxLevel = self:GetHumanMaxLevelLimit()
    local iniLevel
    if mylevel < 10 then
        iniLevel = 10
    elseif mylevel < PlayerMaxLevel then
        iniLevel = math.floor(mylevel / 10) * 10
    else
        iniLevel = PlayerMaxLevel
    end
    local leaderguid = self:LuaFnObjId2Guid(selfId)
    local config = {}
	config.navmapname = "zeiying.nav"					-- 地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	config.client_res = self.g_ClientRes
	config.teamleader = leaderguid
	config.NoUserCloseTime = 0
	config.Timer = self.g_TickTime * 1000
	config.params = {}
	config.params[self.g_keySD["typ"]] = self.g_CopySceneType
	config.params[self.g_keySD["spt"]] = self.script_id
	config.params[self.g_keySD["tim"]] = 0
	config.params[self.g_keySD["scn"]] = -1
	config.params[self.g_keySD["cls"]] = 0
	config.params[self.g_keySD["dwn"]] = 0
	config.params[self.g_keySD["tem"]] = self:GetTeamId( selfId )
	config.params[self.g_keySD["FlagThielf"]] = 800
    local x, z = self:GetWorldPos(selfId)
	config.params[self.g_keySD["x"]] = x
	config.params[self.g_keySD["z"]] = z
    config.params[self.g_keySD["ObjKilled"]] = 0
	config.params[self.g_keySD["MyLevel"]] = mylevel
    local CopyScene_LevelGap = 31
    config.params[CopyScene_LevelGap] = mylevel - iniLevel
    config.params[self.paramonce] = 0
	config.eventfile = "zeiying_area.ini"
	config.monsterfile = "zeiying_monster_" .. iniLevel .. ".ini"
	config.sn 		 = self:LuaFnGenCopySceneSN()

    local bRetSceneID = self:LuaFnCreateCopyScene(config)
    if bRetSceneID > 0 then
        self:NotifyTip(selfId, "副本创建成功！")
    else
        self:NotifyTip(selfId, "副本数量已达上限，请稍候再试！")
    end
end

function eDynamicNPC_ThiefSoldier:OnContinue(selfId, targetId) end

function eDynamicNPC_ThiefSoldier:CheckSubmit(selfId, selectRadioId) end

function eDynamicNPC_ThiefSoldier:OnSubmit(selfId, targetId, selectRadioId) end

function eDynamicNPC_ThiefSoldier:OnDie(objId, killerId)
    print("eDynamicNPC_ThiefSoldier:OnDie", objId, killerId)
    local DataID = self:GetMonsterDataID(objId)
    self:OnKillObject(killerId, DataID, objId)
end

function eDynamicNPC_ThiefSoldier:OnKillObject(selfId, objdataId, objId)
    for i = 1, 10 do if (objdataId == self.NianShou_Boss[i]) then return end end
    local sceneType = self:LuaFnGetSceneType()
    if sceneType ~= 1 then return end
    local fubentype = self:LuaFnGetCopySceneData_Param(0)
    if fubentype ~= self.g_CopySceneType then return end
    local leaveFlag = self:LuaFnGetCopySceneData_Param(4)
    if leaveFlag == 1 then return end
    local num = self:LuaFnGetCopyScene_HumanCount()
    local bIsBoss = 0
    local GroupID = self:GetMonsterGroupID(objId)
    if GroupID == self.g_BossGroupID then bIsBoss = 1 end
    local membercount = self:LuaFnGetCopyScene_HumanCount()
    local memId
    local teamLeaderName
    for i = 1, membercount do
        memId = self:LuaFnGetCopyScene_HumanObjId(i)
        if self:LuaFnIsObjValid(memId) and self:LuaFnIsCanDoScriptLogic(memId) then
            local teamLeaderFlag = self:LuaFnIsTeamLeader(memId)
            if teamLeaderFlag and teamLeaderFlag then
                teamLeaderName = self:LuaFnGetName(memId)
                break
            end
        end
    end
    if bIsBoss == 1 then
        local message
        local nPlayerNum = self:LuaFnGetCopyScene_HumanCount()
        for i = 1, nPlayerNum do
            local nPlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
            self:LuaFnAddMissionHuoYueZhi(nPlayerId, 18)
        end
        local randMessage = math.random(3)
        if teamLeaderName ~= nil then
            teamLeaderName = gbk.fromutf8(teamLeaderName)
            if randMessage == 1 then
                message = string.format(
                              "#{ItemMsg_08}#B#{_INFOUSR%s}#{ItemMsg_09}",
                              teamLeaderName)
            elseif randMessage == 2 then
                message = string.format("#B#{_INFOUSR%s}#cff0000#{ItemMsg_11}",
                                        teamLeaderName)
            else
                message = string.format(
                              "#{ItemMsg_12}#B#{_INFOUSR%s}#cff0000#{ItemMsg_13}",
                              teamLeaderName)
            end
            self:BroadMsgByChatPipe(selfId, message, 4)
        end
    end
    local killedbossnumber = self:LuaFnGetCopySceneData_Param(self.g_keySD["ObjKilled"])
    killedbossnumber = killedbossnumber + 1
    print("killedbossnumber =", killedbossnumber)
    self:LuaFnSetCopySceneData_Param(self.g_keySD["ObjKilled"], killedbossnumber)
    for i = 1, num do
        local ServerID = self:LuaFnGetCopyScene_HumanObjId(i)
        if self:LuaFnIsObjValid(ServerID) and
            self:LuaFnIsCanDoScriptLogic(ServerID) then
            local score = self:GetMissionData(ServerID, define.MD_ENUM.MD_ThiefSoldierInvade)
            if score < 65000 then
                if bIsBoss == 1 then
                    score = score + 5
                else
                    score = score + 1
                end
                if score > 65000 then score = 65000 end
                self:SetMissionData(ServerID, define.MD_ENUM.MD_ThiefSoldierInvade, score)
            end
            local ScoreStr = string.format("当前积分 %d", score)
            self:NotifyTip(ServerID, ScoreStr)
            self:LuaFnAddSalaryPoint(ServerID, 7, 1)
            local KillStr = string.format("已杀死造反恶贼： %d/%d",
                                        killedbossnumber,
                                        self.g_TotalNeedKillBoss)
            self:NotifyTip(ServerID, KillStr)
        end
    end
    if killedbossnumber >= self.g_TotalNeedKillBoss then
        self:LuaFnSetCopySceneData_Param(4, 1)
    end
    if killedbossnumber == (self.g_TotalNeedKillBoss - 1) then
        local CurLevel = self:LuaFnGetCopySceneData_Param(
                             self.g_keySD["MyLevel"])
        self:CreateBoss(CurLevel)
    end
end

function eDynamicNPC_ThiefSoldier:OnEnterZone(selfId, zoneId) end

function eDynamicNPC_ThiefSoldier:OnItemChanged(selfId, itemdataId) end

function eDynamicNPC_ThiefSoldier:OnCopySceneReady(destsceneId)
    local sceneId = self:get_scene_id()
    self:LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId)
    local leaderguid = self:LuaFnGetCopySceneData_TeamLeader(destsceneId)
    local leaderObjId = self:LuaFnGuid2ObjId(leaderguid)
    if leaderObjId == -1 then return end
    if not self:LuaFnIsCanDoScriptLogic(leaderObjId) then return end
    local sn = self:LuaFnGetCopySceneData_Sn(destsceneId)
    local numMem = self:GetNearTeamCount(leaderObjId)
    local member
    self:NewWorld(leaderObjId, destsceneId, sn, self.g_Fuben_X, self.g_Fuben_Z, self.g_ClientRes)
    self:LuaFnAuditQuest(leaderObjId, "贼兵入侵")
    for i = 2, numMem do
        member = self:GetNearTeamMember(leaderObjId, i)
        if self:LuaFnIsCanDoScriptLogic(member) then
            self:NewWorld(member, destsceneId, sn, self.g_Fuben_X, self.g_Fuben_Z, self.g_ClientRes)
            self:LuaFnAuditQuest(member, "贼兵入侵")
        end
    end
end

function eDynamicNPC_ThiefSoldier:OnPlayerEnter(selfId)
	self:SetPlayerDefaultReliveInfo(selfId, 1, 1, 0, self.g_Fuben_X, self.g_Fuben_Z )
end

function eDynamicNPC_ThiefSoldier:OnHumanDie(selfId, killerId) end

function eDynamicNPC_ThiefSoldier:KickOut(objId)
    local oldsceneId = self:LuaFnGetCopySceneData_Param(3)
    local x = self:LuaFnGetCopySceneData_Param(self.g_keySD["x"])
    local z = self:LuaFnGetCopySceneData_Param(self.g_keySD["z"])
    if self:LuaFnIsObjValid(objId) then
        self:NewWorld(objId, oldsceneId, nil, x, z)
    end
end

function eDynamicNPC_ThiefSoldier:OnCopySceneTimer()
    local TickCount = self:LuaFnGetCopySceneData_Param(2)
    TickCount = TickCount + 1
    print("eDynamicNPC_ThiefSoldier:OnCopySceneTimer", os.time(), "TickCount =", TickCount)
    self:LuaFnSetCopySceneData_Param(2, TickCount)
    local leaveFlag = self:LuaFnGetCopySceneData_Param(4)
    local membercount = self:LuaFnGetCopyScene_HumanCount()
    local mems = {}

    for i = 1, membercount do mems[i] = self:LuaFnGetCopyScene_HumanObjId(i) end
    if leaveFlag == 1 then
        local leaveTickCount = self:LuaFnGetCopySceneData_Param(5)
        leaveTickCount = leaveTickCount + 1
        self:LuaFnSetCopySceneData_Param(5, leaveTickCount)
        if leaveTickCount == self.g_CloseTick then
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:KickOut(mems[i])
                end
            end
        elseif leaveTickCount < self.g_CloseTick then
            local strText = string.format("你将在%d秒后离开场景!",
                                          (self.g_CloseTick - leaveTickCount) *
                                              self.g_TickTime)
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:NotifyTip(mems[i], strText)
                end
            end
        end
    elseif TickCount == self.g_LimitTimeSuccess then
        for i = 1, membercount do
            if self:LuaFnIsObjValid(mems[i]) then
                self:NotifyTip(mems[i], "任务时间到，完成!")
            end
        end
        self:LuaFnSetCopySceneData_Param(4, 1)
    elseif TickCount == self.g_LimitTotalHoldTime then
        for i = 1, membercount do
            if self:LuaFnIsObjValid(mems[i]) then
                self:NotifyTip(mems[i], "任务失败，超时!")
            end
        end
        self:LuaFnSetCopySceneData_Param(4, 1)
    else
        local oldteamid = self:LuaFnGetCopySceneData_Param(6)
        for i = 1, membercount do
            if self:LuaFnIsObjValid(mems[i]) then
                if oldteamid ~= self:GetTeamId(mems[i]) then
                    self:NotifyTip(mems[i], "你不在正确的队伍中!")
                    self:KickOut(mems[i])
                end
            end
        end
    end
end

function eDynamicNPC_ThiefSoldier:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function eDynamicNPC_ThiefSoldier:NotifyTip(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return eDynamicNPC_ThiefSoldier
