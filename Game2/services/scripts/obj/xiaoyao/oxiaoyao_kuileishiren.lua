local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_kuileishiren = class("oxiaoyao_kuileishiren", script_base)
function oxiaoyao_kuileishiren:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  逍遥傀儡人F-16型已经从一个严重的系统错误中恢复。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxiaoyao_kuileishiren
