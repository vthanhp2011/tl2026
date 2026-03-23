local class = require "class"
local define = require "define"
local script_base = require "script_base"
local elevelup_lingxinshu = class("elevelup_lingxinshu", script_base)
elevelup_lingxinshu.script_id = 713594
elevelup_lingxinshu.g_nMaxLevel = 100
elevelup_lingxinshu.g_AbilityID = define.ABILITY_LINGXINSHU
elevelup_lingxinshu.g_AbilityName = "灵心术"
function elevelup_lingxinshu:OnDefaultEvent(selfId, targetId, num, npc_script_id, bid)
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
        local strText = "目前此技能只能学习到100级"
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

function elevelup_lingxinshu:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "升级".. self.g_AbilityName.."技能", 12, 1)
end

function elevelup_lingxinshu:CheckAccept(selfId)

end

return elevelup_lingxinshu
