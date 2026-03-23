local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ohuanglong_cunmin = class("ohuanglong_cunmin", script_base)
function ohuanglong_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  最近黄龙镇不太平啊，据说圣物都被莽盖毁掉了，那我们马上就要面临灭顶之灾了吧……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ohuanglong_cunmin
