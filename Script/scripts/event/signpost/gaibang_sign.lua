local class = require "class"
local define = require "define"
local script_base = require "script_base"
local gaibang_sign = class("gaibang_sign", script_base)
gaibang_sign.script_id = 500063
gaibang_sign.g_Signpost = {
    { ["type"] = 2, ["name"] = "加入丐帮", ["x"] = 91, ["y"] = 98, ["tip"] = "陈孤雁",
        ["desc"] = "#{JRMP_090113_09}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习丐帮战斗技能", ["x"] = 94, ["y"] = 99, ["tip"] = "学习丐帮战斗技能",
        ["desc"] = "奚三祁长老可以教给你本帮的技能，它在聚义堂门口。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习丐帮生活技能", ["x"] = 114, ["y"] = 91, ["tip"] = "学习丐帮生活技能",
        ["desc"] = "忠烈堂门口的吴长风长老可以教给你酿酒技能。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习丐帮辅助技能", ["x"] = 131, ["y"] = 83, ["tip"] = "学习丐帮辅助技能",
        ["desc"] = "到桃园去，舵主就在那里，你问问他会不会教你莲花落。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习丐帮骑乘技能", ["x"] = 38, ["y"] = 89, ["tip"] = "学习骑乘技能",
        ["desc"] = "西厢房的蒋光亭可以教你怎样骑乘狼。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "购买坐骑", ["x"] = 54, ["y"] = 86, ["tip"] = "购买坐骑",
        ["desc"] = "购买坐骑找西厢房的李日越。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "丐帮任务", ["x"] = 92, ["y"] = 70, ["tip"] = "丐帮任务",
        ["desc"] = "洪通在聚义堂後面，他正在找人帮忙。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "丐帮传送人", ["x"] = 93, ["y"] = 118, ["tip"] = "丐帮传送人",
        ["desc"] = "聚义堂外的张全祥可以带你去洛阳、大理、苏州或者其他门派。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "酒窖", ["x"] = 41, ["y"] = 144, ["tip"] = "酒窖",
        ["desc"] = "酒窖有人捣乱，去小桃园找佛印带你去赶跑他们。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "学习丐帮轻功", ["x"] = 112, ["y"] = 90, ["tip"] = "丐帮轻功传授人",
        ["desc"] = "忠烈堂门口的吴雪娇可以教给你本帮轻功。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function gaibang_sign:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function gaibang_sign:OnDefaultEvent(selfId, targetId,arg,index)
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

return gaibang_sign
