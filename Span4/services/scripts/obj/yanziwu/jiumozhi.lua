local class = require "class"
local define = require "define"
local script_base = require "script_base"
local jiumozhi = class("jiumozhi", script_base)
jiumozhi.TBL = {
    ["IDX_TimerPrepare"] = 1,
    ["IDX_TimerInterval"] = 2,
    ["IDX_FlagCombat"] = 1,
    ["BossSkill"] = 1002,
    ["PrepareTime"] = 60000,
    ["SkillInterval"] = 60000,
    ["BossBuff"] = 9999
}

function jiumozhi:OnDie(selfId)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"], 0)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 0)
    local szNpcName = self:GetName(selfId)
    if szNpcName == "姚伯当" then
        self:LuaFnNpcChat(selfId, 0, "十八年后，爷爷我又是一条好汉！")
        self:ClearMonsterByName("秦家寨亲兵")
        self:TipAllHuman("姚伯当被打败，其手下纷纷四散逃窜。")
    elseif szNpcName == "司马林" then
        self:LuaFnNpcChat(selfId, 0, "十八年后，爷爷我又是一条好汉！")
        self:ClearMonsterByName("青城派弟子")
        self:TipAllHuman("司马林被打败，其手下纷纷四散逃窜。")
    elseif szNpcName == "鸠摩智" then
        self:LuaFnNpcChat(selfId, 0, "想不到中原武林卧虎藏龙，竟有如此高手！")
        self:ClearMonsterByName("吐蕃喇嘛")
        self:ClearMonsterByName("木人傀儡")
        self:TipAllHuman("鸠摩智被打败，其手下纷纷四散逃窜。")
        if self:LuaFnGetCopySceneData_Param(8) == 12 then
            self:LuaFnSetCopySceneData_Param(8, 14)
        end
    end
end

function jiumozhi:OnHeartBeat()
end

function jiumozhi:OnInit(selfId)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"], 0)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 0)
end

function jiumozhi:OnKillCharacter()
end

function jiumozhi:OnEnterCombat(selfId)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"],self.TBL["PrepareTime"])
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 1)
end

function jiumozhi:OnLeaveCombat(selfId)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"], 0)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 0)
end

function jiumozhi:ClearMonsterByName(szName)
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum do
        local nMonsterId = self:GetMonsterObjID(i)
        if self:GetName(nMonsterId) == szName then
            self:LuaFnDeleteMonster(nMonsterId)
        end
    end
end

function jiumozhi:TipAllHuman(Str)
    local nHumanNum = self:LuaFnGetCopyScene_HumanCount()
    if nHumanNum < 1 then return end
    for i = 1, nHumanNum do
        local PlayerId = self:LuaFnGetCopyScene_HumanObjId(i)
        self:BeginEvent(self.script_id)
        self:AddText(Str)
        self:EndEvent()
        self:DispatchMissionTips(PlayerId)
    end
end

return jiumozhi
