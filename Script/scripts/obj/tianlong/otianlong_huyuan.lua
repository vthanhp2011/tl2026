local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_huyuan = class("otianlong_huyuan", script_base)
function otianlong_huyuan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  天龙寺乃是佛门清修之所。如果你需要帮助，请到寺门附近找知客僧帮忙。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_huyuan
