local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_dizi_4 = class("oxiaoyao_dizi_4", script_base)
function oxiaoyao_dizi_4:OnDefaultEvent(selfId,targetId)
self:BeginEvent(self.script_id)
self:AddText("我是逍遥派弟子。")
self:EndEvent()
self:DispatchEventList(selfId,targetId)
end

return oxiaoyao_dizi_4