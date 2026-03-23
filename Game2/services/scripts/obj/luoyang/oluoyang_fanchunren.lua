local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_fanchunren = class("oluoyang_fanchunren", script_base)
local ScriptGlobal = require ("scripts.ScriptGlobal")
oluoyang_fanchunren.script_id = 000030
oluoyang_fanchunren.g_eventList = {600000,1018713,1018714}

function oluoyang_fanchunren:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  想要创建帮会就来找我吧！")
    self:AddNumText("帮会与领地介绍", 11, 10)
    self:AddNumText("查看帮会列表", 6, 2)
    if not self:IsShutout(selfId, ScriptGlobal.ONOFF_T_GUILD)then
        self:AddNumText("创建帮会", 6, 1)
    end
    self:AddNumText("管理帮会会员信息", 6, 3)
    self:AddNumText("查看本帮详细资讯", 6, 4)
    if (self:GetHumanGuildID(selfId) ~= -1) then
        if not self:IsShutout(selfId, ScriptGlobal.ONOFF_T_CITY) then
            self:AddNumText("申请城市", 6, 5)
        end
        if (self:CityGetSelfCityID(selfId) ~= -1) then
            self:AddNumText("进入本帮城市", 9, 6)
        end
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:AddNumText("关于帮派繁荣度", 11, 11)
    self:AddNumText("同盟介绍", 11, 12)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_fanchunren:OnEventRequest(selfId, targetId, arg, index)
    if index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_069}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{Guild_Boom_Help}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TM_20080331_07}" .. "#{TM_20080320_02}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId, arg, index)
        if arg == eventId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end
function oluoyang_fanchunren:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept",selfId, targetId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,targetId, missionScriptId)
            end
            return
        end
    end
end

function oluoyang_fanchunren:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:OnDefaultEvent(selfId, targetId)
            return
        end
    end
end

function oluoyang_fanchunren:OnMissionContinue(selfId, targetId,
                                                missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,targetId)
            return
        end
    end
end

function oluoyang_fanchunren:OnMissionSubmit(selfId, targetId, missionScriptId,selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_fanchunren:OnDie(selfId, killerId) end

return oluoyang_fanchunren
