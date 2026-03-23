local class = require "class"
local define = require "define"
local script_base = require "script_base"
local wudang_sign = class("wudang_sign", script_base)
wudang_sign.script_id = 500064
wudang_sign.g_Signpost = {
    { ["type"] = 2, ["name"] = "拜见掌门", ["x"] = 77, ["y"] = 85, ["tip"] = "掌门",
        ["desc"] = "掌门在紫霄大殿里，你想去拜见他么？按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    , { ["type"] = 2, ["name"] = "加入武当", ["x"] = 77, ["y"] = 85, ["tip"] = "张玄素",
    ["desc"] = "#{JRMP_090113_01}", ["eventId"] = -1 }
,
    { ["type"] = 2, ["name"] = "学习武当战斗技能", ["x"] = 82, ["y"] = 84, ["tip"] = "学习武当战斗技能",
        ["desc"] = "紫霄大殿里的俞远山可以教你武当派的的技能。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习武当生活技能", ["x"] = 44, ["y"] = 56, ["tip"] = "学习武当生活技能",
        ["desc"] = "鹤云道人可以教你炼丹，通过天阶就能找到他了。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习武当辅助技能", ["x"] = 41, ["y"] = 58, ["tip"] = "学习武当辅助技能",
        ["desc"] = "宁虚散人可以教你道法，通过天阶就能找到他了。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习武当骑乘技能", ["x"] = 102, ["y"] = 112, ["tip"] = "学习骑乘技能",
        ["desc"] = "岩义殿的张君羡会教给你骑鹤的本领。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "购买坐骑", ["x"] = 101, ["y"] = 115, ["tip"] = "购买坐骑",
        ["desc"] = "你可以向张君慕购买仙鹤坐骑，他就在岩义殿。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "武当任务", ["x"] = 78, ["y"] = 92, ["tip"] = "武当任务",
        ["desc"] = "如果你想为本派做些事情，就到紫霄大殿前去找张中行。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "武当传送人", ["x"] = 101, ["y"] = 136, ["tip"] = "武当传送人",
        ["desc"] = "剑河桥北的莫太冲可以带你去洛阳、大理、苏州或者其他门派。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "灵性峰", ["x"] = 58, ["y"] = 73, ["tip"] = "灵性峰",
        ["desc"] = "大师兄林灵素管理灵性峰的进入，他在天阶和紫霄大殿中间。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习武当轻功", ["x"] = 65, ["y"] = 109, ["tip"] = "武当轻功传授人",
        ["desc"] = "三清殿的静初散人可以交给你本派轻功。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function wudang_sign:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function wudang_sign:OnDefaultEvent(selfId, targetId, arg, index)
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

return wudang_sign
