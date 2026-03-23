local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_kuileimuren = class("oxiaoyao_kuileimuren", script_base)
function oxiaoyao_kuileimuren:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  逍遥傀儡人F-874型正在进行数据动作处理：#r  10：伸出右侧手臂。#r  20：向左挥动。#r  30：向右挥动。#r  返回20，循环开始……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxiaoyao_kuileimuren
