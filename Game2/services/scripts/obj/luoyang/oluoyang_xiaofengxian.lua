local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_xiaofengxian = class("oluoyang_xiaofengxian", script_base)
function oluoyang_xiaofengxian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  太后让我们来宋朝好好进行蹴鞠比赛。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_xiaofengxian
