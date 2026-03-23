local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ojingji_Npc_3 = class("ojingji_Npc_3", script_base)
ojingji_Npc_3.script_id = 125013
ojingji_Npc_3.g_eventList = {}
ojingji_Npc_3.g_Goto = {
    {
        ["name"] = "屈平原",
        ["scene"] = 2,
        ["x"] = 177,
        ["z"] = 135,
        ["scname"] = "大理"
    }, {
        ["name"] = "陶水潜",
        ["scene"] = 0,
        ["x"] = 157,
        ["z"] = 107,
        ["scname"] = "洛阳"
    }, {
        ["name"] = "贾思谊",
        ["scene"] = 1,
        ["x"] = 187,
        ["z"] = 132,
        ["scname"] = "苏州"
    }, {
        ["name"] = "宋知玉",
        ["scene"] = 420,
        ["x"] = 155,
        ["z"] = 130,
        ["scname"] = "束河古镇"
    }
}
function ojingji_Npc_3:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local szName = self:GetName(targetId)
    local level = self:GetLevel(targetId)
    if szName == "宋知玉" and level < 20 then
        local  str = "  十分抱歉，你的等级未满20级不能去束河古镇！"
        self:AddText(str)
    else
        for i, scene in pairs(self.g_Goto) do
            if scene["name"] == self:GetName(targetId) then
               local str = "  你要离开嵩山封禅台，前往" .. scene["scname"] .. "吗？"
                self:AddText(str)
                self:AddNumText("送我去" .. scene["scname"], 9, 1)
            end
        end
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function ojingji_Npc_3:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function ojingji_Npc_3:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        for i, Scene in pairs(self.g_Goto) do
            if Scene["name"] == self:GetName(targetId) then
                if Scene["scname"] == "束河古镇" then
                    self:BeginUICommand()
                    self:UICommand_AddInt(self.script_id)
                    self:UICommand_AddInt(targetId)
                    self:UICommand_AddStr("GotoShuHeGuZhen")
                    self:UICommand_AddStr("束河古镇为不加杀气场景，请注意安全。你确认要进入吗？")
                    self:EndUICommand()
                    self:DispatchUICommand(selfId, 24)
                    return
                else
                    self:CallScriptFunction((400900), "TransferFunc", selfId, Scene["scene"], Scene["x"], Scene["z"])
                    return
                end
            end
        end
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
end

function ojingji_Npc_3:OnMissionAccept(selfId, targetId, missionScriptId)
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

function ojingji_Npc_3:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function ojingji_Npc_3:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function ojingji_Npc_3:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function ojingji_Npc_3:OnDie(selfId, killerId) end

function ojingji_Npc_3:GotoShuHeGuZhen(selfId, targetId)
    self:CallScriptFunction((400900), "TransferFunc", selfId, 420, 155, 130, 20)
    return
end

return ojingji_Npc_3
