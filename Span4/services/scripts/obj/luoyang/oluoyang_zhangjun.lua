local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zhangjun = class("oluoyang_zhangjun", script_base)
function oluoyang_zhangjun:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  今年，我们大宋一定还会拿第一的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_zhangjun
