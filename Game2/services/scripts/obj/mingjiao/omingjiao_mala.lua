local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omingjiao_mala = class("omingjiao_mala", script_base)
function omingjiao_mala:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("百花妹妹说中土有座寒玉塔，里边有好多传说啊，真想去看看。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omingjiao_mala
