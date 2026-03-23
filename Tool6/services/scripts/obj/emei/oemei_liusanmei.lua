local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oemei_liusanmei = class("oemei_liusanmei", script_base)
oemei_liusanmei.script_id = 015035
function oemei_liusanmei:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("峨嵋山自古都以猿猱为名，最近这些恶猿闹得越来越不成话，竟然来本派胡闹，你愿意试试去击退它们吗？")
    self:AddNumText("去击退猿猱", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oemei_liusanmei:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 21 then
            self:BeginEvent(self.script_id)
            local strText = "可不要小看这些恶猿，我看你还是等级超过21级再来找我吧。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 145, 89, 142)
        end
    end
end

return oemei_liusanmei
