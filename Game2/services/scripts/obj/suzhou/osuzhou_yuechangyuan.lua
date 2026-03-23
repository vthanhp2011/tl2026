local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_yuechangyuan = class("osuzhou_yuechangyuan", script_base)
osuzhou_yuechangyuan.script_id = 050001
osuzhou_yuechangyuan.g_eventList = {050017, 808064, 050020}

osuzhou_yuechangyuan.g_ControlScript = 050009
function osuzhou_yuechangyuan:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    if self:CallScriptFunction(self.g_ControlScript, "IsMidAutumnPeriod", selfId) > 0 then
        self:AddText("    中秋之夜，花好月圆，寻常巷陌陈罗绮，" .. "几处楼台奏管弦。但此时此刻，正是边关的将士奋力抗击外敌" .. "，才有了我们这花花世界。")
    else
        self:AddText("    苏学士有一句词写得好，人有悲欢离合，" .. "月有阴晴圆缺，此事古难全。现在虽然不是花好月圆之夜，但" .. "在我心中，月亮和人一样，永远是团圆的。")
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_yuechangyuan:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function osuzhou_yuechangyuan:OnEventRequest(selfId, targetId, arg, index)
    local Num = index
    if (Num == 1010) then
        self:BeginEvent(self.script_id)
        self:AddNumText("#{ZQHD_20070916_010}", 11, 705)
        self:AddNumText("#{ZQHD_20070916_011}", 11, 10)
        self:AddNumText("#{ZQHD_20070916_012}", 11, 102)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg== findId then
            self:CallScriptFunction(findId, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
end

function osuzhou_yuechangyuan:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function osuzhou_yuechangyuan:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

return osuzhou_yuechangyuan
