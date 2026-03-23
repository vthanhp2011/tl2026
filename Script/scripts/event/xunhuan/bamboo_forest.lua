local gbk = require "gbk"
local class = require "class"
local ScriptGlobal = require "scripts.ScriptGlobal"
local define = require "define"
local script_base = require "script_base"
local bamboo_forest = class("bamboo_forest", script_base)
bamboo_forest.script_id = 050101
bamboo_forest.g_MissionId = 1261
bamboo_forest.g_Name = "花剑雨"
bamboo_forest.g_MissionKind = 8
bamboo_forest.g_MissionLevel = 10000
bamboo_forest.g_MissionName = "除害"
bamboo_forest.g_MissionInfo = "    "
bamboo_forest.g_MissionTarget =
    "    苏州的花剑雨#{_INFOAIM251,108,1,花剑雨}让你杀死80只野熊，并杀死红熊王。#r    #{FQSH_090206_01}"
bamboo_forest.g_ContinueInfo =
    "    你们准备好了就请前去竹林消灭红熊王！"
bamboo_forest.g_SubmitInfo = "    任务做得怎么样了？"
bamboo_forest.g_MissionComplete =
    "    既然你们已经杀死红熊王了，那么依约我也该告诉你们这块令牌的来历了。你们把这封信交给钱宏宇#{_INFOAIM62,162,1,钱宏宇},他自然会明白一切的。"
bamboo_forest.g_IsMissionOkFail = 0
bamboo_forest.g_DemandKill = {
    {["id"] = 4120, ["num"] = 1}, {["id"] = 4110, ["num"] = 80}
}

bamboo_forest.g_Param_sceneid = 3
bamboo_forest.g_DemandKillGroup = {2, 1}

bamboo_forest.g_BossGroup = 2
bamboo_forest.g_Token = 40004315
bamboo_forest.g_Mail = 40004316
bamboo_forest.g_NumText_Main = 1
bamboo_forest.g_NumText_EnterCopyScene = 2
bamboo_forest.g_CopySceneMap = "zhulin.nav"
bamboo_forest.g_CopySceneArea = "zhulin_area.ini"
bamboo_forest.g_CopyScenePatrolPoint = "zhulin_patrolpoint.ini"
bamboo_forest.g_ClientRes = 81
bamboo_forest.g_CopySceneMonsterIni = "zhulin_monster_%d.ini"
bamboo_forest.g_CopySceneType = ScriptGlobal.FUBEN_ZHULIN
bamboo_forest.g_LimitMembers = 1
bamboo_forest.g_LevelLimit = 30
bamboo_forest.g_TickTime = 5
bamboo_forest.g_LimitTotalHoldTime = 360
bamboo_forest.g_CloseTick = 6
bamboo_forest.g_NoUserTime = 300
bamboo_forest.g_Fuben_X = 97
bamboo_forest.g_Fuben_Z = 113
bamboo_forest.g_Back_X = 250
bamboo_forest.g_Back_Z = 107
bamboo_forest.g_Fuben_Relive_X = 97
bamboo_forest.g_Fuben_Relive_Z = 113
bamboo_forest.g_BroadcastMsg = {
    "#Y" .. bamboo_forest.g_Name ..
        "：#W#{_INFOUSR$N}#P大侠真是强，一拳打扁#{_BOSS46}#P。有了#{_INFOUSR$N}#P大侠在，哪个毛贼敢倡狂？",
    "#Y" .. bamboo_forest.g_Name ..
        "：#W#{_INFOUSR$N}#P大侠真是行，横扫苏州小竹林。一顿胖揍捶下去，没有#G红熊#P摆不平。",
    "#Y" .. bamboo_forest.g_Name ..
        "：#W#{_INFOUSR$N}#P大侠真是强，侠义之名万古流。武功更是没得说，凡是#G红熊#P全爆头。"
}

bamboo_forest.g_TakeTimes = 5
function bamboo_forest:OnDefaultEvent(selfId, targetId, arg, index)
    print("bamboo_forest:OnDefaultEvent =", selfId, targetId, arg, index)
    if self:GetName(targetId) ~= self.g_Name then return end
    local numText = index
    if not self:IsHaveMission(selfId, self.g_MissionId) then
        if numText == self.g_NumText_Main then
            if self:CheckAccept(selfId) > 0 then
                self:BeginEvent(self.script_id)
                self:AddText(self.g_MissionName)
                self:AddText(
                    "    不错，我确实可以告诉你这块令牌的来历，不过在此之前，你得帮我个忙。")
                self:AddText(
                    "    在苏州城外的竹林里有一群野熊，本来它们是很温顺的，但自从一头红熊当上了这群野熊的首领后，它们就变得残暴起来了，附近已经有不少的村子遭到了袭击，可是朝廷却一直顾不上派兵来对付这些野兽，为了避免乡亲们不受到更大的伤害，我必须尽快想办法除掉这只该死的红熊。")
                self:AddText(
                    "    如果你能帮我杀死这只红熊，我就告诉你这块令牌的来历。")
                self:AddText("#{M_MUBIAO}")
                self:AddText(self.g_MissionTarget)
                self:EndEvent()
                self:DispatchMissionInfo(selfId, targetId, self.script_id, self.g_MissionId)
            end
        end
    else
        if numText == self.g_NumText_Main then
            local bDone = self:CheckSubmit(selfId)
            self:BeginEvent(self.script_id)
            self:AddText(self.g_MissionName)
            if bDone == 1 then
                self:AddText(self.g_SubmitInfo)
            else
                self:AddText(self.g_ContinueInfo)
                self:AskEnterCopyScene(selfId, targetId)
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
                return
            end
            self:EndEvent()
            self:DispatchMissionDemandInfo(selfId, targetId, self.script_id,
                                           self.g_MissionId, bDone)
        elseif numText == self.g_NumText_EnterCopyScene then
            self:AcceptEnterCopyScene(selfId, targetId)
        end
    end
end

function bamboo_forest:CheckConflictMission(selfId)
    for missionId = 1260, self.g_MissionId - 1 do
        if self:IsHaveMission(selfId, missionId) then return 1 end
    end
    for missionId = self.g_MissionId + 1, 1269 do
        if self:IsHaveMission(selfId, missionId) then return 1 end
    end
    return 0
end

function bamboo_forest:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:GetName(targetId) ~= self.g_Name then return end
    if self:CheckConflictMission(selfId) == 1 then return end
    caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 4, self.g_NumText_Main)
end

function bamboo_forest:CheckAccept(selfId)
    if self:IsHaveMission(selfId, self.g_MissionId) then return 0 end
    if self:CheckConflictMission(selfId) == 1 then return 0 end
    --[[local iTime = self:GetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2)
    local CurTime = self:GetQuarterTime()
    if iTime + 1 >= CurTime then
        self:NotifyFailTips(selfId, "放弃任务30分钟后才能再次接取")
        return 0
    end]]
    if self:LuaFnGetAvailableItemCount(selfId, self.g_Token) < 1 then
        self:NotifyFailTips(selfId, "    需要#{_ITEM" .. self.g_Token .. "}。")
        return 0
    end
    local DayTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2_TIMES)
    local oldDate = DayTimes % 100000
    local takenTimes = math.floor(DayTimes / 100000)
    local nowDate = self:GetDayTime()
    if nowDate ~= oldDate then takenTimes = 0 end
    if takenTimes >= self.g_TakeTimes then
        self:NotifyFailTips(selfId, "您今天领取任务的次数已经超过" .. self.g_TakeTimes .. "次，请明天再来领取。")
        return 0
    else
        DayTimes = nowDate + takenTimes * 100000
        self:SetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2_TIMES, DayTimes)
    end
    return 1
end

function bamboo_forest:AskEnterCopyScene(selfId, targetId)
    self:AddNumText("前往竹林", 10, self.g_NumText_EnterCopyScene)
end

function bamboo_forest:OnAccept(selfId, targetId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then
        if self:GetMissionCount(selfId) >= 20 then
            self:NotifyFailBox(selfId, targetId, "    任务记录已满，无法接取更多的任务。")
            return
        end
        if self:GetLevel(selfId) < self.g_LevelLimit then
            self:NotifyFailBox(selfId, targetId, "    你的等级还不足30级，这个任务对你太危险，还是先锻炼锻炼再去吧。")
            return
        end
        if self:CheckConflictMission(selfId) == 1 then return end
        if not self:LuaFnDelAvailableItem(selfId, self.g_Token, 1) then
            self:NotifyFailBox(selfId, targetId, "    需要#{_ITEM" .. self.g_Token .. "}。")
            return
        end
        self:AddMission(selfId, self.g_MissionId, self.script_id, 1, 0, 0)
        if not self:IsHaveMission(selfId, self.g_MissionId) then return end
        local DayTimes
        DayTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2_TIMES)
        DayTimes = DayTimes + 100000
        self:DungeonDone(selfId, 2)
        self:SetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2_TIMES, DayTimes)
        local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
        self:SetMissionByIndex(selfId, misIndex, self.g_IsMissionOkFail, 0)
        self:SetMissionByIndex(selfId, misIndex, self.g_Param_sceneid, -1)
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_ContinueInfo)
        self:AddText("#r    你接受了任务：" .. self.g_MissionName)
        self:AskEnterCopyScene(selfId, targetId)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function bamboo_forest:AcceptEnterCopyScene(selfId, targetId)
    if self:IsHaveMission(selfId, self.g_MissionId) then
        local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
        local copysceneid = self:GetMissionParam(selfId, misIndex, self.g_Param_sceneid)
        if copysceneid >= 0 then
            if self:IsCanEnterCopyScene(copysceneid, selfId) then
                local sn = self:LuaFnGetCopySceneData_Sn(copysceneid)
                self:NewWorld(selfId, copysceneid, sn, self.g_Fuben_X, self.g_Fuben_Z,self.g_ClientRes)
            else
                self:NotifyFailBox(selfId, targetId, "    很抱歉，你的任务已经失败了。")
            end
            return
        end
        if not self:LuaFnHasTeam(selfId) then
            self:NotifyFailBox(selfId, targetId, "    你一个人势单力薄，还是多叫几个帮手再来吧。")
            return
        end
        if not self:LuaFnIsTeamLeader(selfId) then
            self:NotifyFailBox(selfId, targetId, "    你不是队长，只有队长才能决定是否接受我的委托。")
            return
        end
        local teamMemberCount = self:GetTeamMemberCount(selfId)
        local nearMemberCount = self:GetNearTeamCount(selfId)
        if not teamMemberCount or not nearMemberCount or teamMemberCount ~= nearMemberCount then
            self:NotifyFailBox(selfId, targetId, "    你还有队员不在附近。")
            return
        end
        if nearMemberCount < self.g_LimitMembers then
            self:NotifyFailBox(selfId, targetId, "    竹林里野熊很多，最少你们得有 3 位同伴我才放心让你们去。（队伍中至少需要三个30级以上角色）")
            return
        end
        local numerator, denominator = 0, 0
        local outNotAcceptMissionStr = "您队伍中有成员（"
        local notAcceptMissionCount = 0
        local outDoingMissionStr = "您队伍中有成员（"
        local doingMissionCount = 0
        for i = 1, nearMemberCount do
            local member = self:GetNearTeamMember(selfId, i)
            if not self:IsHaveMission(member, self.g_MissionId) then
                if notAcceptMissionCount == 0 then
                    outNotAcceptMissionStr = outNotAcceptMissionStr .. self:GetName(member)
                else
                    outNotAcceptMissionStr = outNotAcceptMissionStr .. "、" .. self:GetName(member)
                end
                notAcceptMissionCount = notAcceptMissionCount + 1
            end
            if notAcceptMissionCount == 0 then
                misIndex = self:GetMissionIndexByID(member, self.g_MissionId)
                if self:GetMissionParam(member, misIndex, self.g_Param_sceneid) >= 0 then
                    if doingMissionCount == 0 then
                        outDoingMissionStr = outDoingMissionStr .. self:GetName(member)
                    else
                        outDoingMissionStr = outDoingMissionStr .. "、" .. self:GetName(member)
                    end
                    doingMissionCount = doingMissionCount + 1
                end
            end
            numerator = numerator + self:GetLevel(member) ^ 4
            denominator = denominator + self:GetLevel(member) ^ 3
        end
        if notAcceptMissionCount > 0 then
            outNotAcceptMissionStr = outNotAcceptMissionStr .. "）还没有接任务。"
            self:NotifyFailBox(selfId, targetId, outNotAcceptMissionStr)
            return
        end
        if doingMissionCount > 0 then
            outDoingMissionStr = outDoingMissionStr ..
                                     "）已经在做该任务了。"
            self:NotifyFailBox(selfId, targetId, outDoingMissionStr)
            return
        end
        local mylevel
        if denominator <= 0 then
            mylevel = 0
        else
            mylevel = numerator / denominator
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
        -- 地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
        local config = {}
        config.navmapname = self.g_CopySceneMap -- 地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
        config.client_res = self.g_ClientRes
        config.teamleader = leaderguid
        config.NoUserCloseTime = self.g_NoUserTime * 1000
        config.Timer = self.g_TickTime * 1000
        config.params = {}
        config.params[0] = self.g_CopySceneType
        config.params[1] = self.script_id
        config.params[2] = 0
        config.params[3] = -1
        config.params[4] = 0
        config.params[5] = 0
        config.params[6] = self:GetTeamId(selfId)
        config.params[7] = 0
        config.params[8] = 0
        config.params[9] = 0
        config.params[10] = 0
        config.params[11] = 0
        config.params[12] = 0
        config.params[13] = iniLevel / 10
        config.params[14] = 0
        config.params[define.CopyScene_LevelGap] = mylevel - iniLevel
        config.eventfile = self.g_CopySceneArea
        config.patrolpoint = self.g_CopyScenePatrolPoint
        config.monsterfile = string.format(self.g_CopySceneMonsterIni, iniLevel)
        config.sn = self:LuaFnGenCopySceneSN()

        local bRetSceneID = self:LuaFnCreateCopyScene(config)
        if bRetSceneID > 0 then
            self:NotifyFailTips(selfId, "副本创建成功！")
        else
            self:NotifyFailTips(selfId,
                                "副本数量已达上限，请稍候再试！")
        end
    end
end

function bamboo_forest:OnCopySceneReady(destsceneId)
    local sceneid = self:get_scene_id()
    self:LuaFnSetCopySceneData_Param(destsceneId, 3, sceneid)
    local leaderguid = self:LuaFnGetCopySceneData_TeamLeader(destsceneId)
    local leaderObjId = self:LuaFnGuid2ObjId(leaderguid)
    if leaderObjId == -1 then return end
    if not self:LuaFnIsCanDoScriptLogic(leaderObjId) then return end
    local members = {}

    local validmembercount = 0
    local nearMemberCount = self:GetNearTeamCount(leaderObjId)
    for i = 1, nearMemberCount do
        local member = self:GetNearTeamMember(leaderObjId, i)
        if self:IsHaveMission(member, self.g_MissionId) then
            validmembercount = validmembercount + 1
            members[validmembercount] = member
        end
    end
    if validmembercount < self.g_LimitMembers then
        self:NotifyFailTips(leaderObjId, "    竹林里野熊很多，最少你们得有 3 位同伴我才放心让你们去。")
        return
    end
    local sn = self:LuaFnGetCopySceneData_Sn(destsceneId)
    for i = 1, validmembercount do
        local misIndex = self:GetMissionIndexByID(members[i], self.g_MissionId)
        if self:LuaFnIsCanDoScriptLogic(members[i]) then
            self:SetMissionByIndex(members[i], misIndex, self.g_Param_sceneid, destsceneId)
            self:NewWorld(members[i], destsceneId, sn, self.g_Fuben_X, self.g_Fuben_Z, self.g_ClientRes)
        end
    end
end

function bamboo_forest:OnPlayerEnter(selfId)
    self:SetPlayerDefaultReliveInfo(selfId, 0.1, -1, 0, self.g_Fuben_Relive_X, self.g_Fuben_Relive_Z)
end

function bamboo_forest:OnKillObject(selfId, objdataId, objId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then return end
    local sceneType = self:LuaFnGetSceneType()
    if sceneType ~= 1 then return end
    local fubentype = self:LuaFnGetCopySceneData_Param(0)
    if fubentype ~= self.g_CopySceneType then return end
    local leaveFlag = self:LuaFnGetCopySceneData_Param(4)
    if leaveFlag == 1 then return end
    local GroupID = self:GetMonsterGroupID(objId)
    if GroupID == self.g_BossGroup then
        self:LuaFnSetCopySceneData_Param(12, 1)
        local monstercount = self:GetMonsterCount()
        local bossId
        for i = 1, monstercount do
            bossId = self:GetMonsterObjID(i)
            self:SetNPCAIType(bossId, 1)
            self:SetAIScriptID(bossId, 0)
            self:NpcToIdle(bossId)
        end
        local BroadcastMsg = self.g_BroadcastMsg[math.random(#(self.g_BroadcastMsg))]
        BroadcastMsg = string.gsub(BroadcastMsg, "%$N", self:GetName(selfId))
        BroadcastMsg = gbk.fromutf8(BroadcastMsg)
        self:BroadMsgByChatPipe(selfId, BroadcastMsg, 4)
    end
    local killedMonsterIndex, killedCount = 0, 0
    for i = 1, #(self.g_DemandKillGroup) do
        if GroupID == self.g_DemandKillGroup[i] then
            killedMonsterIndex = i
            killedCount = self:LuaFnGetCopySceneData_Param(7 + i - 1) + 1
            self:LuaFnSetCopySceneData_Param(7 + i - 1, killedCount)
            break
        end
    end
    if killedMonsterIndex == 0 then return end
    local maxKilledCount = self.g_DemandKill[killedMonsterIndex]["num"]
    local num = self:LuaFnGetCopyScene_HumanCount()
    local mems = {}

    local strText = string.format("已杀死%s： %d/%d", self:GetName(objId), killedCount, maxKilledCount)
    for i = 1, num do
        mems[i] = self:LuaFnGetCopyScene_HumanObjId(i)
        if self:LuaFnIsObjValid(mems[i]) then
            self:NotifyFailTips(mems[i], strText)
           local misIndex = self:GetMissionIndexByID(mems[i], self.g_MissionId)
            self:SetMissionByIndex(mems[i], misIndex, 3 - killedMonsterIndex, killedCount)
        end
    end
    local leaveFlag = 1
    for i = 1, #(self.g_DemandKillGroup) do
        if self:LuaFnGetCopySceneData_Param(7 + i - 1) <
            self.g_DemandKill[i]["num"] then
            leaveFlag = 0
            break
        end
    end
    if leaveFlag == 1 then
        self:LuaFnSetCopySceneData_Param(4, 1)
        for i = 1, num do
            if self:LuaFnIsObjValid(mems[i]) then
                self:NotifyFailTips(mems[i], "任务目标完成，即将离开副本....")
                local misIndex = self:GetMissionIndexByID(mems[i], self.g_MissionId)
                self:SetMissionByIndex(mems[i], misIndex, self.g_IsMissionOkFail, 1)
                self:LuaFnAddSweepPointByID(mems[i], 2, 6)
            end
        end
    end
end

function bamboo_forest:OnHumanDie(selfId, killerId) end

function bamboo_forest:Exit(selfId)
    local oldsceneId = self:LuaFnGetCopySceneData_Param(3)
    self:NewWorld(selfId, oldsceneId, nil, self.g_Back_X, self.g_Back_Z)
end

function bamboo_forest:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function bamboo_forest:OnAbandon(selfId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then return end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local copyscene = self:GetMissionParam(selfId, misIndex,
                                           self.g_Param_sceneid)
    local CurTime = self:GetQuarterTime()
    self:SetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2, CurTime)
    self:DelMission(selfId, self.g_MissionId)
    local sceneid = self:get_scene_id()
    if sceneid == copyscene then
        self:NotifyFailTips(selfId, "任务失败！")
        local oldsceneId = self:LuaFnGetCopySceneData_Param(3)
        self:NewWorld(selfId, oldsceneId, nil, self.g_Back_X, self.g_Back_Z)
    end
end

function bamboo_forest:OnCopySceneTimer(nowTime)
    local TickCount = self:LuaFnGetCopySceneData_Param(2)
    TickCount = TickCount + 1
    self:LuaFnSetCopySceneData_Param(2, TickCount)
    local leaveFlag = self:LuaFnGetCopySceneData_Param(4)
    local membercount = self:LuaFnGetCopyScene_HumanCount()
    local mems = {}
    for i = 1, membercount do
        mems[i] = self:LuaFnGetCopyScene_HumanObjId(i)
    end
    if leaveFlag == 1 then
        local leaveTickCount = self:LuaFnGetCopySceneData_Param(5)
        leaveTickCount = leaveTickCount + 1
        self:LuaFnSetCopySceneData_Param(5, leaveTickCount)
        if leaveTickCount >= self.g_CloseTick then
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:Exit(mems[i])
                end
            end
        else
            local strText = string.format("你将在 %d 秒后离开场景", (self.g_CloseTick - leaveTickCount) *self.g_TickTime)
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:NotifyFailTips(mems[i], strText)
                end
            end
        end
    elseif TickCount == self.g_LimitTotalHoldTime then
        for i = 1, membercount do
            if self:LuaFnIsObjValid(mems[i]) then
                self:NotifyFailTips(mems[i], "任务时间已到，离开场景....")
                self:Exit(mems[i])
            end
        end
        self:LuaFnSetCopySceneData_Param(4, 1)
    else
        local oldteamid = self:LuaFnGetCopySceneData_Param(6)
        for i = 1, membercount do
            if self:LuaFnIsObjValid(mems[i]) and oldteamid ~= self:GetTeamId(mems[i]) then
                self:NotifyFailTips(mems[i],  "你不在正确的队伍中，离开场景....")
                self:Exit(mems[i])
            end
        end
        if self.g_TickTime * TickCount % 60 < self.g_TickTime and TickCount <
            self.g_LimitTotalHoldTime then
            local str = "剩余 " .. (self.g_LimitTotalHoldTime - TickCount) * self.g_TickTime / 60 .. " 分钟..."
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:NotifyFailTips(mems[i], str)
                end
            end
        end
        local monstercount = self:GetMonsterCount()
        local x, z = self:GetLastPatrolPoint(0)
        for i = 1, monstercount do
            if self:LuaFnGetCopySceneData_Param(14) > 0 then break end
            local bossId = self:GetMonsterObjID(i)
            local GroupID = self:GetMonsterGroupID(bossId)
            if GroupID == self.g_BossGroup then
                local bossX, bossZ = self:GetWorldPos(bossId)
                if (x - bossX) * (x - bossX) + (z - bossZ) * (z - bossZ) < 25 then
                    self:NpcToIdle(bossId)
                    self:RestoreHp(bossId)
                    self:SetNPCAIType(bossId, 0)
                    self:SetAIScriptID(bossId, 129)
                    self:SetPatrolId(bossId, -1)
                    self:LuaFnSetCopySceneData_Param(14, 1)
                end
                break
            end
        end
    end
end

function bamboo_forest:CheckSubmit(selfId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then return 0 end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    if self:GetMissionParam(selfId, misIndex, self.g_IsMissionOkFail) ~= 1 then
        return 0
    end
    if self:LuaFnGetTaskItemBagSpace(selfId) < 1 then
        self:NotifyFailTips(selfId, "缺少一格任务物品空间")
        return 0
    end
    return 1
end

function bamboo_forest:OnSubmit(selfId, targetId)
    if self:GetName(targetId) ~= self.g_Name then return end
    if self:CheckSubmit(selfId) == 1 then
        self:NotifyFailBox(selfId, targetId, self.g_MissionComplete)
        self:TryRecieveItem(selfId, self.g_Mail, 1)
        self:DelMission(selfId, self.g_MissionId)
        self:LuaFnAuditQuest(selfId, "竹林")
        local strText = self.g_MissionName .. "任务已完成。"
        self:NotifyFailTips(selfId, strText)
        self:Msg2Player(selfId, strText, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:LuaFnAddSweepPointByID(selfId, 2, 1)
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
        self:CallScriptFunction(define.SCENE_SCRIPT_ID, "PlaySoundEffect", selfId, 66)
    end
end

function bamboo_forest:NotifyFailBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function bamboo_forest:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function bamboo_forest:CalSweepData(selfId)
    local drop_items
    local PlayerMaxLevel = self:GetHumanMaxLevelLimit()
    local mylevel = self:GetLevel(selfId)
    local iniLevel
    if mylevel < 10 then
        iniLevel = 10
    elseif mylevel < PlayerMaxLevel then
        iniLevel = math.floor(mylevel / 10) * 10
    else
        iniLevel = PlayerMaxLevel
    end
    local monster_file = string.format(self.g_CopySceneMonsterIni, iniLevel)
    monster_file = self:ParserIniFile(monster_file)
    local monster_count = monster_file.info.monstercount
    local award_exp = 0
    local boss_id
    for i = 0, monster_count - 1 do
        local key = string.format("monster%d", i)
        local monster = monster_file[key]
        if monster then
            award_exp = award_exp + self:CalMonsterAwardExp(monster.type)
            local monster_name = self:GetMonsterNamebyDataId(monster.type)
            if monster_name == "红熊王" then
                boss_id = monster.type
            end
        end
    end
    if boss_id then
        drop_items = self:CalMonsterDropItems(boss_id)
    end
    local DayTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2_TIMES)
    DayTimes = DayTimes + 100000
    self:SetMissionData(selfId, define.MD_ENUM.MD_ROUNDMISSION2_TIMES, DayTimes)
    return drop_items, award_exp
end

return bamboo_forest
