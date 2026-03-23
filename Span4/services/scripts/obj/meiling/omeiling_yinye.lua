local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_yinye = class("omeiling_yinye", script_base)

function omeiling_yinye:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  听了荆棘大护法一席话，才知道过去几十年全是白活了。以後大家跟着荆棘大护法，上刀山下油锅，都心甘情愿。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_yinye
