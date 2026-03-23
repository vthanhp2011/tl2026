local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omeiling_jisi = class("omeiling_jisi", script_base)
function omeiling_jisi:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  听说武夷山紫薇姐姐那边出了不少事情，好多姐妹都死了……啊，我只知道这些。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return omeiling_jisi
