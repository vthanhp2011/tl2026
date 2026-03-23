local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dali_sign_teacher = class("dali_sign_teacher", script_base)
dali_sign_teacher.script_id = 500049
dali_sign_teacher.g_Signpost = {
    { ["type"] = 2, ["name"] = "拜师", ["x"] = 141, ["y"] = 133, ["tip"] = "聂政",
        ["desc"] = "拜师介绍人就在五华坛，按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function dali_sign_teacher:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function dali_sign_teacher:OnDefaultEvent(selfId, targetId,arg,index)
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

return dali_sign_teacher
