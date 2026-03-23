--云思儿

local class = require "class"
local script_base = require "script_base"
local osuzhou_yunsier = class("osuzhou_yunsier", script_base)
osuzhou_yunsier.g_shoptableindex = 102
local g_eventList = {400918, 400963}
function osuzhou_yunsier:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
        self:AddText("#{YXZ_80917_01}")
        for _, eventId in ipairs(g_eventList) do
            self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
        end
        self:AddNumText("灵兽丹合成",6,-99)
        self:AddNumText("珍兽幻化",6,10)
        self:AddNumText("珍兽幻化丹合成",6,11)
        self:AddNumText("提升幻化珍兽灵性",6,12)
        self:AddNumText("购买宠物技能书",7,2)
        self:AddNumText("#{XXWD_8916_07}",11,5)
        self:AddNumText("灵兽丹合成介绍",11,-98)
        self:AddNumText("如何给珍兽快速升级",11,-97)
        self:AddNumText("关于珍兽幻化",11,-96)
        self:AddNumText("关于提升幻化珍兽灵性",11,-95)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_yunsier:OnEventRequest(selfId, targetId, arg, index)
	if index == 1 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1001095)
	elseif index == 2 then
		self:DispatchShopItem(selfId,targetId, self.g_shoptableindex )
	elseif index == 10 then
		self:BeginUICommand()
        self:UICommand_AddInt(targetId )
		self:EndUICommand()
		self:DispatchUICommand(selfId, 20090804)	--珍兽幻化
	elseif index == 12 then
		self:BeginUICommand()
        self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId, 20090805)	--珍兽幻化灵性提升
	elseif index == 11 then
		self:BeginEvent(targetId)
		self:AddText("#{RXZS_090804_9}")
		self:AddNumText("合成",6,20)
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
	elseif index == 5 then
		self:BeginEvent(targetId)
		self:AddText("#{XXWD_8916_08}" )
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	end
	for _, eventId in ipairs(g_eventList) do
		if eventId == arg then
			self:CallScriptFunction(arg, "OnEventRequest", self, selfId)
		end
	end
end

return osuzhou_yunsier