local gbk = require "gbk"
local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local FB_cangjinge_FB = class("FB_cangjinge_FB", script_base)
FB_cangjinge_FB.script_id = 402112
FB_cangjinge_FB.g_CopySceneName = "藏经阁"
FB_cangjinge_FB.g_CopySceneType = ScriptGlobal.FUBEN_PORTECT_PET
FB_cangjinge_FB.g_CloseTime = 30 * 60
FB_cangjinge_FB.g_XiaoGuaiCount = 13
FB_cangjinge_FB.g_XiaoGuaiTime = 60
FB_cangjinge_FB.g_CopySceneMap = "cangjingge.nav"
FB_cangjinge_FB.g_client_res = 272
FB_cangjinge_FB.g_Exit = "cangjingge.ini"
FB_cangjinge_FB.g_LimitMembers = 1
FB_cangjinge_FB.g_TickTime = 1
FB_cangjinge_FB.g_LimitTotalHoldTime = 360
FB_cangjinge_FB.g_LimitTimeSuccess = 500
FB_cangjinge_FB.g_CloseTick = 3
FB_cangjinge_FB.g_NoUserTime = 10
FB_cangjinge_FB.g_DeadTrans = 0
FB_cangjinge_FB.g_Fuben_X = 64
FB_cangjinge_FB.g_Fuben_Z = 103
FB_cangjinge_FB.g_Back_X = 264
FB_cangjinge_FB.g_Back_Z = 278
FB_cangjinge_FB.g_Back_SceneId = 18
FB_cangjinge_FB.g_PetSceneId = 18
FB_cangjinge_FB.g_SetpTime = 1
FB_cangjinge_FB.g_SetpWaiteTime_1 = 15
FB_cangjinge_FB.g_SetpWaiteTime_2 = 25
FB_cangjinge_FB.g_SetpWaiteTime_3 = 35
FB_cangjinge_FB.g_SetpWaiteTime_4 = 45
FB_cangjinge_FB.g_SetpWaiteTime_5 = 55
FB_cangjinge_FB.g_SetpWaiteTime_6 = 65
FB_cangjinge_FB.g_SetpWaiteTime_7 = 75
FB_cangjinge_FB.g_SetpWaiteTime_8 = 85
FB_cangjinge_FB.g_MonsterInfo_1 = {["id"] = 13583, ["x"] = 23, ["z"] = 47, ["ai"] = 9, ["ai_f"] = 0, ["p"] = 0}

FB_cangjinge_FB.g_MonsterInfo_2 = {["id"] = 13583, ["x"] = 103, ["z"] = 48, ["ai"] = 9, ["ai_f"] = 0, ["p"] = 1}

FB_cangjinge_FB.g_MonsterInfo_3 = {["id"] = 13574, ["x"] = 23, ["z"] = 47, ["ai"] = 9, ["ai_f"] = 0, ["p"] = 0}

FB_cangjinge_FB.g_MonsterInfo_4 = {["id"] = 13574, ["x"] = 103, ["z"] = 48, ["ai"] = 9, ["ai_f"] = 0, ["p"] = 1}

FB_cangjinge_FB.g_MonsterInfo_5 = {["id"] = 13592, ["x"] = 64, ["z"] = 32, ["ai"] = 9, ["ai_f"] = 234, ["p"] = 0}

FB_cangjinge_FB.g_MonsterAI = {
    {["id"] = 13565, ["ai"] = 3},
    {["id"] = 13566, ["ai"] = 3},
    {["id"] = 13567, ["ai"] = 3},
    {["id"] = 13568, ["ai"] = 3},
    {["id"] = 13569, ["ai"] = 3},
    {["id"] = 13570, ["ai"] = 3},
    {["id"] = 13571, ["ai"] = 3},
    {["id"] = 13572, ["ai"] = 3},
    {["id"] = 13573, ["ai"] = 3}
}

FB_cangjinge_FB.g_MonsterInfo_Count_1 = 10
FB_cangjinge_FB.g_MonsterInfo_Count_2 = 7
FB_cangjinge_FB.g_MonsterInfo_Count_3 = 8
FB_cangjinge_FB.g_MonsterInfo_Count_4 = 5
FB_cangjinge_FB.g_MonsterInfo_Count_5 = 5
FB_cangjinge_FB.g_MonsterInfo_Count_6 = 8
FB_cangjinge_FB.g_MonsterInfo_Count_7 = 20
function FB_cangjinge_FB:OnDefaultEvent(selfId, targetId, arg, index)
    if index == 1010 then
        self:BeginEvent(self.script_id)
        self:AddText(
            "    贫僧近来通过演算和打探江湖消息，了解到有一群恶僧多次侵入少林欲夺取少林武学典籍。而少林云游武僧多在#G雁南#W集结，然后回寺援助。每天的#G10：45、16：30、21：30和23：00#W就是我们集结的时间。"
        )
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if not self:LuaFnHasTeam(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText("#B藏经阁")
        self:AddText("   进入副本需要一支队伍。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetTeamSize(selfId) < 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#B藏经阁")
        self:AddText("  进入副本需要一支队伍。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetTeamLeader(selfId) ~= selfId then
        self:BeginEvent(self.script_id)
        self:AddText("#B藏经阁")
        self:AddText("  进入副本需要一支队伍。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetTeamSize(selfId) ~= self:GetNearTeamCount(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText("#B藏经阁")
        self:AddText("  进入副本需要一支队伍。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local nPlayerNum = self:GetNearTeamCount(selfId)
    local strName = {}

    strName[1] = ""
    strName[2] = ""
    strName[3] = ""
    strName[4] = ""
    strName[5] = ""
    strName[6] = ""
    local ret = 1
    for i = 1, nPlayerNum do
        local nPlayerId = self:GetNearTeamMember(selfId, i)
        if self:GetLevel(nPlayerId) < 40 then
            ret = 0
            strName[i] = self:GetName(nPlayerId)
        end
    end
    local nCount = 0
    if ret == 0 then
        local szAllName = ""
        for i = 1, 6 do
            if strName[i] ~= "" then
                if nCount == 0 then
                    szAllName = strName[i]
                else
                    szAllName = szAllName .. "、" .. strName[i]
                end
                nCount = nCount + 1
            end
        end
        self:BeginEvent(self.script_id)
        self:AddText("#B藏经阁")
        self:AddText("  您队伍中有成员（" .. szAllName .. "）等级低于40级，不能参加藏经阁。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:MakeCopyScene(selfId, targetId)
    self:LuaFnDeleteMonster(targetId)
end

function FB_cangjinge_FB:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddText(
        "    贫僧近来通过演算和打探江湖消息，了解到有一群恶僧多次侵入少林欲夺取少林武学典籍。而少林云游武僧多在#G雁南#W集结，然后回寺援助。每天的#G10：45、16：30、21：30和23：00#W就是我们集结的时间。"
    )
    caller:AddNumTextWithTarget(self.script_id, "藏经阁", 10, -1)
    caller:AddNumTextWithTarget(self.script_id, "关于藏经阁", 11, 1010)
end

function FB_cangjinge_FB:CheckAccept(selfId)
end

function FB_cangjinge_FB:AskEnterCopyScene(selfId)
end

function FB_cangjinge_FB:OnAccept(selfId, targetId)
end

function FB_cangjinge_FB:AcceptEnterCopyScene(selfId)
end

function FB_cangjinge_FB:MakeCopyScene(selfId, targetId)
    local param0 = 4
    local param1 = 3
    local mylevel = 0
    local memId
    local tempMemlevel = 0
    local level0 = 0
    local level1 = 0
    local nearmembercount = self:GetNearTeamCount(selfId)
    for i = 1, nearmembercount do
        memId = self:GetNearTeamMember(selfId, i)
        tempMemlevel = self:GetLevel(memId)
        level0 = level0 + (tempMemlevel ^ param0)
        level1 = level1 + (tempMemlevel ^ param1)
    end
    if level1 == 0 then
        mylevel = 0
    else
        mylevel = level0 / level1
    end
    if nearmembercount == -1 then
        mylevel = self:GetLevel(selfId)
    end
    local leaderguid = self:LuaFnObjId2Guid(selfId)
    local config = {}
    config.navmapname = "cangjingge.nav"
    config.client_res = self.g_client_res
    config.teamleader = leaderguid
    config.NoUserCloseTime = 100 * 1000
    config.Timer = self.g_TickTime * 1000
    config.params = {}
    config.params[0] = self.g_CopySceneType
    config.params[1] = self.script_id
    config.params[2] = 0
    config.params[3] = -1
    config.params[4] = 0
    config.params[5] = 0
    config.params[6] = self:GetTeamId( selfId )
    config.params[7] = 0
    for i = 8, 31 do
        config.params[i] = 0
    end
    local PlayerMaxLevel = self:GetHumanMaxLevelLimit()
    local iniLevel
    if mylevel < 10 then
        iniLevel = 1
    elseif mylevel < PlayerMaxLevel then
        iniLevel = math.floor(mylevel / 10)
    else
        iniLevel = math.floor(PlayerMaxLevel / 10)
    end
    config.params[8] = mylevel
    config.params[9] = iniLevel
    config.params[10] = self:GetMonsterDataID(targetId)
    local x, z = self:GetWorldPos(selfId)
    config.params[16] = x
    config.params[17] = z
    config.sn 		 = self:LuaFnGenCopySceneSN()
    config.patrolpoint = "cangjingge_patrolpoint.ini"
    local bRetSceneID = self:LuaFnCreateCopyScene(config)
    self:BeginEvent(self.script_id)
    if bRetSceneID > 0 then
        self:AddText("副本创建成功！")
    else
        self:AddText("副本数量已达上限，请稍候再试！")
    end
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function FB_cangjinge_FB:OnCopySceneReady(destsceneId)
    local sceneId = self:get_scene_id()
    self:LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId)
    local leaderguid = self:LuaFnGetCopySceneData_TeamLeader(destsceneId)
    local leaderObjId = self:LuaFnGuid2ObjId(leaderguid)
    if not self:LuaFnIsCanDoScriptLogic(leaderObjId) then
        return
    end
    if not self:LuaFnHasTeam(leaderObjId) then
        self:GotoScene(leaderObjId, destsceneId)
    else
        if not self:IsCaptain(leaderObjId) then
            self:GotoScene(leaderObjId, destsceneId)
        else
            local nearteammembercount = self:GetNearTeamCount(leaderObjId)
            local mems = {}
            for i = 1, nearteammembercount do
                mems[i] = self:GetNearTeamMember(leaderObjId, i)
                self:GotoScene(mems[i], destsceneId)
            end
        end
    end
end

function FB_cangjinge_FB:GotoScene(ObjId, destsceneId)
    local sn = self:LuaFnGetCopySceneData_Sn(destsceneId)
    self:NewWorld(ObjId, destsceneId, sn, self.g_Fuben_X, self.g_Fuben_Z, self.g_client_res)
end

function FB_cangjinge_FB:OnPlayerEnter(selfId)
    print("FB_cangjinge_FB:OnPlayerEnter", selfId)
    self:SetPlayerDefaultReliveInfo(selfId, 1, 1, 0, self.g_Fuben_X, self.g_Fuben_Z)
    self:SetUnitCampID(selfId, 100)
    self:TipAllHuman("窃书恶僧将于15秒后开始进攻，注意在20分钟将他们全部击退！")
end

function FB_cangjinge_FB:OnHumanDie(selfId, killerId)
end

function FB_cangjinge_FB:OnAbandon(selfId)
end

function FB_cangjinge_FB:BackToCity(selfId)
end

function FB_cangjinge_FB:OnContinue(selfId, targetId)
end

function FB_cangjinge_FB:CheckSubmit(selfId, selectRadioId)
end

function FB_cangjinge_FB:OnSubmit(selfId, targetId, selectRadioId)
end

function FB_cangjinge_FB:TipAllHuman(Str)
    local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
    if nHumanNum < 1 then
        return
    end
    for i = 1, nHumanNum do
        local PlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
        self:BeginEvent(self.script_id)
        self:AddText(Str)
        self:EndEvent()
        self:DispatchMissionTips(PlayerId)
    end
end

function FB_cangjinge_FB:OnKillObject(selfId, objdataId, objId)
end

function FB_cangjinge_FB:OnEnterZone(selfId, zoneId)
end

function FB_cangjinge_FB:OnItemChanged(selfId, itemdataId)
end

function FB_cangjinge_FB:OnCopySceneTimer(nowTime)
    local TickCount = self:LuaFnGetCopySceneData_Param(2)
    TickCount = TickCount + 1
    self:LuaFnSetCopySceneData_Param(2, TickCount)
    local nLastTime = self.g_CloseTime
    local NndTime = self:LuaFnGetCopySceneData_Param(21)
    if TickCount == 1 then
        local nMonterIniID = self:LuaFnGetCopySceneData_Param(9)
        local nMonterID = self:LuaFnGetCopySceneData_Param(10)
        local nRetrievalMonterID
        if nMonterIniID >= 11 then
            nRetrievalMonterID = nMonterID + 8
        else
            nRetrievalMonterID = nMonterID + nMonterIniID - 3
        end
        local nNpcId = self:LuaFnCreateMonster(nRetrievalMonterID, 64, 105, 9, 226, -1)
        self:SetUnitCampID(nNpcId, 100)
        self:SetCharacterTitle(nNpcId, "少林高僧")
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
        self:LuaFnSetCopySceneData_Param(15, nNpcId)
    end
    if TickCount == 10 then
        self:TipAllHuman("窃书恶僧将由左上角开始第一次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将开始下一次进攻！")
        self:CreateNpcBOSS(0)
        self:CreateXiaoBOSS(0)
    end
    if TickCount == self.g_XiaoGuaiTime * 2 then
        self:TipAllHuman("窃书恶僧将由右上角开始第二次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将开始下一次进攻！")
        self:CreateNpcBOSS(1)
        self:CreateXiaoBOSS(1)
    end
    if TickCount == self.g_XiaoGuaiTime * 3 then
        self:TipAllHuman("窃书恶僧将由左上角开始第三次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将开始下一次进攻！")
        self:CreateNpcBOSS(0)
        self:CreateXiaoBOSS(0)
    end
    if TickCount == self.g_XiaoGuaiTime * 4 then
        self:TipAllHuman("窃书恶僧将由右上角开始第四次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将开始下一次进攻！")
        self:CreateNpcBOSS(1)
        self:CreateXiaoBOSS(1)
    end
    if TickCount == self.g_XiaoGuaiTime * 5 then
        self:TipAllHuman("窃书恶僧将由左上角开始第五次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将开始下一次进攻！")
        self:CreateNpcBOSS(0)
        self:CreateXiaoBOSS(0)
    end
    if TickCount == self.g_XiaoGuaiTime * 6 then
        self:TipAllHuman("窃书恶僧将由右上角开始第六次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将开始下一次进攻！")
        self:CreateXiaoBOSS(1)
        self:CreateNpcBOSS(1)
    end
    if TickCount == self.g_XiaoGuaiTime * 7 then
        self:TipAllHuman("窃书恶僧将由左上角开始第七次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将进行后一次进攻！")
        self:CreateNpcBOSS(0)
        self:CreateXiaoBOSS(0)
    end
    if TickCount == self.g_XiaoGuaiTime * 8 then
        self:TipAllHuman("窃书恶僧将由右上角开始第八次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将进行后一次进攻！")
        self:CreateNpcBOSS(1)
        self:CreateXiaoBOSS(1)
    end
    if TickCount == self.g_XiaoGuaiTime * 9 then
        self:TipAllHuman("窃书恶僧将由左上角开始第九次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将进行后一次进攻！")
        self:CreateNpcBOSS(0)
        self:CreateXiaoBOSS(0)
    end
    if TickCount == self.g_XiaoGuaiTime * 10 then
        self:TipAllHuman("窃书恶僧将由右上角开始第十次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将进行后一次进攻！")
        self:CreateNpcBOSS(1)
        self:CreateXiaoBOSS(1)
    end
    if TickCount == self.g_XiaoGuaiTime * 11 then
        self:TipAllHuman("窃书恶僧将由左上角开始第十一次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将进行后一次进攻！")
        self:CreateNpcBOSS(0)
        self:CreateXiaoBOSS(0)
    end
    if TickCount == self.g_XiaoGuaiTime * 12 then
        self:TipAllHuman("窃书恶僧将由右上角开始第十二次攻击！")
        self:TipAllHuman("30秒后窃书恶僧将进行后一次进攻！")
        self:CreateNpcBOSS(1)
        self:CreateXiaoBOSS(1)
    end
    if TickCount == self.g_XiaoGuaiTime * 13 then
        self:TipAllHuman("窃书恶僧将由左上角开始第十三次攻击！")
        self:TipAllHuman("30秒后头目蒙面恶僧将出现！")
        self:CreateNpcBOSS(0)
        self:CreateXiaoBOSS(0)
    end
    if TickCount == (self.g_XiaoGuaiTime * 13 + 30) then
        local Npc = self.g_MonsterInfo_5
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["z"], Npc["ai"], Npc["ai_f"], 402112)
        self:SetUnitCampID(nNpcId, 101)
        self:SetMonsterFightWithNpcFlag(nNpcId, 1)
        self:SetCharacterTitle(nNpcId, "妙手空空")
        self:TipAllHuman("头目蒙面恶僧出现！！")
        self:LuaFnSetCopySceneData_Param(13, nNpcId)
        local nPlayerNum = self:LuaFnGetCopyScene_HumanCount()
        for i = 1, nPlayerNum do
            local nPlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
            self:LuaFnAddMissionHuoYueZhi(nPlayerId, 19)
        end
    end
    local bOk = 0
    local nNpcId = self:LuaFnGetCopySceneData_Param(15)
    local nMonsterCount = self:GetMonsterCount()
    for i = 1, nMonsterCount do
        local nMontserid = self:GetMonsterObjID(i)
        if nNpcId == nMontserid and self:LuaFnIsCharacterLiving(nMontserid) then
            bOk = 1
        end
    end
    if bOk == 0 then
        self:TipAllHuman("守护僧死亡，挑战失败")
        local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
        for i = 1, nHumanNum do
            local nPlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
            self:KickOut(nPlayerId)
        end
    end
    if TickCount >= nLastTime - 20 then
        nNpcId = self:LuaFnGetCopySceneData_Param(15)
        bOk = 0
        nMonsterCount = self:GetMonsterCount()
        for i = 1, nMonsterCount do
            local nMontserid = self:GetMonsterObjID(i)
            if nNpcId == nMontserid and self:LuaFnIsCharacterLiving(nMontserid) then
                bOk = 1
            end
        end
        if bOk == 1 and NndTime == 0 then
            local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
            if nHumanNum < 1 then
                return
            end
            self:TipAllHuman("藏经阁挑战成功！")
            self:LuaFnSetCopySceneData_Param(21, 1)
            local nLeaderId = 0
            for i = 1, nHumanNum do
                local nPlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
                if self:GetTeamLeader(nPlayerId) == nPlayerId then
                    nLeaderId = nPlayerId
                end
            end
            if nLeaderId == 0 then
                return
            end
            local szLeaderName = self:GetName(nLeaderId)
            local str = string.format("#G藏经阁内#P，#{_INFOUSR%s}#P带领众江湖好汉挫败了恶僧盗取少林绝技的阴谋，将恶僧偷盗的秘笈完璧归赵。真是武林豪杰的典范啊！！", szLeaderName)
            str = gbk.fromutf8(str)
            self:BroadMsgByChatPipe(nLeaderId, str, 4)
        end
    end
    if TickCount == nLastTime - 15 then
        self:TipAllHuman("副本将在15秒后关闭。")
    end
    if TickCount == nLastTime - 10 then
        self:TipAllHuman("副本将在10秒后关闭。")
    end
    if TickCount == nLastTime - 5 then
        self:TipAllHuman("副本将在5秒后关闭。")
    end
    if TickCount == nLastTime then
        local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
        for i = 1, nHumanNum do
            local nPlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
            self:KickOut(nPlayerId)
        end
    end
end

function FB_cangjinge_FB:OnDie(objId, killerId)
    self:LuaFnSetCopySceneData_Param(2, (self.g_CloseTime - 20))
end

function FB_cangjinge_FB:KickOut(objId)
    local oldsceneId = self:LuaFnGetCopySceneData_Param(3)
    local x = self:LuaFnGetCopySceneData_Param(16)
    local z = self:LuaFnGetCopySceneData_Param(17)
    if self:LuaFnIsObjValid(objId) then
        self:NewWorld(objId, oldsceneId, nil, x, z)
    end
end

function FB_cangjinge_FB:CreateNpcBOSS(fangxiang)
    local Npc = self.g_MonsterInfo_1
    if fangxiang == 1 then
        Npc = self.g_MonsterInfo_2
    end
    for i = 1, self.g_XiaoGuaiCount do
        local nNpcId = self:CreateNpc(Npc["id"], Npc["x"], Npc["z"], Npc["ai"], Npc["ai_f"], -1)
        if nNpcId > 0 then
            self:SetUnitCampID(nNpcId, 101)
            self:SetMonsterFightWithNpcFlag(nNpcId, 1)
            self:SetPatrolId(nNpcId, Npc["p"])
        end
    end
end

function FB_cangjinge_FB:CreateXiaoBOSS(fangxiang)
    if fangxiang == 0 then
        local nMonsterIda = self:LuaFnCreateMonster(13579, 23, 47, 9, -1, -1)
        self:SetUnitCampID(nMonsterIda, 101)
        self:SetMonsterFightWithNpcFlag(nMonsterIda, 1)
        self:SetPatrolId(nMonsterIda, 0)
    else
        local nMonsterIdb = self:LuaFnCreateMonster(13579, 103, 48, 9, -1, -1)
        self:SetUnitCampID(nMonsterIdb, 101)
        self:SetMonsterFightWithNpcFlag(nMonsterIdb, 1)
        self:SetPatrolId(nMonsterIdb, 1)
    end
end

function FB_cangjinge_FB:CreateNpc(NpcId, x, y, Ai, AiFile, Script)
    local PlayerLevel = self:LuaFnGetCopySceneData_Param(8)
    local ModifyLevel = self:LuaFnGetCopySceneData_Param(9)
    local nNpcId = 0
    if ModifyLevel >= 11 then
        nNpcId = NpcId + 8
    else
        nNpcId = NpcId + ModifyLevel - 3
    end
    local nMonsterId = self:LuaFnCreateMonster(nNpcId, x, y, Ai, AiFile, Script)
    self:SetLevel(nMonsterId, PlayerLevel)
    return nMonsterId
end

return FB_cangjinge_FB
