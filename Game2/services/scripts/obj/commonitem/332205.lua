local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
        return 0
    end
	local FreeSpace = self:LuaFnGetPropertyBagSpace(selfId)
	if( FreeSpace < 2 ) then
	    local strNotice = "道具栏已满，请保留2个空位。"
		self:notify_tips(selfId, strNotice)
	    return 0
	end
	return 1 --不需要任何条件，并且始终返回1。
end

function common_item:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function common_item:OnActivateOnce(selfId)
	local FreeSpace = self:LuaFnGetPropertyBagSpace(selfId)
	local strNotice = "道具栏已满，请保留2个空位。"
	if( FreeSpace < 2 ) then
		self:notify_tips(selfId, strNotice)
	    return 0
	end
	local PetSkill = {30402021,30402022,30402023,30402024}
	local nRandom = math.random(1,#(PetSkill))
    self:BeginAddItem()
    self:AddItem(30501318,1)
	self:AddItem(PetSkill[nRandom],1)
    if self:EndAddItem(selfId) then
		self:notify_tips(selfId, strNotice)
		return
    end
	self:AddItemListToHuman(selfId)
	self:notify_tips(selfId,"获得1个古书残页。")
	self:notify_tips(selfId,string.format("获得1本%s。",self:GetItemName(PetSkill[nRandom])))
	self:LuaFnSendSpecificImpactToUnit(selfId,selfId,selfId,18,0)
	return 1
end

return common_item
