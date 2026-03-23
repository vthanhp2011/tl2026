local class = require "class"
local define = require "define"
local script_base = require "script_base"
local item_6096 = class("item_6096", script_base)
item_6096.g_petCommonId = define.PETCOMMON
item_6096.script_id = 336096
function item_6096:GetPetBookId(selfId)
    local ItemIndexInBag = self:LuaFnGetBagIndexOfUsedItem(selfId)
    local PetBookId = self:LuaFnGetItemTableIndexByIndex(selfId, ItemIndexInBag)
    return PetBookId
end

function item_6096:IsSkillLikeScript(selfId)
    return 1
end

function item_6096:OnConditionCheck(selfId)
    if (self:LuaFnVerifyUsedItem(selfId) == 0) then
        return 0
    end
    local petGUID_H = self:LuaFnGetHighSectionOfTargetPetGuid(selfId)
    local petGUID_L = self:LuaFnGetLowSectionOfTargetPetGuid(selfId)
    local checkAvailable = self:LuaFnIsPetAvailableByGUIDNoPW(selfId, petGUID_H, petGUID_L)
    if checkAvailable and checkAvailable ~= 1 then
        return 0
    end
    return 1
end

function item_6096:OnDeplete(selfId)
    return 1
end

function item_6096:OnActivateOnce(selfId)
    local PetBookId = self:GetPetBookId(selfId)
    local SkillId = self:GetPetBookSkillID(PetBookId)
    if -1 == SkillId then
        return 0
    end
    local PetGuidH = self:LuaFnGetHighSectionOfTargetPetGuid(selfId)
    local PetGuidL = self:LuaFnGetLowSectionOfTargetPetGuid(selfId)
    local pgH, pgL = self:LuaFnGetCurrentPetGUID(selfId)
    if (PetGuidH == pgH) and (PetGuidL == pgL) then
        return 0
    end
    if (self:LuaFnDepletingUsedItem(selfId)) then
        self:CallScriptFunction(self.g_petCommonId, "PetStudy", selfId, SkillId)
        return 1
    end
    return 0
end

function item_6096:OnActivateEachTick(selfId)
    return 1
end

function item_6096:CancelImpacts(selfId)
    return 0
end

return item_6096
