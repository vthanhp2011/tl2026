local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxingxiu_dizi_1 = class("oxingxiu_dizi_1", script_base)
function oxingxiu_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  想在星宿海平安出入，没点胆子是不行的。如果你需要帮助，请到大门附近找知客弟子帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oxingxiu_dizi_1
