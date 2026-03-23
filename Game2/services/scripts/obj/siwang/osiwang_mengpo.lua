local class = require "class"
local script_base = require "script_base"
local osiwang_mengpo = class("osiwang_mengpo", script_base)

function osiwang_mengpo:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
		self:AddText("年轻人，再见！再见就是不见，回去后一切小心。你想去哪里？")
		if  self:GetLevel(selfId)<10	then
			self:AddNumText("大理",9,2)
		end
		if	self:GetLevel(selfId)>=10	then
			self:AddNumText("洛阳",9,0)
			self:AddNumText("苏州",9,1)
			self:AddNumText("大理",9,2)
		end
		self:AddNumText("#{DFBZ_081016_01}",11,3)
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
end

function osiwang_mengpo:OnEventRequest(selfId, targetId, arg, index)
	if index >= 0 and index < 3 then
		self:RestoreHp(selfId)
		self:RestoreMp(selfId)
	end
	-- 洛阳
	if index == 0 then
        self:change_scene(selfId, 0, 132, 183)
	-- 苏州
	elseif index == 1 then
        self:change_scene(selfId, 1, 114, 162)
	-- 大理
	elseif index == 2 then
        self:change_scene(selfId, 2, 241, 138)
    end
end

return osiwang_mengpo