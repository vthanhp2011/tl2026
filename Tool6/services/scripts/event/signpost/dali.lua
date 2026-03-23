local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dali = class("dali", script_base)
dali.script_id = 500040
dali.g_Signpost = {
    { ["type"] = 1, ["name"] = "如何加入门派", ["eventId"] = 500049, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
        ["desc"] = " " }
    , { ["type"] = 1, ["name"] = "九大门派传送人", ["eventId"] = 500041, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "购买各种物品", ["eventId"] = 500042, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "驿站", ["eventId"] = 500043, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "钱庄、当铺", ["eventId"] = 500044, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "我想出城门去练习本领", ["eventId"] = 500045, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "学习一些生活技能", ["eventId"] = 500046, ["x"] = 0, ["y"] = 0, ["tip"] = " ",
    ["desc"] = " " }
, { ["type"] = 1, ["name"] = "任务与副本", ["eventId"] = 500047, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "擂台", ["eventId"] = 500048, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
, { ["type"] = 1, ["name"] = "拜师", ["eventId"] = 500049, ["x"] = 0, ["y"] = 0, ["tip"] = " ", ["desc"] = " " }
}
function dali:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function dali:OnDefaultEvent(selfId, targetId,arg,index)
    local signpost = self.g_Signpost[index]
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText(signpost["name"] .. "：")
        self:AddText("请到各城市的驿站处（按Tab可以打开地图查看#G驿#W字样）传送到您想拜师的门派。到了门派之後点击#G门派指路人#W就可以询问拜师的位置了。或者按tab键打开地图找#G师#W字样。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        self:CallScriptFunction(888888, "AskTheWay", selfId, 241, 136, "崔逢九")
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

return dali
