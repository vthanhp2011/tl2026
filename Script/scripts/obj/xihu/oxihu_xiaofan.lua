local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxihu_xiaofan = class("oxihu_xiaofan", script_base)
oxihu_xiaofan.script_id = 050201
oxihu_xiaofan.g_shoptableindex = 166
function oxihu_xiaofan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    这位大侠，来买碗绿豆汤去去暑气吧！小店的冰镇绿豆汤方圆百里都有名啊！")
    self:AddNumText("购买绿豆汤", 7, 1)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxihu_xiaofan:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
end

return oxihu_xiaofan
