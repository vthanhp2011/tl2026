--曼陀山庄NPC
--王素商
--普通
local gbk = require "gbk"
local define = require "define"
local class = require "class"
local script_base = require "script_base"
local omantuo_wangsushang = class("omantuo_wangsushang", script_base)
omantuo_wangsushang.eventList = {228905}
omantuo_wangsushang.script_id = 377004
local MenPaiPet =
{
	[1] = {["id"] = 3030, ["name"] = "狗", ["itemList"] = {{["id"] = 30601001,["num"] = 20 },{["id"] = 30602001,["num"] = 20}}},
	[2] = {["id"] = 3040, ["name"] = "刺猬", ["itemList"] = {{["id"] = 30601001,["num"] = 20}, {["id"] = 30604001, ["num"] = 20}}},
	[3] = {["id"] = 3050, ["name"] = "猴子", ["itemList"] = {{["id"] = 30601001, ["num"] = 20}, {["id"] = 30605001, ["num"] = 20}}},
}
function omantuo_wangsushang:OnDefaultEvent(selfId, targetId)
	local menpai = self:GetMenPai(selfId)
    self:BeginEvent(self.script_id)
        self:AddText("#{MPSD_220622_05}")
        if menpai == 9 then
            self:AddNumText("#G加入门派", 6, 0)
        end
		if menpai == 10 then
			self:AddNumText("兑换称号", 3, 8)
			self:AddNumText("兑换物品", 3, 7)
			if self:GetMissionDataEx(selfId, 134) < 1 then
				self:AddNumText("领取装备", 4, 100)
			end
			if self:GetMissionDataEx(selfId, 135) < 1 then
				self:AddNumText("领取珍兽", 4, 101)
			end
			if self:GetMissionDataEx(selfId, 133) < 1 then
				self:AddNumText("领取门派时装", 4, 102)
			end
		end
        self:AddNumText("门派介绍", 8, 1)
        self:AddNumText("如何学习门派技能", 8, 6)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function omantuo_wangsushang:OnEventRequest(selfId, targetId, arg, index)
	local nMenPai = self:GetMenPai(selfId)
	if index == 0 then
		if nMenPai ~= 9 then
			self:MsgBox(selfId, targetId, "   你已经拜入了其他门派。")
			return
		end
		if nMenPai == 10 then
			self:MsgBox(selfId,targetId,"#{event_mantuo_0001}")
			return
		end
		self:BeginEvent(self.script_id)
		self:AddText(" #{MenpaiInfo_009}")
		self:AddNumText("我确定要拜入曼陀山庄", 6,3)
		self:AddNumText("我暂时还不想拜入门派", 8,1000)
		self:EndEvent()
		self:DispatchEventList(selfId, targetId)
	elseif index == 1 then
		self:MsgBox(selfId, targetId, " #{OBJ_mantuo_0002}")
	elseif index == 6 then
		self:MsgBox(selfId, targetId, " #{MPJN_090728_10}")
	elseif index == 3 then
		if self:GetLevel(selfId) < 10 then
			self:MsgBox(selfId, targetId, "少侠还是等到10级之后再来拜师学艺吧！")
			return
		end
		self:BeginAddItem()
		self:AddItem(10124791,1)
		self:AddItem(30501001,20,true)
		local ret = self:EndAddItem(selfId)
		if not ret then
			self:MsgBox(selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
			return
		end
		if self:GetMenPai(selfId) == 9 then
			self:LuaFnJoinMenpai(selfId, 10)
			self:LuaFnSetXinFaLevel(selfId,64,10)
			self:LuaFnSetXinFaLevel(selfId,65,1)
			self:LuaFnSetXinFaLevel(selfId,66,1)
			self:LuaFnSetXinFaLevel(selfId,67,1)
			self:LuaFnSetXinFaLevel(selfId,68,10)
			self:LuaFnSetXinFaLevel(selfId,69,1)
			self:AddItemListToHuman(selfId)
			self:notify_tips(selfId, "你已经加入曼陀山庄！")
			self:notify_tips(selfId, "你获得了" .. self:GetItemName(10124791) .. "。")
			self:notify_tips(selfId, "得到20枚门派召集令。")
			self:CallScriptFunction(210268, "CheckMenPai", selfId)
		end
	elseif index == 100 then
		if self:GetMissionDataEx(selfId, 134) > 0 then
			self:MsgBox(selfId, targetId, "你已经领取过了。")
			return
		end
		if nMenPai == 9 then
			self:MsgBox(selfId, targetId, "  你还没有加入门派")
			return
		end
		if nMenPai ~= 10 then
			self:MsgBox(selfId, targetId, "  你不是本门弟子！")
			return
		end
		self:BeginAddItem()
		self:AddItem(10436009, 1,true)
		self:AddItem(10443810, 1,true)
		local ret = self:EndAddItem(selfId)
		if not ret then
			self:MsgBox(selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
			return
		end
		self:AddItemListToHuman(selfId)
		self:notify_tips(selfId, "你获得了" .. self:GetItemName(10436009) .. "。")
		self:notify_tips(selfId, "你获得了" .. self:GetItemName(10443810) .. "。")
		self:SetMissionDataEx(selfId, 134, self:GetDayTime())
	elseif index == 101 then
		if self:GetMissionDataEx(selfId, 135) > 0 then
			self:MsgBox(selfId, targetId, "你已经领取过了。")
			return
		end
		if nMenPai == 9 then
			self:MsgBox(selfId, targetId, "  你还没有加入门派")
			return
		end
		if nMenPai ~= 10 then
			self:MsgBox(selfId, targetId, "  你不是本门弟子！")
			return
		end
		local nRandom = math.random(#MenPaiPet)
		local itemList = MenPaiPet[nRandom]["itemList"]
		if not itemList then
			return
		end
		self:BeginAddItem()
		for i, item in pairs(itemList) do
			self:AddItem(item["id"], item["num"])
		end
		local ret = self:EndAddItem(selfId)
		if not ret then
			self:MsgBox(selfId, targetId, "    在送你珍兽时，同时还要给你珍兽玩具与珍兽的食品，请在物品背包中留出两个空格，再来找我。")
			return
		end
		local Isok, petGUID_H, petGUID_L = self:LuaFnCreatePetToHuman(selfId,MenPaiPet[nRandom]["id"], true)
		if not Isok then
			self:MsgBox(selfId, targetId, "  你已经不能携带更多的宠物了。你可以选择放生宠物来空出一个宠物栏位。\n  打开宠物介面，选择宠物清单中你要丢弃的宠物，点击放生就可以放弃此宠物了。")
			return
		end
		self:notify_tips(selfId, "你获得了一只" .. MenPaiPet[nRandom]["name"] .. "。")
		self:MsgBox(selfId, targetId, "  看看你的宠物栏，你得到了宠物奖励。")
		self:AddItemListToHuman(selfId)
		self:SetMissionDataEx(selfId, 135, self:GetDayTime())
	elseif index == 102 then
		if self:GetMissionDataEx(selfId, 133) > 0 then
			self:MsgBox(selfId, targetId, "    您已经领取过门派时装，无法再次领取。")
			return
		end
		if self:GetItemCount(selfId, 10124791) > 0 then
			self:MsgBox(selfId, targetId, "    您身上已经有了门派时装，无法再次领取。")
			return
		end
		self:BeginAddItem()
		self:AddItem(10124791, 1)
		local ret = self:EndAddItem(selfId)
		if not ret then
			self:MsgBox(selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
			return
		end
		self:notify_tips(selfId, "你获得了" .. self:GetItemName(10124791) .. "。")
		self:AddItemListToHuman(selfId)
		self:SetMissionDataEx(selfId, 133, self:GetDayTime())
	elseif index == 1000 then
		self:BeginUICommand()
		self:EndUICommand()
		self:DispatchUICommand(selfId, 1000)
	end
end
function omantuo_wangsushang:MsgBox(selfId, targetId, msg)
	self:BeginEvent(self.script_id)
	self:AddText(msg)
	self:EndEvent()
	self:DispatchEventList(selfId, targetId)
end
return omantuo_wangsushang