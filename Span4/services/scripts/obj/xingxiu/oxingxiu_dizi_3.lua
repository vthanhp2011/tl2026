local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxingxiu_dizi_3 = class("oxingxiu_dizi_3", script_base)
function oxingxiu_dizi_3:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我是星宿派弟子。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxingxiu_dizi_3
