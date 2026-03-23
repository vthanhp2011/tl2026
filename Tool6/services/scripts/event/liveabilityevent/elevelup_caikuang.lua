local class = require "class"
local define = require "define"
local script_base = require "script_base"
local elevelup_caikuang = class("elevelup_caikuang", script_base)
elevelup_caikuang.script_id = 713578
elevelup_caikuang.g_nMaxLevel = 5
elevelup_caikuang.g_AbilityID = define.ABILITY_CAIKUANG
elevelup_caikuang.g_AbilityName = "采矿"
function elevelup_caikuang:OnDefaultEvent(selfId, targetId, num, npc_script_id, bid)
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

function elevelup_caikuang:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "升级".. self.g_AbilityName.. "技能", 12, 1)
end

function elevelup_caikuang:CheckAccept(selfId)

end

return elevelup_caikuang
