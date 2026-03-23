local class = require "class"
local define = require "define"
local script_base = require "script_base"
local wuyong = class("wuyong", script_base)
wuyong.script_id = 892015
wuyong.g_MonsterId = 13552
wuyong.g_CreateId = 13456
wuyong.g_posX = 35
wuyong.g_posY = 42
wuyong.g_AIScript = 258
wuyong.g_Title = "天机星"
function wuyong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("生死擂台不是这么好闯的，每战胜副本内每一个BOSS，都可以获得高级神秘物品，要注意危险哦!")
    self:AddNumText("#c00ff00决战 吴永？", 6, 200)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function wuyong:OnEventRequest(selfId, targetId, arg, index)
    local nkey = self:LuaFnGetCopySceneData_Param(29)
    if index == 200 then
        if self:GetTeamLeader(selfId) ~= selfId then
            self:BeginEvent(self.script_id)
            self:AddText("#{PMF_20080521_07}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local nCount = self:GetMonsterCount()
        for i = 1, nCount do
            local nObjId = self:GetMonsterObjID(i)
            local MosDataID = self:GetMonsterDataID(nObjId)
            if MosDataID == self.g_CreateId - nkey then
                self:BeginEvent(self.script_id)
                self:AddText("#G您的队伍已经开始战斗了，请不要重复刷怪！")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
                return
            end
        end
        self:CallScriptFunction(self.g_scriptId, "TipAllHuman", "战斗开始")
        local nMonsterNum = self:GetMonsterCount()
        local Monsters = self.g_MonsterId
        for i = 1, nMonsterNum do
            local MonsterId = self:GetMonsterObjID(i)
            if Monsters == self:GetMonsterDataID(MonsterId) then
                self:LuaFnSendSpecificImpactToUnit(MonsterId, MonsterId, MonsterId, 152, 0)
                self:SetCharacterDieTime(MonsterId, 1000)
            end
        end
        local posX = self.g_posX
        local posY = self.g_posY
        local AIScript = self.g_AIScript
        local Title = self.g_Title
        local MstId = self:LuaFnCreateMonster(self.g_CreateId - nkey, posX, posY, 27, AIScript, 892009)
        self:SetMonsterFightWithNpcFlag(MstId, 0)
        self:SetUnitReputationID(selfId, MstId, 29)
        self:SetNPCAIType(MstId, 1)
        if Title ~= "" then
            self:SetCharacterTitle(MstId, Title)
        end
        self:LuaFnSendSpecificImpactToUnit(MstId, MstId, MstId, 152, 0)
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
end

function wuyong:TipAllHuman(Str)
    local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
    for i = 1, nHumanNum do
        local PlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
        if self:LuaFnIsObjValid(PlayerId) and self:LuaFnIsCanDoScriptLogic(PlayerId) then
            self:BeginEvent(self.script_id)
            self:AddText(Str)
            self:EndEvent()
            self:DispatchMissionTips(PlayerId)
        end
    end
end

return wuyong
