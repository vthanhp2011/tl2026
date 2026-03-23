local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_chujiping = class("odali_chujiping", script_base)
odali_chujiping.script_id = 002077
odali_chujiping.g_shoptableindex = 10
function odali_chujiping:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    本人出售独家秘制鉴定符，可以鉴定所有类型的装备，欢迎选购！")
    self:AddNumText("看看你卖的东西", 7, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_chujiping:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
end

return odali_chujiping
