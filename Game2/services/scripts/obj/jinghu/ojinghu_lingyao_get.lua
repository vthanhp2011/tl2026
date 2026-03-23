local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oJingHu_LingYao_Get = class("oJingHu_LingYao_Get", script_base)
oJingHu_LingYao_Get.script_id = 005112
function oJingHu_LingYao_Get:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oJingHu_LingYao_Get:UpdateEventList(selfId, targetId)
    local nYaoDingCount = self:GetItemCount(selfId, 40004415)
    if nYaoDingCount <= 0 then
        self:BeginEvent(self.script_id)
        self:AddText("灵药已经炼制成功，只有炼药的人才能取得灵药——经验葫芦。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif nYaoDingCount >= 1 then
        local nItemBagIndex = self:GetBagPosByItemSn(selfId, 40004415)
        local actId = 36
        local status = self:GetActivityParam(actId, 0)
        local YaoDing_LianYao_TimeCur = self:GetActivityParam(actId, 4)
        local YaoDing_LianYao_TimeItem = self:GetBagItemParam(selfId, nItemBagIndex, 3, 2)
        if YaoDing_LianYao_TimeCur ~= YaoDing_LianYao_TimeItem then
            self:DelItem(selfId, 40004415, 1)
            return 0
        end
        self:BeginEvent(self.script_id)
        self:AddText("经验葫芦已经炼制成功，请问您是否现在要领取？")
        self:AddNumText("领取经验葫芦", 2, 0)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oJingHu_LingYao_Get:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:LuaFnGetPropertyBagSpace(selfId) < 1 then
            self:x808004_MsgBox(selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
            return 0
        end
        if self:TryRecieveItem(selfId, 39900010, 1) then
            local str = "#Y你获得了" .. self:GetItemName(39900010) .. "。"
            self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            self:NotifyTip(selfId, str)
            self:DelItem(selfId, 40004415, 1)
            self:BeginEvent(self.script_id)
            self:AddText("你获得了经验葫芦!")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            self:LuaFnDeleteMonster(targetId)
            self:LuaFnAuditHDXianCaoZhengDuo(selfId, "经验葫芦成")
        end
    end
end

function oJingHu_LingYao_Get:NotifyTip(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return oJingHu_LingYao_Get
