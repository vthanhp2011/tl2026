--苏州NPC
--朱锋
--普通
local class = require "class"
local script_base = require "script_base"
local osuzhou_zhufeng = class("osuzhou_zhufeng", script_base)
osuzhou_zhufeng.key	=
{
	["inf"]	= 1000,	--制造介绍
	["ln"]	= 1,		--我要学习精炼配方 - 精炼 - 铸造
	["zh"]	= 2,		--我要学习精制配方 - 精制 - 缝纫
	["gn"]	= 3,		--我要学习精工配方 - 精工 - 工艺
	["sh"]	= 4,		--精工配方商店
}
function osuzhou_zhufeng:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
        self:AddText( "    十年磨一剑，我朱锋做出来的东西是天下最好的！" )
		if self:GetLevel(selfId ) >= 10 then
			self:AddNumText("我要学习精炼（锻造）配方", 2, self.key["ln"] )
			self:AddNumText("我要学习精制（缝纫）配方", 2, self.key["zh"] )
			self:AddNumText("我要学习精工（工艺）配方", 2, self.key["gn"] )
			self:AddNumText("购买精工配方", 7, self.key["sh"])
		end
		self:AddNumText("制造介绍", 11, self.key["inf"] )
    self:EndEvent()
    self:DispatchEventList(selfId, targetId )
end

function osuzhou_zhufeng:OnEventRequest(selfId, targetId, arg, index)
    local	key	= index
	if key == self.key["inf"] then
		self:MsgBox(selfId, targetId, "#{INTRO_ZHIZAO}" )
	elseif key == self.key["ln"] then
		if self:QueryHumanAbilityLevel(selfId, 46 ) ~= 1 then
			self:SetHumanAbilityLevel(selfId, 46, 1 )
		end
		for i = 644, 703 do
			self:SetPrescription(selfId, i, 1 )
		end
		for i = 1144, 1153 do
			self:SetPrescription(selfId, i, 1 )
		end
		self:MsgBox(selfId, targetId, "    恭喜你已经学会了所有的精炼配方。" )
	elseif key == self.key["zh"] then
		if self:QueryHumanAbilityLevel(selfId, 47 ) ~= 1 then
			self:SetHumanAbilityLevel(selfId, 47, 1 )
		end
		for i = 704, 773 do
			self:SetPrescription(selfId, i, 1 )
		end
		for i = 804, 883 do
			self:SetPrescription(selfId, i, 1 )
		end
		self:MsgBox(selfId, targetId, "    恭喜你已经学会了所有的精制配方。" )
	elseif key == self.key["gn"] then
		if self:QueryHumanAbilityLevel(selfId, 48 ) ~= 1 then
			self:SetHumanAbilityLevel(selfId, 48, 1 )
		end
		for i = 774, 803 do
			self:SetPrescription(selfId, i, 1 )
		end
		for i = 1064, 1075 do
			self:SetPrescription(selfId, i, 1 )
		end
		self:MsgBox(selfId, targetId, "    恭喜你已经学会了所有的精工配方。" )
	elseif key == self.key["sh"] then
		self:DispatchShopItem(selfId, targetId, 196)
	end
end

return osuzhou_zhufeng