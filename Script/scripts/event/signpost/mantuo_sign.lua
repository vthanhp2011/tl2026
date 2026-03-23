local class = require "class"
local define = require "define"
local script_base = require "script_base"
local mantuo_sign = class("mantuo_sign", script_base)
mantuo_sign.script_id = 500072
mantuo_sign.g_Signpost = {
    { ["type"] = 2, ["name"] = "#{MPSD_220622_23}", ["x"] = 140, ["y"] = 75, ["tip"] = "庄主王夫人",
        ["desc"] = "#{MPSD_220622_24}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_26}", ["x"] = 140, ["y"] = 88, ["tip"] = "曼陀山庄拜师人王素商",
        ["desc"] = "#{MPSD_220622_27}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_29}", ["x"] = 155, ["y"] = 114, ["tip"] = "武功传授人王和铃",
        ["desc"] = "#{MPSD_220622_30}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_32}", ["x"] = 210, ["y"] = 158, ["tip"] = "生活技能关山月",
        ["desc"] = "#{MPSD_220622_33}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_35}", ["x"] = 186, ["y"] = 171, ["tip"] = "生活辅助技能王水风",
        ["desc"] = "#{MPSD_220622_36}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_38}", ["x"] = 63, ["y"] = 132, ["tip"] = "坐骑管理叶婆婆",
        ["desc"] = "#{MPSD_220622_39}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_41}", ["x"] = 129, ["y"] = 106, ["tip"] = "师门任务王安歌",
        ["desc"] = "#{MPSD_220622_42}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_44}", ["x"] = 143, ["y"] = 159, ["tip"] = "曼陀山庄传送人幽草",
        ["desc"] = "#{MPSD_220622_45}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_120}", ["x"] = 30, ["y"] = 197, ["tip"] = "皓月洲",
        ["desc"] = "#{MPSD_220622_121}", ["eventId"] = -1 }
    ,
    { ["type"] = 2, ["name"] = "#{MPSD_220622_123}", ["x"] = 151, ["y"] = 36, ["tip"] = "轻功传授人王雁足",
        ["desc"] = "#{MPSD_220622_47}", ["eventId"] = -1 }
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
