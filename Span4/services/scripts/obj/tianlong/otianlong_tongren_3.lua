local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_tongren_3 = class("otianlong_tongren_3", script_base)
function otianlong_tongren_3:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  足阳明胃经要穴如下：隐白、大都、太白、公孙、商丘、三阴交、漏谷、血海、箕门、冲门、大横、天溪、大包。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_tongren_3
