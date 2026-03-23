local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_4926 = class("item_4926", script_base)
item_4926.script_id = 334926
function item_4926:OnDefaultEvent(selfId, bagIndex)
    local sceneId = self:get_scene_id()
    if sceneId and selfId and bagIndex then
        local selfGUID = self:LuaFnGetGUID(selfId)
        local targetGUID = self:GetBagItemParam(selfId, bagIndex, 0, "uint")
        if selfGUID and targetGUID then
            self:BeginEvent(self.script_id)
            if selfGUID == targetGUID then
                self:AddText("此为你自已的结婚请帖。凭此可以参加你的婚礼，快发给你的朋友吧。")
            else
                local targetName = self:LuaFnGetItemCreator(selfId, bagIndex)
                if targetName then
                    self:AddText(
                        "此为" .. targetName .. "发送给您的请帖。可以凭此请帖去#G洛阳（177，94）#R喜来乐#W处参加婚礼。#r在婚礼结束前，可以在婚礼会场内找喜来乐用请帖兑换礼品哦。"
                    )
                else
                    self:AddText("此为未知角色发送给您的请帖。可以凭此参加婚礼，记得婚礼结束之后可以用请帖兑换。")
                end
            end
            self:EndEvent()
            self:DispatchEventList(selfId, selfId)
        end
    end
    return 0
end

function item_4926:IsSkillLikeScript(selfId)
    return 0
end

function item_4926:CancelImpacts(selfId)
    return 0
end

function item_4926:OnConditionCheck(selfId)
    return 1
end

function item_4926:OnDeplete(selfId)
    if (self:LuaFnDepletingUsedItem(selfId)) then
        return 1
    end
    return 0
end

function item_4926:OnActivateOnce(selfId)
    return 1
end

function item_4926:OnActivateEachTick(selfId)
    return 1
end

return item_4926
