local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ogaibang_dizi_1 = class("ogaibang_dizi_1", script_base)
function ogaibang_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  这里是丐帮总舵。如果你需要帮助，请到院门附近找知客丐帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ogaibang_dizi_1
