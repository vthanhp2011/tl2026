local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oliaoxi_zhouyou = class("oliaoxi_zhouyou", script_base)
oliaoxi_zhouyou.script_id = 021009
function oliaoxi_zhouyou:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    朋友，这银皑雪原上的怪物个个都拥有寒冰神力，只有#G冰抗#W足够高才能在这里横行无忌。在下可以帮你提升一些冰抗，但更多的冰抗还需要你自己来努力。")
    self:AddNumText("提升一些冰抗", 6, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oliaoxi_zhouyou:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 153, 0)
    end
end

return oliaoxi_zhouyou
