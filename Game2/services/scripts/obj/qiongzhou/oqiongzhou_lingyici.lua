local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oqiongzhou_lingyici = class("oqiongzhou_lingyici", script_base)
function oqiongzhou_lingyici:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  老三总是想要我来琼州，可是琉球的百姓正在遭受瘟疫之苦，我实在不能舍他们而去。#r  这次我来琼州，主要是听子衿说南海有一位神医岳仲秋，用异种树皮治癒了瘟疫。等我掌握了这门技术之後，我还要赶回琉球，治疗那里的百姓的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oqiongzhou_lingyici
