local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_duziteng = class("odali_duziteng", script_base)
odali_duziteng.script_id = 002028
odali_duziteng.g_shoptableindex = 5
odali_duziteng.g_eventList = {210201, 210202, 210203}

odali_duziteng.g_ControlScript = 050009
odali_duziteng.g_ExchangeList = {["id"] = 40004305, ["name"] = "上好蔗糖", ["cost"] = 55}

function odali_duziteng:UpdateEventList(selfId, targetId)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    if PlayerSex == 0 then
        PlayerSex = "姑娘"
    else
        PlayerSex = "少侠"
    end
    self:BeginEvent(self.script_id)
    self:AddText("  " .. PlayerName .. PlayerSex .. "，想不想尝尝我们大理的有名的小吃？包你吃了八碗又八碗，走也不想走了。")
    --self:AddNumText("购买食品", 7, 0)
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_duziteng:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_duziteng:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
    if index == 0 then
        --self:DispatchShopItem(selfId, targetId, self.g_shoptableindex)
    end
    if self:CallScriptFunction(self.g_ControlScript, "IsMidAutumnPeriod", selfId) > 0 then
        if index == 1 then
            local score = self:GetMissionData(selfId, define.MD_ENUM.MD_MIDAUTUMN_SCORE)
            if score < self.g_ExchangeList["cost"] then
                self:NotifyFailBox(
                    selfId,
                    targetId,
                    "    要换一份" ..
                        self.g_ExchangeList["name"] ..
                            "，需要积分" .. self.g_ExchangeList["cost"] .. "点，你现在只有" .. score .. "分，似乎不够啊。"
                )
                return
            end
            self:BeginEvent(self.script_id)
            self:AddText(
                "  你目前的中秋积分为" ..
                    score ..
                        "分，换取一份" .. self.g_ExchangeList["name"] .. "，需要积分" .. self.g_ExchangeList["cost"] .. "点，你确定要换吗？"
            )
            self:AddNumText("确定要换", -1, 3)
            self:AddNumText("我只是路过", -1, 4)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        elseif index == 2 then
            self:NotifyFailBox(
                selfId,
                targetId,
                "    在洛阳姜鲤（127，" ..
                    "154），苏州包世荣（190，168），大理杜子腾（109，170）分别换" .. "三种不同的食材后，找苏州（193，148）岳常圆传送到西湖来换中秋" .. "特殊物品。"
            )
            return
        elseif index == 3 then
            local score = self:GetMissionData(selfId, define.MD_ENUM.MD_MIDAUTUMN_SCORE)
            if score < self.g_ExchangeList["cost"] then
                return
            end
            if not self:LuaFnTryRecieveItem(selfId, self.g_ExchangeList["id"]) then
                self:NotifyFailBox(selfId, targetId, "    背包空间已满。")
            end
            score = score - self.g_ExchangeList["cost"]
            self:SetMissionData(selfId, define.MD_ENUM.MD_MIDAUTUMN_SCORE, score)
            self:NotifyFailBox(selfId, targetId, "    剩余积分：" .. score .. "。")
            return
        elseif index == 4 then
            self:BeginUICommand()
            self:EndUICommand()
            self:DispatchUICommand(selfId, 1000)
        end
        return
    end
end

function odali_duziteng:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function odali_duziteng:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_duziteng:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_duziteng:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_duziteng:OnDie(selfId, killerId)
end

function odali_duziteng:NotifyFailBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_duziteng
