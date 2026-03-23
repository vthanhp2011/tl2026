local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqiongzhou_honglong = class("oqiongzhou_honglong", script_base)
oqiongzhou_honglong.script_id = 035007
oqiongzhou_honglong.g_shoptableindex = 110
function oqiongzhou_honglong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("为了卖几颗破石头我们兄弟整天东奔西跑的，你说我容易嘛我。")
    self:AddNumText("看看你卖的石头", 7, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oqiongzhou_honglong:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if (self:GetLevel(selfId) < 30) then
            self:BeginEvent(self.script_id)
            self:AddText("#{BSSR_20080131_01}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
end

return oqiongzhou_honglong
