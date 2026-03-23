local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianshan_dengpo = class("otianshan_dengpo", script_base)
otianshan_dengpo.script_id = 017035
function otianshan_dengpo:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我天山一向与那些雪怪井水不犯河水，可是这些家伙越来越暴虐，姥姥用了计谋将它们引到了灵鹫峰上，现在就看你的了。")
    self:AddNumText("去歼灭雪怪", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function otianshan_dengpo:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 61 then
            self:BeginEvent(self.script_id)
            local strText = "这些雪怪力大无穷，你等级不到61级，这样带你去，实在是危险。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 147, 94, 145)
        end
    end
end

return otianshan_dengpo
