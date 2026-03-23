local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omingjiao_shibing = class("omingjiao_shibing", script_base)
function omingjiao_shibing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("光明殿重地，不要乱跑！小心迷路！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omingjiao_shibing
