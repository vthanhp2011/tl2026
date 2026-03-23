local class = require "class"
local define = require "define"
local script_base = require "script_base"
local QingXinDan = class("QingXinDan", script_base)
QingXinDan.script_id = 330070
function QingXinDan:OnDefaultEvent(selfId, bagIndex)
end

function QingXinDan:IsSkillLikeScript(selfId)
    return 1
end

function QingXinDan:CancelImpacts(selfId)
    return 0
end

function QingXinDan:OnConditionCheck(selfId)
    if (not self:LuaFnVerifyUsedItem(selfId)) then
        return 0
    end
    local sceneId = self:GetSceneID()
    if not (sceneId == 0 or sceneId == 1 or sceneId == 2 or sceneId == 151) then
        self:notify_tips(selfId,"清心丹只能在大理、苏州、洛阳、监狱才能使用。")
        return 0
    end
    local pk_value = self:GetPKValue(selfId)
    if pk_value <= 0 then
        self:notify_tips(selfId, "只有杀气大于0才能使用清心丹")
        return 0
    end
    return 1
end

function QingXinDan:OnDeplete(selfId)
    if (self:LuaFnDepletingUsedItem(selfId)) then
        return 1
    end
    return 0
end

function QingXinDan:OnActivateOnce(selfId)
    local pk_value = self:GetPKValue(selfId)
    if pk_value <= 0 then
        self:notify_tips("只有杀气大于0才能使用清心丹")
        return 0
    end
    self:notify_tips(selfId, "当前杀气减少1点")
    self:SetPKValue(selfId, pk_value - 1)
    return 1
end

function QingXinDan:OnActivateEachTick(selfId)
    return 1
end

return QingXinDan
