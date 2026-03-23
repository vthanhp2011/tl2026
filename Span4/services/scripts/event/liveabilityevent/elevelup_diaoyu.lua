local class = require "class"
local define = require "define"
local script_base = require "script_base"
local elevelup_diaoyu = class("elevelup_diaoyu", script_base)
elevelup_diaoyu.script_id = 713568
elevelup_diaoyu.g_nMaxLevel = 5
elevelup_diaoyu.g_AbilityID = define.ABILITY_DIAOYU
elevelup_diaoyu.g_AbilityName = "钓鱼"
function elevelup_diaoyu:OnDefaultEvent(selfId, targetId, num, npc_script_id, bid)
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, self.g_AbilityID)
    if AbilityLevel < 1 then
        self:BeginEvent(self.script_id)
        local strText = "你还没有学会".. self.g_AbilityName.."技能！"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if bid then
		--检查城市是否处于低维护状态
		if self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "CheckCityStatus", selfId,targetId) < 0 then
			return
		end
		local ret = self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck", selfId, self.g_AbilityID, bid, 2)
		if ret then
			self:CallScriptFunction(define.CITY_BUILDING_ABILITY_SCRIPT, "OnCityAction", selfId, targetId, self.g_AbilityID, bid, 2)
		end
		return
	end
    if AbilityLevel >= self.g_nMaxLevel then
        self:BeginEvent(self.script_id)
        local strText = "我只能教你1-5级的" .. self.g_AbilityName .. "技能,请到帮派中学习更高级的".. self.g_AbilityName.. "."
        self:AddText(strText)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    else
        local tempAbilityId = self.g_AbilityID
        local tempAbilityLevel = AbilityLevel + 1
        local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel =
            self:LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel)
        if ret then
            self:DispatchAbilityInfo(selfId, targetId, self.script_id, tempAbilityId, demandMoney, demandExp,
                limitAbilityExpShow, limitLevel)
        end
    end
end

function elevelup_diaoyu:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "升级".. self.g_AbilityName.. "技能", 12, 1)
end

function elevelup_diaoyu:CheckAccept(selfId)

end

return elevelup_diaoyu
