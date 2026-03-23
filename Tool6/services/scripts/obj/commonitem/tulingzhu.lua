local class = require "class"
local define = require "define"
local script_base = require "script_base"
local tulingzhu = class("tulingzhu", script_base)
tulingzhu.script_id = 330001
tulingzhu.g_ItemId = 30008007
tulingzhu.g_ItemId01 = 30505216
tulingzhu.g_UseTim = 10
tulingzhu.g_Yinpiao = 40002000
tulingzhu.g_UselessScn = { 151, 539, 540, 541, 542, 543, 544, 545, 546, 547, 191, 548, 195 }
tulingzhu.g_SetPosLimitScn = { 125, 414, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 191, 195, 413 }
tulingzhu.g_LimitTransScene = { 
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
tulingzhu.g_StrCannotUse = "您处于无法使用传送的情况下，无法使用传送道具。"
tulingzhu.g_Impact_NotTransportList = { 5929 }
tulingzhu.g_TalkInfo_NotTransportList = { "#{GodFire_Info_062}" }
function tulingzhu:OnDefaultEvent(selfId, bagIndex)
end

function tulingzhu:IsSkillLikeScript(selfId)
    return 1
end

function tulingzhu:CancelImpacts(selfId)
    return 0
end

function tulingzhu:OnConditionCheck(selfId)
    local bagId = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local sceneId = self:GetSceneID()
    if bagId < 0 then
        return 0
    end
    if (1 ~= self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    if self:LuaFnLockCheck(selfId, bagId, 0) < 0 then
        self:MsgBox(selfId, "此物品已被锁定！")
        return 0
    end
    if self:IsTeamFollow(selfId) then
        self:MsgBox(selfId, self.g_StrCannotUse)
        return 0
    end
    if self:LuaFnIsStalling(selfId) then
        self:MsgBox(selfId, self.g_StrCannotUse)
        return 0
    end
    if self:IsHaveMission(selfId, 4021) then
        self:MsgBox(selfId, self.g_StrCannotUse)
        return 0
    end
    if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
        self:MsgBox(selfId, self.g_StrCannotUse)
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
    for _, tmp in pairs(self.g_UselessScn) do
        if tmp == sceneId then
            self:MsgBox(selfId, "此场景内无法使用！")
            return 0
        end
    end
    local otim
    local osid
    local opx, opy
    otim = self:GetBagItemParam(selfId, bagId, 3,"uchar")
    osid = self:GetBagItemParam(selfId, bagId, 4,"uchar")
    opx = self:GetBagItemParam(selfId, bagId, 6,"uchar")
    opy = self:GetBagItemParam(selfId, bagId, 8,"uchar")
    if opx > 0 and opy > 0 then
        for _, tmp in pairs(self.g_LimitTransScene) do
            if ((tmp[1] == osid) and (self:GetLevel(selfId) < tmp[2])) then
                local szMsg = self:format("此场景需要%d级以上方可入内", tmp[2])
                self:MsgBox(selfId, szMsg)
                return 0
            end
        end
    end
    if self:GetLevel(selfId) < 10 then
        self:MsgBox(selfId, "此场景需要10级以上方可入内")
        return 0
    end
    return 1
end

function tulingzhu:OnDeplete(selfId)
    local ret
    local sceneId = self:GetSceneID()
    ret = self:OnConditionCheck(selfId)
    if 0 == ret then
        return 0
    end
    local bagId = self:LuaFnGetBagIndexOfUsedItem(selfId)
    if self:GetBagItemParam(selfId, bagId, 6,"uchar") > 0
    and self:GetBagItemParam(selfId, bagId, 8,"uchar") > 0 then
        return 1
    else
        self:MsgBox(selfId, "请选择合适的地点定位后再使用传送功能。")
        return 0
    end
    return 1
end

function tulingzhu:OnActivateOnce(selfId)
    local bagId = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local sceneId = self:GetSceneID()
    local otim
    local osid
    local opx, opy
    otim = self:GetBagItemParam(selfId, bagId, 3,"char")
    osid = self:GetBagItemParam(selfId, bagId, 4,"short")
    opx = self:GetBagItemParam(selfId, bagId, 6,"short")
    opy = self:GetBagItemParam(selfId, bagId, 8,"short")
    otim = otim - 1
    self:SetBagItemParam(selfId, bagId, 3, otim,"char")
    self:LuaFnRefreshItemInfo(selfId, bagId)
    local ret
    if otim <= 0 then
        ret = self:EraseItem(selfId, bagId)
        if not ret then
            return
        end
    end
    if opx > 0 and opy > 0 then
        if sceneId == osid then
            self:SetPos(selfId, opx, opy)
        else
            self:CallScriptFunction((400900), "TransferFunc", selfId, osid, opx, opy)
        end
    end
    return 1
end

function tulingzhu:OnActivateEachTick(selfId)
    return 1
end

function tulingzhu:MsgBox(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function tulingzhu:SetPosition(selfId, nItemIndex)
    local sceneId = self:GetSceneID()
    if self:GetLevel(selfId) < 10 then
        self:MsgBox(selfId, "等级不够")
        return
    end
    if self:LuaFnLockCheck(selfId, nItemIndex, 0) < 0 then
        self:MsgBox(selfId, "此物品已被锁定！")
        return 0
    end
    if self:GetItemTableIndexByIndex(selfId, nItemIndex) ~= self.g_ItemId and self:GetItemTableIndexByIndex(selfId, nItemIndex) ~= self.g_ItemId01 then
        self:MsgBox(selfId, "背包内部错误")
        return
    end
    if self:LuaFnGetSceneType() == 1 or self:LuaFnGetSceneType() == 4 then
        self:MsgBox(selfId, "副本或帮会城市内无法定位！")
        return
    end
    for _, tmp in pairs(self.g_SetPosLimitScn) do
        if tmp == sceneId then
            self:MsgBox(selfId, "此场景内无法使用！")
            return
        end
    end
    local otim
    local osid
    local opx, opy
    otim = self:GetBagItemParam(selfId, nItemIndex, 3,"char")
    osid = self:GetBagItemParam(selfId, nItemIndex, 4,"short")
    opx = self:GetBagItemParam(selfId, nItemIndex, 6,"short")
    opy = self:GetBagItemParam(selfId, nItemIndex, 8,"short")
    if otim == 0 and osid == 0 and opx == 0 and opy == 0 then
        otim = self.g_UseTim
    end
    osid = sceneId
    opx,opy = self:LuaFnGetUnitPosition(selfId)
    opx = math.floor(opx)
    opy = math.floor(opy)
    self:SetBagItemParam(selfId, nItemIndex, 0, 10,"uchar")
    self:SetBagItemParam(selfId, nItemIndex, 2, self.g_UseTim,"uchar")
    self:SetBagItemParam(selfId, nItemIndex, 3, otim,"char")
    self:SetBagItemParam(selfId, nItemIndex, 4, osid,"short")
    self:SetBagItemParam(selfId, nItemIndex, 6, opx,"short")
    self:SetBagItemParam(selfId, nItemIndex, 8, opy,"short")
    self:LuaFnRefreshItemInfo(selfId, nItemIndex)
    self:MsgBox(selfId, "你的土灵珠定位成功。")
end

return tulingzhu
