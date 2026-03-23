local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oemei_dizi_1 = class("oemei_dizi_1", script_base)
function oemei_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  欢迎你来到峨嵋山。如果你需要帮助，请到山门附近找知客使帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oemei_dizi_1
