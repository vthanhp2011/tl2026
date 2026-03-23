local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_liuyuehong = class("osuzhou_liuyuehong", script_base)
osuzhou_liuyuehong.script_id = 1025
osuzhou_liuyuehong.g_ControlScript = 808071
function osuzhou_liuyuehong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  从现在开始，你只许疼我一个，要宠我，不许骗我，答应我的每一件事情都要做到。")
    self:CallScriptFunction(self.g_ControlScript, "OnEnumerate", self, selfId, targetId)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_liuyuehong:OnEventRequest(selfId, targetId, arg, index)
    if arg == self.g_ControlScript then
        self:CallScriptFunction(self.g_ControlScript, "OnDefaultEvent", selfId, targetId, arg, index)
        return
    end
end

return osuzhou_liuyuehong
