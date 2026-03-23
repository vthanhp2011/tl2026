local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianshan_dizi_1 = class("otianshan_dizi_1", script_base)
function otianshan_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  灵鹫宫里大多是女子，禁忌颇多。如果你需要帮助，请到山门附近找知客弟子帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianshan_dizi_1
