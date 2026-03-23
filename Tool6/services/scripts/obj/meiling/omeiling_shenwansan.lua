local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_shenwansan = class("omeiling_shenwansan", script_base)
function omeiling_shenwansan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  没想到这批胭脂水粉卖的这麽快，看来这次来对了。途经草原的时候，兰陵郡主还对我的货物大加赞许，我得好好计算一下这次可以赚多少……")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_shenwansan
