local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_chenyongren = class("oluoyang_chenyongren", script_base)
oluoyang_chenyongren.script_id = 311001
function oluoyang_chenyongren:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  大侠，去看过洛阳花会了吗？有没有见到师师姑娘？听说每次花会师师姑娘都会前往，可惜，我公务在身总是无缘得见啊！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_chenyongren:OnDefaultEvent(selfId, targetId) end

return oluoyang_chenyongren
