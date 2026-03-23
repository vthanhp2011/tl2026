local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omingjiao_dizi_4 = class("omingjiao_dizi_4", script_base)
function omingjiao_dizi_4:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我是明教弟子。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omingjiao_dizi_4
