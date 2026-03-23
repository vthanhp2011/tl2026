local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_dengbaichuan = class("osuzhou_dengbaichuan", script_base)
function osuzhou_dengbaichuan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  公子爷举手投足都像极了老爷，只是年纪未到，有待成熟而已。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return osuzhou_dengbaichuan
