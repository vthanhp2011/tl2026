local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odunhuang_xiabing = class("odunhuang_xiabing", script_base)

function odunhuang_xiabing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  不明白皇帝陛下为什麽要编制汉人军团，我们党项军团的战斗力远远超过汉人啊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odunhuang_xiabing
