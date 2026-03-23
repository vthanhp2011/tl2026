local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local shuilao_12 = class("shuilao_12", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
shuilao_12.script_id = 232002
shuilao_12.g_CopySceneName = "水牢"
shuilao_12.g_client_res = 66
shuilao_12.g_MissionId = 1213
shuilao_12.g_MissionIdPre = 1212
shuilao_12.g_Name = "呼延庆"
shuilao_12.g_IfMissionElite = 1
shuilao_12.g_MissionLevel = 10000
shuilao_12.g_MissionKind = 1
shuilao_12.g_MissionName = "水牢"
shuilao_12.g_MissionInfo = "#{event_xunhuan_0006}"
shuilao_12.g_MissionTarget =
    "  太湖水寨的呼延庆#{_INFOAIM67,77,4,呼延庆}让你杀死10个犯人头目和50个小怪物。"
shuilao_12.g_ContinueInfo =
    "  你是否已经杀死10个凶悍的犯人头目，以及诸多小怪物？"
shuilao_12.g_MissionComplete =
    "  水牢终于守住了，我们以后千万不能掉以轻心。"
shuilao_12.g_MoneyBonus = 1000
shuilao_12.g_IsMissionOkFail = 0
shuilao_12.g_MissionRound = 5
shuilao_12.g_DemandKill = {{["id"] = 367, ["num"] = 60}}
shuilao_12.g_Param_killcount = 1
shuilao_12.g_Param_sceneid = 2
shuilao_12.g_Param_teamid = 3
shuilao_12.g_Param_time = 4
shuilao_12.g_CopySceneType = ScriptGlobal.FUBEN_SHUILAO
shuilao_12.g_LimitMembers = 1
shuilao_12.g_TickTime = 5
shuilao_12.g_LimitTotalHoldTime = 360
shuilao_12.g_CloseTick = 6
shuilao_12.g_NoUserTime = 300
shuilao_12.g_Fuben_X = 95
shuilao_12.g_Fuben_Z = 89
shuilao_12.g_Back_X = 52
shuilao_12.g_Back_Z = 96
shuilao_12.g_NeedMonsterGroupID = 1
shuilao_12.g_TotalNeedKillBoss = 60
shuilao_12.g_keySD = {
    ["typ"] = 0,
    ["spt"] = 1,
    ["tim"] = 2,
    ["scn"] = 3,
    ["cls"] = 4,
    ["dwn"] = 5,
    ["tem"] = 6,
    ["kil"] = 7,
    ["lev"] = 8
}
shuilao_12.g_minLevel = 20
shuilao_12.g_namMonster = "普通犯人"
shuilao_12.g_typMonster = {
    2490, 2491, 2492, 2493, 2494, 2495, 2496, 2497, 2498, 2499
}
shuilao_12.g_gemList = {50101001, 50101002, 50111001, 50111002}
shuilao_12.g_gemRate = 20
shuilao_12.g_IsMissionOkFailPre = 0
function shuilao_12:OnDefaultEvent(selfId, targetId)
    if self:LuaFnGetName(targetId) ~= self.g_Name then return end
    if self:IsHaveMission(selfId, self.g_MissionId) then
        local bDone = self:CheckSubmit(selfId)
        if bDone == 0 then
            self:BeginEvent(self.script_id)
            self:AddText(self.g_MissionName)
            self:AddText("  准备好了吗？")
            self:EndEvent()
            self:DispatchMissionInfo(selfId, targetId, self.script_id,
                                     self.g_MissionId)
        elseif bDone == 1 then
            self:BeginEvent(self.script_id)
            self:AddText(self.g_MissionName)
            self:AddText(self.g_ContinueInfo)
            self:AddMoneyBonus(self.g_MoneyBonus)
            self:EndEvent()
            self:DispatchMissionDemandInfo(selfId, targetId, self.script_id,
                                           self.g_MissionId, bDone)
        end
    else
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionInfo)
        self:AddText("#{M_MUBIAO}")
        self:AddText(self.g_MissionTarget)
        self:AddText(" ")
        self:AddMoneyBonus(self.g_MoneyBonus)
        self:EndEvent()
        self:DispatchMissionInfo(selfId, targetId, self.script_id,
                                 self.g_MissionId)
    end
end

function shuilao_12:OnEnumerate(caller, selfId, targetId, arg, index)
    if not self:IsHaveMission(selfId, self.g_MissionIdPre) then
        self:MsgBox(selfId, targetId,
                    "  我的兄弟呼延豹去苏州搬救兵去了，你看到他了吗？")
        return
    else
        if self:IsHaveMission(selfId, self.g_MissionId) then
            local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
            local misIndexPre = self:GetMissionIndexByID(selfId,
                                                         self.g_MissionIdPre)
            if self:GetMissionParam(selfId, misIndex, self.g_IsMissionOkFail) ==
                1 and
                self:GetMissionParam(selfId, misIndexPre,
                                     self.g_IsMissionOkFailPre) == 1 then
                self:MsgBox(selfId, targetId,
                            "  你可以回苏州找我的兄弟呼延豹领取奖励了！")
                return
            end
            if self:GetMissionParam(selfId, misIndex, self.g_IsMissionOkFail) ~=
                1 and
                self:GetMissionParam(selfId, misIndexPre,
                                     self.g_IsMissionOkFailPre) == 2 then
                self:MsgBox(selfId, targetId,
                            "  很遗憾，你的平定任务失败了！")
                return
            end
        end
    end
    caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 4, -1)
end

function shuilao_12:CheckAccept(selfId, targetId)
    if self:LuaFnGetLevel(selfId) < self.g_minLevel then
        self:NotifyTip(selfId, "阁下的等级太低，犯人比较厉害，")
        self:NotifyTip(selfId, "还是等你到了" .. self.g_minLevel ..
                           "级之后再来找我吧。")
        return 0
    end
    if not self:LuaFnHasTeam(selfId) then
        self:NotifyTip(selfId,
                       "水牢里面犯人众多，你一个人势单力薄，")
        self:NotifyTip(selfId, "还是多叫几个帮手再来吧。")
        return 0
    end
    if not self:LuaFnIsTeamLeader(selfId) then
        self:NotifyTip(selfId, "你不是队长，")
        self:NotifyTip(selfId,
                       "只有队长才能决定是否接受我的委托。")
        return 0
    end
    local numMem = self:GetNearTeamCount(selfId)
    if numMem ~= self:LuaFnGetTeamSize(selfId) then
        self:NotifyTip(selfId, "你有队员不在旁边。")
        return 0
    end
    if numMem < self.g_LimitMembers then
        self:NotifyTip(selfId, "水牢里面犯人众多，")
        self:NotifyTip(selfId, "最少你们得有" .. self.g_LimitMembers ..
                           "位同伴我才放心让你们去。")
        return 0
    end
    for i = 1, numMem do
        local member = self:GetNearTeamMember(selfId, i)
        if not self:IsHaveMission(member, self.g_MissionIdPre) then
            self:NotifyTip(selfId, "队伍中有人没有接水牢任务。")
            return 0
        end
        local misIndex = self:GetMissionIndexByID(member, self.g_MissionIdPre)
        if self:GetMissionParam(member, misIndex, 6) ~= 1 then
            self:NotifyTip(selfId, "队伍中有人接了别的平定任务。")
            return 0
        end
        if self:GetMissionParam(member, misIndex, self.g_IsMissionOkFailPre) ==
            1 then
            self:NotifyTip(selfId,
                           "队伍中已经有人完成了平定任务。")
            self:MsgBox(selfId, targetId,
                        "  非常感谢您帮我平定了水牢的叛乱，请回到苏州找我的兄弟领取奖励吧，小小礼物不成敬意。")
            return 0
        end
        if self:GetMissionParam(member, misIndex, self.g_IsMissionOkFail) == 1 then
            self:NotifyTip(selfId,
                           "队伍中有人已经完成了这个任务。")
            return 0
        end
        if self:GetMissionCount(member) >= 20 then
            self:NotifyTip(selfId, "队伍中有人的任务记录已满。")
            return 0
        end
        if self:IsHaveMission(member, self.g_MissionId) then
            self:NotifyTip(selfId, "队伍中有人已经接了此任务。")
            return 0
        end
    end
    return 1
end

function shuilao_12:OnAccept(selfId, targetId)
    local teamid = self:GetTeamId(selfId)
    if self:IsHaveMission(selfId, self.g_MissionId) then
        local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
        local misIndexPre =
            self:GetMissionIndexByID(selfId, self.g_MissionIdPre)
        local copysceneid = self:GetMissionParam(selfId, misIndex,
                                                 self.g_Param_sceneid)
        local saveteamid = self:GetMissionParam(selfId, misIndex,
                                                self.g_Param_teamid)
        if copysceneid >= 0 and teamid == saveteamid then
            if self:IsCanEnterCopyScene(copysceneid, self:GetHumanGUID(selfId)) then
                local sn = self:LuaFnGetCopySceneData_Sn(copysceneid)
                self:NewWorld(selfId, copysceneid, sn, self.g_Fuben_X, self.g_Fuben_Z)
            else
                self:NotifyTip(selfId, "任务失败，请放弃重新接取")
                self:SetMissionByIndex(selfId, misIndex, self.g_IsMissionOkFail,
                                       2)
                self:SetMissionByIndex(selfId, misIndexPre,
                                       self.g_IsMissionOkFailPre, 2)
            end
            return
        end
    end
    if self:CheckAccept(selfId, targetId) == 0 then return end
    local numMem = self:GetNearTeamCount(selfId)
    for i = 1, numMem do
        local member = self:GetNearTeamMember(selfId, i)
        self:AddMission(member, self.g_MissionId, self.script_id, 1, 0, 0)
        local misIndex = self:GetMissionIndexByID(member, self.g_MissionId)
        self:SetMissionByIndex(member, misIndex, self.g_IsMissionOkFail, 0)
        self:SetMissionByIndex(member, misIndex, self.g_Param_sceneid, -1)
        self:SetMissionByIndex(member, misIndex, self.g_Param_teamid, teamid)
        local misIndexPre = self:GetMissionIndexByID(member, self.g_MissionIdPre)
        self:SetMissionByIndex(member, misIndexPre, self.g_IsMissionOkFailPre, 1)
    end
    self:MakeCopyScene(selfId, numMem)
end

function shuilao_12:OnAbandon(selfId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local copyscene = self:GetMissionParam(selfId, misIndex, self.g_Param_sceneid)
    self:NotifyTip(selfId, "任务失败！")
    self:MissionFailExe(selfId)
    local sceneId = self:get_scene_id()
    if sceneId == copyscene then
        local oldsceneId = self:LuaFnGetCopySceneData_Param(3)
        self:NewWorld(selfId, oldsceneId, nil, self.g_Back_X, self.g_Back_Z)
    end
end

function shuilao_12:MakeCopyScene(selfId, nearmembercount)
    local param0 = 4
    local param1 = 3
    local mylevel = 0
    local mems = {}
    local tempMemlevel = 0
    local level0 = 0
    local level1 = 0
    for i = 1, nearmembercount do
        mems[i] = self:GetNearTeamMember(selfId, i)
        tempMemlevel = self:GetLevel(mems[i])
        level0 = level0 + (tempMemlevel ^ param0)
        level1 = level1 + (tempMemlevel ^ param1)
    end
    if level1 == 0 then
        mylevel = self.g_minLevel
    else
        mylevel = level0 / level1
    end
    local leaderguid = self:LuaFnObjId2Guid(selfId)
    local config = {}
    config.navmapname = "shuilao.nav"
	config.client_res = self.g_client_res
    config.teamleader = leaderguid
	config.NoUserCloseTime = self.g_NoUserTime * 1000
	config.Timer = self.g_TickTime * 1000
	config.params = {}
	config.params[self.g_keySD["typ"]] = self.g_CopySceneType						-- 设置副本类型
	config.params[self.g_keySD["spt"]] = self.script_id							-- 将1号数据设置为副本场景事件脚本号
	config.params[self.g_keySD["tim"]] = 0
	config.params[self.g_keySD["scn"]] = -1
	config.params[self.g_keySD["cls"]] = 0
	config.params[self.g_keySD["dwn"]] = 0
	config.params[self.g_keySD["tem"]] = self:GetTeamId(selfId)
	config.params[self.g_keySD["kil"]] = 0
    local PlayerMaxLevel = self:GetHumanMaxLevelLimit()
    local iniLevel
    if mylevel < 10 then
        iniLevel = 10
    elseif mylevel < PlayerMaxLevel then
        iniLevel = math.floor(mylevel / 10) * 10
    else
        iniLevel = PlayerMaxLevel
    end
    config.monsterfile = "shuilao_monster_" .. iniLevel .. ".ini"
	config.params[define.CopyScene_LevelGap] = mylevel - iniLevel
	config.params[self.g_keySD["lev"]] = mylevel
    config.sn = self:LuaFnGenCopySceneSN()
    local bRetSceneID = self:LuaFnCreateCopyScene(config)
    if bRetSceneID > 0 then
        self:NotifyTip(selfId, "副本创建成功！")
    else
        for i = 1, nearmembercount do
            self:NotifyTip(mems[i], "副本数量已达上限，请稍候再试！")
            self:DelMission(mems[i], self.g_MissionId)
            local misIndexPre = self:GetMissionIndexByID(mems[i], self.g_MissionIdPre)
            self:SetMissionByIndex(mems[i], misIndexPre, self.g_IsMissionOkFailPre, 0)
        end
    end
end

function shuilao_12:OnContinue(selfId, targetId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    if self:GetMissionParam(selfId, misIndex, self.g_Param_sceneid) >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText("  恭喜，你将得到#{_MONEY" .. self.g_MoneyBonus .. "}的奖励！")
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
    end
end

function shuilao_12:CheckSubmit(selfId, selectRadioId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local ret = self:GetMissionParam(selfId, misIndex, self.g_IsMissionOkFail)
    if ret == 1 then
        return 1
    else
        return 0
    end
end

function shuilao_12:OnSubmit(selfId, targetId, selectRadioId)
    if self:LuaFnGetName(targetId) ~= self.g_Name then return end
    if self:CheckSubmit(selfId, selectRadioId) > 0 then
        self:AddMoney(selfId, self.g_MoneyBonus)
        local nSeed = math.random(#(self.g_gemList))
        local sName = self:GetName(selfId)
        if math.random(self.g_gemRate) == 1 then
            local nPos = self:LuaFnTryRecieveItem(selfId, self.g_gemList[nSeed], false)
            if nPos ~= -1 then
                local sTran = self:GetBagItemTransfer(selfId, nPos)
                if math.random(2) == 1 then
                    local msg = "#{_INFOUSR" .. sName .. "}因平定水牢叛乱有功，特被奖励#{_INFOMSG%s}一颗。"
                    msg = gbk.fromutf8(msg)
                    msg = string.format(msg, sTran)
                    self:AddGlobalCountNews(msg, true)
                else
                    local msg = "#{_INFOUSR" .. sName .."}平定水牢之后，在水牢的角落里面发现了一颗#{_INFOMSG%s}。"
                    msg = gbk.fromutf8(msg)
                    msg = string.format(msg, sTran)
                    self:AddGlobalCountNews(msg, true)
                end
            end
        end
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionComplete)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        self:DelMission(selfId, self.g_MissionId)
        local misIndexPre = self:GetMissionIndexByID(selfId, self.g_MissionIdPre)
        self:SetMissionByIndex(selfId, misIndexPre, self.g_IsMissionOkFailPre, 1)
    end
end

function shuilao_12:OnKillObject(selfId, objdataId, objId)
    local sceneType = self:LuaFnGetSceneType()
    if sceneType ~= 1 then return end
    local fubentype = self:LuaFnGetCopySceneData_Param(0)
    if fubentype ~= self.g_CopySceneType then return end
    local leaveFlag = self:LuaFnGetCopySceneData_Param(4)
    if leaveFlag == 1 then return end
    local num = self:LuaFnGetCopyScene_HumanCount()
    local GroupID = self:GetMonsterGroupID(objId)
    if self:GetMonsterNamebyDataId(objdataId) ~= self.g_namMonster and GroupID ~= self.g_NeedMonsterGroupID then
        return
    end
    local killedbossnumber = self:LuaFnGetCopySceneData_Param(7)
    killedbossnumber = killedbossnumber + 1
    self:LuaFnSetCopySceneData_Param(7, killedbossnumber)
    if killedbossnumber < self.g_TotalNeedKillBoss then
        local strText = string.format("已杀死囚犯： %d/%d", killedbossnumber, self.g_TotalNeedKillBoss)
        for i = 1, num do
            local humanObjId = self:LuaFnGetCopyScene_HumanObjId(i)
            if self:LuaFnIsObjValid(humanObjId) then
                self:NotifyTip(humanObjId, strText)
                local misIndex = self:GetMissionIndexByID(humanObjId, self.g_MissionId)
                self:SetMissionByIndex(humanObjId, misIndex, self.g_Param_killcount, killedbossnumber)
            end
        end
    elseif killedbossnumber >= self.g_TotalNeedKillBoss then
        self:LuaFnSetCopySceneData_Param(4, 1)
        local TickCount = self:LuaFnGetCopySceneData_Param(2)
        local strText = string.format("已杀死囚犯： %d/%d", self.g_TotalNeedKillBoss, self.g_TotalNeedKillBoss)
        local strText2 = string.format( "任务完成，将在%d秒后传送到入口位置", self.g_CloseTick * self.g_TickTime)
        for i = 1, num do
            local humanObjId = self:LuaFnGetCopyScene_HumanObjId(i)
            if self:LuaFnIsObjValid(humanObjId) then
                local misIndex = self:GetMissionIndexByID(humanObjId, self.g_MissionId)
                self:SetMissionByIndex(humanObjId, misIndex, self.g_Param_killcount, self.g_TotalNeedKillBoss)
                self:SetMissionByIndex(humanObjId, misIndex, self.g_IsMissionOkFail, 1)
                self:SetMissionByIndex(humanObjId, misIndex, self.g_Param_time, TickCount * self.g_TickTime)
                self:NotifyTip(humanObjId, strText)
                self:NotifyTip(humanObjId, strText2)
            end
        end
    end
end

function shuilao_12:OnEnterZone(selfId, zoneId) end

function shuilao_12:OnItemChanged(selfId, itemdataId) end

function shuilao_12:OnCopySceneReady(destsceneId)
    local sceneId = self:get_scene_id()
    self:LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId)
    local leaderguid = self:LuaFnGetCopySceneData_TeamLeader(destsceneId)
    local leaderObjId = self:LuaFnGuid2ObjId(leaderguid)
    if leaderObjId == -1 then return end
    if not self:LuaFnIsCanDoScriptLogic(leaderObjId) then return end
    local numMem = self:GetNearTeamCount(leaderObjId)
    if numMem < self.g_LimitMembers then
        self:NotifyTip(leaderObjId, "你的队伍人数不足。")
        return
    end
    local sn = self:LuaFnGetCopySceneData_Sn(destsceneId)
    for i = 1, numMem do
        local member = self:GetNearTeamMember(leaderObjId, i)
        if self:LuaFnIsCanDoScriptLogic(member) then
            if self:IsHaveMission(member, self.g_MissionId) then
                local misIndex = self:GetMissionIndexByID(member, self.g_MissionId)
                self:SetMissionByIndex(member, misIndex, self.g_Param_sceneid, destsceneId)
                self:NewWorld(member, destsceneId, sn, self.g_Fuben_X, self.g_Fuben_Z)
            else
                self:NotifyTip(member, "你当前未接此任务")
            end
        end
    end
end

function shuilao_12:OnPlayerEnter(selfId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then
        self:NotifyTip(selfId, "你当前未接此任务")
        local oldsceneId = self:LuaFnGetCopySceneData_Param(3)
        self:NewWorld(selfId, oldsceneId, nil, self.g_Back_X, self.g_Back_Z)
        return
    end
    self:SetPlayerDefaultReliveInfo(selfId, 0.1, 0.1, 0, self.g_Fuben_X,self.g_Fuben_Z)
end

function shuilao_12:OnHumanDie(selfId, killerId) end

function shuilao_12:OnCopySceneTimer(nowTime)
    local TickCount = self:LuaFnGetCopySceneData_Param(self.g_keySD["tim"])
    TickCount = TickCount + 1
    self:LuaFnSetCopySceneData_Param(self.g_keySD["tim"], TickCount)
    if TickCount == 1 then
        local iniLevel = self:LuaFnGetCopySceneData_Param(self.g_keySD["lev"])
        self:RefreshMonster(iniLevel)
    end
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
        if leaveTickCount == self.g_CloseTick then
            local oldsceneId = self:LuaFnGetCopySceneData_Param(3)
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:NewWorld(mems[i], oldsceneId, nil, self.g_Back_X, self.g_Back_Z)
                end
            end
        elseif leaveTickCount < self.g_CloseTick then
            local strText = string.format("你将在%d秒后离开场景!", (self.g_CloseTick - leaveTickCount) * self.g_TickTime)
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:NotifyTip(mems[i], strText)
                end
            end
        end
    elseif TickCount == 1 then
        local CloseMin = math.floor(self.g_LimitTotalHoldTime * self.g_TickTime / 60)
        if CloseMin > 0 then
            for i = 1, membercount do
                if self:LuaFnIsObjValid(mems[i]) then
                    self:NotifyTip(mems[i], "副本将在" .. CloseMin .."分钟后关闭!")
                end
            end
        end
    elseif TickCount >= self.g_LimitTotalHoldTime then
        for i = 1, membercount do
            if self:LuaFnIsObjValid(mems[i]) then
                self:NotifyTip(mems[i], "任务失败，超时!")
                self:MissionFailExe(mems[i])
            end
        end
        self:LuaFnSetCopySceneData_Param(4, 1)
    else
        local oldteamid = self:LuaFnGetCopySceneData_Param(6)
        local oldsceneId
        for i = 1, membercount do
            if self:LuaFnIsObjValid(mems[i]) and self:IsHaveMission(mems[i], self.g_MissionId) then
                if oldteamid ~= self:GetTeamId(mems[i]) then
                    self:NotifyTip(mems[i], "任务失败，你不在正确的队伍中!")
                    self:MissionFailExe(mems[i])
                    oldsceneId = self:LuaFnGetCopySceneData_Param(3)
                    self:NewWorld(mems[i], oldsceneId, nil, self.g_Back_X,  self.g_Back_Z)
                end
            end
        end
    end
end

function shuilao_12:NotifyTip(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function shuilao_12:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function shuilao_12:RefreshMonster(iniLevel)
    local ini = math.floor(iniLevel / 10)
    if ini <= 0 then
        ini = 1
    elseif ini > 10 then
        ini = 10
    end
    local typ = self.g_typMonster[ini]
    local nai = 0
    local numMon = self:GetMonsterCount()
    local idMon
    local lstLay = {{-1, -1}, {1, -1}, {-1, 1}, {1, 1}, {0, 0}}
    for i = 1, numMon do
        idMon = self:GetMonsterObjID(i)
        local x, y = self:LuaFnGetWorldPos(idMon)
        local objId
        for _, untLay in pairs(lstLay) do
            local px = math.floor(x) + untLay[1]
            local py = math.floor(y) + untLay[2]
            objId = self:LuaFnCreateMonster(typ, px, py, nai, -1, -1)
            self:SetLevel(objId, iniLevel)
        end
    end
end

function shuilao_12:MissionFailExe(selfId)
    self:DelMission(selfId, self.g_MissionId)
    self:DelMission(selfId, self.g_MissionIdPre)
    self:NotifyTip(selfId, "任务被系统自动删除！")
end

return shuilao_12
