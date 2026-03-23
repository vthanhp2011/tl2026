local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local equip_failetimes = class("equip_failetimes", script_base)
equip_failetimes.script_id = 809265
function equip_failetimes:OnEnumerate(caller, selfId, targetId, arg, index) end
function equip_failetimes:EquipFaileTimes(selfId, nItemIndex1, nItemIndex2)
    local ret = self:LuaFnIsItemLocked(selfId, nItemIndex1)
    if ret then
        self:BeginEvent(self.script_id)
        self:AddText("该装备不可用。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    ret = self:LuaFnIsItemAvailable(selfId, nItemIndex2)
    if not ret then
        self:BeginEvent(self.script_id)
        self:AddText("润物露不可用。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    local szTransfer = self:GetBagItemTransfer(selfId, nItemIndex2)
    local sy_index = self:LuaFnGetItemTableIndexByIndex(selfId, nItemIndex2)
    if sy_index ~= 30900007 and sy_index ~= 30900000 then
        self:BeginEvent(self.script_id)
        self:AddText("减少修理失败次数需要润物露。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    local text = "修理成功"
    local money = self:GetMoney(selfId)
    local jiaozi = self:GetMoneyJZ(selfId)
    local need_money = self:GetBagItemLevel(selfId, nItemIndex1) * 200
    if money + jiaozi < need_money then
        text = "降低该装备修理失败次数需要#{_EXCHG%d}，您身上的现金不足。"
        text = self:format(text, need_money)
        self:BeginEvent(self.script_id)
        self:AddText(text)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    local szMsg
    local szName
    szName = self:GetName(selfId)
    if sy_index == 30900007 then
        ret = self:LuaFnFaileTimes(selfId, nItemIndex1, nItemIndex2, 1)
        szMsg = string.format("#W#{_INFOUSR%s}#H使用了#W#{_INFOMSG%%s}#H之后，装备的可修理次数成功增加1次，避免了装备修理失败3次后碎裂。",  szName)
    elseif sy_index == 30900000 then
        ret = self:LuaFnFaileTimes(selfId, nItemIndex1, nItemIndex2, 0)
        szMsg = string.format("#W#{_INFOUSR%s}#H使用了#W#{_INFOMSG%%s}#H之后，装备的可修理次数成功的恢复成为3次，避免了装备修理失败3次后碎裂。", szName)
    end
    szMsg = gbk.fromutf8(szMsg)
    szMsg = string.format(szMsg, szTransfer)
    if ret == 0 then
        self:LuaFnCostMoneyWithPriority(selfId, need_money)
        self:LuaFnEraseItem(selfId, nItemIndex2)
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
        self:AddGlobalCountNews(szMsg, true)
    end
    if ret == -1 then text = "未知错误。" end
    if ret == -2 then text = "装备不可用。" end
    if ret == -3 then text = "润物露不可用。" end
    if ret == -4 then text = "修理失败次数已经最低了。" end
    self:BeginEvent(self.script_id)
    self:AddText(text)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return equip_failetimes