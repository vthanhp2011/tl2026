local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owuliang_wangxiaoya = class("owuliang_wangxiaoya", script_base)
owuliang_wangxiaoya.script_id = 006011
owuliang_wangxiaoya.g_NianShouJieShao = "  #{NSBS_20071228_13}"
function owuliang_wangxiaoya:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  爹，我不要新衣服，我要娘，娘去哪里了，怎么还不回来啊？")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function owuliang_wangxiaoya:OnEventRequest(selfId, targetId, arg, index)
    if index == 101 then
        self:CallScriptFunction(050054, "OnDefaultEvent", selfId, targetId)
        return
    end
    if index == 102 then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_NianShouJieShao)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

return owuliang_wangxiaoya
