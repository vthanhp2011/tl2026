local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dali_sign_buyitem = class("dali_sign_buyitem", script_base)
dali_sign_buyitem.script_id = 500042
dali_sign_buyitem.g_Signpost = {
    { ["type"] = 2, ["name"] = "兵器店", ["x"] = 216, ["y"] = 133, ["tip"] = "蒲良",
        ["desc"] = "兵器店就在东大街路北。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "服饰店", ["x"] = 238, ["y"] = 171, ["tip"] = "黄公道",
        ["desc"] = "服饰店就在东大街路南。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "饰品店", ["x"] = 248, ["y"] = 171, ["tip"] = "小钗",
        ["desc"] = "饰品店就在东大街路南。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "珍兽店", ["x"] = 265, ["y"] = 128, ["tip"] = "云飘飘",
        ["desc"] = "珍兽店就在东大街路北，驿站的东北方向。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "药店", ["x"] = 102, ["y"] = 131, ["tip"] = "卢三七",
        ["desc"] = "药店在西大街路北。按下TAB键，地图上会有闪烁的标识的。", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "酒店", ["x"] = 110, ["y"] = 159, ["tip"] = "杜子腾",
        ["desc"] = "酒店在西大街路南，那里可以买到各种用于回复的食品。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "杂货店", ["x"] = 57, ["y"] = 131, ["tip"] = "高升祥",
        ["desc"] = "杂货店在西门内，向北走的农田旁边。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function dali_sign_buyitem:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function dali_sign_buyitem:OnDefaultEvent(selfId, targetId,arg,index)
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

return dali_sign_buyitem
