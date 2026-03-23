local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_jinwuye = class("odali_jinwuye", script_base)
function odali_jinwuye:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  行走江湖，当然是谁拳头硬谁就是大爷。但俗话说得好，有钱能使磨推鬼，手里有了元宝，就能使很多难办的事情变得简单起来。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_jinwuye
