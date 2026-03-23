local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omingjiao_dizi_1 = class("omingjiao_dizi_1", script_base)
function omingjiao_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  光明殿重地，不得随意走动！如果你需要帮助，就去大门附近找知客使帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omingjiao_dizi_1
