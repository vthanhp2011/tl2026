local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ohuanglong_hongba = class("ohuanglong_hongba", script_base)
ohuanglong_hongba.script_id = 023007
ohuanglong_hongba.g_shoptableindex = 111
function ohuanglong_hongba:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("我这儿的卖价可比市价低多了，信不信由你。")
    self:AddNumText("看看你卖的什麽", 7, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ohuanglong_hongba:OnEventRequest(selfId, targetId, arg, index)
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

return ohuanglong_hongba
