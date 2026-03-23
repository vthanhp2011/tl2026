local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_jingji = class("omeiling_jingji", script_base)
function omeiling_jingji:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  哪里有压迫，哪里就有反抗。我们山越护法不能再和我们的祖辈父辈一样，受山越女祭司的压迫了！即使我们这一代人失败了，我们的子子孙孙，也会反抗下去的！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_jingji
