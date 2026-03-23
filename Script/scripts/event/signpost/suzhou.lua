local class = require "class"
local define = require "define"
local script_base = require "script_base"
local suzhou = class("suzhou", script_base)
suzhou.script_id = 500020
suzhou.g_Signpost = {
    { ["type"] = 1, ["name"] = "如何加入门派", ["eventId"] = 500049, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
        ["desc"] = " " }
    ,
    { ["type"] = 2, ["name"] = "如何领取双倍经验", ["x"] = 164, ["y"] = 80, ["tip"] = "沈澄",
        ["desc"] = "你可以向沈澄（164,80）领取双倍经验，他在苏州北门附近。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    , { ["type"] = 1, ["name"] = "购买各种物品", ["eventId"] = 500021, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "我想出城门去练习本领", ["eventId"] = 500022, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "我想学习生活技能", ["eventId"] = 500023, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "任务与副本", ["eventId"] = 500024, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "珍兽", ["eventId"] = 500025, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "驿站", ["eventId"] = 500026, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "钱庄", ["eventId"] = 500027, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "装备强化与鉴定", ["eventId"] = 500028, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "去除杀气", ["eventId"] = 500029, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
}
function suzhou:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function suzhou:OnDefaultEvent(selfId, targetId, arg, index)
    local signpost = self.g_Signpost[index]
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText(signpost["name"] .. "：")
        self:AddText("请到各城市的驿站处（按Tab可以打开地图查看#G驿#W字样）传送到您想拜师的门派。到了门派之后点击#G门派指路人#W就可以询问拜师的位置了。或者按tab键打开地图找#G师#W字样。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        self:CallScriptFunction(888888, "AskTheWay", selfId, 111, 160, "李乘风")
        return
    end
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

return suzhou
