local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_xiaowei = class("oluoyang_xiaowei", script_base)
function oluoyang_xiaowei:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  王府重地，不得随意走动！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_xiaowei
