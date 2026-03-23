local class = require "class"
local define = require "define"
local script_base = require "script_base"
local suzhou_sign_yizhan = class("suzhou_sign_yizhan", script_base)
suzhou_sign_yizhan.script_id = 500026
suzhou_sign_yizhan.g_Signpost = {
    { ["type"] = 2, ["name"] = "李乘风", ["x"] = 111, ["y"] = 160, ["tip"] = "李乘风",
        ["desc"] = "驿站老板李乘风（111，160）在西市南口向东的街上。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function suzhou_sign_yizhan:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function suzhou_sign_yizhan:OnDefaultEvent(selfId, targetId, arg, index)
    local signpost = self.g_Signpost[index]
    if signpost["type"] == 1 then
        self:BeginEvent(self.script_id)
        self:AddText(signpost["name"] .. "：")
        self:CallScriptFunction(signpost["eventId"], "OnEnumerate", selfId, targetId)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif signpost["type"] == 2 then
        self:CallScriptFunction(888888, "AskTheWay", selfId, signpost["x"], signpost["y"], signpost["tip"])
        self:BeginEvent(self.script_id)
        self:AddText(signpost["desc"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

return suzhou_sign_yizhan
