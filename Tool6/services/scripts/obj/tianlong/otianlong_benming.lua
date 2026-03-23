local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_benming = class("otianlong_benming", script_base)
otianlong_benming.script_id = 013035
function otianlong_benming:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("老僧最近参破了寒玉塔上的玄机，了因了果，无名无相，你想挑战传说中的魔道傀儡帝吗？")
    self:AddNumText("去大战傀儡", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function otianlong_benming:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 91 then
            self:BeginEvent(self.script_id)
            local strText = "这个施主等级不到91级，进到幻境恐怕危险之极啊。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 143, 95, 134)
        end
    end
end

return otianlong_benming
