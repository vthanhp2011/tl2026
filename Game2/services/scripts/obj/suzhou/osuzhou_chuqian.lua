local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_chuqian = class("osuzhou_chuqian", script_base)
function osuzhou_chuqian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  上有天堂，下有苏杭。苏州的美景，你可曾见识过？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_chuqian
