local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshilin_liangapo = class("oshilin_liangapo", script_base)

function oshilin_liangapo:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("梁阿婆~~")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oshilin_liangapo
