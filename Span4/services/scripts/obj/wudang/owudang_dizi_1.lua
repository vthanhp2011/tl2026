local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owudang_dizi_1 = class("owudang_dizi_1", script_base)
function owudang_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  圆转如意，清静无为，这里就是武当山。如果你需要帮助，请到山门附近找知客道人帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return owudang_dizi_1
