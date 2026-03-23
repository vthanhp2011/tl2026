local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local city0_building12 = class("city0_building12", script_base)
city0_building12.script_id = 805019
city0_building12.g_BuildingID14 = 1
city0_building12.g_SavvyToExp = {
    0, 6000, 12730, 18898, 31156, 46811, 82992, 172059, 236185, 827077, 837599
}
city0_building12.g_GrowRateToExp = {0, 7791, 14744, 70492, 251189}
city0_building12.g_hugeExp = 1500000
city0_building12.g_safeNum = 600000000
city0_building12.g_maxExp = 30000000

function city0_building12:OnDefaultEvent(selfId, targetId)
    local guildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    local strText
    if (guildid ~= cityguildid) then
        self:BeginEvent(self.script_id)
        strText = "    这个帮所有兄弟我都记得名字，一看就知道阁下不是我们帮的。"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    self:BeginEvent(self.script_id)
    strText = "#{ZSKSSJ_081113_01}"
    self:AddText(strText)
    self:AddNumText("厢房介绍", 8, 1)
    self:AddNumText("寄练珍兽", 6, 4)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function city0_building12:OnEventRequest(selfId, targetId, arg, index)
    if index == 3 then
    elseif index == 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_XiangFang}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif (index == 2) then
    elseif index == 4 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function city0_building12:PetShelizi(selfId, PetGuidH, PetGuidL)
    local ret = self:LuaFnCheckPetShelizi(selfId, PetGuidH, PetGuidL)
    if ret then
        if self:LuaFnIsPetGrowRateByGUID(selfId, PetGuidH, PetGuidL) == 0 then
            self:Notify(selfId, "#{ZSKSSJ_081113_09}")
            return
        end
        local nAllExp = self:CalcExp(selfId, PetGuidH, PetGuidL)
        self:BeginUICommand()
        self:UICommand_AddInt(nAllExp)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 8050192)
    end
end

function city0_building12:PetShelizi_Done(selfId, PetGuidH, PetGuidL)
    local pgH, pgL = self:LuaFnGetCurrentPetGUID(selfId)
    if PetGuidH == pgH and PetGuidL == pgL then
        self:Notify(selfId, "#{ZSKSSJ_081113_05}")
        return
    end
    if self:LuaFnIsPetLockedByGUID(selfId, PetGuidH, PetGuidL) then
        self:Notify(selfId, "#{ZSKSSJ_081113_06}")
        return
    end
    if not self:IsPilferLockFlag(selfId) then return end
    if not self:LuaFnCheckPetShelizi(selfId, PetGuidH, PetGuidL) then return end
    local nAllExp = self:CalcExp(selfId, PetGuidH, PetGuidL)
    local needmoney = math.floor(nAllExp / 100)
    if needmoney <= 0 then needmoney = 1 end
    local selfMoney = self:GetMoney(selfId) + self:GetMoneyJZ(selfId)
    if selfMoney < needmoney then
        self:Notify(selfId, "#{no_money}")
        return
    end
    if self:LuaFnGetPropertyBagSpace(selfId) == 0 then
        self:Notify(selfId, "#{QRJ_81009_05}")
        return
    end
    local t_growLevel = self:LuaFnGetPetGrowRateByGUID(selfId, PetGuidH,    PetGuidL)
    if t_growLevel < 1 then t_growLevel = 1 end
    local t_savvy = self:GetPetSavvy(selfId, PetGuidH, PetGuidL)
    if t_savvy < 0 then t_savvy = 0 end
    local t_petLevel = self:LuaFnGetPetLevelByGUID(selfId, PetGuidH, PetGuidL)
    if not self:LuaFnCostMoneyWithPriority(selfId, needmoney) then return end
    local PlayerName = self:GetName(selfId)
    if self:LuaFnDeletePetByGUID(selfId, PetGuidH, PetGuidL) == 0 then return end
    local BagIndex = self:TryRecieveItem(selfId, 30900058)
    if BagIndex == -1 then
        self:Notify(selfId, "#{QRJ_81009_05}")
        return
    end
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    self:SetBagItemParam(selfId, BagIndex, 4, 2, nAllExp)
    self:LuaFnRefreshItemInfo(selfId, BagIndex)
    self:Notify(selfId, "#{ZSKSSJ_081126_1}")
    local guid = self:LuaFnObjId2Guid(selfId)
    local log = string.format("PetGuidH=%X,PetGuidL=%X,PetLevel=%d,PetgrowLevel=%d,PetSavvy=%d,nAllExp=%d", PetGuidH, PetGuidL, t_petLevel, t_growLevel, t_savvy,nAllExp)
    self:ScriptGlobal_AuditGeneralLog(ScriptGlobal.LUAAUDIT_PETSHELIZI, guid, log)
    if nAllExp > self.g_hugeExp then
        local growstr = ""
        if t_growLevel == 1 then
            growstr = "#{ZSKSSJ_PT}"
        elseif t_growLevel == 2 then
            growstr = "#{ZSKSSJ_YX}"
        elseif t_growLevel == 3 then
            growstr = "#{ZSKSSJ_JC}"
        elseif t_growLevel == 4 then
            growstr = "#{ZSKSSJ_ZY}"
        elseif t_growLevel == 5 then
            growstr = "#{ZSKSSJ_WM}"
        else
            growstr = "#{ZSKSSJ_PT}"
        end
        local ProductItemInfo = self:GetBagItemTransfer(selfId, BagIndex)
        local strText = string.format( "#{_INFOUSR%s}#{ZSKSSJ_081113_12}%s#{ZSKSSJ_081113_13}%d#{ZSKSSJ_081113_14}%d#{ZSKSSJ_081113_15}%d#{ZSKSSJ_081113_16}#{_INFOMSG%s}#{ZSKSSJ_081113_17}", PlayerName, growstr, t_savvy, t_petLevel, nAllExp, ProductItemInfo)
        self:AddGlobalCountNews(strText)
    end
end

function city0_building12:Notify(selfId, str)
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function city0_building12:CalcExp(selfId, PetGuidH, PetGuidL)
    local t_growLevel = self:LuaFnGetPetGrowRateByGUID(selfId, PetGuidH, PetGuidL)
    if t_growLevel < 1 then t_growLevel = 1 end
    local t_savvy = self:GetPetSavvy(selfId, PetGuidH, PetGuidL)
    if t_savvy < 0 then t_savvy = 0 end
    local t_petLevel = self:LuaFnGetPetLevelByGUID(selfId, PetGuidH, PetGuidL)
    local nAllExp = self.g_SavvyToExp[tonumber(t_savvy) + 1] + self.g_GrowRateToExp[tonumber(t_growLevel)]
    local levelToExp = 0
    for i = 1, t_petLevel do
        levelToExp = levelToExp + self:LuaFnGetPetNeedExp(selfId, i)
        if levelToExp > self.g_safeNum then return self.g_maxExp end
    end
    nAllExp = nAllExp + levelToExp * 0.05
    if nAllExp > self.g_maxExp then
        return self.g_maxExp
    else
        return nAllExp

    end
end

return city0_building12
