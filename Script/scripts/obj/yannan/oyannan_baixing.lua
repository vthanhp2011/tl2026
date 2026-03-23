local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyannan_baixing = class("oyannan_baixing", script_base)

function oyannan_baixing:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  我们都是好好的大宋百姓，住在雁门关已有几代了，金窝银窝，不如自家的土窝。我们是不会离开的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyannan_baixing
