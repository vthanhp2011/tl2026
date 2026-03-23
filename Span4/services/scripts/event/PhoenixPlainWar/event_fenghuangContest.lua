local class = require "class"
local define = require "define"
local script_base = require "script_base"
local event_fenghuangContest = class("event_fenghuangContest", script_base)
local gbk = require "gbk"

event_fenghuangContest.script_id = 403006

event_fenghuangContest.g_BigBox =
{ 
    ["Name"] = "凤凰战旗",
    ["MonsterID"] = 14012,
    ["PosX"] = 162,
    ["PosY"] = 161,
    ["ScriptID"] = 403006
}
event_fenghuangContest.g_LimitiBuff = {50,112,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,1090,1709,1710,1711,1712,1713,1714,1715,1716,1717,1718,1719,1720,7084,7085}

function event_fenghuangContest:OnTimer(actId, uTime)
    --判断凤凰古城争夺战是否进行中
    local is_open = self:LuaFnGetCopySceneData_Param(21) or 0
    if is_open < 1 then
        return
    end
    --场景内存在战旗不重复刷新
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum do
        local MonsterId = self:GetMonsterObjID(i)
        local MosDataID = self:GetMonsterDataID(MonsterId)
        if MosDataID == self.g_BigBox["MonsterID"] then
            return
        end
    end
    --记录战旗是否有归属玩家
    if self:LuaFnGetCopySceneData_Param(31) > 0 then
        return
    end
    --记录战旗是否正在刷新中
    if self:LuaFnGetCopySceneData_Param(30) > 0 then
        return
    end
    local MstId = self:LuaFnCreateMonster(self.g_BigBox["MonsterID"], self.g_BigBox["PosX"], self.g_BigBox["PosY"], 3, 0,self.g_BigBox["ScriptID"])
    if MstId > 0 then
        self:MonsterTalk(-1,"凤凰平原", "#{FHZD_090708_67}")
        self:HumanTips("#{FHZD_090708_67}")
        self:SetCharacterName(MstId, self.g_BigBox["Name"])
    end
end

function event_fenghuangContest:OnDefaultEvent(actId, param1, param2, param3, param4, param5)
    self:StartOneActivity(actId, 100 * 10, param1)
end

function event_fenghuangContest:OnBigBoxOpen(selfId, activatorId)
    local LeagueId = self:LuaFnGetHumanGuildLeagueID(activatorId)
    local LeagueName = self:LuaFnGetHumanGuildLeagueName(activatorId)
    self:LuaFnSendSpecificImpactToUnit(activatorId, activatorId, activatorId, 3019, 0)
    local Name = self:GetName(activatorId)
    local sMessage = ""
    sMessage = string.format("#{_INFOUSR%s}#W力挽狂澜，在乱军之中拔起凤凰战旗。",Name)
    self:MonsterTalk(-1,"凤凰平原",sMessage)
    self:HumanTips(string.format("%s的%s拔起了凤凰战旗。",LeagueName,Name))
    sMessage = string.format("@*;SrvMsg;GLL:#Y凤凰古城战况：#{_INFOUSR%s}#W力挽狂澜，在乱军之中拔起凤凰战旗。",Name)
    self:BroadMsgByChatPipe(activatorId,gbk.fromutf8(sMessage), 12)
    self:LuaFnGmKillObj(selfId, activatorId)
    self:LuaFnDeleteMonster(selfId)
    self:LuaFnSetCopySceneData_Param(31,activatorId)
end
function event_fenghuangContest:OnActivateConditionCheck(selfId,activatorId)
    local strText = "当前状态无法开启"
    if self:LuaFnIsUnbreakable(activatorId) then
        self:BeginEvent(self.script_id)
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(activatorId)
        return 0
    end

    if self:LuaFnIsConceal(activatorId) then
        self:BeginEvent(self.script_id)
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(activatorId)
        return 0
    end
    for i,impactId in pairs(self.g_LimitiBuff) do
        if self:LuaFnHaveImpactOfSpecificDataIndex(activatorId,impactId) then
            self:BeginEvent(self.script_id)
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(activatorId)
            return 0
        end
    end
    return 1
end

function event_fenghuangContest:OnActivateDeplete(selfId,activatorId)
    return 1
end

function event_fenghuangContest:OnActivateEffectOnce(selfId,activatorId)
    self:OnBigBoxOpen(selfId,activatorId)
    return 1
end

function event_fenghuangContest:OnActivateEffectEachTick(selfId,activatorId)
    return 1
end

function event_fenghuangContest:OnActivateActionStart(selfId,activatorId)
    return 1
end

function event_fenghuangContest:OnActivateCancel(selfId,activatorId)
    return 0
end

function event_fenghuangContest:OnActivateInterrupt(selfId,activatorId)
    return 0
end
function event_fenghuangContest:HumanTips(str)
    local nHumanCount = self:LuaFnGetCopyScene_HumanCount()
    for i = 1, nHumanCount do
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

return event_fenghuangContest
