local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqiongzhou_yuanzijin = class("oqiongzhou_yuanzijin", script_base)
function oqiongzhou_yuanzijin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我们南海鳄鱼帮帮主，就是号称“南海鳄神”的岳老三。这次我是奉三哥之命，去琉球岛把三嫂接来琼州。现在三嫂已经到了，我们略做修整，就去鳄鱼帮找三哥。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oqiongzhou_yuanzijin
