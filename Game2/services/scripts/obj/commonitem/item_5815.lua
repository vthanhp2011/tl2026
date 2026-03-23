local class = require "class"
local define = require "define"
local script_base = require "script_base"
local GongLiDan = class("GongLiDan", script_base)
GongLiDan.script_id = 390102
function GongLiDan:OnDefaultEvent(selfId, bagIndex) end

function GongLiDan:IsSkillLikeScript(selfId) return 1 end

function GongLiDan:CancelImpacts(selfId) return 0 end

function GongLiDan:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then return 0 end
    local nPower = self:GetGongLi(selfId) 
    local NowTime = self:GetDayTime()
    local DayTime = self:GetMissionDataEx(selfId,147)
    if nPower == 10000 then
        self:NotifyTips(selfId, "当前功力是满的")
        return 0
    end
    if NowTime ~= DayTime then
        self:SetMissionDataEx(selfId,147,self:GetDayTime())
        self:SetMissionDataEx(selfId,146,0)
    end
    local nCount = self:GetMissionDataEx(selfId,146)
    if nCount >= 20 then
        self:NotifyTips(selfId,"今日功力丹使用已达上限。")
        return 0
    end
    return 1
end

function GongLiDan:OnDeplete(selfId)
    if (self:LuaFnDepletingUsedItem(selfId)) then return 1 end
    return 0
end

function GongLiDan:OnActivateOnce(selfId)
    local nPower = self:GetGongLi(selfId)
    local AllCount = 20
    local nPower_Fin = nPower + 100
    --根据策划要求修改为上限为1W，这段取消
    --nPower_Fin = nPower_Fin > 100 and 100 or nPower_Fin
    self:SetGongLi(selfId, nPower_Fin)
    local BagIndex = self:LuaFnGetBagIndexOfUsedItem(selfId)
    self:LuaFnDecItemLayCount(selfId, BagIndex, 1)
    self:SetMissionDataEx(selfId,146,self:GetMissionDataEx(selfId,146) + 1)
    self:NotifyTips(selfId, "使用成功，功力恢复到100点 ")
    local nCount = self:GetMissionDataEx(selfId,146)
    self:NotifyTips(selfId,string.format("今日功力丹已使用%s次，剩余使用次数%s。",nCount,AllCount - nCount))
    return 1
end

function GongLiDan:OnActivateEachTick(selfId) return 1 end

function GongLiDan:NotifyTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return GongLiDan
