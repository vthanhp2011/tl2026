local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local odali_azi = class("odali_azi", script_base)
odali_azi.script_id = 2115
odali_azi.g_ModifyMenpaibookID = 38002427
local nMenPaiName = {"少林","明教","丐帮","武当","峨眉","星宿","天龙","天山","逍遥","无门派","曼陀山庄"}
local nMenPaiAttr = {"玄属性","火属性","毒属性","冰属性、玄属性","冰属性、玄属性","毒属性","冰属性、火属性、玄属性、毒属性","冰属性","火属性、毒属性","无属性","玄属性、毒属性"}
function odali_azi:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{MPZH_180719_01}")
    self:AddNumText("#{MPZH_180719_02}", 6, 0)
    local nCurrentTime = self:GetTime2Day()
    local nLastTime = self:GetMissionDataEx(selfId, ScriptGlobal.MD_LAST_MODIFYMENPAI_TIME)
    if nCurrentTime < nLastTime then
        local nMenPaiID = self:GetMissionDataEx(selfId, ScriptGlobal.MD_LAST_MODIFYMENPAI_OLDID)
        if nMenPaiID ~= self:GetMenPai(selfId) and nMenPaiID ~= 9 then
            self:AddNumText("转回原门派", 6, 3)
        end
    end
    self:AddNumText("领取门派转换宝典", 6, 1)
    self:AddNumText("关于门派转换", 11, 2)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_azi:OnEventRequest(selfId, targetId, arg, index)
    local Operation = index
    if Operation == 0 then
        self:BeginUICommand()
        self:UICommand_AddInt(22)
        self:UICommand_AddInt(self:GetMenPai(selfId))
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 2115)
    end
    if Operation == 1 then
        local nNum = self:LuaFnGetAvailableItemCount(selfId, self.g_ModifyMenpaibookID)
        if nNum >= 1 then
            self:NotifyTip(selfId, "#H您当前背包内已拥有转门派引导手册，无法重复领取。")
            return
        end
        if self:LuaFnGetPropertyBagSpace(selfId) < 1 then
            self:NotifyTip(selfId, "#H您的背包道具栏空位不足1个，无法领取。")
            return
        end
        self:TryRecieveItem(selfId, self.g_ModifyMenpaibookID, 1)
        self:NotifyTip(selfId, "#H您已成功领取门派转换宝典。")
    end
    if Operation == 2 then
        self:BeginEvent(self.script_id)
        self:AddText("#{MPZH_180719_104}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if Operation == 3 then
        --self:CallScriptFunction(900030, "OnRegretCheck", selfId, targetId)
        return
    end
end

function odali_azi:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

local yigudan = { 38002426, 38002428 }
function odali_azi:OnContinueCheck(selfId, targetId, menpai)
    if self:LuaFnMtl_GetCostNum(selfId, yigudan) < 1 then
        self:notify_tips(selfId, "没有移骨丹")
        return
    end
    self:BeginUICommand()
    self:UICommand_AddInt(44)
    self:UICommand_AddInt(targetId)
    self:UICommand_AddInt(menpai)
    self:UICommand_AddStr(string.format("    #cfff263您所更换的门派为：#G%s#cfff263，该门派主属性为：#G%s#cfff263，确认要更换门派吗？#r    若要转换为该门派，请在确认后，再次点击门派转换须知界面中的“#G心意已决#cfff263”按钮，将为您更换门派。否则可点击“#G我再想想#cfff263”按钮，结束本次门派转换。",nMenPaiName[menpai + 1],nMenPaiAttr[menpai + 1]))
    self:EndUICommand()
    self:DispatchUICommand(selfId, 2115)
end

function odali_azi:OnConfirmSwitch(selfId, targetId, menpai)
    if self:GetLevel(selfId) < 60 then
        self:NotifyTip(selfId,"#{MPZH_180719_38}")
        return
    end
    if self:LuaFnMtl_GetCostNum(selfId, yigudan) < 1 then
        self:notify_tips(selfId, "没有移骨丹")
        return
    end
    local oldMenPai = self:GetMenPai(selfId)
    self:LuaFnCancelImpactInSpecificImpact(selfId, 308)
    self:LuaFnMtl_CostMaterial(selfId, 1, { 38002426, 38002428 })
    self:LuaFnChangeMenPai(selfId, menpai)
    self:SetMissionDataEx(selfId,ScriptGlobal.MD_LAST_MODIFYMENPAI_OLDID,oldMenPai) --记录转换前的上一次门派
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

function odali_azi:NotifyTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return odali_azi
