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
	if( FreeSpace < 2 ) then
	    local strNotice = "道具栏已满，请保留2个空位。"
		self:notify_tips(selfId, strNotice)
	    return 0
	end
    self:TryRecieveItem(selfId, 10142048, false)
    self:TryRecieveItem(selfId, 30008114, false)
	return 1
end

return common_item
