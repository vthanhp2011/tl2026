local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_baobutong = class("osuzhou_baobutong", script_base)
function osuzhou_baobutong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  非也非也，应该是“平芜尽处是春山，行人更在春山外。”才对。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_baobutong
