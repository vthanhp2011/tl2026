local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyannan_shibing = class("oyannan_shibing", script_base)
function oyannan_shibing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  跟着种世衡大帅，能建功立业；跟着马承倩监军，能升官发财。可这两件事总是感觉挺矛盾的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyannan_shibing
