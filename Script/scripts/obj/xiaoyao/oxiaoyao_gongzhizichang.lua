local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_gongzhizichang = class("oxiaoyao_gongzhizichang", script_base)
oxiaoyao_gongzhizichang.script_id = 014035
function oxiaoyao_gongzhizichang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("最近我无意中找到了本巧匠的奇书，依书所为，竟然做成了天机傀儡。它们功能非常，似乎还能思考，想去见识见识么？")
    self:AddNumText("去见识天机傀儡", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxiaoyao_gongzhizichang:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 81 then
            self:BeginEvent(self.script_id)
            local strText = "不要太小看我公冶子长的技艺，等级达不到81级，我是不会让你见天机傀儡的。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 144, 51, 129)
        end
    end
end

return oxiaoyao_gongzhizichang
