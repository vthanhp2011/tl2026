local class = require "class"
local define = require "define"
local script_base = require "script_base"
local onanhai_dinglianyi = class("onanhai_dinglianyi", script_base)
function onanhai_dinglianyi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  师父、师娘……还有大师兄……就这样，就这样，都已经不在了吗？呜呜……别来管我，我不要活了……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return onanhai_dinglianyi
