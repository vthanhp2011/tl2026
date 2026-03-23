local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_dongci = class("omeiling_dongci", script_base)
function omeiling_dongci:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我觉得我用了沈先生的胭脂水粉，也挺好看的啊，要加点腮红就更好了。嗯，睫毛也应该再修一修了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_dongci
