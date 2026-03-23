local class = require "class"
local define = require "define"
local script_base = require "script_base"
local event_fenghuangControl = class("event_fenghuangControl", script_base)
local gbk = require "gbk"

event_fenghuangControl.script_id = 403005
--目前仅支持八个同盟进入凤凰古城争夺
event_fenghuangControl.g_SceneData =
{
    --下列数组含义1和2是本同盟复活点坐标
    --3是阵营数据 4和5是copysceneparam的占用 4是记录抢夺水晶积分记录 5是夺旗记录
    [1] = {66,35,109,0,22},
    [2] = {252,28,110,1,23},
    [3] = {288,62,111,2,24},
    [4] = {292,250,112,3,25},
    [5] = {261,291,113,4,26},
    [6] = {68,291,114,5,27},
    [7] = {28,239,115,6,28},
    [8] = {34,60,116,7,29}
}
event_fenghuangControl.g_CrystalCampID = 
{
    --下列数组含义1用于记录水晶归属 2用于记录水晶刷新时间
    --4用于记录击杀者的场景临时ID
    [14003] = {8,13,"西南",17,40,41},
    [14005] = {9,14,"东南",18,42,43},
    [14007] = {10,15,"西北",19,44,45},
    [14009] = {11,16,"东北",20,46,47}

}
local flag_pos = 
{ 
    world_pos = { x = 0, y = 0}, --地图上旗子的位置
    hold_name = "", --手里拿着旗子的玩家
    hold_guild_name = "", --手里拿着旗子的玩家的同盟
}
local crystal_pos = 
    { 
        --第一个水晶
        [1] = 
        {
            world_pos = {x = -1, y = -1}, --水晶位置
            league_id = -1, --占领水晶同盟id
            guild_id = -1, --占领水晶帮会id
            league_name = "", --占领水晶同盟名称
            hp = 0, -- 写死传0
        },
        --第二个水晶
        [2] = 
        {
            world_pos = {x = -1, y = -1}, --水晶位置
            league_id = -1, --占领水晶同盟id
            guild_id = -1, --占领水晶帮会id
            league_name = "", --占领水晶同盟名称
            hp = 0, -- 写死传0
        },
        --第三个水晶
        [3] = 
        {
            world_pos = {x = -1, y = -1}, --水晶位置
            league_id = -1, --占领水晶同盟id
            guild_id = -1, --占领水晶帮会id
            league_name = "", --占领水晶同盟名称
            hp = 0, -- 写死传0
        },
        --第四个水晶
        [4] = 
        {
            world_pos = {x = -1, y = -1}, --水晶位置
            league_id = -1, --占领水晶同盟id
            guild_id = -1, --占领水晶帮会id
            league_name = "", --占领水晶同盟名称
            hp = 0, -- 写死传0
        },
    }
event_fenghuangControl.g_AllBossData = {14003,14005,14007,14009,14012}
--第一个占领据点的同盟数据记录
event_fenghuangControl.g_First_Ascription = 12
--记录本次活动是否开启
event_fenghuangControl.g_NewFengHuangNoticeData = 21
--记录凤凰战旗刷新时间
event_fenghuangControl.FLAG_RefreshTime = 30
--记录凤凰战旗归属。
event_fenghuangControl.g_NewFengHuangFlag = 31
event_fenghuangControl.ScenePosData = {32,33,34,35,36,37,38,39}
--上面数据全部结束了，要进行所有参与同盟之间数据排序了
local TopListData =
{
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 1},
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 2},
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 3},
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 4},
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 5},
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 6},
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 7},
        {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = 8},
}
--*********************************
-- 水晶归属交旗操作
--*********************************
function event_fenghuangControl:OnDefaultEvent(selfId,targetId)
    local LeagueId = self:LuaFnGetHumanGuildLeagueID(selfId)
    local LeagueName = self:LuaFnGetHumanGuildLeagueName(selfId)
    local IsId = 0
    local sMessage = ""
    local nRanking = 0
    local nHave = self:LuaFnHaveImpactOfSpecificDataIndex(selfId,3019)
    if nHave and self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag) > 0 then
        for i = 1,8 do
            if (LeagueId + 100) == self:LuaFnGetCopySceneData_Param(self.ScenePosData[i]) then
                IsId = i
                break
            end
        end
        self:LuaFnCancelSpecificImpact(selfId,3019) --清理战旗状态
        self:LuaFnSetCopySceneData_Param(self.g_NewFengHuangFlag,0) --清理战旗归属数据
        self:LuaFnSetCopySceneData_Param(self.FLAG_RefreshTime,45)--设置战旗45s刷新
        flag_pos.world_pos.x = 0
        flag_pos.world_pos.y = 0
        flag_pos.hold_name = ""
        flag_pos.hold_name = ""
        self:DispatchPhoenixPlainWarFlagPos(flag_pos) -- 通知客户端，现在没旗子了。
        self:LuaFnSetCopySceneData_Param(self.g_SceneData[IsId][4],self:LuaFnGetCopySceneData_Param(self.g_SceneData[IsId][4]) + 120) --夺旗一次加分120分
        nRanking = TopListData[IsId].ranking
        TopListData[nRanking].crystal_hold_score = self:LuaFnGetCopySceneData_Param(self.g_SceneData[IsId][4])
        self:HumanTips("#{FHZD_090708_27}")
        self:NotifyFailBox(selfId,targetId,"#{FHZD_090708_83}")
        local Name = self:GetName(selfId)
        local fmt = string.format("#{_INFOUSR%s}#W过五关，斩六将，冲出重围，将凤凰战旗稳稳地插在了本方据点上，#{_INFOUSR%s}#W是凤凰古城上真正的英雄！#c996666%s#W得到了#G120分#W。",Name,Name,LeagueName)
        self:MonsterTalk(-1,"凤凰平原",fmt)
        sMessage = string.format("@*;SrvMsg;GLL:#Y凤凰古城战况：#{_INFOUSR%s}#W力挽狂澜，夺取了凤凰战旗，为我方得到了#G120分#W。", self:GetName(selfId))
        self:BroadMsgByChatPipe(selfId,gbk.fromutf8(sMessage),12)
    else
        self:NotifyFailBox(selfId,targetId,"你没有旗帜")
        return
    end
end
--*********************************
-- 场景内数据回调
--*********************************
function event_fenghuangControl:OnSceneTimer()
    self:OnSceneJianCe()
end
--*********************************
-- 玩家进入场景
--*********************************
function event_fenghuangControl:OnPlayerEnter(selfId)
    local LeagueId = self:LuaFnGetHumanGuildLeagueID(selfId)
    local LeagueName = self:LuaFnGetHumanGuildLeagueName(selfId)
    if LeagueId == -1 then
        --self:NewWorld(selfId,0,nil,89,180)
        return
    end
    local guildinfo = self:GetLeagueGuildsIDandName(LeagueId)
    --进入场景后设置当前同盟复活点
    local IsId
    for i = 1, 8 do
        if (LeagueId + 100) == self:LuaFnGetSceneData_Param(self.ScenePosData[i]) then
            IsId = i
            break
        end
    end
    if IsId == nil then
        for i = 1, 8 do
            local value = self:LuaFnGetCopySceneData_Param(self.ScenePosData[i]) or 0
            if value == 0 then
                IsId = i
                break
            end
        end
        if IsId then
            self:LuaFnSetCopySceneData_Param(self.ScenePosData[IsId], (LeagueId + 100))
        end
    end
    if IsId == nil then
        self:notify_tips(selfId, "场景中已存在8个同盟，你无法再参加")
        --self:NewWorld(selfId,0,nil,89,180)
        return
    end
    self:SetPlayerPvpRule(selfId,9) --设置玩家PVP规则
    self:SetUnitCampID(selfId,self.g_SceneData[IsId][3])
    self:SetPlayerDefaultReliveInfo(selfId,1,1,1,191,self.g_SceneData[IsId][1] ,self.g_SceneData[IsId][2])
    local nNoticeData = self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangNoticeData)
    local nWeek = self:GetTodayWeek()
    local nTime = self:GetHour()*100 + self:GetMinute()
    if tonumber(nWeek) ~= 3 and tonumber(nWeek) ~= 2 then
        return
    end
    if tonumber(nTime) < 1000 or tonumber(nTime) > 2359 then
        return
    end
    --初始化榜单
    local playcount = 0
    local nRanking = 0
    local guilid_1,guilid_2,guilid_3,guilid_name1,guilid_name2,guilid_name3 = -1,-1,-1,"","",""
    if IsId then
        if guildinfo then
            if guildinfo[1] then
                guilid_1 = guildinfo[1].id
                guilid_name1 = guildinfo[1].name
            end
            if guildinfo[2] then
                guilid_2 = guildinfo[2].id
                guilid_name2 = guildinfo[2].name
            end
            if guildinfo[3] then
                guilid_3 = guildinfo[3].id
                guilid_name3 = guildinfo[3].name
            end
        end
        playcount = TopListData[IsId].playercount + 1
        nRanking = TopListData[IsId].ranking
        TopListData[IsId] = {league_id = LeagueId,guild_id_1 = guilid_1,guild_id_2 = guilid_2,guild_id_3 = guilid_3,crystal_hold_score = 0,flag_capture_score = 0,league_name = LeagueName,guild_name_1 = guilid_name1,guild_name_2 = guilid_name2,guild_name_3 = guilid_name3,playercount = playcount,ranking = nRanking}
    end
    if nNoticeData < 1 then
        for i = 0,7 do
            if self:LuaFnGetCopySceneData_Param(i) > 0 then
                self:LuaFnSetCopySceneData_Param(i,0)
            end
            if self:LuaFnGetCopySceneData_Param(i + 22) > 0 then
                self:LuaFnSetCopySceneData_Param(i + 22,0)
            end
        end
        --活动重新开始清理一次数据
        for i = 1,#self.g_AllBossData do
            local nMonsterNum = self:GetMonsterCount()
            for r = 1,nMonsterNum do
            local MonsterId = self:GetMonsterObjID(r)
            local MosDataID = self:GetMonsterDataID(MonsterId)
                if MosDataID == self.g_AllBossData[i]  then
                    self:LuaFnDeleteMonster(MonsterId)
                end
            end
        end
        self:LuaFnSetCopySceneData_Param(self.g_NewFengHuangNoticeData,1) --开启活动
        self:LuaFnSetCopySceneData_Param(self.FLAG_RefreshTime,45) --设置战旗45s后刷新
        for i = 13,16 do
            self:LuaFnSetCopySceneData_Param(i,15) --设置水晶15s刷新
        end
        self:LuaFnSetCopySceneData_Param(self.g_NewFengHuangFlag,0) --战旗归属清除
        --防止有人多余buff清除硬性清除一下战旗状态
        self:LuaFnCancelSpecificImpact(selfId,3019)
    end
end
--*********************************
-- 凤凰古城争夺战检测
--*********************************
function event_fenghuangControl:OnSceneJianCe()
    if self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangNoticeData) > 0 then
        for i = 0,7 do
            if self:LuaFnGetCopySceneData_Param(i) + self:LuaFnGetCopySceneData_Param(i + 22) >= 10000 then
                if self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag) > 0 then
                    if self:LuaFnHaveImpactOfSpecificDataIndex(self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag),3019) then
                        self:LuaFnCancelSpecificImpact(self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag),949)
                    end
                end
                self:LuaFnSetCopySceneData_Param(self.g_NewFengHuangFlag,0)
                self:LuaFnSetCopySceneData_Param(self.FLAG_RefreshTime,0)
                self:AddGlobalCountNews(string.format("#P凤凰古城，一场大战之后，%s#P最终战胜了各路好汉，赢得了本次凤凰古城争夺战的桂冠。整个武林为之震撼，他们是今天真正的英雄，在接下来的数天内，他们将在凤凰古城享受英雄般的待遇。",TopListData[1].league_name))
                for m = 1,#self.g_AllBossData do
                    local nMonsterNum = self:GetMonsterCount()
                    for r = 1,nMonsterNum do
                    local MonsterId = self:GetMonsterObjID(r)
                    local MosDataID = self:GetMonsterDataID(MonsterId)
                        if MosDataID == self.g_AllBossData[m]  then
                            self:LuaFnDeleteMonster(MonsterId)
                        end
                    end
                end
                local nMstId = self:LuaFnCreateMonster(14011,162,161,3,-1,-1)
                if nMstId > 0 then
                    self:SetCharacterTitle(nMstId,"本期凤凰争夺战霸主")
                    self:SetCharacterName(nMstId,TopListData[1].league_name)
                end
                for j = 0,47 do
                    self:LuaFnSetCopySceneData_Param(j,0) --清除所有记录
                end
                --清理榜单信息
                local nRanking = 0
                for k = 1,#TopListData do
                    nRanking = TopListData[i].ranking
                    TopListData[i] = {league_id = -1,guild_id_1 = -1,guild_id_2 = -1,guild_id_3 = -1,crystal_hold_score = 0,flag_capture_score = 0,league_name = "",guild_name_1 = "",guild_name_2 = "",guild_name_3 = "",playercount = 0,ranking = nRanking}
                end
            end
        end
        local nFlagData = self:LuaFnGetCopySceneData_Param(self.FLAG_RefreshTime)
        if nFlagData > 0 then
            nFlagData = nFlagData - 1
            self:LuaFnSetCopySceneData_Param(self.FLAG_RefreshTime,nFlagData) 
        end
        --水晶刷新读秒
        local nData = {0,0,0,0}
        local Idx = 0;
        for i = 1,4 do
            nData[i] = self:LuaFnGetCopySceneData_Param(i+12)
            if nData[i] > 0 then
                Idx = i;
            end
        end
        if Idx > 0 then
            for i = 1,Idx do
                nData[i] = nData[i] - 1
                self:LuaFnSetCopySceneData_Param(i+12,nData[i])
            end
        end
        --判断水晶归属并给归属盟加分
        local nScoreData = {0,0,0,0,0,0,0,0}
        local Isleuagid = {}
        local nScoreID = 0
        local nRanking = 0
        for i = 1,8 do
            for j = 8,11 do
                if self:LuaFnGetCopySceneData_Param(j) == self.g_SceneData[i][3] then
                    table.insert(Isleuagid,i) --将数据存入组内
                end
            end
        end
        if #Isleuagid then
            for i = 1,#Isleuagid do
                nScoreData[Isleuagid[i]] = nScoreData[Isleuagid[i]] + 1
            end
        end
        for i = 1,#nScoreData do
            if nScoreData[i] > 0 then
                nScoreID = i
                self:LuaFnSetCopySceneData_Param(self.g_SceneData[nScoreID][5] ,self:LuaFnGetCopySceneData_Param(self.g_SceneData[nScoreID][5]) + nScoreData[nScoreID])
                print("nScoreData = ",nScoreID)
                nRanking = TopListData[nScoreID].ranking
                TopListData[nRanking].flag_capture_score = self:LuaFnGetCopySceneData_Param(self.g_SceneData[nScoreID][5])
            end
        end
        --积分排序
        table.sort
        (
            TopListData,function(t1,t2)
            local t1_score = (t1.crystal_hold_score + t1.flag_capture_score)
            local t2_score = (t2.crystal_hold_score + t2.flag_capture_score)
                if t1_score == t2_score then
                    return t1.league_id > t2.league_id
                else
                    return t1_score > t2_score
                end
            end
        )
        --小地图战旗显示
        local nMonsterNum = self:GetMonsterCount()
        for i = 1,nMonsterNum do
            local MonsterId = self:GetMonsterObjID(i)
            local MosDataID = self:GetMonsterDataID(MonsterId)
            if MosDataID == 14012 and self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag) == 0 then
                flag_pos.world_pos.x = 162
                flag_pos.world_pos.y = 161
                flag_pos.hold_name = ""
                flag_pos.hold_guild_name = ""
                print("flag_pos = ",flag_pos)
            end
            if self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag) > 0 and MosDataID ~= 14012 then
                local nPosX,nPosY = self:GetWorldPos(self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag))
                flag_pos.world_pos.x = nPosX
                flag_pos.world_pos.y = nPosY
                flag_pos.hold_name = self:GetName(self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag))
                flag_pos.hold_guild_name = self:LuaFnGetHumanGuildLeagueName(self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag))
            end
        end
        local stalInfo =
        {
            [14003] = {91,229,40,41},
            [14005] = {230,230,42,43},
            [14007] = {92,90,44,45},
            [14009] = {229,90,46,47},
        }
        --初始化数据
        for i = 1,nMonsterNum do
            local MonsterId = self:GetMonsterObjID(i)
            local MosDataID = self:GetMonsterDataID(MonsterId)
            if stalInfo[MosDataID] ~= nil then
                if self:LuaFnGetCopySceneData_Param(stalInfo[MosDataID][4]) > 0 then
                    print("MosDataID = ",MosDataID)
                    crystal_pos[i].world_pos.x = stalInfo[MosDataID][1]
                    crystal_pos[i].world_pos.y = stalInfo[MosDataID][2]
                    crystal_pos[i].guild_id = self:LuaFnGetCopySceneData_Param(stalInfo[MosDataID][3])
                    crystal_pos[i].league_id = self:LuaFnGetCopySceneData_Param(stalInfo[MosDataID][4])
                    crystal_pos[i].league_name = self:LuaFnGetCopySceneData_Param(self.g_CrystalCampID[MosDataID][4])
                    crystal_pos[i].hp = 0
                else
                    crystal_pos[i].world_pos.x = stalInfo[MosDataID][1]
                    crystal_pos[i].world_pos.y = stalInfo[MosDataID][2]
                    crystal_pos[i].guild_id = -1
                    crystal_pos[i].league_id = -1
                    crystal_pos[i].league_name = ""
                    crystal_pos[i].hp = 0
                end
            end
        end
        print("crystal_pos = ",table.tostr(crystal_pos))
        self:DispatchPhoenixPlainWarFlagPos(flag_pos)
        self:LuaFnDispatchPhoenixPlainWarScore(TopListData)
        self:DispatchPhoenixPlainWarCrystalPos(crystal_pos)
        self:DispatchPhoenixPlainWarCampInfo()
    end
end
--*********************************
-- 玩家离开场景
--*********************************
function event_fenghuangControl:OnPlayerLeave(selfId)
	--玩家离开场景，或者离线后清理一下场景内当前同盟参战人数
    local LeagueId = self:LuaFnGetHumanGuildLeagueID(selfId)
    for i = 1,#TopListData do
        if TopListData[i].league_id == LeagueId then
            TopListData[i].playercount = TopListData[i].playercount - 1
        end
    end
    self:LuaFnDispatchPhoenixPlainWarScore(TopListData)
    --离线或者离开场景检测是否是有战旗的玩家，是的话必须清理玩家战旗标记
    local nHave = self:LuaFnHaveImpactOfSpecificDataIndex(selfId,3019)
    if nHave and self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag) > 0 then
        self:LuaFnCancelSpecificImpact(selfId,3019) --清理战旗状态
        self:LuaFnSetCopySceneData_Param(self.g_NewFengHuangFlag,0) --清理战旗归属数据
        self:LuaFnSetCopySceneData_Param(self.FLAG_RefreshTime,45)--设置战旗45s刷新
        self:HumanTips("#{FHZD_090708_27}")
    end
end
--*********************************
-- 发放奖励
--*********************************
function event_fenghuangControl:PhoneixReWard()
end
--*********************************
-- 水晶被打碎
--*********************************
function event_fenghuangControl:OnDie(objId,KillerId)
    local nMonsterId = self:GetMonsterDataID(objId)
    local nKillName = self:GetName(KillerId)
    local sMessage = ""
    local IsId = -1
    if self:GetCharacterType(KillerId) == "pet" then
        KillerId = self:GetPetCreator(KillerId)
    end
    local LeagueName = self:LuaFnGetHumanGuildLeagueName(KillerId)
    local LeagueId = self:LuaFnGetHumanGuildLeagueID(KillerId)
    local TarGetData = self:LuaFnGetCopySceneData_Param(self.g_CrystalCampID[nMonsterId] [4])
    for i = 1,8 do
        if (LeagueId + 100) == self:LuaFnGetCopySceneData_Param(self.ScenePosData[i]) then
            IsId = i
            break
        end
    end
    print("IsIdData = ",IsId)
    if self:LuaFnGetCopySceneData_Param(self.g_First_Ascription) == 0 then
        self:LuaFnSetCopySceneData_Param(self.g_SceneData[IsId] [5] ,self:LuaFnGetCopySceneData_Param(self.g_SceneData[IsId] [5] ) + 100)
        self:LuaFnSetCopySceneData_Param(self.g_First_Ascription,1)
        sMessage = string.format("%s率领帮众及同盟闪电般地夺取了第一个据点。",nKillName)
        self:HumanTips(sMessage)
        sMessage = string.format("@*;SrvMsg;GLL:#Y凤凰古城战况：#W我方的#{_INFOUSR%s}#W成功击毁了#Y%s据点#W的生命水晶，我方夺得了第一个据点，获得奖励#G100分#W。",nKillName,self.g_CrystalCampID[nMonsterId][3])
        self:BroadMsgByChatPipe(KillerId,gbk.fromutf8(sMessage),12)
        sMessage = string.format("#{_INFOUSR%s}#W成功击毁了#Y%s据点#W的生命水晶，#c996666%s#W夺得了第一个据点，获得奖励#G100分#W。#c996666%s#G每秒获得分数+1#W。",nKillName,self.g_CrystalCampID[nMonsterId][3] ,LeagueName,LeagueName)
        self:MonsterTalk(-1,"凤凰平原",sMessage)
    else

        sMessage = string.format("@*;SrvMsg;GLL:#Y凤凰古城战况：#W我方的#{_INFOUSR%s}#W成功击毁了#Y%s据点#W的生命水晶，#G15#W秒后，我方将占领该据点。",nKillName,self.g_CrystalCampID[nMonsterId][3])
        self:BroadMsgByChatPipe(KillerId,gbk.fromutf8(sMessage),12)
        sMessage = string.format("#{_INFOUSR%s}#W成功击毁了#Y%s据点#W的生命水晶，#G15#W秒后，#c996666%s#W将占领%s据点。",nKillName,self.g_CrystalCampID[nMonsterId] [3] ,LeagueName,self.g_CrystalCampID[nMonsterId] [3])
        self:MonsterTalk(-1,"凤凰平原",sMessage)

    end
    self:LuaFnSetCopySceneData_Param(self.g_CrystalCampID[nMonsterId] [1] ,self.g_SceneData[IsId] [3] )
    self:LuaFnSetCopySceneData_Param(self.g_CrystalCampID[nMonsterId] [2] ,15)
    if TarGetData ~= 0 then
        sMessage = string.format("#{_INFOUSR%s}#W成功击毁了#Y%s据点#W的生命水晶，#G15#W秒后，#c996666%s#W将占领%s据点。",nKillName,TarGetData,self.g_CrystalCampID[nMonsterId] [3] ,LeagueName,self.g_CrystalCampID[nMonsterId] [3] ,LeagueName)
        self:MonsterTalk(-1,"凤凰平原",sMessage)
    end
    if KillerId ~= -1 then
        self:LuaFnSetCopySceneData_Param(self.g_CrystalCampID[nMonsterId] [4] ,self:LuaFnGetHumanGuildLeagueName(KillerId))
        self:LuaFnSetCopySceneData_Param(self.g_CrystalCampID[nMonsterId] [5] ,self:GetHumanGuildID(KillerId))
        self:LuaFnSetCopySceneData_Param(self.g_CrystalCampID[nMonsterId] [6] ,self:LuaFnGetHumanGuildLeagueID(KillerId))
    end
    sMessage = string.format("各路英雄请注意！15秒后，%s据点水晶将再次刷新。",self.g_CrystalCampID[nMonsterId][3])
    self:HumanTips(sMessage)
    self:LuaFnDeleteMonster(objId)
end
--*********************************
-- 玩家死亡状态
--*********************************
function event_fenghuangControl:OnSceneHumanDie(selfId,KillerId)
    --防止自杀情况
    if selfId == KillerId then
        return
    end
    local nHave = self:LuaFnHaveImpactOfSpecificDataIndex(selfId,3019)
    local nFlag = self:LuaFnGetCopySceneData_Param(self.g_NewFengHuangFlag)
    if nHave and nFlag > 0 then
        self:LuaFnCancelSpecificImpact(selfId,3019)
        self:LuaFnSetCopySceneData_Param(self.g_NewFengHuangFlag,0)
        self:LuaFnSetCopySceneData_Param(self.FLAG_RefreshTime,45)
        local Msg = string.format("#{_INFOUSR%s}丢掉了凤凰战旗。",self:GetName(selfId))
        self:HumanTips(gbk.fromutf8(Msg))
        self:HumanTips("#{FHZD_090708_27}")
        Msg = string.format("#{_INFOUSR%s}丢掉了凤凰战旗。",self:GetName(selfId))
        self:MonsterTalk(-1,"凤凰平原",Msg)
    end
end

function event_fenghuangControl:HumanTips(str)
    local nHumanCount = self:LuaFnGetCopyScene_HumanCount()
    for i = 1,nHumanCount do
        local nHumanId = self:LuaFnGetCopyScene_HumanObjId(i)
        if self:LuaFnIsObjValid(nHumanId)
        and self:LuaFnIsCanDoScriptLogic(nHumanId)
        and self:LuaFnIsCharacterLiving(nHumanId) then
            self:BeginEvent(self.script_id)
            self:AddText(str)
            self:EndEvent()
            self:DispatchMissionTips(nHumanId)
        end
     end
end

function event_fenghuangControl:MsgBox(selfId,str)
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function event_fenghuangControl:NotifyFailBox(selfId,targetId,msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
end
return event_fenghuangControl