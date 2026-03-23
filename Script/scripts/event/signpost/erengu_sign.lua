local class = require "class"
local define = require "define"
local script_base = require "script_base"
local mantuo_sign = class("mantuo_sign", script_base)
mantuo_sign.script_id = 500073
mantuo_sign.g_Signpost = {
    { ["type"] = 2, ["name"] = "#{ERMP_240620_115}", ["x"] = 84, ["y"] = 26, ["tip"] = "谷主山鬼",
        ["desc"] = "#{ERMP_240620_116}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_117}", ["x"] = 154, ["y"] = 56, ["tip"] = "恶人谷拜师人段延庆",
        ["desc"] = "#{ERMP_240620_118}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_119}", ["x"] = 180, ["y"] = 120, ["tip"] = "武功传授人叶二娘",
        ["desc"] = "#{ERMP_240620_120}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_121}", ["x"] = 132, ["y"] = 123, ["tip"] = "生活技能山流儿",
        ["desc"] = "#{ERMP_240620_122}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_123}", ["x"] = 117, ["y"] = 123, ["tip"] = "生活辅助技能山曜",
        ["desc"] = "#{ERMP_240620_124}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_125}", ["x"] = 38, ["y"] = 57, ["tip"] = "坐骑管理刑万里",
        ["desc"] = "#{ERMP_240620_126}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_127}", ["x"] = 182, ["y"] = 181, ["tip"] = "师门任务岳老三",
        ["desc"] = "#{ERMP_240620_128}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_129}", ["x"] = 123, ["y"] = 150, ["tip"] = "恶人谷传送人孙三霸",
        ["desc"] = "#{ERMP_240620_130}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{ERMP_240620_131}", ["x"] = 79, ["y"] = 161, ["tip"] = "轻功传授人云中鹤",
        ["desc"] = "#{ERMP_240620_132}", ["eventId"] = -1 }
}
function mantuo_sign:OnEnumerate(caller, selfId, targetId, arg, index)
    for i, signpost in pairs(self.g_Signpost) do
        caller:AddNumTextWithTarget(self.script_id, signpost["name"], -1, i)
    end
end

function mantuo_sign:OnDefaultEvent(selfId, targetId, arg, index)
    local signpost = self.g_Signpost[index]
    local sceneId = self:GetSceneID()
    if signpost["type"] == 1 then
        self:BeginEvent(self.script_id)
        self:AddText(signpost["name"] .. "：")
        self:CallScriptFunction(signpost["eventId"], "OnEnumerate", selfId, targetId)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif signpost["type"] == 2 then
        self:CallScriptFunction(888888, "AskTheWay", selfId,sceneId,signpost["x"], signpost["y"], signpost["tip"])
        self:BeginEvent(self.script_id)
        self:AddText(signpost["desc"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

return mantuo_sign
