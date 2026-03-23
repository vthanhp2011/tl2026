local class = require "class"
local define = require "define"
local script_base = require "script_base"
local elevelup_zhifu = class("elevelup_zhifu", script_base)
elevelup_zhifu.script_id = 713577
elevelup_zhifu.g_nMaxLevel = 10
elevelup_zhifu.g_AbilityID = define.ABILITY_ZHIFU
elevelup_zhifu.g_AbilityName = "制符"
function elevelup_zhifu:OnDefaultEvent(selfId, targetId, num, npc_script_id, bid)
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, self.g_AbilityID)
    if self:GetMenPai(selfId) ~= define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI then
        self:BeginEvent(self.script_id)
        self:AddText("你不是本派弟子，我不能教你。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if AbilityLevel < 1 then
        self:BeginEvent(self.script_id)
        local strText = "你还没有学会".. self.g_AbilityName.."技能！"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if AbilityLevel >= self.g_nMaxLevel then
        self:BeginEvent(self.script_id)
        local strText = "我只能教你1-10级的".. self.g_AbilityName.."技能,请到帮派中学习更高级的".. self.g_AbilityName.."."
        self:AddText(strText)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    else
        local tempAbilityId =  self.g_AbilityID
        local tempAbilityLevel = AbilityLevel + 1
        local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel =
            self:LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel)
        if ret then
            self:DispatchAbilityInfo(selfId, targetId, self.script_id, tempAbilityId, demandMoney, demandExp,
                limitAbilityExpShow, limitLevel)
        end
    end
end

function elevelup_zhifu:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "升级".. self.g_AbilityName.."技能", 12, 1)
end

function elevelup_zhifu:CheckAccept(selfId)

end

return elevelup_zhifu
