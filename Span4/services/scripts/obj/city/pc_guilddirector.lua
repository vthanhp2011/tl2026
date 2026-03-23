local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local pc_guilddirector = class("pc_guilddirector", script_base)
pc_guilddirector.script_id = 805009
pc_guilddirector.g_BuildingID1 = 0
pc_guilddirector.g_eventList = {600035, 600040}
pc_guilddirector.g_eventSetList = {600035, 600040}
pc_guilddirector.g_TicketItemIdx = 40002000
pc_guilddirector.g_Yinpiao = 40002000
pc_guilddirector.g_GuildContriTitle = {{
    ["currName"] = "",
    ["nextId"] = 242,
    ["needContri"] = 250,
    ["name"] = "★关内侯"
}, {
    ["currName"] = "★关内侯",
    ["nextId"] = 243,
    ["needContri"] = 750,
    ["name"] = "★亭侯"
}, {
    ["currName"] = "★亭侯",
    ["nextId"] = 244,
    ["needContri"] = 1500,
    ["name"] = "★乡侯"
}, {
    ["currName"] = "★乡侯",
    ["nextId"] = 245,
    ["needContri"] = 3000,
    ["name"] = "★县侯"
}, {
    ["currName"] = "★县侯",
    ["nextId"] = 246,
    ["needContri"] = 7500,
    ["name"] = "★郡侯"
}, {
    ["currName"] = "★郡侯",
    ["nextId"] = 247,
    ["needContri"] = 15000,
    ["name"] = "★县公"
}, {
    ["currName"] = "★县公",
    ["nextId"] = 248,
    ["needContri"] = 30000,
    ["name"] = "★郡公"
}, {
    ["currName"] = "★郡公",
    ["nextId"] = 249,
    ["needContri"] = 60000,
    ["name"] = "★国公"
}, {
    ["currName"] = "★国公",
    ["nextId"] = 250,
    ["needContri"] = 125000,
    ["name"] = "★郡王"
}, {
    ["currName"] = "★郡王",
    ["nextId"] = 251,
    ["needContri"] = 250000,
    ["name"] = "★亲王"
}}

function pc_guilddirector:UpdateEventList(selfId, targetId)
    local i = 1
    local eventId = 0
    local Humanguildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    self:BeginEvent(self.script_id)

    if (Humanguildid == cityguildid) then
        self:AddText("    帮中大小事务，有需要我能帮你什麽的，一家兄弟不必客气。")
        self:AddNumText("设置/查看上线留言", 6, 22)
        self:AddNumText("城市建设", 6, 12)
        self:AddNumText("城市研究", 6, 14)
        for i, eventId in pairs(self.g_eventList) do
            self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
        end
        self:AddNumText("商业路线", 12, 18)
        self:AddNumText("县衙介绍", 11, 19)
        self:AddNumText("建设任务介绍", 11, 20)
        self:AddNumText("研究任务介绍", 11, 21)
        self:AddNumText("#{BGCH_8829_02}", 11, 25)
        self:AddNumText("申请成为帮主", 6, 23)
        self:AddNumText("#{SQBZ_090205_01}", 11, 26)
        self:AddNumText("#{BHCS_090226_10}", 9, 29)
        local currGuildContriSum = self:CityGetAttr(selfId, 15)
        local currGuildContriTitle = self:GetGuildContriTitle(selfId)
        local guildName = self:LuaFnGetGuildName(selfId)
        for i, titleItem in pairs(self.g_GuildContriTitle) do
            if currGuildContriTitle == "" then
                currGuildContriTitle = guildName
            end
            if currGuildContriTitle == guildName .. titleItem["currName"] then
                self:AddNumText("晋升为" .. titleItem["name"], 6, 30)
                break
            end
        end
        self:AddNumText("#{BGCH_8829_01}", 6, 24)
    else
        local PlayerGender = self:GetSex(selfId)
        local rank
        if PlayerGender == 0 then
            rank = "侠女"
        elseif PlayerGender == 1 then
            rank = "少侠"
        else
            rank = "这位"
        end
        self:AddText("    " .. rank .. "面生得紧，我乃本城的主管，有什麽事情我可以接待外客。")
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function pc_guilddirector:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function pc_guilddirector:IsValidEvent(selfId, eventId)
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

function pc_guilddirector:OnEventRequest(selfId, targetId, arg, index)
    if self:IsValidEvent(selfId, arg) == 1 then
        self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
        return
    end
    local strText = ""
    if index == 1 then
        self:CityBuildingChange(selfId, self.g_BuildingID1, 0)
    elseif index == 2 then
        self:CityBuildingChange(selfId, self.g_BuildingID1, 1)
    elseif index == 3 then
        self:CityBuildingChange(selfId, self.g_BuildingID1, 2)
    elseif index == 4 then
        self:CityBuildingChange(selfId, self.g_BuildingID1, 3)
    elseif index == 5 then
        self:CityBuildingChange(selfId, self.g_BuildingID1, 4)
    elseif index == 6 then
        self:CitySetLevel(selfId, 0)
    elseif index == 7 then
        self:CitySetLevel(selfId, 1)
    elseif index == 8 then
        self:CitySetLevel(selfId, 2)
    elseif index == 9 then
        self:CitySetLevel(selfId, 3)
    elseif index == 10 then
        self:CitySetLevel(selfId, 4)
    elseif index == 11 then
        if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
            self:BeginEvent(self.script_id)
            self:AddText("  你身上有银票，正在跑商！我不能帮助你。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 0, 144, 98)
    elseif index == 12 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 100)
    elseif index == 13 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 101)
    elseif index == 14 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 102)
    elseif index == 15 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 103)
    elseif index == 18 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 105)
    elseif index == 16 then
        local guildid = self:GetHumanGuildID(selfId)
        local cityguildid = self:GetCityGuildID(selfId)
        if (guildid ~= cityguildid) then
            self:BeginEvent(self.script_id)
            strText = "阁下不是本帮成员，本帮任务不便相告。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local guildpos = self:GetGuildPos(selfId)
        if ((guildpos ~= define.GUILD_POSITION_COM) and (guildpos ~= define.GUILD_POSITION_CHIEFTAIN)) then
            self:BeginEvent(self.script_id)
            strText = "对不起,只有商业官员或是帮主才能够获得官票."
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local level = self:GetLevel(selfId)
        if (level < 40) then
            self:BeginEvent(self.script_id)
            strText = "这位小兄弟现在就来经商，未免早了一些，不如到40级再来找我，方是道理。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local curMoney = 0
        local maxMoney = 0
        if level >= 40 and level < 55 then
            curMoney = 20000
            maxMoney = 100000
        elseif level >= 55 and level < 69 then
            curMoney = 30000
            maxMoney = 150000
        elseif level >= 70 and level < 84 then
            curMoney = 40000
            maxMoney = 250000
        elseif level >= 85 and level < 100 then
            curMoney = 50000
            maxMoney = 300000
        end
        local bagpos = self:GetBagPosByItemSn(selfId, self.g_TicketItemIdx)
        if bagpos ~= -1 then
            self:BeginEvent(self.script_id)
            strText = "对不起,您只能领取一张官票"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        elseif bagpos == -1 then
            local GuildMoney = self:CityGetAttr(selfId, ScriptGlobal.GUILD_MONEY)
            if GuildMoney <= curMoney then
                self:BeginEvent(self.script_id)
                strText = "帮派资金不够为你开出银票"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
            end
            self:BeginAddItem()
            self:AddItem(self.g_TicketItemIdx, 1)
            ret = self:EndAddItem(selfId)
            if ret then
                self:AddItemListToHuman(selfId)
                bagpos = self:GetBagPosByItemSn(selfId, self.g_TicketItemIdx)
                self:SetBagItemParam(selfId, bagpos, ScriptGlobal.TICKET_ITEM_PARAM_CUR_MONEY_START, ScriptGlobal.TICKET_ITEM_PARAM_CUR_MONEY_TYPE, curMoney)
                self:SetBagItemParam(selfId, bagpos, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MONEY_START, ScriptGlobal.TICKET_ITEM_PARAM_MAX_MONEY_TYPE, maxMoney)
                self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, (-1) * curMoney)
                self:LuaFnRefreshItemInfo(selfId, bagpos)
                self:BeginEvent(self.script_id)
                strText = "甚好甚好，这张银票你且拿去，多为本帮赚回些资金，功劳不小啊。"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
            else
                self:BeginEvent(self.script_id)
                strText = "背包已满,无法接受任务"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
            end
        end
    elseif index == 17 then
        local guildid = self:GetHumanGuildID(selfId)
        local cityguildid = self:GetCityGuildID(selfId)
        if (guildid ~= cityguildid) then
            self:BeginEvent(self.script_id)
            strText = "阁下不是本帮成员..."
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local guildpos = self:GetGuildPos(selfId)
        if ((guildpos ~= define.GUILD_POSITION_COM) and (guildpos ~= define.GUILD_POSITION_CHIEFTAIN)) then
            self:BeginEvent(self.script_id)
            strText = "对不起,只有商业官员或是帮主才能够交还银票."
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        local level = self:GetLevel(selfId)
        if (level < 40) then
            self:BeginEvent(self.script_id)
            strText = "这位小兄弟现在就来经商，未免早了一些..."
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
                    strText = "你的银票没有赚到应赚的价值，再去赚赚吧。"
                    self:AddText(strText)
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
                self:CityChangeAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT, 50)
                self:CityChangeAttr(selfId, ScriptGlobal.GUILD_MONEY, TicketMoney * 0.9)
                self:AddMoney(selfId, TicketMoney * 0.1)
                self:AddExp(selfId, 20000)
                local ReturnType = self:DelItem(selfId, self.g_TicketItemIdx, 1)
                if not ReturnType  then
                    self:BeginEvent(self.script_id)
                    strText = "无法删除银票"
                    self:AddText(strText)
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                else
                    self:BeginEvent(self.script_id)
                    strText = "成功删除银票"
                    self:AddText(strText)
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
            else
                self:BeginEvent(self.script_id)
                strText = "对不起,您的银票里没钱"
                self:AddText(strText)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
        else
            self:BeginEvent(self.script_id)
            strText = "对不起,您没有银票"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
    elseif index == 19 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_XianYa}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 20 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_Build}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 21 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_Research}")

        self:EndEvent()

        self:DispatchEventList(selfId, targetId)

    elseif index == 22 then
        local guildpos = self:GetGuildPos(selfId)
        if guildpos ~= define.GUILD_POSITION_ASS_CHIEFTAIN and guildpos ~= define.GUILD_POSITION_CHIEFTAIN then
            self:BeginUICommand()
            self:UICommand_AddInt(targetId)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 19841120)
            return
        else
            self:BeginUICommand()
            self:UICommand_AddInt(targetId)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 19840424)
            return
        end
    elseif index == 23 then
        self:GuildPromoteToChief(selfId)
    elseif index == 24 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19821)
    elseif index == 25 then
        self:BeginEvent(self.script_id)
        self:AddText("#{BGCH_8829_05}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 26 then
        self:BeginEvent(self.script_id)
        self:AddText("#{SQBZ_090205_02}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 27 then
        if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
            self:BeginEvent(self.script_id)
            self:AddText("  你身上有银票，正在跑商！我不能帮助你。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 2, 181, 120)
    elseif index == 28 then
        if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
            self:BeginEvent(self.script_id)
            self:AddText("  你身上有银票，正在跑商！我不能帮助你。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 1, 224, 185)
    elseif index == 29 then
        self:BeginEvent(self.script_id)
        self:AddText("#{BHCS_090226_11}")
        self:AddNumText("回到洛阳", 9, 11)
        self:AddNumText("#{BHCS_090219_02}", 9, 27)
        self:AddNumText("#{BHCS_090219_03}", 9, 28)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 30 then
        local currGuildContriSum = self:CityGetAttr(selfId, 15)
        local currGuildContriTitle = self:GetGuildContriTitle(selfId)
        local guildName = self:LuaFnGetGuildName(selfId)
        for i, titleItem in pairs(self.g_GuildContriTitle) do
            if currGuildContriTitle == "" then
                currGuildContriTitle = guildName
            end
            if currGuildContriTitle == guildName .. titleItem["currName"] then
                local playerName = self:GetName(selfId)
                if currGuildContriSum < titleItem["needContri"] then
                    local strTip = "#R" .. playerName .. "#W！晋升为帮会的#G" .. guildName .. titleItem["name"] .. "#W需要为帮会做出#G" .. titleItem["needContri"] .. "#W点贡献的！想要晋升的话，就为帮会多做一些事情吧！"
                    self:BeginEvent(self.script_id)
                    self:AddText(strTip)
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    return
                end
                self:AwardGuildContriTitle(selfId, guildName .. titleItem["name"])
                self:SetCurTitle(selfId, 38, 0)
                self:LuaFnDispatchAllTitle(selfId)
                local strTip = "恭喜你！#R" .. playerName .. "#W！你现在是我们帮会的#G" .. guildName .. titleItem["name"] .. "#W了！为了帮会的盛世霸业，继续努力吧！"
                self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
                local sMessage = string.format("@*;SrvMsg;GLD:#W本帮高手#R#{_INFOUSR%s}#W为本帮立下大功，赐予爵位：#G%s#W！望#R#{_INFOUSR%s}#W再接再厉，为本帮再立新功！", playerName, guildName .. titleItem["name"], playerName)
                self:BroadMsgByChatPipe(selfId, sMessage, 6)
                sMessage = string.format("#W#{_INFOUSR%s}为#G%s#W的建设不辞辛苦，特赐予爵位：#G%s#W！", playerName, guildName, guildName .. titleItem["name"])
                self:BroadMsgByChatPipe(selfId, sMessage, 4)
                self:BeginEvent(self.script_id)
                self:AddText(strTip)
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
                break
            end
        end
    end
end

function pc_guilddirector:OnMissionAccept(selfId, targetId, missionScriptId)
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

function pc_guilddirector:OnMissionRefuse(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:UpdateEventList(selfId, targetId)
        return
    end
end

function pc_guilddirector:OnMissionContinue(selfId, targetId, missionScriptId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
        return
    end
end

function pc_guilddirector:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    if self:IsValidEvent(selfId, missionScriptId) == 1 then
        self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
        return
    end
end

function pc_guilddirector:OnDie(selfId, killerId)

end

function pc_guilddirector:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function pc_guilddirector:BanggongExchange(selfId, nvalue)
    local haveBangGong = self:CityGetAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT)
    if not self:IsPilferLockFlag(selfId) then
        return
    end
    if nvalue > haveBangGong then
        self:NotifyFailTips(selfId, "#{BGCH_8829_03}")
        return
    end
    if nvalue > 200 then
        self:NotifyFailTips(selfId, "#{BGCH_8922_25}")
        return
    end
    if nvalue < 10 then
        self:NotifyFailTips(selfId, "#{BGCH_8922_26}")
        return
    end
    local totalvalue = math.floor(nvalue * 0.1) + nvalue
    if totalvalue > haveBangGong then
        self:NotifyFailTips(selfId, "#{BGCH_8922_27}")
        return
    end
    if self:LuaFnGetPropertyBagSpace(selfId) <= 0 then
        self:NotifyFailTips(selfId, "#{SJQM_8819_20}")
        return
    end
    local ret = self:CityChangeAttr(selfId, ScriptGlobal.GUILD_CONTRIB_POINT, -totalvalue)
    if ret == 1 then
        local BagIndex = self:TryRecieveItem(selfId, 30900050)
        local roleBangPaiID = self:GetHumanGuildID(selfId)
        if BagIndex ~= -1 then
            self:SetBagItemParam(selfId, BagIndex, 4, 2, roleBangPaiID)
            self:SetBagItemParam(selfId, BagIndex, 8, 2, nvalue)
            self:LuaFnRefreshItemInfo(selfId, BagIndex)
            self:NotifyFailTips(selfId, "#{BGCH_8829_10}" .. nvalue .. "#{BGCH_8829_11}")
        else
            self:NotifyFailTips(selfId, "创建物品出错")
        end
    else
        self:NotifyFailTips(selfId, "扣除帮贡失败")
    end
end

return pc_guilddirector
