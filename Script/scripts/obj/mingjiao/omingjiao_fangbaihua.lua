local class = require "class"
local define = require "define"
local script_base = require "script_base"
local omingjiao_fangbaihua = class("omingjiao_fangbaihua", script_base)
omingjiao_fangbaihua.script_id = 011002
function omingjiao_fangbaihua:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我可以传授给你本派的独门轻功，不过需要花费1#-15。")
    self:AddNumText("学习明教轻功", 12, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function omingjiao_fangbaihua:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetMenPai(selfId) == 1 then
            if not self:HaveSkill(selfId, 24) then
                if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < define.STUDY_MENPAI_QINGGONG_SPEND then
                    self:BeginEvent(self.script_id)
                    self:AddText("  您身上的现金不足1#-15，因此无法学习本门轻功。")
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    return
                end
                self:LuaFnCostMoneyWithPriority(selfId, define.STUDY_MENPAI_QINGGONG_SPEND)
                self:AddSkill(selfId, 24)
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
            self:AddText("学习明教轻功需要先加入明教！")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("你不是本门派的弟子，我是不能教你明教的轻功的")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    end
end

function omingjiao_fangbaihua:OnMissionAccept(selfId, targetId, missionScriptId)
end

function omingjiao_fangbaihua:OnMissionRefuse(selfId, targetId, missionScriptId)
end

function omingjiao_fangbaihua:OnMissionContinue(selfId, targetId, missionScriptId)
end

function omingjiao_fangbaihua:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function omingjiao_fangbaihua:OnDie(selfId, killerId)
end

return omingjiao_fangbaihua
