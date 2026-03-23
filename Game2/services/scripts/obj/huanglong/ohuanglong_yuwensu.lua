local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ohuanglong_yuwensu = class("ohuanglong_yuwensu", script_base)
function ohuanglong_yuwensu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  阿文最近不知道怎麽了，不吃饭，不睡觉，整天都在那里发呆……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ohuanglong_yuwensu
