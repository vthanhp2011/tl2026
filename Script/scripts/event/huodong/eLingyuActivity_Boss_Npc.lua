local class = require "class"
local define = require "define"
local script_base = require "script_base"
local eLingyuActivity_Boss_Npc = class("eLingyuActivity_Boss_Npc", script_base)
-- local IsScriptid = 808002
eLingyuActivity_Boss_Npc.script_id = 900068
eLingyuActivity_Boss_Npc.need_item = {
	[50947] = {id = 38002798,num = 30,boss = 50948,boss_name = "古灵武·延寿"},
	[50949] = {id = 38002807,num = 100,boss = 50950,boss_name = "古灵武·上生"},
}
function eLingyuActivity_Boss_Npc:OnDefaultEvent(selfId,targetId)
	local dataid = self:GetMonsterDataID(targetId)
	local create_boss = self.need_item[dataid]
	if not create_boss then return end
	local have = self:LuaFnGetAvailableItemCount(selfId,create_boss.id)
	local item_name = self:GetItemName(create_boss.id)
	local npc_msg = string.format("    #G%d#W个#G%s#W可召唤#B%s#W，你当前拥有#G%d#W个#G%s#W。",
	create_boss.num,item_name,create_boss.boss_name,have,item_name)
    self:BeginEvent(self.script_id)
		self:AddText(npc_msg)
		self:AddNumText("确定召唤",6,1)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end
function eLingyuActivity_Boss_Npc:OnEventRequest(selfId,targetId,arg,index)
	if index == 0 then
		self:OnDefaultEvent(selfId,targetId)
	elseif index == 1 then
		local dataid = self:GetMonsterDataID(targetId)
		local create_boss = self.need_item[dataid]
		if not create_boss then return end
		local have = self:LuaFnGetAvailableItemCount(selfId,create_boss.id)
		local item_name = self:GetItemName(create_boss.id)
		if have < create_boss.num then
			local npc_msg = string.format("    %s数量不足。",item_name)
			self:BeginEvent(self.script_id)
				self:AddText(npc_msg)
				self:AddNumText("返回首页",6,0)
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
			return
		end
		self:LuaFnDelAvailableItem(selfId,create_boss.id,create_boss.num)
		local posx,posz = self:GetWorldPos(selfId)
		posx = math.floor(posx + 2)
		posz = math.floor(posz + 2)
		local monsterid = self:LuaFnCreateMonster(create_boss.boss, posx, posz, 4, define.INVAILD_ID, define.INVAILD_ID)
		if monsterid then
			self:SetCharacterDieTime(monsterid,30 * 60 * 1000)
			self:BeginEvent(self.script_id)
				self:AddText("    召唤成功。")
				self:AddNumText("返回首页",6,0)
			self:EndEvent()
			self:DispatchEventList(selfId, targetId)
			local name = self:LuaFnGetName(selfId)
			local msg = string.format("#{_INFOUSR%s}在#G长春谷·不老殿[%d,%d]#P召唤出一只#G%s#P，请有志之士速速赶往击杀。",
			name,posx,posz,create_boss.boss_name)
			self:AddGlobalCountNews(msg)
		end
	end
end
return eLingyuActivity_Boss_Npc
