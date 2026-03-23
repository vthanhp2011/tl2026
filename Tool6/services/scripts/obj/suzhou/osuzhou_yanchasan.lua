local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_yanchasan = class("osuzhou_yanchasan", script_base)
function osuzhou_yanchasan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  此次恩科，各地才子齐聚苏州，我这心里还真没谱。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_yanchasan
