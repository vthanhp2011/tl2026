local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_hufa = class("omeiling_hufa", script_base)
function omeiling_hufa:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  翻身了！翻身了！我们要当家作主了！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_hufa
