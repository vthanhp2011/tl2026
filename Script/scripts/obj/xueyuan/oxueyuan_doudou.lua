local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxueyuan_doudou = class("oxueyuan_doudou", script_base)

function oxueyuan_doudou:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("你是来找我的吗？博拉和袁平说我不是企鹅……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxueyuan_doudou
