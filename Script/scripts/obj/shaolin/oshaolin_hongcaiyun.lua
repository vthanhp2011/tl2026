local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshaolin_hongcaiyun = class("oshaolin_hongcaiyun", script_base)
oshaolin_hongcaiyun.script_id = 009018
function oshaolin_hongcaiyun:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  我可以传授给你本派的独门轻功，不过需要花费1#-15。")
    self:AddNumText("学习少林轻功", 12, 0)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshaolin_hongcaiyun:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:GetMenPai(selfId) == 0 then
            if not self:HaveSkill(selfId, 23)  then
                if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < define.STUDY_MENPAI_QINGGONG_SPEND then
                    self:BeginEvent(self.script_id)
                    self:AddText("  您身上的现金不足1#-15，因此无法学习本门轻功。")
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    return
                end
                self:LuaFnCostMoneyWithPriority(selfId, define.STUDY_MENPAI_QINGGONG_SPEND)
                self:AddSkill(selfId, 23)
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
            self:AddText("学习少林轻功需要先加入少林派！")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("你不是本门派的弟子，我是不能教你少林的轻功的")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    end
end

function oshaolin_hongcaiyun:OnMissionAccept(selfId, targetId, missionScriptId)
end

function oshaolin_hongcaiyun:OnMissionRefuse(selfId, targetId, missionScriptId)
end

function oshaolin_hongcaiyun:OnMissionContinue(selfId, targetId, missionScriptId)
end

function oshaolin_hongcaiyun:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
end

function oshaolin_hongcaiyun:OnDie(selfId, killerId)
end

return oshaolin_hongcaiyun
