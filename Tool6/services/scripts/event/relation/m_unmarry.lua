local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local m_unmarry = class("m_unmarry", script_base)
m_unmarry.script_id = 806005
m_unmarry.g_Unmarry = {}

m_unmarry.g_Unmarry["Id"] = 1001
m_unmarry.g_Unmarry["Name"] = "离婚"
m_unmarry.g_Unmarry["Skills"] = {
    {260, "一级夫妻技能"},
    {261, "二级夫妻技能"},
    {262, "三级夫妻技能"},
    {263, "四级夫妻技能"},
    {264, "五级夫妻技能"},
    {265, "六级夫妻技能"},
    {266, "七级夫妻技能"},
    {267, "八级夫妻技能"},
    {268, "九级夫妻技能"}
}

m_unmarry.g_msg_unm = {}

m_unmarry.g_msg_unm["tem"] = "  如果想离婚，请男女双方2人组成一队再来找我。"
m_unmarry.g_msg_unm["mar"] = "  你们还没结婚呢？为啥要离婚捏？"
m_unmarry.g_msg_unm["gld"] = "  男方需要携带#{_EXCHG55555}才能离婚。"
m_unmarry.g_msg_unm["ner"] = "  只有2人都走到我身边才可以离婚。"
function m_unmarry:OnDefaultEvent(selfId, targetId, index)
    local tId, male, female = self:CheckAccept(selfId, targetId)
    if tId == 0 or male == 0 or female == 0 then
        return 0
    end
    if index == 1 then
        self:OnAccept(male, female)
        self:MessageBox(tId, targetId, "  对方已经接受了你的离婚请求。")
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return 1
    end
    if index == 2 then
        self:MessageBox(tId, targetId, "  很遗憾，对方没有同意你的请求。")
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return 1
    end
    self:OnSubmit(selfId, targetId, tId)
    return 1
end

function m_unmarry:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:LuaFnIsMarried(selfId) then
        caller:AddNumTextWithTarget(self.script_id, self.g_Unmarry["Name"], 6, -1)
    end
end

function m_unmarry:CheckAccept(selfId, targetId)
    if not self:LuaFnHasTeam(selfId) then
        self:MessageBox(selfId, targetId, self.g_msg_unm["tem"])
        return 0
    end
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        self:MessageBox(selfId, targetId, self.g_msg_unm["tem"])
        return 0
    end
    if self:LuaFnGetTeamSceneMemberCount(selfId) ~= 1 then
        self:MessageBox(selfId, targetId, self.g_msg_unm["tem"])
        return 0
    end
    local selfSex = self:LuaFnGetSex(selfId)
    local tId = self:LuaFnGetTeamSceneMember(selfId, 1)
    local tSex = self:LuaFnGetSex(tId)
    if selfSex == tSex then
        self:MessageBox(selfId, targetId, self.g_msg_unm["mar"])
        return 0
    end
    local male, female
    if selfSex == 1 then
        male = selfId
        female = tId
    else
        male = tId
        female = selfId
    end
    if not self:LuaFnIsSpouses(male, female) then
        self:MessageBox(selfId, targetId, self.g_msg_unm["mar"])
        return 0
    end
    if not self:LuaFnIsCanDoScriptLogic(male) then
        return 0
    end
    if not self:LuaFnIsCanDoScriptLogic(female) then
        return 0
    end
    local nMoneyJZ = self:GetMoneyJZ(male)
    local nMoneyJB = self:LuaFnGetMoney(male)
    local nMoneySelf = nMoneyJZ + nMoneyJB
    if nMoneySelf < 55555 then
        self:MessageBox(selfId, targetId, self.g_msg_unm["gld"])
        return 0
    end
    if not self:IsInDist(selfId, tId, 10) then
        self:MessageBox(selfId, targetId, self.g_msg_unm["ner"])
        return 0
    end
    return tId
end

function m_unmarry:OnSubmit(selfId, targetId, tId)
    local selfName = self:LuaFnGetName(selfId)
    self:BeginEvent(self.script_id)
    self:AddText("  等待对方答复。。。#r  离婚后，夫妻双方的友好度将降至10，同时所学的夫妻技能将会全部清空。#r注意，离婚需要男方花费#{_EXCHG55555}")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  你同意与" .. selfName .. "离婚吗？离婚后，夫妻双方的友好度将降至10，同时所学的夫妻技能将会全部清空。#r注意，离婚需要男方花费#{_EXCHG55555}")
    self:AddNumText("是", 6, 1)
    self:AddNumText("否", 8, 2)
    self:EndEvent()
    self:DispatchEventList(tId, targetId)
end

function m_unmarry:OnAccept(male, female)
    self:LuaFnCostMoneyWithPriority(male, 55555)
    self:LuaFnSetFriendPoint(male, female, 10)
    self:LuaFnSetFriendPoint(female, male, 10)
    self:LuaFnAwardSpouseTitle(female, "")
    self:DispatchAllTitle(female)
    self:LuaFnAwardSpouseTitle(male, "")
    self:DispatchAllTitle(male)
    self:Msg2Player(male, "你恢复单身了。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(male, "失去夫妻称号。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(male, "失去所有夫妻技能。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(female, "你恢复单身了。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(female, "失去夫妻称号。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(female, "失去所有夫妻技能。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    for _, skillId in pairs(self.g_Unmarry["Skills"]) do
        self:DelSkill(male, skillId[1])
        self:DelSkill(female, skillId[1])
    end
    local NewSkill = {250, 251, 252, 253, 254, 255, 256, 257, 258, 259}
    for _, skillId in pairs(NewSkill) do
        self:DelSkill(male, skillId)
        self:DelSkill(female, skillId)
    end
    for _, skillId in pairs({269, 270, 271, 272, 273}) do
        self:DelSkill(male, skillId)
        self:DelSkill(female, skillId)
    end
    self:CallScriptFunction(250036, "OnAbandon", male)
    self:CallScriptFunction(250037, "OnAbandon", male)
    self:CallScriptFunction(250036, "OnAbandon", female)
    self:CallScriptFunction(250037, "OnAbandon", female)
    self:SetMissionData(male, ScriptGlobal.MD_TW_REEXPERIENCE_WEDDING_TOTAL_COUNT, 0)
    self:SetMissionData(female, ScriptGlobal.MD_TW_REEXPERIENCE_WEDDING_TOTAL_COUNT, 0)
    self:LuaFnUnMarry(male, female)
end

function m_unmarry:MessageBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return m_unmarry
