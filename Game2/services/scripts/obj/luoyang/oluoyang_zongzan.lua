local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zongzan = class("oluoyang_zongzan", script_base)
function oluoyang_zongzan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  大宋在上届蹴鞠大赛上拿了冠军，这次该我们吐蕃拿冠军了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_zongzan
