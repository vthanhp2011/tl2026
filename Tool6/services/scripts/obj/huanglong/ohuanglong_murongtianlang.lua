local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ohuanglong_murongtianlang = class("ohuanglong_murongtianlang", script_base)
function ohuanglong_murongtianlang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  这个夕颜来路不明，非我族类，其心必异！我让阿文注意一下她的行动，阿文却每次都告诉我她的行为没有什麽异常……我觉得我没有看错人，一定有什麽别的问题发生了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ohuanglong_murongtianlang
