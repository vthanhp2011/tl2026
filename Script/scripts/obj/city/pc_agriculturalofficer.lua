local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local pc_agriculturalofficer = class("pc_agriculturalofficer", script_base)
pc_agriculturalofficer.script_id = 805014
pc_agriculturalofficer.g_BuildingID8 = 7
pc_agriculturalofficer.g_eventList = {600007}
pc_agriculturalofficer.g_eventSetList = {600007}

function pc_agriculturalofficer:UpdateEventList(selfId, targetId)
    local i = 1
    local eventId = 0
    local Humanguildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    self:BeginEvent(self.script_id)
    if Humanguildid == cityguildid then
        self:AddText("    帮会强大在乎农也，有什麽需要我帮你的麽？")
        for i, eventId in pairs(self.g_eventList) do
            self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
        end
        self:AddNumText("发展任务介绍", 11, 1)
        self:AddNumText("加厚城墙", 6, 3)
        self:AddNumText("米仓介绍", 11, 2)
        self:AddNumText("换取冰镇西瓜", 6, 4)
        self:AddNumText("冰镇西瓜介绍", 11, 5)
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "AddCityLifeAbilityOpt", selfId, self.script_id, self.g_BuildingID8, 888)
    else
        self:AddText("    阁下不是本帮成员，面生的紧啊！")
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function pc_agriculturalofficer:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function pc_agriculturalofficer:IsValidEvent(selfId, eventId)
    local i = 1
    local findId = 0
    local bValid = 0
    for i, findId in pairs(self.g_eventList) do
        if eventId == findId then
            bValid = 1
            break
        end
    end
    if bValid == 0 then
        for i, findId in pairs(self.g_eventSetList) do
            if self:CallScriptFunction(findId, "IsInEventList", selfId, eventId) == 1 then
                bValid = 1
                break
            end
        end
    end
    return bValid
end

function pc_agriculturalofficer:OnEventRequest(selfId, targetId, arg, index)
    if self:IsValidEvent(selfId, arg) == 1 then
        self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
        return
    elseif arg ~= self.script_id then
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnDefaultEvent", selfId, targetId, arg, self.script_id, self.g_BuildingID8)
        return
    end
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Dev_Mission_Help}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_MiCang}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 3 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 888 then
        self:BeginEvent(self.script_id)
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnEnumerate", self, selfId, targetId, self.g_BuildingID8)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 4 then
        self:BeginEvent(self.script_id)
        self:AddText("#{BGHXG_JS}")
        self:AddText("您确认要用9点帮贡换取冰镇西瓜吗？")
        self:AddNumText("确认", 6, 16)
        self:AddNumText("取消", 8, 17)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 5 then
        self:BeginEvent(self.script_id)
        self:AddText("#{BGHXG_JS}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 16 then
        self:BingZhenXiGua(selfId, targetId)
    elseif index == 17 then
        self:OnDefaultEvent(selfId, targetId)
    end
end

function pc_agriculturalofficer:OnMissionAccept(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
        if ret > 0 then
            self:CallScriptFunction(missionScriptId, "OnAccept", selfId, targetId)
        elseif ret == -1 then
            self:NotifyFailTips(selfId, "你现在不能领取这个任务")
        elseif ret == -2 then
            self:NotifyFailTips(selfId, "无法接受更多任务")
        end
        return
    end
end

function pc_agriculturalofficer:OnMissionRefuse(selfId, targetId,  missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:UpdateEventList(selfId, targetId)
        return
    end
end

function pc_agriculturalofficer:OnMissionContinue(selfId, targetId,  missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
        return
    end
end

function pc_agriculturalofficer:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
        return
    end
end

function pc_agriculturalofficer:OnDie(selfId, killerId) end

function pc_agriculturalofficer:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function pc_agriculturalofficer:BingZhenXiGua(selfId, targetId)
    local humanGuildId = self:GetHumanGuildID(selfId)
    local cityGuildId = self:GetCityGuildID(selfId)
    if not humanGuildId or not cityGuildId or humanGuildId ~= cityGuildId then
        self:BeginEvent(self.script_id)
        self:AddText("只有本帮成员才能换取。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return 0
    end
    local guildPoint = self:CityGetAttr(selfId, 6)
    if not guildPoint or guildPoint < 9 then
        self:BeginEvent(self.script_id)
        self:AddText("你的帮贡不足9点，无法换取。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return 0
    end
    self:LuaFnBeginAddItem()
    self:LuaFnAddItem(30501103, 1)
    local ret = self:LuaFnEndAddItem(selfId)
    if not ret then
        self:BeginEvent(self.script_id)
        self:AddText("你现在无法获得物品，请检查背包。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return 0
    end
    ret = self:CityChangeAttr(selfId, 6, -9)
    if not ret then
        self:BeginEvent(self.script_id)
        self:AddText("操作失败，请重试。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return 0
    end
    self:AddItemListToHuman(selfId)
    self:NotifyFailTips(selfId, "你获得了一个冰镇西瓜。")
    local szTransferItem = self:GetItemTransfer(selfId, 0)
    local selfName = self:LuaFnGetName(selfId)
    selfName = gbk.fromutf8(selfName)
    local strChatMessage = "#{_INFOUSR" .. selfName ..    gbk.fromutf8("}#P乐呵呵的从#G朱世友[129，100]#P手里接过一瓤#Y#{_INFOMSG") ..  szTransferItem .. gbk.fromutf8("}#P，吃上一口真是从头顶凉到脚底板啊！")
    self:BroadMsgByChatPipe(selfId, "@*;SrvMsg;GLD:" .. strChatMessage, 6)
    self:OnDefaultEvent(selfId, targetId)
end

return pc_agriculturalofficer
