local class = require "class"
local define = require "define"
local script_base = require "script_base"
local pc_militaryofficer = class("pc_militaryofficer", script_base)
pc_militaryofficer.script_id = 805028
pc_militaryofficer.g_BuildingID16 = 11
pc_militaryofficer.g_eventList = {600030}
pc_militaryofficer.g_eventSetList = {600030}
pc_militaryofficer.TIME_2000_01_03_ = 946828868
pc_militaryofficer.g_BuffPalyer_25 = 60
pc_militaryofficer.g_BuffAll_15 = 62
pc_militaryofficer.g_BangGongLimit = 50
pc_militaryofficer.g_Item = 40004426

function pc_militaryofficer:UpdateEventList(selfId, targetId)
    local i = 1
    local eventId = 0
    local PlayerName = self:GetName(selfId)
    local guildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    local strText
    if (guildid ~= cityguildid) then
        self:BeginEvent(self.script_id)
        strText = "什麽人！敢擅闯我帮！"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    self:BeginEvent(self.script_id)
    strText = "老武乃本城武事官员，虽武某一介武夫，有机会可以与我比划比划，对了，还有何见教？"
    self:AddText(strText)
    self:AddText("    " .. PlayerName .. "！ 来做点国防任务咯！")
    local sceneId = self:get_scene_id()
    if self:CityGetSelfCityID(selfId) == sceneId then
        for i, eventId in pairs(self.g_eventList) do
            self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
        end
    end
    self:AddNumText("国防任务介绍", 11, 1)
    self:AddNumText("修建箭楼", 6, 3)
    self:AddNumText("修炼攻击", 6, 4)
    self:AddNumText("配方商店", 7, 5)
    self:AddNumText("武坊介绍", 11, 2)
    self:AddNumText("领取双倍经验", 6, 6)
    self:AddNumText("#{YPLJ_090116_01}", 6, 7)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function pc_militaryofficer:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function pc_militaryofficer:IsValidEvent(selfId, eventId)
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

function pc_militaryofficer:OnEventRequest(selfId, targetId, arg, index)
    if self:IsValidEvent(selfId, arg) == 1 then
        self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
        return
    end
    if index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Defance_Mission_Help}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_WuFang}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 3 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 4 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 5 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(self.g_BuildingID16)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 104)
    elseif index == 6 then
        if self:CityGetMaintainStatus(selfId) == 1 then
            self:BeginEvent(self.script_id)
            self:AddText("  当前本帮处在低维护状态，所有福利都无法提供给诸位，还是同舟共济尽可能为本城赚取更多的资金为好。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:BeginEvent(self.script_id)
        self:AddText(" 在江湖上闯荡，讲究的是效率，是否要领些双倍经验时间呢？")
        self:AddNumText("我要领取一小时双倍经验", 6, 111)
        self:AddNumText("我要领取二小时双倍经验", 6, 222)
        self:AddNumText("我要领取四小时双倍经验", 6, 333)
        self:AddNumText("我想查询我本周双倍经验时间", 6, 444)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 7 then
        if self:GetItemCount(selfId, self.g_Item) >= 1 then
            self:BeginEvent(self.script_id)
            self:AddText("#{YPLJ_090116_02}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        if self:CityGetAttr(selfId, 6) < self.g_BangGongLimit then
            self:BeginEvent(self.script_id)
            self:AddText("#{YPLJ_090116_03}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:BeginEvent(self.script_id)
        self:AddText("#{YPLJ_090116_04}")
        self:AddNumText("#{YPLJ_090116_05}", 6, 8)
        self:AddNumText("#{YPLJ_090116_06}", 6, 9)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif index == 8 then
        if self:GetItemCount(selfId, self.g_Item) >= 3 then return end
        local nGuildPoint = self:CityGetAttr(selfId, 6)
        if nGuildPoint < self.g_BangGongLimit then return end
        self:BeginAddItem()
        self:AddItem(self.g_Item, 1)
        local ret = self:EndAddItem(selfId)
        if not ret then
            self:BeginEvent(self.script_id)
            self:AddText("#{YPLJ_090116_07}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        if self:CityChangeAttr(selfId, 6, -self.g_BangGongLimit) ~= 1 then
            self:BeginEvent(self.script_id)
            self:AddText("#{YPLJ_090116_08}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:AddItemListToHuman(selfId)
        self:BeginEvent(self.script_id)
        self:AddText("#{YPLJ_090116_09}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif index == 9 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return
    elseif index == 111 then
        self:DoubleExpTime(selfId, targetId, 1)
    elseif index == 222 then
        self:DoubleExpTime(selfId, targetId, 2)
    elseif index == 333 then
        self:DoubleExpTime(selfId, targetId, 4)
    elseif index == 444 then
        local _, nCount = self:DEGetCount(selfId)
        if nCount == 0 then
            self:BeginEvent(self.script_id)
            self:AddText("  真是遗憾，我能提供你本周的双倍经验时间为#R 0小时#W了。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("  我能提供你本周的双倍经验时间为#R" ..  nCount .. "小时#W，快好好利用吧。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end

    elseif index == 201 then
        self:DealDoubleExpTime(selfId, targetId, index - 200)
    elseif index == 202 then
        self:DealDoubleExpTime(selfId, targetId, index - 200)
    elseif index == 204 then
        self:DealDoubleExpTime(selfId, targetId, index - 200)
    elseif index == 300 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return
    end
end

function pc_militaryofficer:DealDoubleExpTime(selfId, targetId, nPoint)
    local nGuildPos = self:GetGuildPos(selfId)
    local BasePoint = 25
    if nGuildPos == 8 then
        BasePoint = 12.5
    elseif nGuildPos == 9 then
        BasePoint = 0
    else
        BasePoint = 25
    end
    local bTimeOk = 1
    if nGuildPos == 8 or nGuildPos == 9 then
        local isPosLongEnough = self:IsGuildPosLongEnough(selfId)
        if isPosLongEnough < 1 then
            bTimeOk = 0
            BasePoint = 25
        end
    else
        bTimeOk = -1
    end
    local nCity = self:CityGetAttr(selfId, 6)
    if nCity < math.floor(BasePoint * nPoint) then
        self:BeginEvent(self.script_id)
        self:AddText("  你没有足够的帮会贡献度可以消耗。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if BasePoint ~= 0 then
        if self:CityChangeAttr(selfId, 6, -(math.floor(BasePoint * nPoint))) ~= 1 then
            self:BeginEvent(self.script_id)
            self:AddText(" 扣除帮会贡献度失败，请稍後尝试。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
    end
    local _, nCount = self:DEGetCount(selfId)
    if nCount < nPoint then return end
    local nCurHave = self:DEGetFreeTime(selfId)
    nCurHave = nCurHave + self:DEGetMoneyTime(selfId)
    local nFreeTime = self:DEGetFreeTime(selfId)
    local nTrueTime = nCurHave
    if nTrueTime < 0 then nTrueTime = 0 end
    self:WithDrawFreeDoubleExpTime(selfId, 0, nPoint, 0)
    local nCurTime = self:LuaFnGetCurrentTime()
    self:BeginEvent(self.script_id)
    self:AddText("  你已成功领取了#R" .. nPoint ..  "小时#W的双倍经验时间。现在你一共拥有#Y" .. tostring(math.floor((nTrueTime + nPoint * 3600) / 60)) .. "分钟#W的双倍经验时间")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  你已成功领取了#R" .. nPoint .. "小时#W的双倍经验时间。现在你一共拥有#Y" ..  tostring(math.floor((nTrueTime + nPoint * 3600) / 60)) .. "分钟#W的双倍经验时间")
    self:EndEvent()
    self:DispatchMissionTips(selfId)
    if bTimeOk == 1 then
        if nGuildPos == 8 then
            self:BeginEvent(self.script_id)
            self:AddText( "  由於你担任副帮主超过一周，本次领双消耗帮贡减半。")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        elseif nGuildPos == 9 then
            self:BeginEvent(self.script_id)
            self:AddText("  由於你担任帮主超过一周，本次领双不消耗帮贡。")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        end
    end
    self:SendDoubleExpToClient(selfId)
end

function pc_militaryofficer:DoubleExpTime(selfId, targetId, nTime)
    if self:CityGetMaintainStatus(selfId) == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("  当前本帮处在低维护状态，所有福利都无法提供给诸位，还是同舟共济尽可能为本城赚取更多的资金为好。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local nCurTime = self:LuaFnGetCurrentTime()
    local nPreTime = self:DEGetPreTime(selfId)
    if (nCurTime - nPreTime >= 3600 * 24 * 7) or
        (math.floor((nCurTime - self.TIME_2000_01_03_) / (3600 * 24 * 7)) ~=
            math.floor((nPreTime - self.TIME_2000_01_03_) / (3600 * 24 * 7))) then
        self:DEResetWeeklyFreeTime(selfId)
    end
    self:AddDETime(selfId, targetId, nTime, nCurTime, nPreTime)
end

function pc_militaryofficer:AddDETime(selfId, targetId, nPoint, nCurTime, nPreTime)
    local nCurHave = self:DEGetFreeTime(selfId)
    nCurHave = nCurHave + self:DEGetMoneyTime(selfId)
    local nTrueTime = nCurHave
    local nFreeTime = self:DEGetFreeTime(selfId)
    if nTrueTime < 0 then nTrueTime = 0 end
    local _, nCount = self:DEGetCount(selfId)
    if (nCount <= 0) then
        self:BeginEvent(self.script_id)
        self:AddText("  你本周的双倍经验时间似乎已经用完了。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if nCount < nPoint then
        self:BeginEvent(self.script_id)
        self:AddText("  你没有这麽多的时间可以领取了")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end

    if nFreeTime >= 120 * 60 then
        self:BeginEvent(self.script_id)
        self:AddText("  你在三大城市和自建城市中获得的双倍经验时间已经达到可领取的上限")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end

    if nFreeTime + nPoint * 3600 > 3600 * 4 then
        self:BeginEvent(self.script_id)
        self:AddText("  你在三大城市和自建城市中获得的双倍经验时间已经达到可领取的上限")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:DEIsLock(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText( "  你还有冻结的双倍经验时间，还是先解冻再领取新的双倍经验时间吧。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:BeginEvent(self.script_id)
    if (nTrueTime / 60) > 0 then
        self:AddText("  你本周双倍经验时间剩余#R" ..
                         tostring(math.floor(nCount)) ..
                         "小时#W，当前已有双倍经验时间#Y" ..
                         tostring(math.floor(nTrueTime / 60)) ..
                         "分钟#W，你确认要领取#Y" ..
                         tostring(math.floor(nPoint * 60)) ..
                         "分钟#W双倍经验时间并同时消耗帮派贡献度" ..
                         tostring(math.floor(nPoint * 25)) ..
                         "吗？#r  如果你担任了一周以上的帮主，可以不用消耗帮贡，副帮主可以减半。")
    else
        self:AddText("  你本周双倍经验时间剩余#R" ..
                         tostring(math.floor(nCount)) ..
                         "小时#W，你确认要领取#Y" ..
                         tostring(math.floor(nPoint * 60)) ..
                         "分钟#W双倍经验时间并同时消耗帮派贡献度" ..
                         tostring(math.floor(nPoint * 25)) ..
                         "吗？#r  如果你担任了一周以上的帮主，可以不用消耗帮贡，副帮主可以减半。")
    end
    if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, self.g_BuffPalyer_25) or self:LuaFnHaveImpactOfSpecificDataIndex(selfId, self.g_BuffAll_15) then
        self:AddText("  #r  #R请注意:您身上已经存在了多倍经验时间，是否确认领取？")
    end
    self:AddNumText("是的，我要领取。", -1, 200 + nPoint)
    self:AddNumText("不了，我点错了。", -1, 300)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function pc_militaryofficer:OnMissionAccept(selfId, targetId, missionScriptId)
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

function pc_militaryofficer:OnMissionRefuse(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:UpdateEventList(selfId, targetId)
        return
    end
end

function pc_militaryofficer:OnMissionContinue(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
        return
    end
end

function pc_militaryofficer:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId,  selectRadioId)
        return
    end
end

function pc_militaryofficer:OnDie(selfId, killerId) end

function pc_militaryofficer:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return pc_militaryofficer
