local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oemei_sunerniang = class("oemei_sunerniang", script_base)
oemei_sunerniang.script_id = 15014
function oemei_sunerniang:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我可以传授给你本派的独门轻功，不过需要花费1#-15。")
    self:AddNumText("学习峨嵋轻功", 12, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oemei_sunerniang:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetMenPai(selfId) == 4 then
            if not self:HaveSkill(selfId, 27) then
                if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < define.STUDY_MENPAI_QINGGONG_SPEND then
                    self:BeginEvent(self.script_id)
                    self:AddText("  您身上的现金不足1#-15，因此无法学习本门轻功。")
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    return
                end
                self:LuaFnCostMoneyWithPriority(selfId, define.STUDY_MENPAI_QINGGONG_SPEND)
                self:AddSkill(selfId, 27)
                self:DelSkill(selfId, 34)
                self:BeginEvent(self.script_id)
                self:AddText("恭喜你学会本门的轻功，希望为本门的发扬光大继续努力。")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            else
                self:BeginEvent(self.script_id)
                self:AddText("你不是已经学会了吗？")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            end
        elseif self:GetMenPai(selfId) == 9 then
            self:BeginEvent(self.script_id)
            self:AddText("学习峨嵋轻功需要先加入峨嵋派！")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("你不是本门派的弟子，我是不能教你峨嵋的轻功的")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    end
end

function oemei_sunerniang:OnMissionAccept(selfId, targetId, missionScriptId)
end

function oemei_sunerniang:OnMissionRefuse(selfId, targetId, missionScriptId)
end

function oemei_sunerniang:OnMissionContinue(selfId, targetId, missionScriptId)
end

function oemei_sunerniang:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function oemei_sunerniang:OnDie(selfId, killerId)
end

return oemei_sunerniang
