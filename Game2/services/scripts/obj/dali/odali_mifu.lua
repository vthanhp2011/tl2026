local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_mifu = class("odali_mifu", script_base)
function odali_mifu:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  苍山不墨千秋画，洱海无弦万古琴。这大理国果然是个好地方，王大将军真有眼力，竟然会选此地隐居。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_mifu
