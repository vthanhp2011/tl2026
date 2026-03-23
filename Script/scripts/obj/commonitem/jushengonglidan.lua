local class = require "class"
local define = require "define"
local script_base = require "script_base"
local JSGongLiDan = class("JSGongLiDan", script_base)
JSGongLiDan.script_id = 891092
JSGongLiDan.needitem = 38008162
JSGongLiDan.needitem_bind = 38008163
function JSGongLiDan:OnDefaultEvent(selfId, bagIndex) end

function JSGongLiDan:IsSkillLikeScript(selfId) return 1 end

function JSGongLiDan:CancelImpacts(selfId) return 0 end

function JSGongLiDan:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then return 0 end
    local nPower = self:GetGongLi(selfId) 
    if nPower >= 10000 then
        self:NotifyTips(selfId, "当前功力是满的")
        return 0
    end
	local nCount = self:GetMissionDataEx(selfId,146)
	if nCount < 20 then
		self:NotifyTips(selfId,"今日功力丹使用次数未满。")
		return 0
	end
    local NowTime = self:GetDayTime()
    local DayTime = self:GetMissionDataEx(selfId,651)
    if NowTime ~= DayTime then
        self:SetMissionDataEx(selfId,652,0)
        self:SetMissionDataEx(selfId,651,NowTime)
	else
		nCount = self:GetMissionDataEx(selfId,652)
		if nCount >= 10 then
			self:NotifyTips(selfId,"今日聚神功力丹使用已达上限。")
			return 0
		end
    end
    return 1
end

function JSGongLiDan:OnDeplete(selfId)
    -- if (self:LuaFnDepletingUsedItem(selfId)) then return 1 end
    return 1
end

function JSGongLiDan:OnActivateOnce(selfId)
	if self:OnConditionCheck(selfId) == 1 then
		local BagIndex = self:LuaFnGetBagIndexOfUsedItem(selfId)
		local nItemId = self:LuaFnGetItemTableIndexByIndex(selfId,BagIndex)
		if nItemId ~= self.needitem and nItemId ~= self.needitem_bind then
			return 1
		end
		self:LuaFnDecItemLayCount(selfId, BagIndex, 1)
		local nPower = self:GetGongLi(selfId)
		local AllCount = 10
		local nPower_Fin = nPower + 100
		--根据策划要求修改为上限为1W，这段取消
		--nPower_Fin = nPower_Fin > 100 and 100 or nPower_Fin
		self:SetGongLi(selfId, nPower_Fin)
		self:SetMissionDataEx(selfId,652,self:GetMissionDataEx(selfId,652) + 1)
		self:NotifyTips(selfId, "使用成功，功力恢复到100点 ")
		local nCount = self:GetMissionDataEx(selfId,652)
		self:NotifyTips(selfId,string.format("今日聚神功力丹已使用%s次，剩余使用次数%s。",nCount,AllCount - nCount))
    end
	return 1
end

function JSGongLiDan:OnActivateEachTick(selfId) return 1 end

function JSGongLiDan:NotifyTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return JSGongLiDan
