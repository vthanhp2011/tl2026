local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_dizi_3 = class("oshaolin_dizi_3", script_base)
function oshaolin_dizi_3:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我是少林派弟子。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oshaolin_dizi_3
