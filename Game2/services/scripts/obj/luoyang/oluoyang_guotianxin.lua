local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_guotianxin = class("oluoyang_guotianxin", script_base)
function oluoyang_guotianxin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  最近将有水星淩日的神奇天象出现，有空去看看吧。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_guotianxin
