local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ogaibang_ouyangguo = class("ogaibang_ouyangguo", script_base)
ogaibang_ouyangguo.script_id = 010035
function ogaibang_ouyangguo:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("那些恶猴一贯进入我们酒窖偷酒，甚是可恶，我们教训过他们几次，竟不知进退的来攻丐帮总舵，要去给他们些颜色吗？")
    self:AddNumText("去抵挡恶猴", 10, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ogaibang_ouyangguo:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetLevel(selfId) < 11 then
            self:BeginEvent(self.script_id)
            local strText = "可不要小看这些恶猴，我看你还是等级超过11级再来找我吧。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, 140, 91, 151)
        end
    end
end

return ogaibang_ouyangguo
