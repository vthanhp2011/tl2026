local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_shutong = class("oluoyang_shutong", script_base)
function oluoyang_shutong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  老爷完成《资治通鉴》后，身体已经非常虚弱了，还经常为国事操劳，真让人担心啊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_shutong
