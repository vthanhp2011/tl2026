local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_menwei = class("odali_menwei", script_base)
function odali_menwei:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  保卫大理城是我的职责！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_menwei
