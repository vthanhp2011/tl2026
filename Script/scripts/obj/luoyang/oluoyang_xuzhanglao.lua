local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_xuzhanglao = class("oluoyang_xuzhanglao", script_base)
oluoyang_xuzhanglao.script_id = 000021
oluoyang_xuzhanglao.g_eventList = {
    200020, 200022, 200023, 200086, 200087, 200088, 200089, 200090
}

function oluoyang_xuzhanglao:UpdateEventList(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText(
        "  丐帮杏子林大会不久即将召开，到时候我要向大家宣布一件重大的事情，" ..
            PlayerName .. PlayerSex .. "，若有时间就一起来参加吧！")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_xuzhanglao:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_xuzhanglao:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
end

function oluoyang_xuzhanglao:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret =
                self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
    for i, findId in pairs(self.g_eventListTest) do
        if missionScriptId == findId then
            local ret =
                self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function oluoyang_xuzhanglao:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
    for i, findId in pairs(self.g_eventListTest) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_xuzhanglao:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
    for i, findId in pairs(self.g_eventListTest) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_xuzhanglao:OnMissionSubmit(selfId, targetId, missionScriptId,
                                             selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
    for i, findId in pairs(self.g_eventListTest) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_xuzhanglao:OnDie(selfId, killerId) end

return oluoyang_xuzhanglao
