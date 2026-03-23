local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_tongren_2 = class("otianlong_tongren_2", script_base)
function otianlong_tongren_2:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  手阳明大肠经要穴如下：商阳、合谷、阳溪、偏历、温溜、手三里、曲池、手五里、巨骨、天鼎、迎香。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_tongren_2
