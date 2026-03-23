local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_chris = class("omeiling_chris", script_base)
function omeiling_chris:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  亲爱的朋友！快来帮帮我啊！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function omeiling_chris:OnDie(selfId, killerId) end

return omeiling_chris
