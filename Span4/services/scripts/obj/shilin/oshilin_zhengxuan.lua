local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshilin_zhengxuan = class("oshilin_zhengxuan", script_base)
oshilin_zhengxuan.script_id = 026000
oshilin_zhengxuan.g_eventList = {212103, 212104}
function oshilin_zhengxuan:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  $N，我知道你，你的名字在大理已经传遍了，非常高兴能在石林这里看到你。但是，现在石林是个非常危险的地方，你凡事都要小心。")
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    if self:IsHaveMission(selfId, 602) then
        self:AddNumText("绝望之地的故事", 6, 1)
        self.nDescIndex = 1
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshilin_zhengxuan:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oshilin_zhengxuan:OnEventRequest(selfId, targetId, arg, index)
    local arg = index
    if arg == 6 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 415, 45, 34)
        return
    end
    if arg == self.script_id then
        self:BeginEvent(self.script_id)
        if self.nDescIndex == 1 then
            self:AddText("#{Lua_Shilin_002}")
            self:AddNumText("什麽？恐怖的瘟疫！那后来呢？", 8, 1)
        elseif self.nDescIndex == 2 then
            self:AddText("#{Lua_Shilin_003}")
            self:AddNumText("看来是偃师救了圆月村，对吗？", 8, 1)
        elseif self.nDescIndex == 3 then
            self:AddText("#{Lua_Shilin_004}")
        end
        self.nDescIndex = self.nDescIndex + 1
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        if self.nDescIndex == 4 then
            local misIndex = self:GetMissionIndexByID(selfId, 602)
            local num0 = self:GetMissionParam(selfId, misIndex, 0)
            if num0 < 1 then
                self:SetMissionByIndex(selfId, misIndex, 0, 1)
                self:BeginEvent(self.script_id)
                self:AddText("已经听完郑玄的故事：1/1")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
            end
        end
    end
    if not self:IsHaveMission(selfId, 602) then
        self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId)
    end
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
        end
    end
end

function oshilin_zhengxuan:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId, targetId)
            end
            return
        end
    end
end

function oshilin_zhengxuan:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function oshilin_zhengxuan:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function oshilin_zhengxuan:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function oshilin_zhengxuan:OnDie(selfId, killerId) end

return oshilin_zhengxuan
