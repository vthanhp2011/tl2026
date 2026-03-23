local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_hehongling = class("otianlong_hehongling", script_base)
function otianlong_hehongling:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  本相大师最近总向我提起他的一个后辈，此人是当今皇上的侄儿，名叫段誉。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return otianlong_hehongling
