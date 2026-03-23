local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_dizi_1 = class("oshaolin_dizi_1", script_base)
function oshaolin_dizi_1:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  此处就是武林圣地少林寺。如果你需要帮助，请到寺门附近找知客僧帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oshaolin_dizi_1
