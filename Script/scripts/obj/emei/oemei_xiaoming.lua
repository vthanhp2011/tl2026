local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oemei_xiaoming = class("oemei_xiaoming", script_base)
function oemei_xiaoming:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  掌门姐姐从苏州回来之后，一连好几天都茶饭不思的，好像有很多的心事呢。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oemei_xiaoming
