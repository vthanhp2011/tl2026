local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ocangshan_saxue = class("ocangshan_saxue", script_base)

function ocangshan_saxue:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("每年冬天，这里的雪无边无际，席卷而来。它在暗示着什麽呢？呵！这真是一个奇妙又略显恐怖的世界！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return ocangshan_saxue
