local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_gancao = class("omeiling_gancao", script_base)
function omeiling_gancao:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  荆棘大护法说得好，梅岭的大事小情，无不在大护法的算计之中。我们都照着大护法的意思去做，就算死一万次，也比稀里糊涂活着快活得多。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_gancao
