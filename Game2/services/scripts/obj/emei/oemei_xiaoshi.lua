local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oemei_xiaoshi = class("oemei_xiaoshi", script_base)
function oemei_xiaoshi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  掌门姐姐最近总是谈起一个叫做韩世忠的人，说他是不世出的大英雄，可以和“北乔峰”、“南慕容”并驾齐驱。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oemei_xiaoshi
