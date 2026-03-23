local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dali_sign_yizhan = class("dali_sign_yizhan", script_base)
dali_sign_yizhan.script_id = 500043
dali_sign_yizhan.g_Signpost = {
    { ["type"] = 2, ["name"] = "驿站", ["x"] = 241, ["y"] = 136, ["tip"] = "崔逢九",
        ["desc"] = "行万里路，破万卷书，想去其他地方看看，驿站是最方便的。驿站的老崔就在东大街的路北，按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function dali_sign_yizhan:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function dali_sign_yizhan:OnDefaultEvent(selfId, targetId,arg,index)
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

return dali_sign_yizhan
