local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_liuzhongfu = class("odali_liuzhongfu", script_base)
odali_liuzhongfu.script_id = 002092
function odali_liuzhongfu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    刘某学棋至今凡五十二年，从未遇到敌手。只是数年之前，在一位骊山仙姥手下败过一次，那时才知天外有天，人上有人。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_liuzhongfu
