local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_tongren_4 = class("otianlong_tongren_4", script_base)
function otianlong_tongren_4:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  足阳明胃经要穴如下：承泣、四白、颊车、下关、气户、梁门、关门、太乙、天枢、伏兔、阴市、足三里、内庭。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_tongren_4
