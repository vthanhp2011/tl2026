local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odunhuang_lichonggui = class("odunhuang_lichonggui", script_base)

function odunhuang_lichonggui:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我们已经打败了回鹘和龟兹，攻进玉门关，攻占宋朝是早晚的事情。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odunhuang_lichonggui