local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyuxi_gulula = class("oyuxi_gulula", script_base)
function oyuxi_gulula:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  那老鬼从来不管老婆孩子，一门心思都在那个萝卜身上。#r  唉，想当年追我的男子成千上万，我怎麽会看上这麽一个老鬼！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyuxi_gulula
