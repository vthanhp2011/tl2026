local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_youzuo = class("oluoyang_youzuo", script_base)
function oluoyang_youzuo:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  好久未见恩师，甚为挂念啊！#r  恩师对我们教诲有方，使得我们领悟很多世间的道理，今日特来看望恩师。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_youzuo
