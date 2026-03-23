local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyuxi_ayina = class("oyuxi_ayina", script_base)

function oyuxi_ayina:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  阿妈到底什麽时候才能原谅阿爸呀？如果阿妈和阿爸还能像以前一样在一起就好了，那我就可以天天见到萝卜哥哥了，多好呀！也不知道萝卜哥哥这几天在忙什麽，都不来陪我玩。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyuxi_ayina
