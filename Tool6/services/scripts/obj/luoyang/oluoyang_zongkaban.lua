local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zongkaban = class("oluoyang_zongkaban", script_base)
function oluoyang_zongkaban:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  不知道今年的蹴鞠大会，哪方会赢，真是期待啊！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_zongkaban
