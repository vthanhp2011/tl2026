local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_jinliuye = class("oluoyang_jinliuye", script_base)
oluoyang_jinliuye.script_id = 181000
oluoyang_jinliuye.g_gotoact = 2
oluoyang_jinliuye.g_YBBTIntro = 11
oluoyang_jinliuye.g_leave = 20
function oluoyang_jinliuye:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  欢迎光临，一看您就是贵客，我已经通知总部那边做好接待工作了，您现在就要去我们的总部吗？")
    self:AddNumText("前往钱庄总部", 9, oluoyang_jinliuye.g_gotoact)
    self:AddNumText("元宝摆摊介绍", 11, oluoyang_jinliuye.g_YBBTIntro)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_jinliuye:OnEventRequest(selfId, targetId, arg, index)
    if index == oluoyang_jinliuye.g_gotoact then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 181, 65, 62)
    elseif index == oluoyang_jinliuye.g_YBBTIntro then
        self:BeginEvent(self.script_id)
        self:AddText("#{YBBT_081023_2}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif index == oluoyang_jinliuye.g_leave then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
end

return oluoyang_jinliuye
