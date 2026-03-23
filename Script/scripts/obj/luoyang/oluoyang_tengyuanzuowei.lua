local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_tengyuanzuowei = class("oluoyang_tengyuanzuowei", script_base)
oluoyang_tengyuanzuowei.script_id = 000029
function oluoyang_tengyuanzuowei:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  非常高兴见到你，大宋朝真是个美丽的国家。我很喜欢这里，希望以后还有机会再来。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_tengyuanzuowei
