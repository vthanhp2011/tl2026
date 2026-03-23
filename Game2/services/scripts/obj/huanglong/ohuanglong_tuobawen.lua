local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ohuanglong_tuobawen = class("ohuanglong_tuobawen", script_base)
function ohuanglong_tuobawen:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  夕颜那天去北边的树林了，她做的事情，我都看到了……可是，如果把这件事情告诉慕容长老，他一定会处死夕颜的……我该怎麽办……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ohuanglong_tuobawen
