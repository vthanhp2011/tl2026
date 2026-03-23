local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshilin_zhengjunke = class("oshilin_zhengjunke", script_base)
function oshilin_zhengjunke:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    我叫郑君可，爹爹和姑爹都出远门了。姑姑天天都在哭。其实她不用哭的啊，爹爹和姑爹总有一天会回来的啊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oshilin_zhengjunke
