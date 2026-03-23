--珍兽繁殖
local class = require "class"
local script_base = require "script_base"
local PetProcreateTakeOut = class("PetProcreateTakeOut", script_base)

function PetProcreateTakeOut:OnDefaultEvent(selfId)
	local checkRet	= self:LuaFnCheckPetProcreateTakeOut(selfId)
	if checkRet then
		self:LuaFnPetProcreateTakeOut(selfId)
	end
end

function PetProcreateTakeOut:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, "取出完成繁殖的珍兽", 6, self.script_id)
end

return PetProcreateTakeOut