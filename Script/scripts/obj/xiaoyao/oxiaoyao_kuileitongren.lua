local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_kuileitongren = class("oxiaoyao_kuileitongren", script_base)
function oxiaoyao_kuileitongren:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  逍遥傀儡人F-17173型目前工作正常……良好……优秀……杰出……完美……哦耶……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxiaoyao_kuileitongren
