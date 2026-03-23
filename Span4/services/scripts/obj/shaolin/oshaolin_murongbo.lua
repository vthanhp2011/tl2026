local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_murongbo = class("oshaolin_murongbo", script_base)
function oshaolin_murongbo:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("阿弥陀佛，施主来这藏经阁有何贵干？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oshaolin_murongbo
