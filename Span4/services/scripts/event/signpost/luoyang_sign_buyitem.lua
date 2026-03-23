local class = require "class"
local define = require "define"
local script_base = require "script_base"
local luoyang_sign_buyitem = class("luoyang_sign_buyitem", script_base)
luoyang_sign_buyitem.script_id = 500001
luoyang_sign_buyitem.g_Signpost = {
    { ["type"] = 2, ["name"] = "兵器店", ["x"] = 210, ["y"] = 154, ["tip"] = "王德贵",
        ["desc"] = "兵器店老板王德贵（210，154）在东市的兵器铺中。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "杂货商人", ["x"] = 254, ["y"] = 145, ["tip"] = "芮福祥",
        ["desc"] = "杂货商人芮福祥（254，146）在东门内。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "服饰店", ["x"] = 182, ["y"] = 183, ["tip"] = "甄唯思",
        ["desc"] = "服饰店掌柜甄唯思（182，183）在南大街的服饰店。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "饰品店", ["x"] = 178, ["y"] = 177, ["tip"] = "贾作珍",
        ["desc"] = "饰品店掌柜贾作珍（178，177）在南大街的服饰店。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "药店", ["x"] = 135, ["y"] = 164, ["tip"] = "白萌生",
        ["desc"] = "药店掌柜白萌生（135，164）在南大街的药店。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "酒店", ["x"] = 138, ["y"] = 140, ["tip"] = "范统",
        ["desc"] = "酒店掌柜范统（138，140）在西大街路南。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "珠宝商人", ["x"] = 63, ["y"] = 147, ["tip"] = "郎夫人",
        ["desc"] = "珠宝商人郎夫人（63，147）在西门内。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function luoyang_sign_buyitem:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function luoyang_sign_buyitem:OnDefaultEvent(selfId, targetId,arg,index)
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

return luoyang_sign_buyitem
