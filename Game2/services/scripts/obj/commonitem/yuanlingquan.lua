local class = require "class"
local define = require "define"
local script_base = require "script_base"
local yuanlingquan = class("yuanlingquan", script_base)
yuanlingquan.script_id = 300084
yuanlingquan.g_event = 808131
function yuanlingquan:OnDefaultEvent(selfId, bagIndex)
end

function yuanlingquan:IsSkillLikeScript(selfId)
    return 1
end

function yuanlingquan:CancelImpacts(selfId)
    return 0
end

function yuanlingquan:OnConditionCheck(selfId)
    local sceneId = self:GetSceneID()
    if sceneId ~= 4 then
        self:notify_tips(selfId,"只有在太湖才能许愿！")
        return 0
    end
    local WishesCount = self:GetMissionDataEx(selfId,148)
    if WishesCount >= 5 then
        self:notify_tips(selfId,"今天已经完成了5次许愿。")
        return
    end
    if self:CallScriptFunction(self.g_event, "CheckAccept", selfId) > 0 then
        self:notify_tips(selfId,"请先接取任务一千零一个愿望。")
        return
    end
    local treasureX = 157
    local treasureZ = 188
    PlayerX = self:GetHumanWorldX(selfId)
    PlayerZ = self:GetHumanWorldZ(selfId)
    Distance = math.floor(math.sqrt((treasureX - PlayerX) * (treasureX - PlayerX) + (treasureZ - PlayerZ) * (treasureZ - PlayerZ)))
    if Distance > 5 then
        self:notify_tips(selfId,"请在太湖许愿树(157,188)附近使用[愿灵泉]，当前坐标距离许愿树还有" ..Distance .. "米")
        return 0
    end
    return 1
end

function yuanlingquan:OnDeplete(selfId)
    return 1
end

function yuanlingquan:OnActivateOnce(selfId)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
    self:CallScriptFunction(self.g_event, "OnUseItem", selfId)
    return 1
end

function yuanlingquan:OnActivateEachTick(selfId)
    return 1
end

return yuanlingquan
