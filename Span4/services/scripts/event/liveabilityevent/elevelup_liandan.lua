local class = require "class"
local define = require "define"
local script_base = require "script_base"
local elevelup_liandan = class("elevelup_liandan", script_base)
elevelup_liandan.script_id = 713578
elevelup_liandan.g_nMaxLevel = 10
elevelup_liandan.g_AbilityID = define.ABILITY_LIANDAN
function elevelup_liandan:OnDefaultEvent(selfId, targetId, num, npc_script_id, bid)
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, define.ABILITY_LIANDAN)
    if self:GetMenPai(selfId) ~= define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG then
        self:BeginEvent(self.script_id)
        self:AddText("你不是本派弟子，我不能教你。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if AbilityLevel < 1 then
        self:BeginEvent(self.script_id)
        local strText = "你还没有学会炼丹技能！"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if AbilityLevel >= self.g_nMaxLevel then
        self:BeginEvent(self.script_id)
        local strText = "我只能教你1-10级的炼丹技能,请到帮派中学习更高级的炼丹."
        self:AddText(strText)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    else
        local tempAbilityId = define.ABILITY_LIANDAN
        local tempAbilityLevel = AbilityLevel + 1
        local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel =
            self:LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel)
        if ret then
            self:DispatchAbilityInfo(selfId, targetId, self.script_id, tempAbilityId, demandMoney, demandExp,
                limitAbilityExpShow, limitLevel)
        end
    end
end

function elevelup_liandan:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "升级炼丹技能", 12, 1)
end

function elevelup_liandan:CheckAccept(selfId)

end

return elevelup_liandan
