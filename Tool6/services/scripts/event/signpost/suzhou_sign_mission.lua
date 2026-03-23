local class = require "class"
local define = require "define"
local script_base = require "script_base"
local suzhou_sign_mission = class("suzhou_sign_mission", script_base)
suzhou_sign_mission.script_id = 500024
suzhou_sign_mission.g_Signpost = {
    { ["type"] = 2, ["name"] = "苏州漕使", ["x"] = 234, ["y"] = 78, ["tip"] = "陆士铮",
        ["desc"] = "苏州漕使陆士铮（234，78）在苏州城东北角的码头旁边。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "水牢", ["x"] = 243, ["y"] = 215, ["tip"] = "呼延豹",
        ["desc"] = "呼延豹（243，215）在城东南的府衙前，找到他可以接受平反水牢叛乱任务。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "惩凶任务", ["x"] = 127, ["y"] = 133, ["tip"] = "吴玠",
        ["desc"] = "苏州总捕头吴玠（127，133）在枫侨街，他正在找人帮他惩治凶徒，有可能得到藏宝图哦。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "棋局", ["x"] = 174, ["y"] = 147, ["tip"] = "张弈国",
        ["desc"] = "棋局活动使者张弈国（174，147）在状元场中。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "华山论剑", ["x"] = 194, ["y"] = 139, ["tip"] = "苏剑岭",
        ["desc"] = "华山论剑使者苏剑岭（194，139）在状元场中。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "连环副本", ["x"] = 62, ["y"] = 162, ["tip"] = "钱宏宇",
        ["desc"] = "苏州校尉钱宏宇（62，162）在苏州城西门外，可以找他领取连环副本任务。按下TAB键，地图上会有闪烁的标识的。",
        ["eventId"] = -1 }
}
function suzhou_sign_mission:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function suzhou_sign_mission:OnDefaultEvent(selfId, targetId, arg, index)
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

return suzhou_sign_mission
