local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_weihanjin = class("osuzhou_weihanjin", script_base)
function osuzhou_weihanjin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  苏学士，琴声不在琴上，不在指上，而在心中。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_weihanjin
