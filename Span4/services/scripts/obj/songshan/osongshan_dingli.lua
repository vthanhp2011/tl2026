local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osongshan_dingli = class("osongshan_dingli", script_base)
function osongshan_dingli:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  听说太老爷还活着，怎么可能呢？当年太老爷去世的时候，我亲眼所见啊，这世上真会发生这种事情吗？太不可思议了……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osongshan_dingli
