local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_chaobuzhi = class("osuzhou_chaobuzhi", script_base)
function osuzhou_chaobuzhi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  张耒兄和贺年兄才华都远在我之上。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_chaobuzhi
