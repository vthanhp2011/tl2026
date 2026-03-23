local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianshan_dizi_4 = class("otianshan_dizi_4", script_base)
function otianshan_dizi_4:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我是天山派弟子。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianshan_dizi_4
