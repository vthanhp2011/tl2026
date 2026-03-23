local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oxiaoyao_shiganlin = class("oxiaoyao_shiganlin", script_base)
oxiaoyao_shiganlin.script_id = 014012
function oxiaoyao_shiganlin:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我可以传授给你本派的独门轻功，不过需要花费1#-15。")
    self:AddNumText("学习逍遥轻功", 12, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oxiaoyao_shiganlin:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetMenPai(selfId) == 8 then
            if self:HaveSkill(selfId, 31) < 0 then
                if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < define.STUDY_MENPAI_QINGGONG_SPEND then
                    self:BeginEvent(self.script_id)
                    self:AddText("  您身上的现金不足1#-15，因此无法学习本门轻功。")
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    return
                end
                self:LuaFnCostMoneyWithPriority(selfId, define.STUDY_MENPAI_QINGGONG_SPEND)
                self:AddSkill(selfId, 31)
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
            self:AddText("学习逍遥轻功需要先加入逍遥派哦。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("你不是逍遥派的弟子，我是不能教你本门轻功的。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    end
end

function oxiaoyao_shiganlin:OnMissionAccept(selfId, targetId, missionScriptId)
end

function oxiaoyao_shiganlin:OnMissionRefuse(selfId, targetId, missionScriptId)
end

function oxiaoyao_shiganlin:OnMissionContinue(selfId, targetId, missionScriptId)
end

function oxiaoyao_shiganlin:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function oxiaoyao_shiganlin:OnDie(selfId, killerId)
end

return oxiaoyao_shiganlin
