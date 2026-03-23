local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqiongzhou_bangzhong = class("oqiongzhou_bangzhong", script_base)
function oqiongzhou_bangzhong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我们帮主武功盖世，天下无敌，文成武德，鸟生鱼汤！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oqiongzhou_bangzhong
