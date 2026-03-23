local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_daobaifeng = class("odali_daobaifeng", script_base)
function odali_daobaifeng:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  唉，誉儿走了这么久了还没回来，我是又担心又生气，江湖里的尔虞我诈哪是他这样的毛头小子可以应付的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_daobaifeng
