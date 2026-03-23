local class = require "class"
local define = require "define"
local script_base = require "script_base"
local emei_sign = class("emei_sign", script_base)
emei_sign.script_id = 500065
emei_sign.g_Signpost = {
    { ["type"] = 2, ["name"] = "拜见掌门", ["x"] = 96, ["y"] = 73, ["tip"] = "掌门",
        ["desc"] = "掌门在双桥北面，一直向里走就看到她了。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    , { ["type"] = 2, ["name"] = "加入峨嵋", ["x"] = 96, ["y"] = 51, ["tip"] = "李十二娘",
    ["desc"] = "#{JRMP_090113_07}", ["eventId"] = -1 }
,
    { ["type"] = 2, ["name"] = "学习峨嵋战斗技能", ["x"] = 98, ["y"] = 51, ["tip"] = "学习峨嵋战斗技能",
        ["desc"] = "我们都是向崔绿华姐姐学习武艺的，她她在清音阁前。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习峨嵋生活技能", ["x"] = 43, ["y"] = 108, ["tip"] = "学习峨嵋生活技能",
        ["desc"] = "韩姐姐会使用我派独有的制符技能，你可以到萝峰晴云去找她。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习峨嵋辅助技能", ["x"] = 39, ["y"] = 109, ["tip"] = "学习峨嵋辅助技能",
        ["desc"] = "灵心术是制符的辅助技能，萝峰晴云的扈三娘会教给你的。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习峨嵋骑乘技能", ["x"] = 141, ["y"] = 51, ["tip"] = "学习骑乘技能",
        ["desc"] = "白水秋风的萧湘水会教给你骑乘凤凰的本领。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "购买坐骑", ["x"] = 145, ["y"] = 53, ["tip"] = "购买坐骑",
        ["desc"] = "如果想买一只凤凰就到白水秋风找萧香玉。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "峨嵋任务", ["x"] = 95, ["y"] = 86, ["tip"] = "峨嵋任务",
        ["desc"] = "在双桥的孟龙师兄正在找人帮忙。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "峨嵋传送人", ["x"] = 86, ["y"] = 142, ["tip"] = "峨嵋传送人",
        ["desc"] = "听月桥南的杨四娘可以带你去洛阳、大理、苏州或者其他门派。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "桃花阵", ["x"] = 96, ["y"] = 73, ["tip"] = "桃花阵",
        ["desc"] = "想进入桃花阵就要到双桥北面找掌门。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习峨嵋轻功", ["x"] = 105, ["y"] = 58, ["tip"] = "峨嵋轻功传授人",
        ["desc"] = "学习我派轻功到双桥北面找孙二娘。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function emei_sign:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function emei_sign:OnDefaultEvent(selfId, targetId,arg,index)
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

return emei_sign
