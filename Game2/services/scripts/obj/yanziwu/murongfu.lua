local class = require "class"
local define = require "define"
local script_base = require "script_base"
local murongfu = class("murongfu", script_base)
murongfu.TBL = {
    ["IDX_TimerPrepare"] = 1,
    ["IDX_TimerInterval"] = 2,
    ["IDX_FlagCombat"] = 1,
    ["BossSkill"] = 1002,
    ["PrepareTime"] = 60000,
    ["SkillInterval"] = 60000,
    ["BossBuff"] = 9998
}
murongfu.g_bWangyuyanSpeak = 24
murongfu.g_DuanAndWangFlag = 29
function murongfu:OnDie(selfId, killerId)
    self:LuaFnNpcChat(selfId, 0, "难道我大燕的复国霸业，终究只是黄粱一梦？")
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"], 0)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 0)
    self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 0)
    self:LuaFnSetCopySceneData_Param(self.g_DuanAndWangFlag, 0)
    self:CallScriptFunction((401040), "ClearMonsterByName", "王语嫣")
    self:CallScriptFunction((401040), "ClearMonsterByName", "段誉")
    self:CallScriptFunction((401040), "ClearMonsterByName", "巴天石")
    self:CallScriptFunction((401040), "ClearMonsterByName", "范骅")
    self:CallScriptFunction((401040), "ClearMonsterByName", "褚万里")
    self:CallScriptFunction((401040), "ClearMonsterByName", "古笃诚")
    self:CallScriptFunction((401040), "ClearMonsterByName", "傅思归")
    self:CallScriptFunction((401040), "ClearMonsterByName", "朱丹臣")
    self:TipAllHuman("慕容复已被打败，讨伐燕子坞成功，请从出口回到太湖。")
    local playerID = killerId
    local objType = self:GetCharacterType(killerId)
    if objType == "pet" then playerID = self:GetPetCreator(killerId) end
    local nLeaderId = self:GetTeamLeader(playerID)
    if nLeaderId < 1 then nLeaderId = playerID end
    local str = ""
    local ran = math.random(3)
    if ran == 1 then
        str = string.format("#W#{_INFOUSR%s}#P与#{_BOSS0}单挑，却暗使队友在其身後砸板砖、使绊子、敲闷棍、洒石灰……无所不用，终於将#{_BOSS0}打得大败，落荒而逃，一举攻下了燕子坞。",  self:GetName(nLeaderId))
    elseif ran == 2 then
        str = string.format("#W#{_INFOUSR%s}#P率领队友与#{_BOSS0}酣战半日，忽而领悟到武学的真谛，顿时武功暴涨，#{_BOSS0}抵敌不过，只得落荒而逃，燕子坞遂陷。", self:GetName(nLeaderId))
    else
        str = string.format("#W#{_INFOUSR%s}#P在燕子坞调兵遣将，运筹帷幄，在使用了瞒天过海，暗渡陈仓等三十六计之後，打得#{_BOSS0}只得使用第三十七计逃之夭夭了。",self:GetName(nLeaderId))
    end
    self:BroadMsgByChatPipe(nLeaderId, str, 4)
end

function murongfu:OnHeartBeat(selfId, nTick)
    if (self:LuaFnIsCharacterLiving(selfId)) then
        if (1 == self:MonsterAI_GetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"])) then
            if self:LuaFnGetCopySceneData_Param(self.g_bWangyuyanSpeak) == 0 then
                if self:GetHp(selfId) * 2 <= self:GetMaxHp(selfId) then
                    self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 1)
                end
            end
        end
    end
end

function murongfu:OnInit(selfId)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"], 0)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 0)
end

function murongfu:OnKillCharacter(selfId, targetId) end

function murongfu:OnEnterCombat(selfId, enmeyId)
    if (0 < self.TBL["BossBuff"]) then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, self.TBL["BossBuff"], 0)
    end
    self:LuaFnNpcChat(selfId, 0, "无名鼠辈，安敢坏我复国大计！真是找死！")
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"], self.TBL["PrepareTime"])
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 1)
    self:CallScriptFunction((200060), "Paopao", "段誉", "燕子坞", "王姑娘，你看这里兵马凶险，不如我护着你先走好吗？")
    self:CallScriptFunction((200060), "Paopao", "王语嫣", "燕子坞", "表哥不走，我也不会走的，我要留下来帮表哥。")
end

function murongfu:OnLeaveCombat(selfId)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerPrepare"], 0)
    self:MonsterAI_SetIntParamByIndex(selfId, self.TBL["IDX_TimerInterval"], 0)
    self:MonsterAI_SetBoolParamByIndex(selfId, self.TBL["IDX_FlagCombat"], 0)
    self:CallScriptFunction((401040), "ClearMonsterByName", "王语嫣")
    self:CallScriptFunction((401040), "ClearMonsterByName", "段誉")
    self:CallScriptFunction((401040), "ClearMonsterByName", "巴天石")
    self:CallScriptFunction((401040), "ClearMonsterByName", "范骅")
    self:CallScriptFunction((401040), "ClearMonsterByName", "褚万里")
    self:CallScriptFunction((401040), "ClearMonsterByName", "古笃诚")
    self:CallScriptFunction((401040), "ClearMonsterByName", "傅思归")
    self:CallScriptFunction((401040), "ClearMonsterByName", "朱丹臣")
    self:CallScriptFunction((401040), "CreateMonster_11")
    self:LuaFnSetCopySceneData_Param(self.g_bWangyuyanSpeak, 0)
    self:LuaFnSetCopySceneData_Param(self.g_DuanAndWangFlag, 0)
end

function murongfu:TipAllHuman(Str)
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

return murongfu
