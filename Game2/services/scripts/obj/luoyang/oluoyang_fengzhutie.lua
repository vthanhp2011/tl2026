local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_fengzhutie = class("oluoyang_fengzhutie", script_base)
oluoyang_fengzhutie.script_id = 000141
oluoyang_fengzhutie.g_shoptableindex = 167
oluoyang_fengzhutie.g_eventList = {713538}

function oluoyang_fengzhutie:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  想学习材料加工技能吗？点击下面的“学习材料加工”按钮，就可以学习材料加工技能了。")
    self:AddText(
        "  材料加工需要的是耐心和恒心，才能制作处大量的合成成品，而这些成品是修习工艺、铸造和缝纫三种生活技能必需的，如果你想提升你的工艺、铸造和缝纫三种生活技能，那么就一定要学习材料加工！")
    self:AddText(
        "  注意：学习“材料加工”需要花费#{_EXCHG10000}，别忘记带了！")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:AddNumText("购买材料加工配方", 7, 99)
    self:AddNumText("材料加工介绍", 11, 100)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_fengzhutie:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_fengzhutie:OnEventRequest(selfId, targetId, arg, index)
    if index == 100 then
        self:BeginEvent(self.script_id)
        self:AddText("#{HELP_CLJG}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 99 then
        self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId,
                                    index, self.script_id)
            return
        end
    end
end

function oluoyang_fengzhutie:OnMissionAccept(selfId, targetId, missionScriptId) end

function oluoyang_fengzhutie:OnMissionRefuse(selfId, targetId, missionScriptId) end

function oluoyang_fengzhutie:OnMissionContinue(selfId, targetId, missionScriptId)

end

function oluoyang_fengzhutie:OnMissionSubmit(selfId, targetId, missionScriptId,
                                             selectRadioId) end

function oluoyang_fengzhutie:OnDie(selfId, killerId) end

return oluoyang_fengzhutie
