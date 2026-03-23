local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxingxiu_dizi_2 = class("oxingxiu_dizi_2", script_base)
function oxingxiu_dizi_2:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我是星宿派弟子。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxingxiu_dizi_2
