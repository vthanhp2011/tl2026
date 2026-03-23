local class = require "class"
local define = require "define"
local script_base = require "script_base"
local edali_0239 = class("edali_0239", script_base)
edali_0239.script_id = 210239
edali_0239.g_Position_X = 160.0895
edali_0239.g_Position_Z = 156.9309
edali_0239.g_SceneID = 2
edali_0239.g_AccomplishNPC_Name = "赵天师"
edali_0239.g_MissionId = 719
edali_0239.g_MissionIdPer = 718
edali_0239.g_Name = "赵天师"
edali_0239.g_MissionKind = 13
edali_0239.g_MissionLevel = 10
edali_0239.g_IfMissionElite = 0
edali_0239.g_MissionName = "名门正派"
edali_0239.g_MissionInfo = ""
edali_0239.g_MissionInfo1 = "    $N，你终于来了。#r    不错不错，你现在的根基已经打得相当扎实，去十大门派学习高深武功已经是顺理成章之事了。"
edali_0239.g_MissionInfo2 = "    对，你没有听错，就是传说中的十大门派。星宿派是西域大宗，天山派是西北奇葩，天龙派是天南支柱，逍遥派神出鬼没，峨嵋派万佛朝宗，武当派道骨仙风，明教是天下第一大教，丐帮是天下第一大帮，少林派更是天下武林的泰山北斗。"
edali_0239.g_MissionInfo3 = "    无论你拜入了哪一个门派，都是踏上了一条金光大道啊，我们老哥儿几个脸上都有光啊。"
edali_0239.g_MissionInfo4 = "    这样吧，你去找十大门派的收录人聊聊，听他们讲讲各大门派的特色，然后选择一个门派加入。等你成为了十大门派的弟子，你再来找我，我们会给你开一个庆功宴的。"
edali_0239.g_MissionTarget = "#{MIS_dali_ZTS_001}"
edali_0239.g_ContinueInfo = "    已经成为十大门派的弟子了吗？"
edali_0239.g_MissionComplete = "    看来你已经选好了正确的人生道路，向着未来奔跑吧！"
edali_0239.g_ItemBonus = {}
edali_0239.g_IsMissionOkFail = 0
edali_0239.g_Custom = { { ["id"] = "已加入门派", ["num"] = 1 }
}
function edali_0239:GetExpByMenpaiIndex(MenPaiIndex)
    local ReturnVal = 0
    if (0 == MenPaiIndex) then
        ReturnVal = 3000
    end
    if (1 == MenPaiIndex) then
        ReturnVal = 2900
    end
    if (2 == MenPaiIndex) then
        ReturnVal = 2600
    end
    if (3 == MenPaiIndex) then
        ReturnVal = 2500
    end
    if (4 == MenPaiIndex) then
        ReturnVal = 2200
    end
    if (5 == MenPaiIndex) then
        ReturnVal = 2000
    end
    if (6 == MenPaiIndex) then
        ReturnVal = 1200
    end
    if (7 == MenPaiIndex) then
        ReturnVal = 1000
    end
    if (8 == MenPaiIndex) then
        ReturnVal = 900
    end
    if (10 == MenPaiIndex) then
        ReturnVal = 800
    end
    return ReturnVal
end
function edali_0239:GetMenpaiName(Menpai)
    local Name = "无门派"
    if (0 == Menpai) then
        Name = "少林派"
    elseif (1 == Menpai) then
        Name = "明教"
    elseif (2 == Menpai) then
        Name = "丐帮"
    elseif (3 == Menpai) then
        Name = "武当派"
    elseif (4 == Menpai) then
        Name = "峨嵋派"
    elseif (5 == Menpai) then
        Name = "星宿派"
    elseif (6 == Menpai) then
        Name = "天龙派"
    elseif (7 == Menpai) then
        Name = "天山派"
    elseif (8 == Menpai) then
        Name = "逍遥派"
    elseif (10 == Menpai) then
        Name = "曼陀山庄"
    end
    return Name
end
function edali_0239:MenpaiSort()
    local MenpaiArray = {}
    local ZeroCount = 0
    for i = 1, 10 do
        MenpaiArray[i] = 0
        if (0 == MenpaiArray[i]) then
            ZeroCount = ZeroCount + 1
        end
    end
    if (9 == ZeroCount) then
        MenpaiArray[1] = 6
        MenpaiArray[2] = 2
        MenpaiArray[3] = 7
        MenpaiArray[4] = 5
        MenpaiArray[5] = 8
        MenpaiArray[6] = 0
        MenpaiArray[7] = 3
        MenpaiArray[8] = 4
        MenpaiArray[9] = 1
        MenpaiArray[10] = 10
    end
    return MenpaiArray
end

function edali_0239:OnDefaultEvent(selfId, targetId)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_ContinueInfo)
        self:EndEvent()
        local bDone = self:CheckSubmit(selfId)
        self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, self.g_MissionId, bDone)
    elseif self:CheckAccept(selfId) > 0 then
        local MenpaiArray = self:MenpaiSort()
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionInfo1)
        self:AddText(self.g_MissionInfo2)
        self:AddText(self.g_MissionInfo3)
        self:AddText(self.g_MissionInfo4)
        self:AddText("#{M_MUBIAO}#r" .. self.g_MissionTarget)
        self:EndEvent()
        self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, self.g_MissionId, 0)
        self:DirectAccept(selfId, MenpaiArray)
    end
end

function edali_0239:DirectAccept(selfId, MenpaiArray)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    end
    local ret = self:AddMission(selfId, self.g_MissionId, self.script_id, 1, 0, 0)
    if not ret then
        self:Msg2Player(selfId, "#Y你的任务日志已经满了", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        return
    end
    self:Msg2Player(selfId, "接受任务:#Y" .. self.g_MissionName, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local misIndex = self:GetMissionIndexByID(selfId, 719)
    local Menpai = self:GetMenPai(selfId)
    if (Menpai >= 0 and Menpai < 9) or Menpai == 10 then
        self:SetMissionByIndex(selfId, misIndex, 1, 1)
        self:SetMissionByIndex(selfId, misIndex, 0, 1)
    end
end

function edali_0239:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        local bDone = self:CheckSubmit(selfId)
        if (1 == bDone) then
            caller:AddNumTextWithTarget(self.script_id,self.g_MissionName, 2, -1)
        else
            caller:AddNumTextWithTarget(self.script_id,self.g_MissionName, 1, -1)
        end
    elseif self:CheckAccept(selfId) > 0 then
        caller:AddNumTextWithTarget(self.script_id,self.g_MissionName, 1, -1)
    end
end

function edali_0239:CheckAccept(selfId)
    if not self:IsMissionHaveDone(selfId, self.g_MissionIdPer) then
        return 0
    end
    return 1
end

function edali_0239:OnAccept(selfId)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    end
    local ret = self:AddMission(selfId, self.g_MissionId, self.script_id, 1, 0, 0)
    if not ret then
        self:Msg2Player(selfId, "#Y你的任务日志已经满了", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        return
    end
    self:Msg2Player(selfId, "接受任务:#Y" .. self.g_MissionName, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local misIndex = self:GetMissionIndexByID(selfId, 719)
    local Menpai = self:GetMenPai(selfId)
    if (Menpai >= 0 and Menpai < 9) or Menpai == 10 then
        self:SetMissionByIndex(selfId,misIndex,1,1)
        self:SetMissionByIndex(selfId,misIndex,0,1)
    end
end

function edali_0239:OnAbandon(selfId)
    self:DelMission(selfId, self.g_MissionId)
end

function edali_0239:OnContinue(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_MissionName)
    self:AddText(self.g_MissionComplete)
    for i, item in pairs(self.g_ItemBonus) do
        self:AddItemBonus(item["id"], item["num"])
    end
    self:EndEvent()
    self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
end

function edali_0239:CheckSubmit(selfId)
    local MenPai = self:GetMenPai(selfId)
    if (MenPai == 9) then
        return 0
    end
    if (MenPai < 0) then
        return 0
    end
    return 1
end

function edali_0239:OnSubmit(selfId, targetId, selectRadioId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then
        return
    end
    if self:CheckSubmit(selfId) <= 0 then
        return
    end
    local nPlayerExp = 1000
    self:AddExp(selfId, nPlayerExp)
    self:DelMission(selfId, self.g_MissionId)
    self:MissionCom(selfId, self.g_MissionId)
end

function edali_0239:OnKillObject(selfId, objdataId, objId)
end

function edali_0239:OnEnterArea(selfId, zoneId)
end

function edali_0239:OnItemChanged(selfId, itemdataId)
end

return edali_0239