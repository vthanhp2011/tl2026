local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local m_repudiate = class("m_repudiate", script_base)
m_repudiate.script_id = 806004
m_repudiate.g_Repudiate = {}

m_repudiate.g_Repudiate["Id"] = 1002
m_repudiate.g_Repudiate["Name"] = "强制离婚"
m_repudiate.g_Repudiate["Skills"] = {
    {133, "一级夫妻技能"},
    {134, "二级夫妻技能"},
    {135, "三级夫妻技能"},
    {136, "四级夫妻技能"},
    {137, "五级夫妻技能"},
    {138, "六级夫妻技能"},
    {139, "七级夫妻技能"},
    {140, "八级夫妻技能"},
    {141, "九级夫妻技能"}
}

m_repudiate.g_msg_rep = {}

m_repudiate.g_msg_rep["mar"] = "  你没有结婚，就想离婚么？"
m_repudiate.g_msg_rep["gld"] = "  需要携带#{_EXCHG200000}才能离婚。"
function m_repudiate:OnDefaultEvent(selfId, targetId, index)
    if self:CheckAccept(selfId, targetId) == 0 then
        return 0
    end
    if index == 1 then
        self:OnAccept(selfId)
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return 1
    end
    if index == 2 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return 1
    end
    self:OnSubmit(selfId, targetId)
    return 1
end

function m_repudiate:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:LuaFnIsMarried(selfId) then
        caller:AddNumTextWithTarget(self.script_id, self.g_Repudiate["Name"], 6, -1)
    end
end

function m_repudiate:CheckAccept(selfId, targetId)
    if not self:LuaFnIsMarried(selfId) then
        self:MessageBox(selfId, targetId, self.g_msg_rep["mar"])
        return 0
    end
    local nMoneyJZ = self:GetMoneyJZ(selfId)
    local nMoneyJB = self:LuaFnGetMoney(selfId)
    local nMoneySelf = nMoneyJZ + nMoneyJB
    if nMoneySelf < 200000 then
        self:MessageBox(selfId, targetId, self.g_msg_rep["gld"])
        return 0
    end
    return 1
end

function m_repudiate:OnSubmit(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  你确定要强制离婚吗？离婚后，夫妻双方的友好度将降至10，同时所学的夫妻技能将会全部清空。#r要求强制离婚的一方需要花费#{_EXCHG200000}")
    self:AddNumText("是", 6, 1)
    self:AddNumText("否", 8, 2)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function m_repudiate:OnAccept(selfId)
    if self:LuaFnIsPasswordSetup(selfId, 0) then
        if not self:LuaFnIsPasswordUnlocked(selfId, 1) then
            return
        end
    end
    self:LuaFnCostMoneyWithPriority(selfId, 200000)
    local SpouseGUID = self:LuaFnGetSpouseGUID(selfId)
    self:LuaFnSetFriendPointByGUID(selfId, SpouseGUID, 10)
    self:LuaFnAwardSpouseTitle(selfId, "")
    self:DispatchAllTitle(selfId)
    for _, skillId in pairs(self.g_Repudiate["Skills"]) do
        self:DelSkill(selfId, skillId[1])
    end
    local NewSkill = {123, 124, 125, 126, 127, 128, 129, 130, 131, 132}
    for _, skillId in pairs(NewSkill) do
        self:DelSkill(selfId, skillId)
    end
    for _, skillId in pairs({142, 143, 144, 145, 146}) do
        self:DelSkill(selfId, skillId)
    end
    local SpouseName = self:LuaFnGetFriendName(selfId, SpouseGUID)
    local selfName = self:LuaFnGetName(selfId)
    self:LuaFnSendSystemMail(SpouseName, selfName .. "已选择了与你强制离婚了，唉，随缘吧。由于婚姻破裂，你所学夫妻技能已全部清空。")
    self:CallScriptFunction(250036, "OnAbandon", selfId)
    self:CallScriptFunction(250037, "OnAbandon", selfId)
    self:LuaFnSendScriptMail(SpouseName, ScriptGlobal.MAIL_REPUDIATE, self:LuaFnGetGUID(selfId), 0, 0)
    self:LuaFnDivorce(selfId)
end

function m_repudiate:MessageBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return m_repudiate
