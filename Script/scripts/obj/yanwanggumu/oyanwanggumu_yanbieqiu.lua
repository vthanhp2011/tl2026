local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyanwanggumu_yanbieqiu = class("oyanwanggumu_yanbieqiu", script_base)

function oyanwanggumu_yanbieqiu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  就算生前为帝王，死后也不过一杯黄土而已。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyanwanggumu_yanbieqiu
