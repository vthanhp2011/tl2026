--烹饪技能升级
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local elevelup_gongyi = class("elevelup_gongyi", script_base)
elevelup_gongyi.script_id = 713566
elevelup_gongyi.g_nMaxLevel = 5
elevelup_gongyi.g_AbilityID = define.ABILITY_ZHUZAO
elevelup_gongyi.g_AbilityName = "工艺"
elevelup_gongyi.g_Name1 = "阮星竹"

--**********************************
--任务入口函数
--**********************************
function elevelup_gongyi:OnDefaultEvent(selfId, targetId, nNum, npcScriptId, bid )
	--玩家技能的等级
	local AbilityLevel = self:QueryHumanAbilityLevel(selfId, self.g_AbilityID)
	--玩家加工技能的熟练度
	--任务判断
	--如果是在城市中升级
	if bid then
		local ret = self:CallScriptFunction( define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck", selfId, self.g_AbilityID, bid, 2)
		if ret then
			self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityAction", selfId, targetId, self.g_AbilityID, bid, 2)
		end
		return
	end

	--如果还没有学会该生活技能
	if AbilityLevel < 1	then
		self:BeginEvent(self.scirpt_id)
		local strText = "你还没有学会"..self.g_AbilityName.."技能！"
		self:AddText(strText)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end

    local MaxLevel = self.g_MaxLevel
	if self:GetName(targetId) == self.g_Name1 then
		MaxLevel = 10
	end

	--如果生活技能等级已经超出该npc所能教的范围
	if AbilityLevel >= MaxLevel then
		self:BeginEvent()
        local strText
        if self:GetName(targetId) == self.g_Name1   then
            strText = "我只能教你1-10级的".. self.g_AbilityName.."技能."
        else
            strText = "我只能教你1-5级的"..elevelup_gongyi.g_AbilityName.."技能,请到帮派中或者找工艺造诣更为精湛的#Y阮星竹#G（镜湖#{_INFOAIM108,140,5,阮星竹}）#W学习更高级的"..elevelup_gongyi.g_AbilityName.."."
        end
	    self:AddText(strText)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
	else
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel, extraMoney, extraExp = self:LuaFnGetAbilityLevelUpConfig(self.g_AbilityID, AbilityLevel + 1)
        if self:GetName(targetId) == self.g_Name1   then
			demandMoney = extraMoney
			demandExp =	extraExp
		end
        if ret then
			self:DispatchAbilityInfo(selfId, targetId,self.script_id, elevelup_gongyi.g_AbilityID, demandMoney, demandExp, limitAbilityExpShow, limitLevel)
		end
	end
end

--**********************************
--列举事件
--**********************************
function elevelup_gongyi:OnEnumerate(caller, selfId, targetId, bid )
	if bid then
		local ret = self:CallScriptFunction( define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck", selfId, elevelup_gongyi.g_AbilityID, bid, 6)
		if ret then
            caller:AddNumTextWithTarget(self.script_id,"升级"..elevelup_gongyi.g_AbilityName.."技能", 12, 1) end
		return
	end
	local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = self:LuaFnGetAbilityLevelUpConfig(self.g_AbilityID, 1);
	if ret then
		caller:AddNumTextWithTarget(self.script_id,"升级"..elevelup_gongyi.g_AbilityName.."技能", 12, 1)
	end
	return
end

--**********************************
--检测接受条件
--**********************************
function elevelup_gongyi:CheckAccept(selfId)
end

return elevelup_gongyi