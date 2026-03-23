local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omiaojiang_cunmin = class("omiaojiang_cunmin", script_base)
function omiaojiang_cunmin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  今天我喝了新调出的黑苗酒，感觉真是太舒服了。古大师的调酒技艺真是叫人不得不叹为观止啊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omiaojiang_cunmin
