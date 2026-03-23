-- 宠物悟性提升
local class = require "class"
local script_base = require "script_base"
local petsavvy = class("petsavvy", script_base)
local g_Name = "云霏霏"
function petsavvy:OnDefaultEvent(selfId, targetId)
	if self:GetName(targetId) ~= g_Name then		--判断该 npc 是否是指定的npc
		return
	end
	self:BeginUICommand()
    self:UICommand_AddInt(targetId)
	self:EndUICommand()
	self:DispatchUICommand(selfId, 19820424)
end

function petsavvy:OnEnumerate(caller, _, targetId)
    if self:GetName(targetId) ~= g_Name then		--判断该 npc 是否是指定的npc
		return
	end
    --caller:AddNumTextWithTarget(self.script_id, "提升珍兽的悟性等级", 6, -1)
end

function petsavvy:PetSavvy(selfId, mainPetGuidH, mainPetGuidL, assisPetGuidH, assisPetGuidL)
    local gengu = self:LuaFnGetPetGenGuByGUID(selfId, assisPetGuidH, assisPetGuidL)
	if gengu == 0 then
		self:BeginEvent()
        self:AddText("根骨为0的珍兽无法提升主珍兽的悟性。" )
		self:EndEvent()
		self:DispatchMissionTips(selfId )
		return 0
	end
	local retDiff = self:IncreaceSavvyByCompound(selfId, mainPetGuidH, mainPetGuidL, assisPetGuidH, assisPetGuidL )
	if retDiff then
		--成功的光效
		self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
	end
end

function petsavvy:OnEventRequest(selfId, targetId, arg, index)
    if index == -1 then

    end
end

return petsavvy