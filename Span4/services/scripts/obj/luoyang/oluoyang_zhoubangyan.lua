local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_zhoubangyan = class("oluoyang_zhoubangyan", script_base)
function oluoyang_zhoubangyan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  听传言说师师小姐被送进了端王府，真不敢相信这是真的。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_zhoubangyan
