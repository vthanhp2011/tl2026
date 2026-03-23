local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otaihu_kouxun = class("otaihu_kouxun", script_base)
function otaihu_kouxun:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  行军打仗虽然战术战略等各方面都很重要，但是我认为，人心更为重要，得人心者得天下啊！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otaihu_kouxun
