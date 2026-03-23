local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshilin_cunmin = class("oshilin_cunmin", script_base)

function oshilin_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  圆月村，唉，村子里没有几家还是完整团圆的了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oshilin_cunmin
