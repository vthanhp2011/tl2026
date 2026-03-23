--洛阳NPC
--云渺渺
--普通
local class = require "class"
local script_base = require "script_base"
local oluoyang_yunmiaomiao = class("oluoyang_yunmiaomiao", script_base)
oluoyang_yunmiaomiao.shoptableindex = 17
local g_miscEventId = 311111
function oluoyang_yunmiaomiao:OnDefaultEvent(selfId, targetId)
	self:BeginEvent(self.script_id)
    self:AddText("#{OBJ_luoyang_0026}")
    self:AddNumText("购买珍兽用品",7,0)
    self:AddNumText("珍兽技能学习",6,1)
    self:AddNumText("珍兽还童",6,2)
    self:AddNumText("延长珍兽寿命",6,3)
    self:AddNumText("珍兽驯养",6,4)
    self:AddNumText("珍兽洗点",6,99)
    self:AddNumText("珍兽技能升级",6,34)
    self:AddNumText("珍兽相关介绍", 11, 10 )
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function oluoyang_yunmiaomiao:OnEventRequest(selfId, targetId, arg, index)
    print("oluoyang_yunmiaomiao:OnEventRequest index =", index)
	if index == 100 then
		self:OnDefaultEvent(selfId, targetId)
		return
	elseif index == 99 then
		local phid,plid = self:LuaFnGetCurrentPetGUID(selfId)
		if not phid or not plid then
			self:BeginEvent(self.script_id)
			self:AddText("    请将要洗点的珍兽出战")
			self:AddNumText("返回首页",11,100)
			self:EndEvent()
			self:DispatchEventList(selfId,targetId)
		else
			local curpoint = self:LuaFnGetPetAllocationPoint(selfId, phid, plid)
			if curpoint > 0 then
				self:BeginEvent(self.script_id)
				self:AddText("    你将对出战的珍兽分配#G"..tostring(curpoint).."#W点潜能点进行重置，请确认！")
				self:AddNumText("没错，就是它",6,101)
				self:AddNumText("啊，等等，容我考虑考虑",11,100)
				self:EndEvent()
				self:DispatchEventList(selfId,targetId)
			else
				self:BeginEvent(self.script_id)
				self:AddText("    该出战珍兽尚未记录过潜能点分配，无法重置")
				self:AddNumText("好的，下次我把现在开始分配的珍兽带来",11,100)
				self:EndEvent()
				self:DispatchEventList(selfId,targetId)
			end
		end
		return
	elseif index == 101 then
		self:OnDefaultEvent(selfId, targetId)
		local lsdcount = self:LuaFnGetAvailableItemCount(selfId, 30503021)
		if lsdcount < 1 then
			self:notify_tips(selfId,"你没有"..self:GetItemName(30503021))
			return
		end
		local phid,plid = self:LuaFnGetCurrentPetGUID(selfId)
		if phid and plid then
			local del = self:LuaFnDelAvailableItem(selfId, 30503021, 1)
			if del then
				self:LuaFnResetPetPoint(selfId, phid, plid)
			else
				self:notify_tips(selfId,self:GetItemName(30503021).."扣除失败")
			end
		else
			self:notify_tips(selfId,"请将要洗点的珍兽出战")
		end
		return
	end
    if index == 11 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_057}#r")
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
        return
    end
    if index == 12 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_058}#r")
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
        return
    end
    if index == 34 then
        self:BeginUICommand()
        self:UICommand_AddInt(selfId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19823)
        return
    elseif index<= 6 then
        local sel = index
        self:CallScriptFunction(g_miscEventId, "OnEnumerate", self, selfId, targetId, sel)
        return
    elseif index == 7 then
        self:LuaFnGetPetProcreateInfo(selfId);
        return
    end
    if index == 0 then
        self:DispatchShopItem(selfId,targetId, self.g_shoptableindex )
    end
end

return oluoyang_yunmiaomiao