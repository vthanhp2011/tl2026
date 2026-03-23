local class = require "class"
local define = require "define"
local script_base = require "script_base"
local otianlong_shengrulan = class("otianlong_shengrulan", script_base)
otianlong_shengrulan.script_id = 013011
function otianlong_shengrulan:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我可以传授给你本派的独门轻功，不过需要花费1#-15。")
    self:AddNumText("学习大理派轻功", 12, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function otianlong_shengrulan:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetMenPai(selfId) == 6 then
            if not self:HaveSkill(selfId, 29) then
                if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < define.STUDY_MENPAI_QINGGONG_SPEND then
                    self:BeginEvent(self.script_id)
                    self:AddText("  您身上的现金不足1#-15，因此无法学习本门轻功。")
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    return
                end
                self:LuaFnCostMoneyWithPriority(selfId, define.STUDY_MENPAI_QINGGONG_SPEND)
                self:AddSkill(selfId, 29)
                self:DelSkill(selfId, 34)
                self:BeginEvent(self.script_id)
                self:AddText("  恭喜你学会本门的轻功，希望为本门的发扬光大继续努力。")
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
            self:AddText("学习天龙寺轻功需要先加入大理派！")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("你不是本门派的弟子，我是不能教你大理派轻功的")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    end
end

function otianlong_shengrulan:OnMissionAccept(selfId, targetId, missionScriptId)
end

function otianlong_shengrulan:OnMissionRefuse(selfId, targetId, missionScriptId)
end

function otianlong_shengrulan:OnMissionContinue(selfId, targetId, missionScriptId)
end

function otianlong_shengrulan:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function otianlong_shengrulan:OnDie(selfId, killerId)
end

return otianlong_shengrulan
