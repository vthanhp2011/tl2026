local class = require "class"
local define = require "define"
local script_base = require "script_base"
local suzhou_sign_quchushaqi = class("suzhou_sign_quchushaqi", script_base)
suzhou_sign_quchushaqi.script_id = 500029
suzhou_sign_quchushaqi.g_Signpost = {
    { ["type"] = 2, ["name"] = "去除杀气", ["x"] = 201, ["y"] = 82, ["tip"] = "雪竹莲",
        ["desc"] = "雪竹莲（201，82）在靠近北门附近。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function suzhou_sign_quchushaqi:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function suzhou_sign_quchushaqi:OnDefaultEvent(selfId, targetId, arg, index)
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

return suzhou_sign_quchushaqi
