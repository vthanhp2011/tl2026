local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_jiangli = class("oluoyang_jiangli", script_base)
oluoyang_jiangli.script_id = 000102
oluoyang_jiangli.g_ShopTabId = 15
oluoyang_jiangli.g_eventList = {}

oluoyang_jiangli.g_ControlScript = 050009
oluoyang_jiangli.g_ExchangeList = {
    ["id"] = 40004303,
    ["name"] = "精质面粉",
    ["cost"] = 20
}

function oluoyang_jiangli:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  天上飞的、地上跑的、水里游的，想吃什么我这茗珍楼里应有尽有。")
    self:AddNumText("购买食物", 7, 1111)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_jiangli:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_jiangli:OnEventRequest(selfId, targetId, arg, index)
    if index == 1111 then
        self:DispatchShopItem(selfId, targetId, self.g_ShopTabId)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
            return
        end
    end
    if self:CallScriptFunction(self.g_ControlScript, "IsMidAutumnPeriod", selfId) >
        0 then
        if index == 1 then
            local score = self:GetMissionData(selfId, define.MD_ENUM.MD_MIDAUTUMN_SCORE)
            if score < self.g_ExchangeList["cost"] then
                self:NotifyFailBox(selfId, targetId,
                                   "    要换一份" ..
                                       self.g_ExchangeList["name"] ..
                                       "，需要积分" ..
                                       self.g_ExchangeList["cost"] ..
                                       "点，你现在只有" .. score ..
                                       "分，似乎不够啊。")
                return
            end
            self:BeginEvent(self.script_id)
            self:AddText("  你目前的中秋积分为" .. score ..
                             "分，换取一份" .. self.g_ExchangeList["name"] ..
                             "，需要积分" .. self.g_ExchangeList["cost"] ..
                             "点，你确定要换吗？")
            self:AddNumText("确定要换", -1, 3)
            self:AddNumText("我只是路过", -1, 4)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        elseif index == 2 then
            self:NotifyFailBox(selfId, targetId,
                               "    在洛阳姜鲤（127，" ..
                                   "154），苏州包世荣（190，168），大理杜子腾（109，170）分别换" ..
                                   "三种不同的食材后，找苏州（193，148）岳常圆传送到西湖来换中秋" ..
                                   "特殊物品。")
            return
        elseif index == 3 then
            local score = self:GetMissionData(selfId, define.MD_ENUM.MD_MIDAUTUMN_SCORE)
            if score < self.g_ExchangeList["cost"] then return end
            if not self:TryRecieveItem(selfId, self.g_ExchangeList["id"]) then
                self:NotifyFailBox(selfId, targetId, "    背包空间已满。")
            end
            score = score - self.g_ExchangeList["cost"]
            self:SetMissionData(selfId, define.MD_ENUM.MD_MIDAUTUMN_SCORE, score)
            self:NotifyFailBox(selfId, targetId,
                               "    剩余积分：" .. score .. "。")
            return
        elseif index == 4 then
            self:BeginUICommand()
            self:EndUICommand()
            self:DispatchUICommand(selfId, 1000)
        end
        return
    end
end

function oluoyang_jiangli:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret =
                self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function oluoyang_jiangli:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oluoyang_jiangli:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId,
                                    targetId)
            return
        end
    end
end

function oluoyang_jiangli:OnMissionSubmit(selfId, targetId, missionScriptId,
                                          selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId,
                                    targetId, selectRadioId)
            return
        end
    end
end

function oluoyang_jiangli:OnDie(selfId, killerId) end

function oluoyang_jiangli:NotifyFailBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oluoyang_jiangli
