local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dali_sign_gate = class("dali_sign_gate", script_base)
dali_sign_gate.script_id = 500045
dali_sign_gate.g_Signpost = {
    { ["type"] = 2, ["name"] = "南门", ["x"] = 160, ["y"] = 257, ["tip"] = "南门",
        ["desc"] = "南门通往洱海，如果没到25级，还是先不要去那里为好。", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "东门", ["x"] = 288, ["y"] = 152, ["tip"] = "东门",
        ["desc"] = "东门通往无量山，10级以下的玩家去这里正好。", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "西门", ["x"] = 31, ["y"] = 151, ["tip"] = "西门", ["desc"] = "西门通往剑阁，10级以下的玩家去这里正好。",
        ["eventId"] = -1 }
}
function dali_sign_gate:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function dali_sign_gate:OnDefaultEvent(selfId, targetId,arg,index)
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

return dali_sign_gate
