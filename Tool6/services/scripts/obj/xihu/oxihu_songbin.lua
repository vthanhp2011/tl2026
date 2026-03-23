local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxihu_songbin = class("oxihu_songbin", script_base)
function oxihu_songbin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  张将军用兵如神，水鬼的势力现在越来越弱小了。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxihu_songbin
