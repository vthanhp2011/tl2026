local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_liangdaoshi = class("osuzhou_liangdaoshi", script_base)
osuzhou_liangdaoshi.script_id = 001086
osuzhou_liangdaoshi.g_eventList = {808131}

function osuzhou_liangdaoshi:UpdateEventList(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText(" #{XCHQ_90601_1}")
    self:AddNumText("#{SQXY_09061_5}", 6,100)
    self:AddNumText("#{XCHQ_90609_2}", 6,200)
    self:AddNumText("#{SQXY_09061_6}", 11,5000)
    self:AddNumText("#{XCHQ_90609_4}", 11,5100)
    self:AddNumText("#{XCHQ_90609_3}", 11,5200)
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_liangdaoshi:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function osuzhou_liangdaoshi:OnEventRequest(selfId, targetId, arg, index)
    local nNumText = index
    if nNumText == 100 then
        self:BeginEvent(self.script_id)
        self:AddNumText("兑换天罡强化精华", 6,101)
        self:AddNumText("兑换红宝石(3级)", 6,102)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 101 then
        self:BeginEvent(self.script_id)
        self:AddText("兑换天罡强化精华需要#G7个#W许愿果，确定要兑换吗？")
        self:AddNumText("我要兑换", 0,103)
        self:AddNumText("离开", 0,1000)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif nNumText == 102 then
        self:BeginEvent(self.script_id)
        self:AddText("兑换红宝石(3级)需要#G20个#W许愿果，确定要兑换吗？")
        self:AddNumText("我要兑换", 0,104)
        self:AddNumText("离开", 0,1000)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 103 then
        if self:LuaFnGetAvailableItemCount(selfId,20502010) < 7 then
            self:MsgBox(selfId,targetId," #{SQXY_09061_26}7#{SQXY_09061_27}")
            return
        end
        if not self:LuaFnDelAvailableItem(selfId,20502010,7) then
            self:MsgBox(selfId,targetId,"扣除许愿果失败。")
            return
        end
        self:BeginAddItem()
        self:AddItem(30900006,1)
        if not self:EndAddItem(selfId) then
            self:MsgBox(selfId,targetId," #{SQXY_09061_20}")
            return
        end
        self:TryRecieveItem(selfId,30900006,true)
        self:MsgBox(selfId,targetId,"#{SQXY_09061_28}")
    elseif nNumText == 104 then
        if self:LuaFnGetAvailableItemCount(selfId,20502010) < 20 then
            self:MsgBox(selfId,targetId," #{SQXY_09061_26}20#{SQXY_09061_27}")
            return
        end
        if not self:LuaFnDelAvailableItem(selfId,20502010,20) then
            self:MsgBox(selfId,targetId,"扣除许愿果失败。")
            return
        end
        self:BeginAddItem()
        self:AddItem(50313004,1)
        if not self:EndAddItem(selfId) then
            self:MsgBox(selfId,targetId," #{SQXY_09061_35}")
            return
        end
        self:TryRecieveItem(selfId,50313004,true)
        self:MsgBox(selfId,targetId,"#{SQXY_09061_28}")
    end
    if nNumText == 200 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{XCHQ_90609_5}")
        self:AddNumText("#{XCHQ_90601_2}", 6,201)
        self:AddNumText("#{XCHQ_90601_3}", 6,202)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 201 then
        if self:LuaFnGetAvailableItemCount(selfId,20502011) < 10 then
            self:NotifyFailTips(selfId,"#{XCHQ_90601_5}")
            return
        end
        if not self:LuaFnDelAvailableItem(selfId,20502011,10) then
            self:NotifyFailTips(selfId,"#{XCHQ_90601_6}")
            return
        end
        self:BeginAddItem()
        self:AddItem(30005045,1)
        if not self:EndAddItem(selfId) then
            self:NotifyFailTips(selfId," #{XCHQ_90601_7}")
            return
        end
        self:TryRecieveItem(selfId,30005045,true)
        self:NotifyFailTips(selfId,"#{XCHQ_90601_8}")
    elseif nNumText == 202 then
        if self:LuaFnGetAvailableItemCount(selfId,20502011) < 120 then
            self:NotifyFailTips(selfId,"#{XCHQ_90601_9}")
            return
        end
        if not self:LuaFnDelAvailableItem(selfId,20502011,120) then
            self:NotifyFailTips(selfId,"#{XCHQ_90601_6}")
            return
        end
        self:BeginAddItem()
        self:AddItem(30005045,1)
        if not self:EndAddItem(selfId) then
            self:NotifyFailTips(selfId," #{XCHQ_90601_7}")
            return
        end
        self:TryRecieveItem(selfId,30005045,true)
        self:NotifyFailTips(selfId,"#{XCHQ_90601_10}")
    end
    if nNumText == 1000 then
        self:CloseMe(selfId)
    end
    if nNumText == 5000 then
        self:BeginEvent(self.script_id)
        self:AddText("#Y您是否拥有着美丽的愿望呢？#W#r #r    传说#G太湖#W的#G（159,187）#W长着一棵神奇的#G许愿树#W，到达#G30级#W的英雄就可以接受#G“一千零一个愿望”#W任务，找到#G愿灵泉#W，怀着您的真心去浇灌它，让您的心愿开花结果吧！")
        self:AddText("    每完成一次任务都能获得一个#G许愿果#W。收集#G7个#W许愿果能够兑换#G天罡强化精华#W一个；收集#G20个#W许愿果能够兑换#G红宝石（3级）#W一个！")
        self:AddText("    除此之外，每当我收集#G1001个#W愿望的时候，会有不可思议的奇迹发生哦！每天都有#G3次#W发生奇迹的机会，还不快来看个究竟？")
        self:AddText("    满足30级的玩家参加#G棋局#W，#G楼兰寻宝#W，#G贼兵入侵#W，#G偷袭门派#W，#G藏经阁活动#W，#G抽取幸运快活三#W，每天完成第#G20环师门任务#W都能固定获得一个#G愿灵泉#W道具。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 5100 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{XCHQ_90601_12}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 5200 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{ZXCM_090602_40}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg== findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,arg,index)
            return
        end
    end
end

function osuzhou_liangdaoshi:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId,targetId)
            end
            return
        end
    end
end

function osuzhou_liangdaoshi:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function osuzhou_liangdaoshi:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end
function osuzhou_liangdaoshi:OnDie(selfId, killerId)
end

function osuzhou_liangdaoshi:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function osuzhou_liangdaoshi:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function osuzhou_liangdaoshi:OnMissionCheck(selfId, targetId, scriptId, index1, index2, index3, indexpet, missionIndex)
    for i, eventId in pairs(self.g_XunWuScriptId) do
        if eventId == scriptId then
            self:CallScriptFunction(
                scriptId,
                "OnMissionCheck",
                selfId,
                targetId,
                scriptId,
                index1,
                index2,
                index3,
                indexpet,
                missionIndex
            )
            return 1
        end
    end
end

function osuzhou_liangdaoshi:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_liangdaoshi:CloseMe(selfId)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
end

return osuzhou_liangdaoshi
