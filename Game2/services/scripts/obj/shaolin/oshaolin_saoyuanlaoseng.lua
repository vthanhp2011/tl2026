local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_saoyuanlaoseng = class("oshaolin_saoyuanlaoseng", script_base)
function oshaolin_saoyuanlaoseng:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  施主在江湖上的大名，老衲早有耳闻。今日一见，果然是名不虚传。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oshaolin_saoyuanlaoseng
