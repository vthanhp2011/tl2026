local class = require "class"
local define = require "define"
local script_base = require "script_base"
local luoyang_sign_gate = class("luoyang_sign_gate", script_base)
luoyang_sign_gate.script_id = 500004
luoyang_sign_gate.g_Signpost = {
    { ["type"] = 2, ["name"] = "南门", ["x"] = 159, ["y"] = 251, ["tip"] = "南门",
        ["desc"] = "南门通往嵩山，建议15~20级的玩家前往。", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "东门", ["x"] = 260, ["y"] = 134, ["tip"] = "东门",
        ["desc"] = "东门通往雁南，建议30~36级的玩家前往。", ["eventId"] = -1 }
    , { ["type"] = 2, ["name"] = "西门", ["x"] = 58, ["y"] = 135, ["tip"] = "西门",
    ["desc"] = "西门通往敦煌，建议9~16级的玩家前往。", ["eventId"] = -1 }
}
function luoyang_sign_gate:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function luoyang_sign_gate:OnDefaultEvent(selfId, targetId,arg,index)
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

return luoyang_sign_gate
