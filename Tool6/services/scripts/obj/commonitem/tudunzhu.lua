local class = require "class"
local define = require "define"
local script_base = require "script_base"
local tudunzhu = class("tudunzhu", script_base)
tudunzhu.script_id = 300056
tudunzhu.g_ItemId = 30008030
tudunzhu.g_Yinpiao = 40002000
tudunzhu.g_NoChuangsongScn = { 151, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 191, 195 }
tudunzhu.g_UselessScn = { 125, 414, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 191, 195, 413 }
tudunzhu.g_LimitTransScene = {
    {186,75},
    {424,90},
    {520,90},
    {423,90},
    {519,90},
    {425,90},
    {427,90},
    {433,90},
    {434,90},
    {431,90},
    {432,90},
    {201,90},
    {202,90},
    {400,30},
    {401,30},
    {402,30},
    {1299,90},
    {159,21},
    {160,21},
    {161,21},
    {162,21},
    {163,21},
    {164,21},
    {165,21},
    {166,21},
    {167,21},
    {158,20},
}
tudunzhu.g_Impact_NotTransportList = { 5929 }
tudunzhu.g_TalkInfo_NotTransportList = { "#{GodFire_Info_062}" }
function tudunzhu:OnDefaultEvent(selfId, nItemIndex)
end

function tudunzhu:IsSkillLikeScript(selfId)
    return 1
end

function tudunzhu:CancelImpacts(selfId)
    return 0
end

function tudunzhu:OnDeplete(selfId)
    return 1
end

function tudunzhu:OnConditionCheck(selfId, idid)
    local bagId = self:LuaFnGetBagIndexOfUsedItem(selfId)
    if self:GetItemTableIndexByIndex(selfId, bagId) ~= self.g_ItemId then
        return 0
    end
    if self:LuaFnLockCheck(selfId, bagId) < 0 then
        return 0
    end
    for i, ImpactId in pairs(self.g_Impact_NotTransportList) do
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, ImpactId) then
            self:BeginEvent(self.script_id)
            self:AddText(self.g_TalkInfo_NotTransportList[i])
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return 0
        end
    end
    local nUseCount = self:GetBagItemParam(selfId, bagId, 0,"uchar")
    local x = self:GetBagItemParam(selfId, bagId, 4,"uchar")
    local z = self:GetBagItemParam(selfId, bagId, 8,"uchar")
    local nTarSceneId = math.floor(nUseCount / 100)
    local nCount = nUseCount - nTarSceneId * 100
    if nUseCount == 0 and x == 0 and z == 0 then
        self:MsgBox(selfId, "你的土遁珠尚未定位！")
        return 0
    end
    for _, tmp in pairs(self.g_LimitTransScene) do
        if ((tmp[1] == nTarSceneId) and (self:GetLevel(selfId) < tmp[2])) then
            local szMsg = self:format("此场景需要%d级以上方可入内", tmp[2])
            self:MsgBox(selfId, szMsg)
            return 0
        end
    end
    if self:GetLevel(selfId) < 10 then
        self:MsgBox(selfId, "此场景需要10级以上方可入内")
        return 0
    end
    return 1
end

function tudunzhu:CallMe(selfId, nItemIndex, PlayerGuid)
    local sceneId = self:GetSceneID()
    if self:IsHaveMission(selfId, 4021) then
        self:MsgBox(selfId, "您处于不允许传送的状态，不能使用土遁珠传送！")
        return 0
    end
    if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
        self:MsgBox(selfId, "您处于不允许传送的状态，不能使用土遁珠传送！")
        return 0
    end
    for _, tmp in pairs(self.g_NoChuangsongScn) do
        if tmp == sceneId then
            self:MsgBox(selfId, "此场景内不能使用土遁珠传送！")
            return 0
        end
    end
    if self:LuaFnIsStalling(selfId) then
        self:MsgBox(selfId, "摆摊状态下，不能使用土遁珠传送！")
        return 0
    end
    if self:IsTeamFollow(selfId) then
        self:MsgBox(selfId, "你处于组队跟随状态，不能使用土遁珠传送！")
        return 0
    end
    local inbus = self:LuaFnGetBusPassengerIDIsInBus(selfId)
    if inbus == 1 then
        self:MsgBox(selfId, "您处于无法使用传送的情况下，无法使用传送道具！")
        return 0
    end
    for i, ImpactId in pairs(self.g_Impact_NotTransportList) do
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, ImpactId) then
            self:BeginEvent(self.script_id)
            self:AddText(self.g_TalkInfo_NotTransportList[i])
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return 0
        end
    end
    local Time = self:GetMissionDataEx(selfId, 123)
    local nTarSceneId = self:GetMissionDataEx(selfId, 124)
    local x = self:GetMissionDataEx(selfId, 125)
    local z = self:GetMissionDataEx(selfId, 126)
    for _, tmp in pairs(self.g_LimitTransScene) do
        if ((tmp[1] == nTarSceneId) and (self:GetLevel(selfId) < tmp[2])) then
            local szMsg = self:format("此场景需要%d级以上方可入内", tmp[2])
            self:MsgBox(selfId, szMsg)
            return 0
        end
    end
    if self:LuaFnGetCurrentTime() - Time < 30 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, nTarSceneId, x, z)
    end
    self:SetMissionDataEx(selfId, 123, 0)
    self:SetMissionDataEx(selfId, 124, 0)
    self:SetMissionDataEx(selfId, 125, 0)
    self:SetMissionDataEx(selfId, 126, 0)
end

function tudunzhu:UseItem(selfId, nType, nItemIndex)
    if self:GetLevel(selfId) < 10 then
        self:MsgBox(selfId, "等级不够")
        return
    end
    if nType == 0 then
        self:SetPosition(selfId, nItemIndex)
    elseif nType == 1 then
    end
end

function tudunzhu:OnActivateOnce(selfId)
    local bagId = self:LuaFnGetBagIndexOfUsedItem(selfId)
    if not bagId then
        return
    end
    self:PlayerGoto(selfId, bagId)
end

function tudunzhu:MsgBox(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function tudunzhu:SetPosition(selfId, nItemIndex)
    local sceneId = self:GetSceneID()
    if self:LuaFnGetSceneType() == 1 or self:LuaFnGetSceneType() == 4 then
        self:MsgBox(selfId, "副本或帮会城市内不能使用土遁珠定位！")
        return 0
    end
    for _, tmp in pairs(self.g_UselessScn) do
        if tmp == sceneId then
            self:MsgBox(selfId, "此场景内无法使用土遁珠定位！")
            return 0
        end
    end
    if self:GetItemTableIndexByIndex(selfId, nItemIndex) ~= self.g_ItemId then
        self:BeginEvent(self.script_id)
        self:AddText("  背包内部错误")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    if self:LuaFnLockCheck(selfId, nItemIndex) < 0 then
        self:MsgBox(selfId, "此物品已被锁定！")
        return 0
    end
    local nUseCount = self:GetBagItemParam(selfId, nItemIndex, 0, "uchar")
    local x = self:GetBagItemParam(selfId, nItemIndex, 4, "uchar")
    local z = self:GetBagItemParam(selfId, nItemIndex, 8, "uchar")
    local nTarSceneId = math.floor(nUseCount / 100)
    local nCount = nUseCount - nTarSceneId * 100
    if nUseCount == 0 and x == 0 and z == 0 then
        nCount = 10
    end
    x,z= self:GetWorldPos(selfId)
    self:SetBagItemParam(selfId, nItemIndex, 0, sceneId * 100 + nCount,"uchar")
    self:SetBagItemParam(selfId, nItemIndex, 4, math.floor(x),"uchar")
    self:SetBagItemParam(selfId, nItemIndex, 8, math.floor(z),"uchar")
    self:LuaFnRefreshItemInfo(selfId, nItemIndex)
    self:BeginEvent(self.script_id)
    self:AddText("你的土遁珠定位成功。")
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function tudunzhu:PlayerGoto(selfId, nItemIndex)
    local sceneId = self:GetSceneID()
    if self:GetItemTableIndexByIndex(selfId, nItemIndex) ~= self.g_ItemId then
        self:BeginEvent(self.script_id)
        self:AddText("  背包内部错误")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    if self:IsTeamFollow(selfId) then
        self:MsgBox(selfId, "你处于组队跟随状态，不能使用土遁珠传送！")
        return 0
    end
    if self:IsHaveMission(selfId, 4021) then
        self:MsgBox(selfId, "您处于不允许传送的状态，不能使用土遁珠传送！")
        return 0
    end
    if self:LuaFnLockCheck(selfId, nItemIndex) < 0 then
        self:MsgBox(selfId, "此物品已被锁定！")
        return 0
    end
    if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
        self:MsgBox(selfId, "您处于不允许传送的状态，不能使用土遁珠传送！")
        return 0
    end
    for _, tmp in pairs(self.g_NoChuangsongScn) do
        if tmp == sceneId then
            self:MsgBox(selfId, "此场景内不能使用土遁珠传送！")
            return 0
        end
    end
    if self:LuaFnIsStalling(selfId) then
        self:MsgBox(selfId, "摆摊状态下，不能使用土遁珠传送！")
        return 0
    end
    for i, ImpactId in pairs(self.g_Impact_NotTransportList) do
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, ImpactId) then
            self:BeginEvent(self.script_id)
            self:AddText(self.g_TalkInfo_NotTransportList[i])
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return 0
        end
    end
    local nUseCount = self:GetBagItemParam(selfId, nItemIndex, 0,"uchar")
    local nTarSceneId = math.floor(nUseCount / 100)
    local nCount = nUseCount - nTarSceneId * 100
    local nPointX = self:GetBagItemParam(selfId, nItemIndex, 4, "uchar")
    local nPointZ = self:GetBagItemParam(selfId, nItemIndex, 8, "uchar")
    if nCount == 0 and nPointX == 0 and nPointZ == 0 then
        self:MsgBox(selfId, "这个土遁珠尚未定位，不能执行传送。")
        return
    end
    local ret = 0
    if nCount > 1 then
        self:SetBagItemParam(selfId, nItemIndex, 0, nTarSceneId * 100 + (nCount - 1),"uchar")
        self:LuaFnRefreshItemInfo(selfId, nItemIndex)
        ret = 1
    elseif nCount <= 1 then
        ret = self:EraseItem(selfId, nItemIndex)
    end
    if ret then
        local nTeamCount = self:GetNearTeamCount(selfId)
        local selfGuid = self:LuaFnGetGUID(selfId)
        local nTarSceneName = self:GetSceneName(nTarSceneId)
        if nTeamCount > 0 then
            for i = 1, nTeamCount do
                local nPlayerId = self:GetNearTeamMember(selfId, i)
                if nPlayerId ~= selfId then
                    local str = "你的队友" ..
                    self:GetName(selfId) .. "使用了土遁珠，回到了【" ..
                    nTarSceneName .. "】，你是否也要跟着一起传送？注意：超过20秒仍未做决定将取消传送。"
                    self:BeginUICommand()
                    self:UICommand_AddInt(self.g_scriptId)
                    self:UICommand_AddInt(nItemIndex)
                    self:UICommand_AddInt(selfGuid)
                    self:UICommand_AddStr("CallMe")
                    self:UICommand_AddStr(str)
                    self:EndUICommand()
                    self:DispatchUICommand(nPlayerId, 1009)
                    self:SetMissionDataEx(nPlayerId, 123, self:LuaFnGetCurrentTime())
                    self:SetMissionDataEx(nPlayerId, 124, nTarSceneId)
                    self:SetMissionDataEx(nPlayerId, 125, nPointX)
                    self:SetMissionDataEx(nPlayerId, 126, nPointZ)
                end
            end
        end
        self:CallScriptFunction((400900), "TransferFunc", selfId, nTarSceneId, nPointX, nPointZ)
    end
end

return tudunzhu
