local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_dizi_2 = class("otianlong_dizi_2", script_base)
function otianlong_dizi_2:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我是大理派弟子。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_dizi_2
