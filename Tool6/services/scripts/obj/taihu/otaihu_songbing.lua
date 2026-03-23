local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otaihu_songbing = class("otaihu_songbing", script_base)
function otaihu_songbing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  也不知道我们倒底要等到什么，快点结束这里的事情，去玉门关支援杨将军吧。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otaihu_songbing
