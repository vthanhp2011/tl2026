local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_liujinchan = class("osuzhou_liujinchan", script_base)
function osuzhou_liujinchan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  有个来苏州考试的考生叫颜查散，他真好玩。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_liujinchan
