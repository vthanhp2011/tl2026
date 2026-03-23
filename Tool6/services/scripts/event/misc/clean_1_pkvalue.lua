local class = require "class"
local define = require "define"
local script_base = require "script_base"
local clean_1_pkvalue = class("clean_1_pkvalue", script_base)
clean_1_pkvalue.script_id = 800110
clean_1_pkvalue.g_ModScript = 800112
function clean_1_pkvalue:OnDefaultEvent(selfId, targetId)
    local pk_value = self:LuaFnGetHumanPKValue(selfId)
    if pk_value then
    else
        return 0
    end
    if pk_value < 1 then
        self:NotifyFail(selfId, "你的杀气不足1点", targetId)
        return 0
    end
    if self:CallScriptFunction(self.g_ModScript, "CheckCost", selfId, targetId, 1) ~= 1 then
        return 0
    end
    self:CallScriptFunction(self.g_ModScript, "PayForClean", selfId, 1)
    self:SetPKValue(selfId, pk_value - 1)
    --self:LuaFnAuditGoodbadDecPKValue(selfId, 1) 
    self:NotifyFail(selfId, "你成功消除了1点杀气。", targetId)
end

function clean_1_pkvalue:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "清除1点杀气", 6,1)
end

function clean_1_pkvalue:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function clean_1_pkvalue:NotifyFail(selfId, Tip, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return clean_1_pkvalue
