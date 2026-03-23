local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oyuxi_suomula = class("oyuxi_suomula", script_base)

function oyuxi_suomula:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  老夫当年年轻气盛，曾经做了一个会捉老鼠的锺馗给沈大人看。不知道他是真觉得不错，还是故意寒碜我，这事情被他写进了《梦溪笔谈》之中。现在看那个锺馗，简直就是一个小孩子的玩意……#r  唉，人真是不可以不谨慎啊。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oyuxi_suomula
