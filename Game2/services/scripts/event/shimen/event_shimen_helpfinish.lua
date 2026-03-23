local class = require "class"
local define = require "define"
local script_base = require "script_base"
local event_shimen_helpfinish = class("event_shimen_helpfinish", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
event_shimen_helpfinish.script_id = 229011
function event_shimen_helpfinish:OnDefaultEvent(selfId, targetId, menpaiId, numTextId)
    if numTextId == 1 then
        self:BeginEvent(self.script_id)
        if not self:IsHaveMission(selfId, ScriptGlobal.MENPAI_SHIMEN_MISID[menpaiId + 1]) then
            self:AddText("你好像没有接受师门任务啊。")
        else
            local strText =
            "  光耀师门，人人有责！每日辛勤做师门任务的弟子我们会给予丰厚的奖励的，当然，对做师门任务碰到困难的弟子我们也会倾力协助的。#r  你确定要消耗#G%d点#W师门贡献度，让其他同门师兄和师姐帮你完成当前师门任务吗？"
            strText = string.format(strText, self:GetHelpFinishNeed(selfId))
            self:AddText(strText)
            self:AddNumText("确定", 6, 2)
            self:AddNumText("离开", 8, 3)
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif numTextId == 2 then
        self:CallScriptFunction(ScriptGlobal.MENPAI_SHIMEN_SCRIPTID[menpaiId + 1], "HelpFinishOneHuan", selfId, targetId)
    elseif numTextId == 3 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
end

function event_shimen_helpfinish:OnEnumerate(caller, selfId, targetId, arg, index)
    if arg == self:GetMenPai(selfId) then
        caller:AddNumTextWithTarget(self.script_id,"同门相助", 6, 1)
    end
end

function event_shimen_helpfinish:GetHelpFinishNeed(selfId)
    local level = self:GetLevel(selfId)
    local need = (level - 10) * 0.05 * 20 + 40
    need = need * 0.8
    need = math.floor(need)
    return need
end

function event_shimen_helpfinish:CheckAndDepleteHelpFinishMenPaiPoint(selfId, targetId)
    local needPoint = self:GetHelpFinishNeed(selfId)
    local menpaiPoint = self:GetHumanMenpaiPoint(selfId)
    if menpaiPoint < needPoint then
        self:BeginEvent(self.script_id)
        self:AddText("  你好像没有足够的师门贡献度，多为师门做些贡献，这样其他同门也会全力帮助你的。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return 0
    else
        self:SetHumanMenpaiPoint(selfId, menpaiPoint - needPoint)
        return 1
    end
end

return event_shimen_helpfinish
