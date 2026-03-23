local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local petmanger = class("petmanger", script_base)
petmanger.script_id = 335805
petmanger.g_Impact = -1
petmanger.g_UseMax = 4
petmanger.g_UseUnit = {
    [30509500] = 1,
    [30509501] = 2,
    [30509502] = 3,
    [30509503] = 4
}

function petmanger:OnDefaultEvent(selfId, bagIndex)
end

function petmanger:IsSkillLikeScript(selfId)
    return 1
end

function petmanger:CancelImpacts(selfId)
    return 0
end

function petmanger:OnConditionCheck(selfId)
    local bagId = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local numExtra = self.g_UseUnit[self:GetItemTableIndexByIndex(selfId, bagId)]
    if numExtra == nil then
        return 0
    end
    if not self:LuaFnLockCheck(selfId, bagId, 0) then
        self:MsgBox(selfId, "此物品已被锁定！")
        return 0
    end
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    if self:GetPetNumExtra(selfId) >= self.g_UseMax then
        self:MsgBox(selfId, "宠物的携带空间已达上限，不能再增加新的空间。")
        return 0
    end
    local curShouLanLevel = self:GetPetNumExtra(selfId)
    if curShouLanLevel ~= (numExtra - 1) then
        local szMsg = string.format(
            "您当前兽栏已为%d级，如果想要增加宠物携带数量，请使用第%d级兽栏。",
            curShouLanLevel, curShouLanLevel + 1)
        self:MsgBox(selfId, szMsg)
        return 0
    end
    return 1
end

function petmanger:OnDeplete(selfId)
    return 1
end

function petmanger:OnActivateOnce(selfId)
    if (-1 ~= self.g_Impact) then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, self.g_Impact, 0)
    end
    local nBagIndex = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local numExtra = self.g_UseUnit[self:GetItemTableIndexByIndex(selfId, nBagIndex)]
    local szTran = self:GetBagItemTransfer(selfId, nBagIndex)
    local strMsg
    if numExtra ~= nil and self:EraseItem(selfId, nBagIndex) then
        if self:SetPetNumExtra(selfId, numExtra) then
            if numExtra == 1 then
                self:MsgBox(selfId, "您的宠物携带空间增加到" .. self:GetPetNumMax(selfId) ..
                    "，如果想要再次增加宠物的携带空间请使用更高级的兽栏。")
                 strMsg = string.format(
                    "#W#{_INFOUSR%s}#H使用了#W#{_INFOMSG%%s}#H之后，#H显着改善了宠物们的住宿条件，#H可携带宠物的数量达到了#W%d#H个。",
                    self:LuaFnGetName(selfId), self:GetPetNumMax(selfId))
            elseif numExtra == 2 then
                self:MsgBox(selfId, "您的宠物携带空间增加到" .. self:GetPetNumMax(selfId) ..
                    "，如果想要再次增加宠物的携带空间请使用更高级的兽栏。")
                strMsg = string.format(
                    "#W#{_INFOUSR%s}#H使用了#W#{_INFOMSG%%s}#H之后，#H终于成功建成复式宠物屋，#H可携带宠物的数量达到了#W%d#H个。",
                    self:LuaFnGetName(selfId), self:GetPetNumMax(selfId))
            elseif numExtra == 3 then
                self:MsgBox(selfId, "您的宠物携带空间增加到" .. self:GetPetNumMax(selfId) ..
                    "，如果想要再次增加宠物的携带空间请使用更高级的兽栏。")
                strMsg = string.format(
                    "#W#{_INFOUSR%s}#H使用了#W#{_INFOMSG%%s}#H之后，#H宠物别墅成功落成，#H其可携带宠物的数量达到了#W%d#H个。",
                    self:LuaFnGetName(selfId), self:GetPetNumMax(selfId))
            elseif numExtra == 4 then
                self:MsgBox(selfId, "您的宠物携带空间增加到" .. self:GetPetNumMax(selfId) ..
                    "，兽栏数量已经达到上限。")
                strMsg = string.format(
                    "#W#{_INFOUSR%s}#H使用了#W#{_INFOMSG%%s}#H之后，#H终于完成了宠物圈地运动，#H可携带宠物的数量达到了#W%d#H个。",
                    self:LuaFnGetName(selfId), self:GetPetNumMax(selfId))
            end
            strMsg = gbk.fromutf8(strMsg)
            strMsg = string.format(strMsg, szTran)
            self:AddGlobalCountNews(strMsg, true)
        end
    end
    return 1
end

function petmanger:OnActivateEachTick(selfId)
    return 1
end

function petmanger:MsgBox(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return petmanger
