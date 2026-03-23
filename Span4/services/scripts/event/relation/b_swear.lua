local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local b_swear = class("b_swear", script_base)
b_swear.script_id = 806001
b_swear.g_NeedMoney = 100000
b_swear.g_DrawTitleNeedMoney = 50000
b_swear.g_ChangeTitleNeedMoney = 10000
b_swear.g_msg_swear = {}

b_swear.g_msg_swear["swr"] = "结拜"
b_swear.g_msg_swear["tit"] = "领取称号"
b_swear.g_msg_swear["chr"] = "修改个人称号"
b_swear.g_msg_swear["tem"] = " 你需要和你要结拜之人组队前来找我，我才能给你们主持结拜仪式。"
b_swear.g_msg_swear["ten"] = " 你的队伍中有人不在洛阳城中，所以我无法为你们主持结拜仪式。"
b_swear.g_msg_swear["cap"] = " 只有队长才能完成结拜的操作。"
b_swear.g_msg_swear["mar"] = " 夫妻之间是不能结拜的。你们还是先回去吧。"
b_swear.g_msg_swear["mat"] = " 师徒之间是不能结拜的。你们还是先回去吧。"
b_swear.g_msg_swear["fri"] = " 只有好友之间才能结拜。你们还需要进一步提高友谊才行。"
b_swear.g_msg_swear["all"] = " 所有的结拜兄弟必须同时在队伍中，才能加入新的结拜兄弟。"
b_swear.g_msg_swear["one"] = " 你们已经是结拜兄弟了，不需要再结拜一次来加深友谊了。"
b_swear.g_msg_swear["alr"] = " 您的队伍中A已经结拜过，所以我无法为你们结拜。"
b_swear.g_msg_swear["frd"] = " 如果你们想结拜的话，我可以为你们主持结拜仪式，撰写金兰谱。不过在这之前我要确认你们之间的友好度已经达到1000点。"
b_swear.g_msg_swear["mon"] = " 进行结拜仪式需要花费#{_EXCHG%d}，你确定要结拜吗？"
b_swear.g_msg_swear["nom"] = " 您身上的现金不足#{_EXCHG%d}。"
b_swear.g_msg_swear["con"] = " 兄弟结拜，今后有福同享，有难同当。你真的确定要结拜吗？"
b_swear.g_msg_swear["chn"] = " 你的队伍发生了变化，所以我无法为你们主持结拜仪式。"
b_swear.g_msg_swear["bul"] = " 皇天在上，后土在下！你们今日结拜为兄弟，以后有福同享，有难同当！不求同年同月同日生，但求同年同月同日死！天下英雄们，祝贺他们吧！"
b_swear.g_msg_swear["pro"] = " 恭喜诸位，你们已经成为结拜兄弟，请你们的队长来领取结拜称号吧。"
b_swear.g_msg_swear["caa"] = " 必须和你的所有结拜兄弟组队，才能领取结拜称号。"
b_swear.g_msg_swear["cac"] = " 只有队长才能为结拜兄弟们领取称号。"
b_swear.g_msg_swear["cas"] = " 你还没有结拜过，不能领取结拜称号。"
b_swear.g_msg_swear["cab"] = " 你的队伍中有人不是你的结拜兄弟。"
b_swear.g_msg_swear["cat"] = " 你已经领取过结拜称号了。"
b_swear.g_msg_swear["can"] = " 你还没有领取过结拜称号，还不能修改结拜称号。"
b_swear.g_msg_swear["ccs"] = " 你还没有结拜过，不能修改结拜称号。"
b_swear.g_msg_swear["nmm"] = " 修改结拜称号需要#{_EXCHG%d}，你身上的现金不足。"
b_swear.g_msg_swear["ner"] = " 你距离我太远了，我无法为你们主持结拜仪式。"
b_swear.g_msg_swear["nel"] = " 你的队伍正在结拜，而你距离我太远，我无法为你们主持结拜仪式。"
b_swear.g_msg_swear["wait"] = " 等待其他人回复。"
b_swear.g_key = {}

b_swear.g_key["swear"] = 10000
b_swear.g_key["allow"] = 10001
b_swear.g_key["unall"] = 10002
b_swear.g_key["confi"] = 10003
b_swear.g_key["uncon"] = 10004
b_swear.g_key["title"] = 20000
b_swear.g_key["chrti"] = 30000
function b_swear:OnDefaultEvent(selfId, targetId, index)
    local key = index
    if key == self.g_key["swear"] then
        if self:CheckAccept(selfId, targetId) == 0 then
            return 0
        end
        self:LogTeamInfo(selfId, targetId)
        self:OnSubmit(selfId, targetId)
        return 1
    end
    if key == self.g_key["allow"] then
        local nMoneyJZ = self:GetMoneyJZ(selfId)
        local nMoneyJB = self:LuaFnGetMoney(selfId)
        local nMoneySelf = nMoneyJZ + nMoneyJB
        if nMoneySelf < self.g_NeedMoney then
            local msg = string.format(self.g_msg_swear["nom"], self.g_NeedMoney)
            self:MessageBox(selfId, targetId, msg)
            return 0
        end
        self:OnConfirm(selfId, targetId)
        return 1
    end
    if key == self.g_key["unall"] then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return 1
    end
    if key == self.g_key["confi"] then
        self:AgreeSwear(selfId, targetId)
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        if self:CheckIfAllAgreeSwear(selfId, targetId) == 1 then
            self:DoSwear(selfId, targetId)
        else
            self:WaitSwear(selfId, targetId)
        end
        return 1
    end
    if key == self.g_key["uncon"] then
        self:QuitSwear(selfId, targetId)
        return 1
    end
    if key == self.g_key["title"] then
        local TeamSize = self:CheckDrawTitle(selfId, targetId)
        if TeamSize == 0 then
            return 0
        end
        self:LogTeamInfo(selfId, targetId)
        self:LuaFnDrawJieBaiName(selfId, TeamSize)
        return 1
    end
    if key == self.g_key["chrti"] then
        if self:CheckChangeTitle(selfId, targetId) == 0 then
            return 0
        end
        self:LuaFnChangeJieBaiName(selfId)
        return 1
    end
    return 0
end

function b_swear:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, self.g_msg_swear["swr"], 6, self.g_key["swear"])
    caller:AddNumTextWithTarget(self.script_id, self.g_msg_swear["tit"], 6, self.g_key["title"])
    caller:AddNumTextWithTarget(self.script_id, self.g_msg_swear["chr"], 6, self.g_key["chrti"])
end

function b_swear:CheckAccept(selfId, targetId)
    if not self:LuaFnHasTeam(selfId) then
        self:MessageBox(selfId, targetId, self.g_msg_swear["tem"])
        return 0
    end
    local TeamSize = self:LuaFnGetTeamSize(selfId)
    if TeamSize == 1 then
        self:MessageBox(selfId, targetId, self.g_msg_swear["tem"])
        return 0
    end
    local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(selfId)
    if TeamSizeSameScene + 1 ~= TeamSize then
        self:MessageBox(selfId, targetId, self.g_msg_swear["ten"])
        return 0
    end
    if not self:LuaFnIsTeamLeader(selfId) then
        self:MessageBox(selfId, targetId, self.g_msg_swear["cap"])
        return 0
    end
    if not self:IsInDist(selfId, targetId, 6) then
        self:MessageBox(selfId, targetId, self.g_msg_swear["ner"])
        return 0
    end
    local theID
    local otherID
    local Friend1
    local Friend2
    local Brothers = 0
    local BrotherNum = self:LuaFnIsSweared(selfId)
    for i = 1, TeamSizeSameScene do
        theID = self:LuaFnGetTeamSceneMember(selfId, i)
        if self:LuaFnIsSpouses(selfId, theID) then
            self:MessageBox(selfId, targetId, self.g_msg_swear["mar"])
            return 0
        end
        if self:LuaFnIsMaster(selfId, theID) then
            self:MessageBox(selfId, targetId, self.g_msg_swear["mat"])
            return 0
        end
        if self:LuaFnIsPrentice(theID, selfId) then
            self:MessageBox(selfId, targetId, self.g_msg_swear["mat"])
            return 0
        end
        if not self:LuaFnIsFriend(selfId, theID) then
            self:MessageBox(selfId, targetId, self.g_msg_swear["fri"])
            return 0
        end
        if not self:LuaFnIsFriend(theID, selfId) then
            self:MessageBox(selfId, targetId, self.g_msg_swear["fri"])
            return 0
        end
        Friend1 = self:LuaFnGetFriendPoint(selfId, theID)
        Friend2 = self:LuaFnGetFriendPoint(theID, selfId)
        if Friend1 < 1000 or Friend2 < 1000 then
            self:MessageBox(selfId, targetId, self.g_msg_swear["frd"])
            return 0
        end
        if not self:IsInDist(theID, targetId, 6) then
            local theName = self:LuaFnGetName(theID)
            self:MessageBox(selfId, targetId, " 您的队伍中#R" .. theName .. "#W距离我太远，所以我无法为你们结拜。")
            self:MessageBox(theID, targetId, self.g_msg_swear["nel"])
            return 0
        end
        local theSwear = self:LuaFnIsSweared(theID)
        if theSwear then
            if BrotherNum then
                if self:LuaFnIsBrother(selfId, theID) then
                    local theName = self:LuaFnGetName(theID)
                    self:MessageBox(selfId, targetId, " 您的队伍中" .. theName .. "已经是别人的结拜兄弟，我无法再给你们主持结拜仪式了。")
                    return 0
                end
            else
                local theName = self:LuaFnGetName(theID)
                self:MessageBox(selfId, targetId, " 您的队伍中" .. theName .. "已经是别人的结拜兄弟，我无法再给你们主持结拜仪式了。")
            end
        end
        if theSwear and BrotherNum then
            Brothers = Brothers + 1
        end
        for j = i, TeamSizeSameScene do
            otherID = self:LuaFnGetTeamSceneMember(theID, j)
            if self:LuaFnIsSpouses(theID, otherID) then
                self:MessageBox(selfId, targetId, self.g_msg_swear["mar"])
                return 0
            end
            if self:LuaFnIsMaster(theID, otherID) then
                self:MessageBox(selfId, targetId, self.g_msg_swear["mat"])
                return 0
            end
            if self:LuaFnIsPrentice(otherID, theID) then
                self:MessageBox(selfId, targetId, self.g_msg_swear["mat"])
                return 0
            end
            if not self:LuaFnIsFriend(theID, otherID) then
                self:MessageBox(selfId, targetId, self.g_msg_swear["fri"])
                return 0
            end
            if not self:LuaFnIsFriend(otherID, theID) then
                self:MessageBox(selfId, targetId, self.g_msg_swear["fri"])
                return 0
            end
            Friend1 = self:LuaFnGetFriendPoint(theID, otherID)
            Friend2 = self:LuaFnGetFriendPoint(otherID, theID)
            if Friend1 < 1000 or Friend2 < 1000 then
                self:MessageBox(selfId, targetId, self.g_msg_swear["frd"])
                return 0
            end
        end
    end
    if BrotherNum > 0 then
        if BrotherNum == Brothers then
            if BrotherNum == TeamSizeSameScene then
                self:MessageBox(selfId, targetId, self.g_msg_swear["one"])
                return 0
            end
        else
            self:MessageBox(selfId, targetId, self.g_msg_swear["all"])
            return 0
        end
    end
    return 1
end

function b_swear:MessageBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function b_swear:ConfirmSwear(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_msg_swear["con"])
    self:AddNumText("确认结拜", 6, self.g_key["confi"])
    self:AddNumText("我不想结拜了", 8, self.g_key["uncon"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function b_swear:OnSubmit(selfId, targetId)
    self:BeginEvent(self.script_id)
    local msg = string.format(self.g_msg_swear["mon"], self.g_NeedMoney)
    self:AddText(msg)
    self:AddNumText("确定", 6, self.g_key["allow"])
    self:AddNumText("取消", 8, self.g_key["unall"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function b_swear:OnConfirm(selfId, targetId)
    self:ConfirmSwear(selfId, targetId)
    local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(selfId)
    for i = 1, TeamSizeSameScene do
        self:ConfirmSwear(self:LuaFnGetTeamSceneMember(selfId, i), targetId)
    end
end

function b_swear:LogTeamInfo(selfId, targetId)
    self:LuaFnTeamSnapshort(selfId)
    local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(selfId)
    for i = 1, TeamSizeSameScene do
        self:LuaFnTeamSnapshort(self:LuaFnGetTeamSceneMember(selfId, i))
    end
end

function b_swear:QuitSwear(selfId, targetId)
    self:BeginUICommand()
    self:UICommand_AddInt(targetId)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
    local TeamLeaderID = self:GetTeamLeader(selfId)
    if TeamLeaderID ~= define.INVAILD_ID then
        local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(TeamLeaderID)
        local msg = self:LuaFnGetName(selfId) .. "思虑再三，退出了结拜仪式。"
        if TeamLeaderID ~= selfId then
            self:MessageBox(selfId, targetId, msg)
            self:MessageBox(TeamLeaderID, targetId, msg)
        end
        for i = 1, TeamSizeSameScene do
            local theID = self:LuaFnGetTeamSceneMember(TeamLeaderID, i)
            if theID ~= selfId then
                self:MessageBox(selfId, targetId, msg)
                self:MessageBox(theID, targetId, msg)
            end
        end
    end
end

function b_swear:AgreeSwear(selfId, targetId)
    self:LuaFnAgreeSwear(selfId, selfId)
    local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(selfId)
    for i = 1, TeamSizeSameScene do
        local theID = self:LuaFnGetTeamSceneMember(selfId, i)
        self:LuaFnAgreeSwear(theID, selfId)
    end
end

function b_swear:CheckIfAllAgreeSwear(selfId, targetId)
    if not self:LuaFnIfAllTeamAgreeSwear(selfId) then
        return 0
    end
    local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(selfId)
    for i = 1, TeamSizeSameScene do
        local theID = self:LuaFnGetTeamSceneMember(selfId, i)
        if not self:LuaFnIfAllTeamAgreeSwear(theID) then
            return 0
        end
    end
    return 1
end

function b_swear:DoSwear(selfId, targetId)
    local TeamLeaderID = self:GetTeamLeader(selfId)
    if TeamLeaderID == define.INVAILD_ID then
        return 0
    end
    local BrotherNum = self:LuaFnIsSweared(TeamLeaderID)
    local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(TeamLeaderID)
    if BrotherNum == TeamSizeSameScene then
        return 0
    end
    if self:LuaFnVerifyTeamWithSnapshort(TeamLeaderID) then
        self:MessageBox(TeamLeaderID, targetId, self.g_msg_swear["chn"])
        return 0
    end
    if self:CheckAccept(TeamLeaderID, targetId) == 0 then
        self:MessageBox(TeamLeaderID, targetId, self.g_msg_swear["chn"])
        return 0
    end
    local ret = self:LuaFnCostMoneyWithPriority(TeamLeaderID, 100000)
    if not ret then
        local msg = string.format(self.g_msg_swear["nom"], self.g_NeedMoney)
        self:MessageBox(TeamLeaderID, targetId, msg)
        return 0
    end
    local Names = self:LuaFnGetName(TeamLeaderID)
    self:LuaFnAllTeamSwear(TeamLeaderID)
    for i = 1, TeamSizeSameScene do
        local theID = self:LuaFnGetTeamSceneMember(TeamLeaderID, i)
        self:LuaFnAllTeamSwear(theID)
        Names = Names .. "," .. self:LuaFnGetName(theID)
    end
    self:MessageBox(TeamLeaderID, targetId, self.g_msg_swear["pro"])
    for i = 1, TeamSizeSameScene do
        local theID = self:LuaFnGetTeamSceneMember(TeamLeaderID, i)
        self:MessageBox(theID, targetId, self.g_msg_swear["pro"])
    end
    local sAllUserName = ""
    local sUserName
    local nearteammembercount = self:GetNearTeamCount(selfId)
    for i = 1, nearteammembercount do
        local idMem = self:GetNearTeamMember(selfId, i)
        sUserName = self:GetName(idMem)
        local sUserName2 = string.format("#B#{_INFOUSR%s}#Y", sUserName)
        sAllUserName = sAllUserName .. sUserName2
        if i ~= nearteammembercount then
            sAllUserName = sAllUserName .. "、"
        end
    end
    local sMessage = string.format("#{JieBai_00}%s#{JieBai_01}", sAllUserName)
    self:BroadMsgByChatPipe(selfId, sMessage, 4)
end

function b_swear:CheckDrawTitle(selfId, targetId)
    if not self:LuaFnHasTeam(selfId) then
        self:MessageBox(selfId, targetId, self.g_msg_swear["caa"])
        return 0
    end
    local TeamSize = self:LuaFnGetTeamSize(selfId)
    if TeamSize == 1 then
        self:MessageBox(selfId, targetId, self.g_msg_swear["caa"])
        return 0
    end
    local TeamSizeSameScene = self:LuaFnGetTeamSceneMemberCount(selfId)
    if TeamSizeSameScene + 1 ~= TeamSize then
        self:MessageBox(selfId, targetId, self.g_msg_swear["caa"])
        return 0
    end
    if not self:LuaFnIsTeamLeader(selfId) then
        self:MessageBox(selfId, targetId, self.g_msg_swear["cac"])
        return 0
    end
    local BrotherNum = self:LuaFnIsSweared(selfId)
    if BrotherNum == 0 then
        self:MessageBox(selfId, targetId, self.g_msg_swear["cas"])
        return 0
    end
    local Brothers = 0
    for i = 1, TeamSizeSameScene do
        local theID = self:LuaFnGetTeamSceneMember(selfId, i)
        if not self:LuaFnIsBrother(selfId, theID) then
            self:MessageBox(selfId, targetId, self.g_msg_swear["cab"])
            return 0
        end
        Brothers = Brothers + 1
    end
    if BrotherNum ~= Brothers then
        self:MessageBox(selfId, targetId, self.g_msg_swear["caa"])
        return 0
    end
    local nMoneyJZ = self:GetMoneyJZ(selfId)
    local nMoneyJB = self:LuaFnGetMoney(selfId)
    local nMoneySelf = nMoneyJZ + nMoneyJB
    if nMoneySelf < self.g_DrawTitleNeedMoney then
        local msg = string.format(self.g_msg_swear["nom"], self.g_DrawTitleNeedMoney)
        self:MessageBox(selfId, targetId, msg)
        return 0
    end
    return TeamSize
end

function b_swear:CheckChangeTitle(selfId, targetId)
    local BrotherNum = self:LuaFnIsSweared(selfId)
    if BrotherNum == 0 then
        self:MessageBox(selfId, targetId, self.g_msg_swear["ccs"])
        return 0
    end
    local title = self:LuaFnGetJieBaiName(selfId)
    if title == nil then
        self:MessageBox(selfId, targetId, self.g_msg_swear["can"])
        return 0
    end
    local nMoneyJZ = self:GetMoneyJZ(selfId)
    local nMoneyJB = self:LuaFnGetMoney(selfId)
    local nMoneySelf = nMoneyJZ + nMoneyJB
    if nMoneySelf < self.g_ChangeTitleNeedMoney then
        local msg = string.format(self.g_msg_swear["nmm"], self.g_ChangeTitleNeedMoney)
        self:MessageBox(selfId, targetId, msg)
        return 0
    end
    return 1
end

function b_swear:WaitSwear(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(self.g_msg_swear["wait"])
    self:AddNumText("我不想结拜了", 8, self.g_key["uncon"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return b_swear
