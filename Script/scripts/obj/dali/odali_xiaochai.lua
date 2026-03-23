local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_xiaochai = class("odali_xiaochai", script_base)
odali_xiaochai.script_id = 002055
odali_xiaochai.g_shoptableindex = 3
function odali_xiaochai:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("    本店有大量商品出售，欢迎选购！")
    self:AddNumText("看看你卖的东西", 7, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_xiaochai:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
end

return odali_xiaochai
