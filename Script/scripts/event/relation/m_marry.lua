local gbk = require "gbk"
local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local m_marry = class("m_marry", script_base)
m_marry.script_id = 806003
m_marry.g_eventId_marry = 0
m_marry.g_eventId_selectLevel1 = 1
m_marry.g_eventId_selectLevel2 = 2
m_marry.g_eventId_selectLevel3 = 3
m_marry.g_eventId_selectLevelCancel = 4
m_marry.g_eventId_selfAcceptLevel1 = 5
m_marry.g_eventId_selfAcceptLevel2 = 6
m_marry.g_eventId_selfAcceptLevel3 = 7
m_marry.g_eventId_selfCancelLevel = 8
m_marry.g_eventId_targetAcceptLevel1 = 9
m_marry.g_eventId_targetAcceptLevel2 = 10
m_marry.g_eventId_targetAcceptLevel3 = 11
m_marry.g_eventId_targetCancelLevel = 12
m_marry.g_eventId_end = 13
m_marry.g_ticketItemId = 30505079
m_marry.g_ticketItemId2 = 30505106
function m_marry:OnDefaultEvent(selfId, targetId, index)
    local selectEventId = index
    if self.g_eventId_marry == selectEventId then
        local canMarry = self:CheckOpenMarryLevelUI(selfId, targetId)
        if canMarry == 1 then
            self:OpenMarryLevelUI(selfId, targetId)
        end
    elseif
        self.g_eventId_selectLevel1 == selectEventId or self.g_eventId_selectLevel2 == selectEventId or
            self.g_eventId_selectLevel3 == selectEventId
     then
        local marryLevel = 0
        if self.g_eventId_selectLevel2 == selectEventId then
            marryLevel = 1
        elseif self.g_eventId_selectLevel3 == selectEventId then
            marryLevel = 2
        end
        self:SelfCheckSelectMarryLevel(selfId, targetId, marryLevel)
    elseif self.g_eventId_selectLevelCancel == selectEventId then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    elseif
        self.g_eventId_selfAcceptLevel1 == selectEventId or self.g_eventId_selfAcceptLevel2 == selectEventId or
            self.g_eventId_selfAcceptLevel3 == selectEventId
     then
        local marryLevel = 0
        if self.g_eventId_selfAcceptLevel2 == selectEventId then
            marryLevel = 1
        elseif self.g_eventId_selfAcceptLevel3 == selectEventId then
            marryLevel = 2
        end
        self:OnSelfAcceptSelectMarryLevel(selfId, targetId, marryLevel)
    elseif self.g_eventId_selfCancelLevel == selectEventId then
        local canMarry = self:CheckOpenMarryLevelUI(selfId, targetId)
        if canMarry == 1 then
            self:OpenMarryLevelUI(selfId, targetId)
        end
    elseif
        self.g_eventId_targetAcceptLevel1 == selectEventId or self.g_eventId_targetAcceptLevel2 == selectEventId or
            self.g_eventId_targetAcceptLevel3 == selectEventId
     then
        local marryLevel = 0
        if self.g_eventId_targetAcceptLevel2 == selectEventId then
            marryLevel = 1
        elseif self.g_eventId_targetAcceptLevel3 == selectEventId then
            marryLevel = 2
        end
        self:OnTargetAcceptSelectMarryLevel(selfId, targetId, marryLevel)
    elseif self.g_eventId_targetCancelLevel == selectEventId then
        self:OnTargetCancelSelectMarryLevel(selfId, targetId)
    elseif self.g_eventId_end == selectEventId then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
end

function m_marry:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, "我想结婚", 10, self.g_eventId_marry)
end

function m_marry:CheckOpenMarryLevelUI(selfId, targetId)
    local ret = self:CheckMarry(selfId, targetId, 0, 1)
    return ret
end

function m_marry:OpenMarryLevelUI(selfId, targetId)
    self:BeginEvent(self.script_id)
    local moneyLevel0 = self:CalcNeedMoney(0)
    local moneyLevel1 = self:CalcNeedMoney(1)
    local moneyLevel2 = self:CalcNeedMoney(2)
    self:AddText(
        "#{yuelao_jiehun}#r一般规模的婚礼，需要花费#{_EXCHG" ..
            moneyLevel0 .. "}；中等规模的婚礼，需要花费#{_EXCHG" .. moneyLevel1 .. "}。豪华规模的婚礼，需要花费#{_EXCHG" .. moneyLevel2 .. "}。"
    )
    self:AddNumText("一般规模的婚礼", 6, self.g_eventId_selectLevel1)
    self:AddNumText("中等规模的婚礼", 6, self.g_eventId_selectLevel2)
    self:AddNumText("豪华规模的婚礼", 6, self.g_eventId_selectLevel3)
    self:AddNumText("我暂时不准备结婚……", 8, self.g_eventId_selectLevelCancel)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function m_marry:SelfCheckSelectMarryLevel(selfId, targetId, marryLevel)
    self:LuaFnSetHumanMarryInfo(selfId, -1, 0)
    self:BeginEvent(self.script_id)
    if marryLevel == 2 then
        self:AddText(
            "你选择了" ..
                self:GetMarryLevelName(marryLevel) ..
                    "，同时你将要支付#Y" ..
                        self:GetItemName(self.g_ticketItemId) ..
                            "#W或#{_EXCHG" .. self:CalcNeedMoney(marryLevel) .. "}，#r你们是否已经决定好结婚，并且在接下来的生活中，不离不弃呢？"
        )
    else
        self:AddText(
            "你选择了" ..
                self:GetMarryLevelName(marryLevel) ..
                    "，同时你将要支付#Y" ..
                        self:GetItemName(self.g_ticketItemId) ..
                            "#W或#Y" ..
                                self:GetItemName(self.g_ticketItemId2) ..
                                    "#W或#{_EXCHG" ..
                                        self:CalcNeedMoney(marryLevel) .. "}，#r你们是否已经决定好结婚，并且在接下来的生活中，不离不弃呢？"
        )
    end
    local tempAcceptEventID = self.g_eventId_selfAcceptLevel1
    if marryLevel == 1 then
        tempAcceptEventID = self.g_eventId_selfAcceptLevel2
    elseif marryLevel == 2 then
        tempAcceptEventID = self.g_eventId_selfAcceptLevel3
    end
    self:AddNumText("确认", 6, tempAcceptEventID)
    self:AddNumText("取消", 8, self.g_eventId_selfCancelLevel)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function m_marry:OnSelfAcceptSelectMarryLevel(selfId, targetId, marryLevel)
    local marryTargetId = self:GetMarryTargetId(selfId, 1, targetId)
    if marryTargetId ~= -1 then
        local marryTargetGUID = self:LuaFnGetGUID(marryTargetId)
        self:LuaFnSetHumanMarryInfo(selfId, marryTargetGUID, 1)
        self:TargetCheckSelectMarryLevel(selfId, targetId, marryLevel)
        self:MessageBox(selfId, targetId, "等待对方确定……")
    end
end

function m_marry:TargetCheckSelectMarryLevel(selfId, targetId, marryLevel)
    local marryTargetId = self:GetMarryTargetId(selfId, 1, targetId)
    if marryTargetId ~= -1 then
        self:LuaFnSetHumanMarryInfo(marryTargetId, -1, 0)
        self:BeginEvent(self.script_id)
        if marryLevel == 2 then
            self:AddText(
                "对方选择了" ..
                    self:GetMarryLevelName(marryLevel) ..
                        "，同时对方将要支付#Y" ..
                            self:GetItemName(self.g_ticketItemId) ..
                                "#W或#{_EXCHG" .. self:CalcNeedMoney(marryLevel) .. "}，#r你们是否已经决定好结婚，并且在接下来的生活中，不离不弃呢？"
            )
        else
            self:AddText(
                "对方选择了" ..
                    self:GetMarryLevelName(marryLevel) ..
                        "，同时对方将要支付#Y" ..
                            self:GetItemName(self.g_ticketItemId) ..
                                "#W或#Y" ..
                                    self:GetItemName(self.g_ticketItemId2) ..
                                        "#W或#{_EXCHG" ..
                                            self:CalcNeedMoney(marryLevel) .. "}，#r你们是否已经决定好结婚，并且在接下来的生活中，不离不弃呢？"
            )
        end
        local tempAcceptEventID = self.g_eventId_targetAcceptLevel1
        if marryLevel == 1 then
            tempAcceptEventID = self.g_eventId_targetAcceptLevel2
        elseif marryLevel == 2 then
            tempAcceptEventID = self.g_eventId_targetAcceptLevel3
        end
        self:AddNumText("确认", 6, tempAcceptEventID)
        self:AddNumText("取消", 8, self.g_eventId_targetCancelLevel)
        self:EndEvent()
        self:DispatchEventList(marryTargetId, targetId)
    end
end

function m_marry:OnTargetAcceptSelectMarryLevel(selfId, targetId, marryLevel)
    local marryTargetId = self:GetMarryTargetId(selfId, 1, targetId)
    if marryTargetId ~= -1 then
        local marryTargetGUID = self:LuaFnGetGUID(marryTargetId)
        self:LuaFnSetHumanMarryInfo(selfId, marryTargetGUID, 1)
        local checkRet, maleId, femaleId = self:CheckMarry(marryTargetId, targetId, marryLevel, 0)
        if checkRet == 1 then
            self:DoMarry(marryTargetId, targetId, marryLevel, maleId, femaleId)
        end
    end
end

function m_marry:OnTargetCancelSelectMarryLevel(selfId, targetId, marryLevel)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
    local marryTargetId = self:GetMarryTargetId(selfId, 0, targetId)
    if marryTargetId ~= -1 then
        self:MessageBox(marryTargetId, targetId, "对方拒绝了你！")
    end
end

function m_marry:CheckMarry(selfId, targetId, marryLevel, isCheckOpenMarryLevelUI)
    local szMsg = "如果想要结婚的话，必须男女双方一起组队之后再来找我。"
    if not self:LuaFnHasTeam(selfId) then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "结婚组队的队伍必须只能由男女双方组成，队伍中不能有其他人员。"
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "只有两人均走到我身边之后才能结婚。"
    local nearNum = self:GetNearTeamCount(selfId)
    if nearNum ~= 2 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "必须双方为异性才可以结婚。"
    local maleId = -1
    local femaleId = -1
    local marryTargetId = -1
    for nearIndex = 1, nearNum do
        local memId = self:GetNearTeamMember(selfId, nearIndex)
        local sexType = self:LuaFnGetSex(memId)
        if sexType == 1 then
            maleId = memId
        else
            femaleId = memId
        end
        if memId ~= selfId then
            marryTargetId = memId
        end
    end
    if maleId == -1 or femaleId == -1 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "结婚时男方需要达到35级，女方需要达到20级。"
    if self:LuaFnGetLevel(maleId) < 35 or self:LuaFnGetLevel(femaleId) < 20 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "必须双方均为未婚才能结婚。"
    if self:LuaFnIsMarried(maleId) or self:LuaFnIsMarried(femaleId) then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "如果需要结婚，双方的友好度必须到达1000。"
    if not self:LuaFnIsFriend(maleId, femaleId) or not self:LuaFnIsFriend(femaleId, maleId) then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    if self:LuaFnGetFriendPoint(maleId, femaleId) < 1000 or self:LuaFnGetFriendPoint(femaleId, maleId) < 1000 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "你们是师徒，怎么可以结婚呢？"
    if self:LuaFnIsMaster(maleId, femaleId) or self:LuaFnIsMaster(femaleId, maleId) then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "已经结拜的双方是不能结婚的。"
    if self:LuaFnIsBrother(maleId, femaleId) or self:LuaFnIsBrother(femaleId, maleId) then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    if isCheckOpenMarryLevelUI and isCheckOpenMarryLevelUI == 1 then
        return 1
    end
    local ticketItemPos
    local selectTicketItemId
    if marryLevel == 2 then
        ticketItemPos = self:GetBagPosByItemSn(selfId, self.g_ticketItemId)
        selectTicketItemId = self.g_ticketItemId
    else
        ticketItemPos = self:GetBagPosByItemSn(selfId, self.g_ticketItemId2)
        selectTicketItemId = self.g_ticketItemId2
        if not ticketItemPos or ticketItemPos < 0 then
            ticketItemPos = self:GetBagPosByItemSn(selfId, self.g_ticketItemId)
            selectTicketItemId = self.g_ticketItemId
        end
    end
    if ticketItemPos and ticketItemPos > -1 then
        local checkRet = self:LuaFnIsItemAvailable(selfId, ticketItemPos)
        if not checkRet then
            self:MessageBox(selfId, targetId, "你的#Y" .. self:GetItemName(selectTicketItemId) .. "#W被锁定了，所以现在还不能交给我。")
            self:MessageBox(
                marryTargetId,
                targetId,
                "对方的#Y" .. self:GetItemName(selectTicketItemId) .. "#W被锁定了，所以现在还不能交给我。"
            )
            return 0
        end
    else
        local nMoneyJZ = self:GetMoneyJZ(selfId)
        local nMoneyJB = self:LuaFnGetMoney(selfId)
        local nMoneySelf = nMoneyJZ + nMoneyJB
        local needMoney = self:CalcNeedMoney(marryLevel)
        if nMoneyJZ and nMoneyJB and nMoneySelf and needMoney and nMoneySelf >= needMoney then
        else
            szMsg = "对不起，你身上的金钱不足。"
            self:MessageBox(selfId, targetId, szMsg)
            szMsg = "对不起，对方身上的金钱不足。"
            self:MessageBox(marryTargetId, targetId, szMsg)
            return 0
        end
    end
    szMsg = "物品背包空间已满，无法放置结婚戒指，请检查双方的背包。"
    local maleProSpace = self:LuaFnGetPropertyBagSpace(maleId)
    local femaleProSpace = self:LuaFnGetPropertyBagSpace(femaleId)
    if maleProSpace < 1 or femaleProSpace < 1 then
        self:MessageBox(maleId, targetId, szMsg)
        self:MessageBox(femaleId, targetId, szMsg)
        return 0
    end
    local selfTaskCount = self:GetMissionCount(selfId)
    if selfTaskCount >= 20 then
        szMsg = "任务记录已满，无法获取新任务。"
        self:MessageBox(selfId, targetId, szMsg)
        szMsg = "对方任务记录已满，无法获取新任务。"
        self:MessageBox(marryTargetId, targetId, szMsg)
        return 0
    end
    szMsg = "双方并没有完全同意结婚。"
    local maleGUID = self:LuaFnGetGUID(maleId)
    local femaleGUID = self:LuaFnGetGUID(femaleId)
    local maleIsAccept, maleTargetGUID = self:LuaFnGetHumanMarryInfo(maleId)
    if maleIsAccept and maleIsAccept == 1 and maleTargetGUID and maleTargetGUID == femaleGUID then
    else
        self:MessageBox(maleId, targetId, szMsg)
        return 0
    end
    local femaleIsAccept, femaleTargetGUID = self:LuaFnGetHumanMarryInfo(femaleId)
    if femaleIsAccept and femaleIsAccept == 1 and femaleTargetGUID and femaleTargetGUID == maleGUID then
    else
        self:MessageBox(femaleId, targetId, szMsg)
        return 0
    end
    return 1
end

function m_marry:DoMarry(selfId, targetId, marryLevel, maleId, femaleId)
    if not self:LuaFnHasTeam(selfId) then
        return 0
    end
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        return 0
    end
    local nearNum = self:GetNearTeamCount(selfId)
    if nearNum ~= 2 then
        return 0
    end
    for nearIndex = 1, nearNum do
        local memId = self:GetNearTeamMember(selfId, nearIndex)
        local sexType = self:LuaFnGetSex(memId)
        if sexType == 1 then
            maleId = memId
        else
            femaleId = memId
        end
    end
    if maleId == -1 or femaleId == -1 then
        return 0
    end
    local ticketItemPos
    if marryLevel == 2 then
        ticketItemPos = self:GetBagPosByItemSn(selfId, self.g_ticketItemId)
    else
        ticketItemPos = self:GetBagPosByItemSn(selfId, self.g_ticketItemId2)
        if not ticketItemPos or ticketItemPos < 0 then
            ticketItemPos = self:GetBagPosByItemSn(selfId, self.g_ticketItemId)
        end
    end
    if ticketItemPos and ticketItemPos > -1 then
        local checkRet = self:LuaFnIsItemAvailable(selfId, ticketItemPos)
        if not checkRet then
            return 0
        end
        local eraseItemRet = self:EraseItem(selfId, ticketItemPos)
        if not eraseItemRet or eraseItemRet ~= 1 then
            return 0
        end
    else
        local nMoneyJZ = self:GetMoneyJZ(selfId)
        local nMoneyJB = self:LuaFnGetMoney(selfId)
        local nMoneySelf = nMoneyJZ + nMoneyJB
        local needMoney = self:CalcNeedMoney(marryLevel)
        if nMoneyJZ and nMoneyJB and nMoneySelf and needMoney and nMoneySelf >= needMoney then
        else
            return 0
        end
        self:LuaFnCostMoneyWithPriority(selfId, needMoney)
    end
    local maleName = self:LuaFnGetName(maleId)
    local femaleName = self:LuaFnGetName(femaleId)
    self:LuaFnAwardSpouseTitle(femaleId, "#gB0E2FF" .. maleName .. "的娘子")
    self:DispatchAllTitle(femaleId)
    self:LuaFnAwardSpouseTitle(maleId, "#gB0E2FF" .. femaleName .. "的夫君")
    self:DispatchAllTitle(maleId)
    self:LuaFnSetPrivateInfo(femaleId, "school", "#gB0E2FF#826" .. maleName .. "的娘子#827")
    self:LuaFnSetPrivateInfo(maleId, "school", "#gB0E2FF#826" .. femaleName .. "的夫君#827")
    local pos
    local ringItemId = self:GetRingByMarryLevel(marryLevel)
    pos = self:TryRecieveItem(maleId, ringItemId, 1)
    if pos and pos ~= -1 then
        self:LuaFnSetItemCreator(maleId, pos, femaleName)
    end
    pos = self:TryRecieveItem(femaleId, ringItemId, 1)
    if pos and pos ~= -1 then
        self:LuaFnSetItemCreator(femaleId, pos, maleName)
    end
    self:SetMissionData(maleId, ScriptGlobal.MD_TW_REEXPERIENCE_WEDDING_TOTAL_COUNT, 0)
    self:SetMissionData(femaleId, ScriptGlobal.MD_TW_REEXPERIENCE_WEDDING_TOTAL_COUNT, 0)
    self:LuaFnMarry(maleId, femaleId, marryLevel)
    self:CallScriptFunction(250036, "OnAccept", selfId, marryLevel)
    self:Msg2Player(maleId, "您获得了称号'" .. femaleName .. "的夫君'。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(femaleId, "您获得了称号'" .. maleName .. "的娘子'。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local ringItemName = self:GetItemName(ringItemId)
    if ringItemName then
        self:Msg2Player(maleId, "您获得了" .. ringItemName .. "。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:Msg2Player(femaleId, "您获得了" .. ringItemName .. "。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    local strChatMessage =
        "#b#cff99ff恭喜#W#{_INFOUSR" ..
        maleName .. "}#b#cff99ff和#W#{_INFOUSR" .. femaleName .. "}#b#cff99ff喜结连理，祝愿他们白头偕老、比翼双飞、一生幸福。"
    strChatMessage = gbk.fromutf8(strChatMessage)
    self:BroadMsgByChatPipe(selfId, "@*;SrvMsg;AUC:" .. strChatMessage, 4)
    local maleGuid = self:LuaFnGetGUID(maleId)
    local femaleGuid = self:LuaFnGetGUID(femaleId)
    self:LuaFnSendMailToAllFriend(maleId, "我亲爱的朋友，我已和" .. femaleName .. "喜结良缘，祝福我们吧！", 1, femaleGuid)
    self:LuaFnSendMailToAllFriend(femaleId, "我亲爱的朋友，我已和" .. maleName .. "喜结良缘，祝福我们吧！", 1, maleGuid)
    local endMsg = "恭喜你们喜结连理，接下来请找洛阳（177，94）的喜来乐安排花车巡游，不过喜来乐负责整个洛阳的喜事，每天特别忙，所以你们一定要在一个小时之后找到他。否则过了这个期限可就没办法了。"
    self:BeginEvent(self.script_id)
    self:AddText(endMsg)
    self:AddNumText("谢谢……", 8, self.g_eventId_end)
    self:EndEvent()
    self:DispatchEventList(maleId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(endMsg)
    self:AddNumText("谢谢……", 8, self.g_eventId_end)
    self:EndEvent()
    self:DispatchEventList(femaleId, targetId)
end

function m_marry:MessageBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function m_marry:CalcNeedMoney(marryLevel)
    if marryLevel == 1 then
        return 5203344
    elseif marryLevel == 2 then
        return 13145200
    else
        return 520520
    end
end

function m_marry:GetMarryLevelName(marryLevel)
    if marryLevel == 1 then
        return "中等规模婚礼"
    elseif marryLevel == 2 then
        return "豪华规模婚礼"
    else
        return "一般规模婚礼"
    end
end

function m_marry:GetRingByMarryLevel(marryLevel)
    if marryLevel == 1 then
        return 10422097
    elseif marryLevel == 2 then
        return 10422098
    else
        return 10422096
    end
end

function m_marry:GetMarryTargetId(selfId, showMessage, targetId)
    local marryTargetId = -1
    local szMsg = "如果想要结婚的话，必须男女双方一起组队之后再来找我。"
    if not self:LuaFnHasTeam(selfId) then
        if showMessage and showMessage == 1 then
            self:MessageBox(selfId, targetId, szMsg)
        end
        return -1
    end
    szMsg = "结婚组队的队伍必须只能由男女双方组成，队伍中不能有其他人员。"
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        if showMessage and showMessage == 1 then
            self:MessageBox(selfId, targetId, szMsg)
        end
        return -1
    end
    szMsg = "只有两人均走到我身边之后才能结婚。"
    local nearNum = self:GetNearTeamCount(selfId)
    if nearNum ~= 2 then
        if showMessage and showMessage == 1 then
            self:MessageBox(selfId, targetId, szMsg)
        end
        return -1
    end
    for nearIndex = 1, nearNum do
        local memId = self:GetNearTeamMember(selfId, nearIndex)
        if memId ~= selfId then
            marryTargetId = memId
        end
    end
    return marryTargetId
end

return m_marry
