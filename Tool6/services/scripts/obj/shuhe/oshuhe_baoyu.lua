local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshuhe_baoyu = class("oshuhe_baoyu", script_base)
oshuhe_baoyu.script_id = 001187
oshuhe_baoyu.g_shoptableindex = 25
oshuhe_baoyu.g_MsgInfo = {"#{SHGZ_0612_09}", "#{SHGZ_0620_25}", "#{SHGZ_0620_26}", "#{SHGZ_0620_27}"}

function oshuhe_baoyu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local msgidx = math.random(#(self.g_MsgInfo))
    self:AddText(self.g_MsgInfo[msgidx])
    self:AddNumText("看看你卖的东西", 7, 28)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshuhe_baoyu:OnEventRequest(selfId, targetId, arg, index)
    if index == 28 then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
        return 0
    end
end

return oshuhe_baoyu
