local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ohuanglong_liuaotian = class("ohuanglong_liuaotian", script_base)
function ohuanglong_liuaotian:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  你好，中原的英雄！我叫刘傲天。我是匈奴人的后裔，本姓栾提的，你也可以叫我栾提傲天。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ohuanglong_liuaotian
