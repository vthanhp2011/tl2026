local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local city0_building5 = class("city0_building5", script_base)
city0_building5.script_id = 805012
city0_building5.g_BuildingID6 = 3
city0_building5.g_TicketItemIdx = 40002000
city0_building5.g_OutDateTicketItemIdx = 40000000
city0_building5.g_MerchandiseRate = 1.5
city0_building5.g_GuildRate = 1.00
city0_building5.g_PlayerRate = 1.20
city0_building5.g_TicketTakeTimes = 8
city0_building5.g_BaseTotalTicketTakeTimes = 200
city0_building5.g_TicketTakeTimesBonusPerLvl = 25
city0_building5.g_TicketDecValue = 136
city0_building5.g_TicketIncValue = 680
city0_building5.g_TicketDecRate = 1.0
city0_building5.g_TicketIncRate = 1.0
city0_building5.g_GuildBoomIndex = 18
city0_building5.g_GuildMoneyLimit = 10000

function city0_building5:OnDefaultEvent(selfId, targetId)
    local guildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    local strText
    if (guildid ~= cityguildid) then
        self:BeginEvent(self.script_id)
        strText = "    本帮财务重地，请勿逗留，且在下重职在身，亦不便接待。"
        self:AddText(strText)
        self:AddNumText("商人店铺", 7, 5)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:BeginEvent(self.script_id)
    strText = "    在下负责本帮钱财事务，钱乃诸事之命脉，多在我这里找些事做，于帮於你皆有好处。"
    self:AddText(strText)
    self:AddNumText("领取银票", 6, 2)
    self:AddNumText("交还银票", 6, 3)
    self:AddNumText("钱庄介绍", 11, 4)
    self:AddNumText("商人店铺", 7, 5)
    self:AddNumText("商业路线", 12, 6)
    self:AddNumText("递交过期银票", 6, 7)
    self:AddNumText("领取工资", 7, 8)
    self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT,  "AddCityLifeAbilityOpt", selfId, self.script_id, self.g_BuildingID6, 888)
    self:AddNumText("#{BPZJ_0801014_001}", 6, 11)
    self:AddNumText("#{BPZJ_0801014_002}", 11, 12)
    local Guildpos = self:GetGuildPos(selfId)
    if self:IsManager(Guildpos) == 1 then
        self:AddNumText("领取帮派管理者福利", 7, 9)
        self:AddNumText("关於帮派管理者福利", 11, 10)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function city0_building5:DrawPay(selfId)
    local msg
    if self:GetLevel(selfId) < 40 then
        msg = string.format("您的等级不足40级，因此无法领取工资。")
        self:NotifyTips(selfId, msg)
        return 0
    end
    local nFactionJoinTime = self:GetFactionJoinTime(selfId)
    local nTimeCur = self:LuaFnGetCurrentTime()
    local nTimeDelta = nTimeCur - nFactionJoinTime
    if nTimeDelta < 7 * 24 * 60 * 60 then
        msg = string.format("您入帮的时间不足1周，无法领取工资。")
        self:NotifyTips(selfId, msg)
        return 0
    end
    local nWeekCur = self:GetWeekTime()
    local nCaoYunTime = self:GetMissionData(selfId, ScriptGlobal.MD_CAOYUN_COMPLETE_TIME)
    local nCaoYunNum = (nCaoYunTime % 1000)
    local nWeek = math.floor(nCaoYunTime / 1000)
    local Guildpos = self:GetGuildPos(selfId)
    if ((Guildpos ~= define.GUILD_POSITION_CHIEFTAIN) and
        (Guildpos ~= define.GUILD_POSITION_ASS_CHIEFTAIN)) then
        if nCaoYunNum < 2 or nWeek ~= nWeekCur then
            msg = string.format("您本周的跑商次数不足2次。")
            self:NotifyTips(selfId, msg)
            return 0
        end
    end
    local nFactionAllTimeNum = self:CityGetAttr(selfId, 14)
    local nFactionAllNum = nFactionAllTimeNum % 1000
    local nFactionWeek = math.floor(nFactionAllTimeNum / 1000)
    if nWeekCur ~= nFactionWeek then
        nFactionAllNum = 0
        nFactionAllTimeNum = nWeekCur * 1000 + nFactionAllNum
        local canset = self:CanCitySetAttr(selfId, 14)
        self:CitySetAttr(selfId, 14, nFactionAllTimeNum)
    end
    if nFactionAllNum >= 200 then
        msg = string.format("对不起，本周本帮领取工资达到上线。")
        self:NotifyTips(selfId, msg)
        return 0
    end
    if self:CityGetMaintainStatus(selfId) == 1 then
        msg = string.format("当前本帮处在低维护状态，无法领取工资！")
        self:NotifyTips(selfId, msg)
        return 0
    end
    local nDrawPayTimeLast = self:GetMissionData(selfId, ScriptGlobal.MD_DRAWPAY_TIME)
    local nNum = nDrawPayTimeLast % 1000
    local isPosLongEnough = self:IsGuildPosLongEnough(selfId)
    local minusContri = 30
    if (isPosLongEnough == 1) then
        if (Guildpos == define.GUILD_POSITION_ASS_CHIEFTAIN) then
            minusContri = 15
        elseif (Guildpos == define.GUILD_POSITION_CHIEFTAIN) then
            minusContri = 0
        end
    end
    if nWeekCur ~= nWeek then
        local nContribPoint = self:CityGetAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT)
        nContribPoint = nContribPoint - minusContri
        if nContribPoint < 0 then
            msg = string.format("您的帮贡不足，因此无法领取工资。")
            self:NotifyTips(selfId, msg)
            return 0
        end
        local guildLevel = self:GetGuildLevel(selfId)
        local goldGet = 0
        if guildLevel == 1 then
            goldGet = 5 * 10000
        elseif guildLevel == 2 then
            goldGet = 6 * 10000
        elseif guildLevel == 3 then
            goldGet = 7 * 10000
        elseif guildLevel == 4 then
            goldGet = 8 * 10000
        elseif guildLevel == 5 then
            goldGet = 9 * 10000
        end
        local GuildMoney = self:CityGetAttr(selfId, ScriptGlobal.GUILD_MONEY)
        if GuildMoney < goldGet then
            self:NotifyTips(selfId, "帮派的资金不足，不能领出。")
            return 0
        end
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, (-1) * goldGet)
        nFactionAllNum = nFactionAllNum + 1
        nFactionAllTimeNum = nWeekCur * 1000 + nFactionAllNum
        self:CanCitySetAttr(selfId, 14)
        self:CitySetAttr(selfId, 14, nFactionAllTimeNum)
        if (isPosLongEnough == 1) then
            if (Guildpos == define.GUILD_POSITION_CHIEFTAIN) then
                self:NotifyTips(selfId, "您担任帮主一职超过一周时间，本次领取工资不消耗帮贡。")
            elseif (Guildpos == define.GUILD_POSITION_ASS_CHIEFTAIN) then
                self:NotifyTips(selfId, "您担任副帮主一职超过一周时间，本次领取工资消耗的帮贡减半。")
            end
        end
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT, (-1) * minusContri)
        local guildid = self:GetHumanGuildID(selfId)
        self:LuaFnAuditPlayerGetGuildWage(selfId, guildid, goldGet)
        nNum = 1
        nDrawPayTimeLast = nWeekCur * 1000 + nNum
        self:SetMissionData(selfId, ScriptGlobal.MD_DRAWPAY_TIME, nDrawPayTimeLast)
        self:AddMoney(selfId, goldGet)
        local PlayerName = self:GetName(selfId)
        local sMessage = string.format("@*;SrvMsg;GLD:#Y#{_INFOUSR%s}#cffff00在帮派的金库总管钱为一处领取了本周的工资，共计#{_MONEY%d}。", PlayerName, goldGet)
        self:BroadMsgByChatPipe(selfId, sMessage, 6)
    else
        if nNum >= 1 then
            msg = string.format("您本周已经领过工资，下周再来吧。")
            self:NotifyTips(selfId, msg)
            return 0
        end
        local nContribPoint = self:CityGetAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT)
        nContribPoint = nContribPoint - minusContri
        if nContribPoint < 0 then
            msg = string.format("您的帮贡不足，因此无法领取工资。")
            self:NotifyTips(selfId, msg)
            return 0
        end
        local guildLevel = self:GetGuildLevel(selfId)
        local goldGet = 0
        if guildLevel == 1 then
            goldGet = 5 * 10000
        elseif guildLevel == 2 then
            goldGet = 6 * 10000
        elseif guildLevel == 3 then
            goldGet = 7 * 10000
        elseif guildLevel == 4 then
            goldGet = 8 * 10000
        elseif guildLevel == 5 then
            goldGet = 9 * 10000
        end
        local GuildMoney = self:CityGetAttr(selfId, ScriptGlobal.GUILD_MONEY)
        if GuildMoney < goldGet then
            self:NotifyTips(selfId, "帮派的资金不足，不能领出。")
            return 0
        end
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, (-1) * goldGet)
        nFactionAllNum = nFactionAllNum + 1
        nFactionAllTimeNum = nWeekCur * 1000 + nFactionAllNum
        self:CanCitySetAttr(selfId, 14)
        self:CitySetAttr(selfId, 14, nFactionAllTimeNum)
        if (isPosLongEnough == 1) then
            if (Guildpos == define.GUILD_POSITION_CHIEFTAIN) then
                self:NotifyTips(selfId, "您担任帮主一职超过一周时间，本次领取工资不消耗帮贡。")
            elseif (Guildpos == define.GUILD_POSITION_ASS_CHIEFTAIN) then
                self:NotifyTips(selfId, "您担任副帮主一职超过一周时间，本次领取工资消耗的帮贡减半。")
            end
        end
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT, (-1) * minusContri)
        local guildid = self:GetHumanGuildID(selfId)
        self:LuaFnAuditPlayerGetGuildWage(selfId, guildid, goldGet)
        nNum = nNum + 1
        nDrawPayTimeLast = nWeekCur * 1000 + nNum
        self:SetMissionData(selfId, ScriptGlobal.MD_DRAWPAY_TIME, nDrawPayTimeLast)
        self:AddMoney(selfId, goldGet)
        local PlayerName = self:GetName(selfId)
        local sMessage = string.format("@*;SrvMsg;GLD:#Y#{_INFOUSR%s}#cffff00在帮派的金库总管钱为一处领取了本周的工资，共计#{_MONEY%d}。", PlayerName, goldGet)
        self:BroadMsgByChatPipe(selfId, sMessage, 6)
    end
end

function city0_building5:IsManager(Guildpos)
    if ((Guildpos == define.GUILD_POSITION_CHIEFTAIN) or
        (Guildpos == define.GUILD_POSITION_ASS_CHIEFTAIN) or
        (Guildpos == define.GUILD_POSITION_HR) or (Guildpos == define.GUILD_POSITION_INDUSTRY) or
        (Guildpos == define.GUILD_POSITION_AGRI) or (Guildpos == define.GUILD_POSITION_COM)) then
        return 1
    end
    return 0
end

function city0_building5:DrawManagerBonus(selfId)
    local msg
    if (self:LuaFnGetGuildAppointTime(selfId) < ScriptGlobal.MIN_APPOINT_TIME_FOR_BONUS) then
        msg = string.format("你看看你，新官上任，要多为弟兄们做点事情，而不是急冲冲的来领福利。过几天再来吧！")
        self:NotifyTips(selfId, msg)
        return 0
    end
    local Guildpos = self:GetGuildPos(selfId)
    if (self:IsManager(Guildpos) ~= 1) then
        msg = string.format( "你不是管理层，不能领取帮派官员福利！")
        self:NotifyTips(selfId, msg)
        return 0
    end
    if self:CityGetMaintainStatus(selfId) == 1 then
        msg = string.format("帮会现在资金短缺，每一分钱都要用在刀刃上。管理者福利只能暂停发放啦。")
        self:NotifyTips(selfId, msg)
        return 0
    end
    if self:GetTodayWeek() ~= 0 then
        msg = string.format("还没到发放管理者福利的时候呢，不要太着急啊！")
        self:NotifyTips(selfId, msg)
        return 0
    end
    if self:GetFullExp(selfId) == self:GetExp(selfId) then
        msg = string.format( "你的经验已经达到上限，现在领取福利太不值了吧。去用掉一些再来吧！")
        self:NotifyTips(selfId, msg)
        return 0
    end
    local nWeekCur = self:GetWeekTime()
    local nDrawPayTimeLast = self:GetMissionData(selfId, ScriptGlobal.MD_GUILD_MANAGER_DRAW_BONUS)
    if nWeekCur ~= nDrawPayTimeLast then
        local guildLevel = self:GetGuildLevel(selfId)
        local goldGet = 0
        local GuildMoney = self:CityGetAttr(selfId, ScriptGlobal.GUILD_MONEY)
        local nCount1 = GuildMoney * ScriptGlobal.GUILD_MANAGER_BONUS_MONEY_TABLE[Guildpos][1]

        local nCount2 = guildLevel * ScriptGlobal.GUILD_MANAGER_BONUS_MONEY_TABLE[Guildpos][2]
        goldGet = ((nCount1 < nCount2) and nCount1) or nCount2
        if GuildMoney < goldGet then
            self:NotifyTips(selfId, "帮派的资金不足，不能领出。")
            return 0
        end
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, (-1) * goldGet)
        self:AddMoney(selfId, goldGet)
        local level = self:GetLevel(selfId)
        local expGet = guildLevel * level * ScriptGlobal.GUILD_MANAGER_BONUS_EXP_TABLE[Guildpos]
        self:AddExp(selfId, expGet)
        self:AuditDrawGuildWelfare(selfId, goldGet, expGet)
        self:SetMissionData(selfId, ScriptGlobal.MD_GUILD_MANAGER_DRAW_BONUS, nWeekCur)
        local PlayerName = self:GetName(selfId)
        local sMessage = string.format("@*;SrvMsg;GLD:#Y本帮[%s][#{_INFOUSR%s}]#cffff00领取帮派官员俸禄#{_MONEY%d}和%d点经验。", ScriptGlobal.GUILD_POSITION_NAME_TABLE[Guildpos], PlayerName, goldGet, expGet)
        self:BroadMsgByChatPipe(selfId, sMessage, 6)
        msg = string.format("你的职务是：%s", ScriptGlobal.GUILD_POSITION_NAME_TABLE[Guildpos])
        self:NotifyTips(selfId, msg)
    else
        msg = string.format( "好你个当官的，本周已经领过一次管理者福利了，还要领一次不成？")
        self:NotifyTips(selfId, msg)
        return 0
    end
end

function city0_building5:OnEventRequest(selfId, targetId, arg, index)
    if arg ~= self.script_id then
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnDefaultEvent", selfId, targetId, arg, self.script_id, self.g_BuildingID6)
        return
    end
    local sceneId = self:get_scene_id()
    if index == 1 then
        if (sceneId == 205) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 206) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 207) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 208) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 209) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 210) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 211) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 212) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 213) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 214) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 215) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 216) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 217) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 218) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 219) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 220) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 221) then
            self:DispatchShopItem(selfId, targetId, -1)
        elseif (sceneId == 222) then
            self:DispatchShopItem(selfId, targetId, -1)
        end
    elseif index == 888 then
        self:BeginEvent(self.script_id)
        self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnEnumerate",self,  selfId, targetId, self.g_BuildingID6)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 2 then
        local guildid = self:GetHumanGuildID(selfId)
        local cityguildid = self:GetCityGuildID(selfId)
        if (guildid ~= cityguildid) then
            self:BeginEvent(self.script_id)
            local strText = "阁下不是本帮成员，本帮任务不便相告。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local guildpos = self:GetGuildPos(selfId)
        if ((guildpos ~= define.GUILD_POSITION_COM) and
            (guildpos ~= define.GUILD_POSITION_CHIEFTAIN) and
            (guildpos ~= define.GUILD_POSITION_ASS_CHIEFTAIN) and
            (guildpos ~= define.GUILD_POSITION_AGRI) and
            (guildpos ~= define.GUILD_POSITION_INDUSTRY) and
            (guildpos ~= define.GUILD_POSITION_HR)) then
            self:BeginEvent(self.script_id)
            local strText = "对不起,只有帮主、副帮主、内务使、弘化使、工务使以及商人才能够获得银票."
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local level = self:GetLevel(selfId)
        if (level < 40) then
            self:BeginEvent(self.script_id)
            local strText = "这位小兄弟现在就来经商，未免早了一些，不如到40级再来找我，方是道理。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local curMoney = 0
        local maxMoney = 0
        local maxmaxMoney = 0
        if level >= 40 and level < 55 then
            curMoney = 20000
            maxMoney = 100000
            maxmaxMoney = 250000
        elseif level >= 55 and level < 70 then
            curMoney = 30000
            maxMoney = 150000
            maxmaxMoney = 350000
        elseif level >= 70 and level < 85 then
            curMoney = 40000
            maxMoney = 250000
            maxmaxMoney = 450000
        elseif level >= 85 and level < 100 then
            curMoney = 50000
            maxMoney = 300000
            maxmaxMoney = 550000
        elseif level >= 100 and level < 115 then
            curMoney = 50000
            maxMoney = 310000
            maxmaxMoney = 600000
        elseif level >= 115 and level < 130 then
            curMoney = 60000
            maxMoney = 320000
            maxmaxMoney = 650000
        elseif level >= 130 and level < 145 then
            curMoney = 70000
            maxMoney = 330000
            maxmaxMoney = 700000
        else
            curMoney = 80000
            maxMoney = 340000
            maxmaxMoney = 750000
        end
        local haveImpact = self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 113)
        if haveImpact then
            self:BeginEvent(self.script_id)
            local strText = "对不起,您现在处於运输状态不可接票"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local bagpos = self:GetBagPosByItemSn(selfId, self.g_TicketItemIdx)
        if bagpos ~= -1 then
            self:BeginEvent(self.script_id)
            local strText = "对不起,您只能领取一张银票"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        elseif bagpos == -1 then
            local GuildMoney = self:CityGetAttr(selfId, ScriptGlobal.GUILD_MONEY)
            if GuildMoney <= curMoney then
                self:BeginEvent(self.script_id)
                local strText = "帮派资金不够为你开出银票"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
            local DayTimes, oldDate, nowDate, takenTimes, totalTakenTimes
            DayTimes = self:GetMissionData(selfId, ScriptGlobal.MD_GUILDTICKET_TAKENTIMES)
            oldDate = DayTimes % 100000
            takenTimes = math.floor(DayTimes / 100000)
            nowDate = self:GetDayTime()
            if nowDate == oldDate then
                takenTimes = takenTimes + 1
            else
                takenTimes = 1
            end
            if takenTimes > self.g_TicketTakeTimes then
                self:BeginEvent(self.script_id)
                self:AddText("对不起，您今天领取商人任务已经达到8次，请明天再来。")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
            DayTimes = self:GetTicketTakenTimes(selfId)
            oldDate = DayTimes % 100000
            totalTakenTimes = math.floor(DayTimes / 100000)
            if nowDate == oldDate then
                totalTakenTimes = totalTakenTimes + 1
            else
                totalTakenTimes = 1
            end
            local guildLevel = self:GetGuildLevel(selfId)
            if not guildLevel or guildLevel < 1 or guildLevel > 5 then
                guildLevel = 1
            end
            local maxTimes = self.g_BaseTotalTicketTakeTimes + self.g_TicketTakeTimesBonusPerLvl * (guildLevel - 1)
            local curGuildBoom = self:CityGetAttr(selfId, self.g_GuildBoomIndex)
            if (curGuildBoom < self.g_TicketDecValue) then
                maxTimes = math.floor(maxTimes * self.g_TicketDecRate)
            elseif (curGuildBoom >= self.g_TicketIncValue) then
                maxTimes = math.floor(maxTimes * self.g_TicketIncRate)
            end
            if totalTakenTimes > maxTimes then
                self:BeginEvent(self.script_id)
                self:AddText("我这里今天只有" .. maxTimes .. "张银票，甚是可惜，现在已经领完了，还是明日早来为好。")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
            local itemIdx = 0
            for i = 0, 99 do
                itemIdx = self:LuaFnGetItemTableIndexByIndex(selfId, i)
                if itemIdx >= 20400001 and itemIdx <= 20400200 then
                    self:LuaFnEraseItem(selfId, i)
                end
            end
            self:BeginAddItem()
            self:AddItem(self.g_TicketItemIdx, 1)
            local ret = self:EndAddItem(selfId)
            if ret then

                self:AddItemListToHuman(selfId)
                bagpos = self:GetBagPosByItemSn(selfId, self.g_TicketItemIdx)
                self:SetBagItemParam(selfId, bagpos, ScriptGlobal.TICKET_ITEM_PARAM_CUR_MONEY_START, ScriptGlobal.TICKET_ITEM_PARAM_CUR_MONEY_TYPE, curMoney)
                self:SetBagItemParam(selfId, bagpos, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MONEY_START, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MONEY_TYPE, maxMoney)
                self:SetBagItemParam(selfId, bagpos, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MAX_MONEY_START, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MAX_MONEY_TYPE, maxmaxMoney)
                self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, (-1) * curMoney)
                DayTimes = nowDate + totalTakenTimes * 100000
                self:SetTicketTakenTimes(selfId, DayTimes)
                DayTimes = nowDate + takenTimes * 100000
                self:SetMissionData(selfId, ScriptGlobal.MD_GUILDTICKET_TAKENTIMES, DayTimes)
                self:LuaFnRefreshItemInfo(selfId, bagpos)
                self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 113, 0)
                self:BeginEvent(self.script_id)
                local strText = "我这里还有" .. (maxTimes + 1 - totalTakenTimes) .. "张银票，甚好甚好，这张银票你且拿去，多为本帮赚回些资金，功劳不小啊。"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                self:LuaFnAddMissionHuoYueZhi(selfId, 24)
            else
                self:BeginEvent(self.script_id)
                local strText = "领取银票失败"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
            end
        end
    elseif index == 3 then
        local guildid = self:GetHumanGuildID(selfId)
        local cityguildid = self:GetCityGuildID(selfId)
        local merchandiseDayRate = 1.0
        if (self:GetTodayWeek() == 6) then
            merchandiseDayRate = self.g_MerchandiseRate
        end
        if (guildid ~= cityguildid) then
            self:BeginEvent(self.script_id)
            local strText = "阁下不是本帮成员..."
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local guildpos = self:GetGuildPos(selfId)
        if ((guildpos ~= define.GUILD_POSITION_COM) and
            (guildpos ~= define.GUILD_POSITION_CHIEFTAIN) and
            (guildpos ~= define.GUILD_POSITION_ASS_CHIEFTAIN) and
            (guildpos ~= define.GUILD_POSITION_AGRI) and
            (guildpos ~= define.GUILD_POSITION_INDUSTRY) and
            (guildpos ~= define.GUILD_POSITION_HR)) then
            self:BeginEvent(self.script_id)
            local strText = "对不起,只有帮主、副帮主、内务使、弘化使、工务使以及商人才能够交还银票."
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local level = self:GetLevel(selfId)
        if (level < 40) then
            self:BeginEvent(self.script_id)
            local strText = "这位小兄弟现在就来经商，未免早了一些..."
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local bagpos = self:GetBagPosByItemSn(selfId, self.g_TicketItemIdx)
        if bagpos ~= -1 then
            local TicketMoney = self:GetBagItemParam(selfId, bagpos, ScriptGlobal.TICKET_ITEM_PARAM_CUR_MONEY_START, ScriptGlobal.TICKET_ITEM_PARAM_CUR_MONEY_TYPE)
            local MaxTicketMoney = self:GetBagItemParam(selfId, bagpos, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MONEY_START, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MONEY_TYPE)
            if TicketMoney ~= 0 then
                if TicketMoney < MaxTicketMoney then
                    self:BeginEvent(self.script_id)
                    local strText = "你的银票没有赚到应赚的价值，再去赚赚吧。"
                    self:AddText(strText)
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
                local ReturnType = self:DelItem(selfId, self.g_TicketItemIdx, 1)
                self:LuaFnCancelSpecificImpact(selfId, 113)
                if not ReturnType then
                    self:BeginEvent(self.script_id)
                    local strText = "无法删除银票"
                    self:AddText(strText)
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                else
                    self:BeginEvent(self.script_id)
                    local strText = "成功删除银票"
                    self:AddText(strText)
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                end
                self:LuaFnAuditPaoShang(selfId, TicketMoney)
                local FatigueRate = 1.0
                local isLittleFatigueState = self:LuaFnIsLittleFatigueState(selfId)
                local isExceedingFatigueState = self:LuaFnIsExceedingFatigueState(selfId)
                if (isExceedingFatigueState == 1) then
                    FatigueRate = 0.0
                elseif (isLittleFatigueState == 1) then
                    FatigueRate = 0.5
                end
                self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, TicketMoney * self.g_GuildRate * merchandiseDayRate * FatigueRate)
                self:AddMoney(selfId, TicketMoney * self.g_PlayerRate * merchandiseDayRate)
                local contripoint = 0
                local exppoint = 0
                if level >= 11 and level < 40 then
                    contripoint = 25 * merchandiseDayRate
                    exppoint = 30000
                elseif level >= 40 and level < 60 then
                    contripoint = 50 * merchandiseDayRate
                    exppoint = 45000
                elseif level >= 60 and level < 80 then
                    contripoint = 100 * merchandiseDayRate
                    exppoint = 50000
                elseif level >= 80 and level < 100 then
                    contripoint = 125 * merchandiseDayRate
                    exppoint = 55000
                elseif level >= 100 and level < 120 then
                    contripoint = 150 * merchandiseDayRate
                    exppoint = 60000
                elseif level >= 120 then
                    contripoint = 150 * merchandiseDayRate
                    exppoint = 65000
                end
                self:CityChangeAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT, contripoint)
                self:AddExp(selfId, exppoint * merchandiseDayRate)
                local nCaoYunTime = self:GetMissionData(selfId, ScriptGlobal.MD_CAOYUN_COMPLETE_TIME)
                local nCaoYunNum = nCaoYunTime % 1000
                local nWeek = math.floor(nCaoYunTime / 1000)
                local nWeekCur = self:GetWeekTime()
                if nWeekCur ~= nWeek then
                    nCaoYunNum = 1
                    nCaoYunTime = nWeekCur * 1000 + nCaoYunNum
                    self:SetMissionData(selfId, ScriptGlobal.MD_CAOYUN_COMPLETE_TIME, nCaoYunTime)
                else
                    nCaoYunNum = nCaoYunNum + 1
                    nCaoYunTime = nWeekCur * 1000 + nCaoYunNum
                    self:SetMissionData(selfId, ScriptGlobal.MD_CAOYUN_COMPLETE_TIME, nCaoYunTime)
                end
                local name = self:GetName(selfId)
                self:BroadMsgByChatPipe(selfId, "@*;SrvMsg;GLD:#Y#{_INFOUSR" .. name .. "}#R完成了商人任务，成功的为本帮增加了帮会资金#{_MONEY" .. TicketMoney * self.g_GuildRate *  merchandiseDayRate * FatigueRate ..  "}", 6)
                if (merchandiseDayRate ~= 1.0) then
                    self:Msg2Player(selfId, "#R由於今天是商人日，所以你获得了比平时更多的收益。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
                end
                self:LuaFnComMissComplete(selfId)
            else
                self:BeginEvent(self.script_id)
                local strText = "对不起,您的银票里没钱"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
        else
            self:BeginEvent(self.script_id)
            local strText = "对不起,您没有银票"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
    elseif index == 4 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_QianZhuang}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 5 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(self.g_BuildingID6)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 104)
    elseif index == 6 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 105)
    elseif index == 7 then
        self:BeginEvent(self.script_id)
        self:AddText("请把过期银票拖入到第一个物品格中！")
        self:EndEvent()
        self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, -1, 2)
    elseif index == 8 then
        self:BeginUICommand()
        self:UICommand_AddInt(self.script_id)
        self:UICommand_AddInt(targetId)
        self:UICommand_AddStr("DrawPay")
        self:UICommand_AddStr(
            "您确定要消耗一定数量的帮贡，领取本周的帮派工资吗？")
        self:EndUICommand()
        self:DispatchUICommand(selfId, 24)
    elseif index == 9 then
        self:DrawManagerBonus(selfId)
    elseif index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{BPFL_20080318_01}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 11 then
        local guildmoney = self:CityGetAttr(selfId, ScriptGlobal.GUILD_MONEY)
        local guildmaxmoney = self:CityGetAttr(selfId, 16)
        if guildmoney < guildmaxmoney then
            self:BeginUICommand()
            self:UICommand_AddInt(targetId)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 19822)
        else
            self:BeginEvent(self.script_id)
            self:AddText("#{BPZJ_0801014_003}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{BPZJ_0801014_019}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function city0_building5:OnMissionCheck(selfId, npcid, scriptId, index1, index2,  index3, indexpet)
    if index1 < 0 or index1 >= 255 then
        self:MyNotifyTip(selfId, "您还没有放置想要上交的过期银票。")
        return
    else
        if self:LuaFnIsItemAvailable(selfId, index1) then
            local itm_id = self:LuaFnGetItemTableIndexByIndex(selfId, index1)
            if (itm_id == self.g_OutDateTicketItemIdx) then
                local TicketMoney = self:GetBagItemParam(selfId, index1, 0, 2)
                self:EraseItem(selfId, index1)
                self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, TicketMoney)
                self:AddMoney(selfId, TicketMoney * 0.2)
                local name = self:GetName(selfId)
                self:BroadMsgByChatPipe(selfId, "@*;SrvMsg;GLD:#{_INFOUSR" .. name .. "}不知从哪里得来一张过期银票，#{_MONEY" .. TicketMoney .. "}已充入为本帮的帮会资金。", 6)
                self:MyNotifyTip(selfId, "过期银票充入帮会资金成功。")
                return
            else
                self:MyNotifyTip(selfId, "您要上交的物品似乎不是过期银票啊。")
                return
            end
        end
    end
    self:MyNotifyTip(selfId, "提交失败")
end

function city0_building5:PutGuildMoney(selfId, money)
    local guildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    if guildid ~= cityguildid then
        self:NotifyTips(selfId, "阁下不是本帮成员！")
        return
    end
    if money < self.g_GuildMoneyLimit then
        self:NotifyTips(selfId, "输入的金额小于#{_EXCHG" .. self.g_GuildMoneyLimit .. "}")
        return
    end
    local nMoneyJZ = self:GetMoneyJZ(selfId)
    local nMoneyJB = self:GetMoney(selfId)
    local nMoneySelf = nMoneyJZ + nMoneyJB
    if nMoneySelf < money then
        self:NotifyTips(selfId, "#{BPZJ_0801014_007}")
        return
    end
    if not self:IsPilferLockFlag(selfId) then return end

    local addmoney = math.floor(money * 0.9)
    local guildmoney = self:CityGetAttr(selfId, ScriptGlobal.GUILD_MONEY)
    local guildmaxmoney = self:CityGetAttr(selfId, 16)
    if addmoney + guildmoney > guildmaxmoney then
        self:NotifyTips(selfId, "#{BPZJ_0801014_021}#{_MONEY" .. guildmaxmoney .. "}#{BPZJ_0801014_014}")
        return
    end
    local r, jzCost, jbCost = self:LuaFnCostMoneyWithPriority(selfId, money)
    if not r then
        self:NotifyTips(selfId, "扣除金钱失败！")
        return
    end
    if jzCost == 0 then
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, addmoney)
        self:NotifyTips(selfId, "#{BPZJ_0801014_015}#{_MONEY" .. jbCost .. "}！")
        self:NotifyTips(selfId, "扣税之后，帮会资金实际增长了#{_MONEY" ..addmoney .. "}！")
        local name = self:GetName(selfId)
        self:BroadMsgByChatPipe(selfId, "@*;SrvMsg;GLD:#{_INFOUSR" .. name .. "}#{BPZJ_0801014_017}#{_MONEY" .. jbCost .."}#{BPZJ_0801014_018}", 6)
    end
    if jbCost == 0 then
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, addmoney)
        self:NotifyTips(selfId, "#{BPZJ_0801014_015}#{_EXCHG" .. jzCost .. "}！")
        self:NotifyTips(selfId, "扣税之后，帮会资金实际增长了#{_MONEY" .. addmoney .. "}！")
        local name = self:GetName(selfId)
        self:BroadMsgByChatPipe(selfId, "@*;SrvMsg;GLD:#{_INFOUSR" .. name .. "}#{BPZJ_0801014_017}#{_EXCHG" .. jzCost .."}#{BPZJ_0801014_018}", 6)
    end
    if jzCost ~= 0 and jbCost ~= 0 then
        self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, addmoney)
        self:NotifyTips(selfId, "#{BPZJ_0801014_015}#{_EXCHG" .. jzCost .. "}！")
        self:NotifyTips(selfId, "#{BPZJ_0801014_015}#{_MONEY" .. jbCost .. "}！")
        self:NotifyTips(selfId, "扣税之后，帮会资金实际增长了#{_MONEY" .. addmoney .. "}！")
        local name = self:GetName(selfId)
        self:BroadMsgByChatPipe(selfId, "@*;SrvMsg;GLD:#{_INFOUSR" .. name .. "}#{BPZJ_0801014_017}#{_EXCHG" .. jzCost .. "}和#{_MONEY" .. jbCost .. "}#{BPZJ_0801014_018}", 6)
    end
end

function city0_building5:NotifyTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function city0_building5:MyNotifyTip(selfId, str)
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return city0_building5
