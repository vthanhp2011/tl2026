local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omingjiao_shigang = class("omingjiao_shigang", script_base)
omingjiao_shigang.script_id = 011035
function omingjiao_shigang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("官兵又来围剿光明殿，真是麻烦，不过来的都是些无名小卒，你愿意去练练拳脚吗？")
    self:AddNumText("去抵挡围剿", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function omingjiao_shigang:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 31 then
            self:BeginEvent(self.script_id)
            local strText = "虽是无名小卒，也不可小觎，你还不到31级，为了你的安全依我看，还是练练再来吧。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 141, 97, 157)
        end
    end
end

return omingjiao_shigang
