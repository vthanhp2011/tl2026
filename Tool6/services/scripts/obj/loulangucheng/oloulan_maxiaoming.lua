local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oloulan_maxiaoming = class("oloulan_maxiaoming", script_base)
oloulan_maxiaoming.script_id = 001158
function oloulan_maxiaoming:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  在西域，白骆驼是很稀有的。开始只有很少几个贵族才骑，后来一些富贾也花大量的钱财去搜寻。久而久之，人们把白骆驼当成财富的象徵...#r我这恰好有一些白骆驼，大侠是否要买？")
    self:AddNumText("购买骑乘", 7, 1)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oloulan_maxiaoming:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    if key == 1 then self:DispatchShopItem(selfId, targetId, 185) end
end

function oloulan_maxiaoming:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oloulan_maxiaoming
