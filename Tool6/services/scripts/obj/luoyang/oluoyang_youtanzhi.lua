local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_youtanzhi = class("oluoyang_youtanzhi", script_base)
function oluoyang_youtanzhi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  阿紫小姐，美……美如天仙……真想……想天天都看见她……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_youtanzhi
