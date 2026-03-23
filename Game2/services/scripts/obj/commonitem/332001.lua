local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local gbk = require "gbk"
function common_item:OnDefaultEvent(selfId, bagIndex)
end

function common_item:IsSkillLikeScript(selfId)
    return 1
end

function common_item:CancelImpacts(selfId)
    return 0
end

function common_item:OnConditionCheck(selfId)
    local nLevel = self:GetLevel(selfId)
    if nLevel < 30 then
        return 0
    end
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    return 1
end

function common_item:OnDeplete(selfId)
    if self:LuaFnDepletingUsedItem(selfId) then
        return 1
    end
    return 0
end

function common_item:OnActivateOnce(selfId)
    local szTransfer
    local szPlayerName = self:LuaFnGetName(selfId)
    local nItemBagIndex = self:GetBagPosByItemSn(selfId,30505076)
    if nItemBagIndex >= 0 then
        szTransfer = self:GetBagItemTransfer(selfId, nItemBagIndex)
    end
    local message = string.format(gbk.fromutf8("#{_INFOUSR%s}服用了一颗天下第一奇药#{_INFOMSG%s}，不禁觉得浑身舒泰，感觉自己功力大有长进。"),gbk.fromutf8(szPlayerName), szTransfer)
    self:AddGlobalCountNews(message,true)
    local ExpBonus = 500000
    self:AddExp(selfId, ExpBonus)
    return 1
end

function common_item:OnActivateEachTick(selfId)
    return 1
end

return common_item
