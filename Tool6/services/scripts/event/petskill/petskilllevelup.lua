local class = require "class"
local define = require "define"
local script_base = require "script_base"
local petskilllevelup = class("petskilllevelup", script_base)
petskilllevelup.script_id = 311112
petskilllevelup.g_NumText_Main = 1

function petskilllevelup:OnDefaultEvent(selfId, targetId, arg, index)
    local numText = index
    if numText == self.g_NumText_Main then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19823)
    end
end

function petskilllevelup:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "珍兽技能升级", 6, self.g_NumText_Main)
end

function petskilllevelup:PetSkillLevelup(selfId, petHid, petLid, skillindex,  ItemIndexInBag)
    local checkAvailable = self:LuaFnIsPetAvailableByGUIDNoPW(selfId, petHid,  petLid)
    if checkAvailable then
        local SkillID, SkillLevelUpID, ConsumeGoodsID, ConsumeMoney, IsBroadCast = self:GetPetSkillLevelupTbl(selfId, petHid, petLid, skillindex)
        if not SkillID or not SkillLevelUpID or not ConsumeGoodsID or
            not ConsumeMoney or not IsBroadCast or SkillID == -1 then
            self:NotifyFailTips(selfId, "#{JNHC_81015_03}")
            return
        end
        local itemid = self:LuaFnGetItemTableIndexByIndex(selfId, ItemIndexInBag)
        local ItemInfo = self:GetBagItemTransfer(selfId, ItemIndexInBag)
        if itemid ~= ConsumeGoodsID then
            self:NotifyFailTips(selfId, "#{JNHC_81015_04}")
            return
        end
        local havemoney = self:GetMoney(selfId)
        local haveJiaoZi = self:GetMoneyJZ(selfId)
        if havemoney + haveJiaoZi < ConsumeMoney then
            self:NotifyFailTips(selfId, "#{JNHC_81015_08}")
            return
        end
        if ConsumeMoney > 0 then
            local r = self:LuaFnCostMoneyWithPriority(selfId, ConsumeMoney)
            if not r then
                self:NotifyFailTips(selfId, "扣除金钱失败！")
                return
            end
        end

        if not self:DelItem(selfId,itemid) then
            self:NotifyFailTips(selfId, "扣除物品失败！")
            return
        end
        self:LuaFnPetSkillUp(selfId, petHid, petLid, skillindex, SkillLevelUpID)
        self:NotifyFailTips(selfId, "升级成功！")
        self:AuditPetSkillLevelUpAndCompound(selfId, 1, ConsumeGoodsID)
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
        if IsBroadCast == 1 then
            local szPetTrans = self:GetPetTransString(selfId, petHid, petLid)
            local message = string.format( "#H#{_INFOUSR%s}#{J_09}#{_INFOMSG%s}#{J_10}#{_INFOMSG%s}#{J_11}#G%s#P！", self:LuaFnGetName(selfId), szPetTrans, ItemInfo, self:GetSkillName(SkillLevelUpID))
            self:BroadMsgByChatPipe(selfId, message, 4)
        end
    else
        self:NotifyFailTips(selfId, "#{JNHC_81015_05}")
    end
end

function petskilllevelup:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return petskilllevelup
