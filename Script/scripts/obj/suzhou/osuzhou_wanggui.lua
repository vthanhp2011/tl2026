local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_wanggui = class("osuzhou_wanggui", script_base)
function osuzhou_wanggui:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  楚大人，这次的配方比例应该没有错了吧？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_wanggui
