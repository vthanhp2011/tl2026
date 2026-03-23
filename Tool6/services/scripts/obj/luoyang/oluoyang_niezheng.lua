local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local oluoyang_niezheng = class("oluoyang_niezheng", script_base)
oluoyang_niezheng.script_id = 000111
oluoyang_niezheng.g_name = "聂政"
oluoyang_niezheng.g_RelationEventList = {
    806019, 806008, 806009, 806006, 806015, 806018
}

function oluoyang_niezheng:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_niezheng:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{OBJ_luoyang_0030}")
    for i, eventId in pairs(self.g_RelationEventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:AddNumText("我想用善恶点领取经验", 6, 3)
    self:AddNumText("出师", 6, 10)
    self:AddNumText("师徒介绍", 11, 4)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_niezheng:OnEventRequest(selfId, targetId, arg, index)
    local strText
    local nMlevel = self:LuaFnGetmasterLevel(selfId)
    if arg == self.script_id then
        if index == 1 then
            self:BeginEvent(self.script_id)
            self:AddText("#{OBJ_luoyang_0032}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        elseif index == 4 then
            self:BeginEvent(self.script_id)
            self:AddText("#{function_help_050}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        elseif index == 2 then
            self:BeginEvent(self.script_id)
            strText = string.format("  当前师德点数：%d",
                                  self:LuaFnGetMasterMoralPoint(selfId))
            self:AddText(strText)
            strText = string.format("  累积师德点数：%d",
                                  self:LuaFnGetMasterMoralPoint(selfId))
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        elseif index == 10 then
            local HumanLevel = self:LuaFnGetLevel(selfId)
            if HumanLevel < 45 then
                self:MyMsgBox(selfId, targetId, "#{STGZ_20080520_5}")
                return
            end
            if not self:LuaFnHaveMaster(selfId) then
                self:MyMsgBox(selfId, targetId, "#{STGZ_20080520_6}")
                return
            end
            if self:GetMissionFlag(selfId, ScriptGlobal.MF_ShiTu_ChuShi_Flag) == 1 then
                self:MyMsgBox(selfId, targetId, "#{STGZ_20080520_6}")
                return
            end
            self:SetMissionFlag(selfId, ScriptGlobal.MF_ShiTu_ChuShi_Flag, 1)
            self:LuaFnChuShiMail(selfId)
            self:MyMsgBox(selfId, targetId, "#{STGZ_20080520_1}")
            return
        elseif index == 3 then
            if nMlevel < 1 or nMlevel > 4 then
                self:MyMsgBox(selfId, targetId, "  师德等级错误。")
                return
            end
            if self:LuaGetPrenticeSupplyExp(selfId) == 0 then
                self:MyMsgBox(selfId, targetId,
                              "  没有可以领取的经验。")
                return
            end
            self:LuaFnExpAssign(selfId, 1)
            self:BeginUICommand()
            self:UICommand_AddInt(targetId)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 1000)
        elseif index == 123 then
            local HumanLevel = self:LuaFnGetLevel(selfId)
            if HumanLevel < 30 then
                self:MyMsgBox(selfId, targetId, "30级以上才可领取！")
                return
            end
            local nDayTime = self:GetMissionData(selfId, ScriptGlobal.MD_SHITU_XINLIANXIN)
            local nDay = self:LuaFnGetDayOfThisMonth()
            if nDayTime == nDay then
                self:MyMsgBox(selfId, targetId,
                              "对不起，你今天已经参加过此活动了，请明天再来!")
                return
            end
            self:BeginAddItem()
            self:AddItem(30008045, 1)
            if self:EndAddItem(selfId) < 1 then return end
            self:AddItemListToHuman(selfId)
            self:MyMsgBox(selfId, targetId,
                          "我这里有一个师徒大礼包送给你，好好利用吧！")
            self:BeginEvent(self.script_id)
            strText = "你收到一个师徒大礼包！"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            self:SetMissionData(selfId, ScriptGlobal.MD_SHITU_XINLIANXIN, nDay)
            self:AuditJoinJiaoShiJie(selfId)
        elseif index == 321 then
            self:MyMsgBox(selfId, targetId,
                          "一年一度的教师节即将来临啦！所有30级以上的英雄都可以去聂政大理（170，123）处领取师徒大礼包。使用大礼包还会有意外收获哦！")
            return
        end
        return
    end
    for i, findId in pairs(self.g_RelationEventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, index)
            return
        end
    end
end

function oluoyang_niezheng:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_RelationEventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnAccept", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_niezheng:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_RelationEventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_niezheng:MyMsgBox(selfId, targetId, str)
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_niezheng
