local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_xieshang = class("osuzhou_xieshang", script_base)
function osuzhou_xieshang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  九州商会马上就要正式开业了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_xieshang
