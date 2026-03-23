local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianshan_dizi_2 = class("otianshan_dizi_2", script_base)
function otianshan_dizi_2:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我是天山派弟子。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianshan_dizi_2
