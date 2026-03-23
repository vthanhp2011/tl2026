local class = require "class"
local script_base = require "script_base"
local chuan_song = class("chuan_song", script_base)

function chuan_song:on_enter_area(scene, obj)
	local mon_count = self:GetMonsterCount()
	-- for i = 1,mon_count do
		local targetId = self:GetMonsterObjID(1)
		if targetId ~= -1 then
			self:CallScriptFunction((77001), "OnDefaultEvent", obj:get_obj_id(),targetId)
		end
     -- self:CallScriptFunction((400900), "TransferFunc", obj:get_obj_id(), 2,241,148)
end

return chuan_song