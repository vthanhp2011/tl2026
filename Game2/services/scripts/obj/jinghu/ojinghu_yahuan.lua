local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ojinghu_yahuan = class("ojinghu_yahuan", script_base)
function ojinghu_yahuan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  段老爷没来的时候，小姐天天都在哭，怎么劝都劝不住；可段老爷来了的时候，小姐一下子就高兴起来了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ojinghu_yahuan
