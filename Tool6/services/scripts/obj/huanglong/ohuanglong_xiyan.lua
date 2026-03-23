local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ohuanglong_xiyan = class("ohuanglong_xiyan", script_base)

function ohuanglong_xiyan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我在黄龙镇只生活了几天，但这几天我却觉得无比安逸温暖。比我以前地狱一般的生活，实在是好了不知多少倍。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ohuanglong_xiyan
