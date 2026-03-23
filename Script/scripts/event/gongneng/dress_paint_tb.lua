local class = require "class"
local define = require "define"
local gbk = require "gbk"
-- local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local dress_paint_tb = class("dress_paint_tb", script_base)
dress_paint_tb.script_id = 999361

function dress_paint_tb:OnDefaultEvent( selfId,targetId )
		self:BeginEvent()
			self:AddText("#{BGTS_220125_58}")
			self:AddNumText( "#{BGTS_220125_01}", 6, 1 )
			self:AddNumText( "#{BGTS_220125_02}", 6, 2 )
			self:AddNumText( "#{BGTS_220125_03}", 11, 100 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
end
function dress_paint_tb:OnEventRequest(selfId, targetId, arg, index)
	if index == 0 then
		self:OnDefaultEvent( selfId,targetId )
	elseif index == 1 or index == 2 then
		self:BeginUICommand()
		self:UICommand_AddInt(index - 1)
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId,99936101)
	elseif index == 100 then
		self:BeginEvent()
			self:AddText("#{BGTS_220125_04}")
			self:AddNumText( "返回首页", 11, 0 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	end
end
function dress_paint_tb:ChangeOrnamentsPos( selfId,g_ExteriorType,g_CurSelExteriorID,curX,curY,curZ )
	if g_ExteriorType == 0 then
		local backdata = self:LuaFnGetExteriorBackByID(selfId,g_CurSelExteriorID)
		if not backdata then
			self:notify_tips(selfId,"#{BGTS_220125_48}")
			return
		end
		if backdata.posx == curX
		and backdata.posy == curY
		and backdata.posz == curZ then
			self:notify_tips(selfId,"背饰位置没有变化。")
			return
		end
		local ret = self:LuaFnGetExteriorBackPos(selfId,g_CurSelExteriorID,curX,curY,curZ)
		if ret then
			self:notify_tips(selfId,"位置保存成功。")
		else
			self:notify_tips(selfId,"位置保存失败。")
		end
	elseif g_ExteriorType == 1 then
		local backdata = self:LuaFnGetExteriorHeadByID(selfId,g_CurSelExteriorID)
		if not backdata then
			self:notify_tips(selfId,"头饰尚未激活。")
			return
		end
		if backdata.posx == curX
		and backdata.posy == curY
		and backdata.posz == curZ then
			self:notify_tips(selfId,"头饰位置没有变化。")
			return
		end
		local ret = self:LuaFnGetExteriorHeadPos(selfId,g_CurSelExteriorID,curX,curY,curZ)
		if ret then
			self:notify_tips(selfId,"位置保存成功。")
		else
			self:notify_tips(selfId,"位置保存失败。")
		end
	end
end
function dress_paint_tb:UnlockOrnaments( selfId,g_Item_Pos,itemID,g_Op_Type,flag )
	if not g_Item_Pos or not itemID or itemID < 10000000 then
		self:notify_tips(selfId,"缺少激活道具。")
		return
	end
	if self:LuaFnGetItemTableIndexByIndex(selfId,g_Item_Pos) ~= itemID then
		self:notify_tips(selfId,"道具ID异常。")
		return
	end
	if g_Op_Type == 0 then
		local needinfo = {
			{item = {38003260,38003270},index = 1},
			{item = {38003321},index = 2},
			{item = {38003382},index = 3},
			{item = {38003425},index = 4},
			{item = {38003563,38003564,38003565},index = 5},
			{item = {38003574,38003583},index = 6},
			{item = {38003575,38003584},index = 7},
			{item = {38003586},index = 8},
			{item = {38003656,38003658},index = 9},
			{item = {38003673},index = 10},
			{item = {38003681},index = 11},
			{item = {38003682},index = 12},
			{item = {38003690},index = 13},
		}
		local id
		for i,j in ipairs(needinfo) do
			for m,n in pairs(j.item) do
				if n == itemID then
					id = j.index
					break
				end
			end
		end
		if not id then
			self:notify_tips(selfId,"#{BGTS_220125_14}")
			return
		end
		local backdata = self:LuaFnGetExteriorBackByID(selfId,id)
		if backdata then
			self:notify_tips(selfId,"背饰已激活。")
			return
		end
		local szItemTransfer = self:GetBagItemTransfer(selfId, g_Item_Pos)
		local name = self:GetName(selfId)
		local ret = self:ActivateExteriorBackID(selfId,id,g_Item_Pos)
		if ret then
			self:notify_tips(selfId,"激活成功。")
			local fmt = gbk.fromutf8("#H侠士#{_INFOUSR%s}又添新物！背上的饰物#{_INFOMSG%s}巧夺天工，真是令人羡煞不已！")
			local message = string.format(fmt, gbk.fromutf8(name), szItemTransfer)
			self:BroadMsgByChatPipe(selfId, message, 4)
		end
	elseif g_Op_Type == 1 then
		-- {item = {38003383},index = 1},
		local szItemTransfer = self:GetBagItemTransfer(selfId, g_Item_Pos)
		local name = self:GetName(selfId)
		local ret = self:ActivateExteriorHeadID(selfId,g_Item_Pos,itemID)
		if ret then
			self:notify_tips(selfId,"激活成功。")
			local fmt = gbk.fromutf8("#H#{_INFOUSR%s}实在是个风流倜傥之人！瞧他的头饰#{_INFOMSG%s}，金镶玉嵌，多么华丽！")
			local message = string.format(fmt, gbk.fromutf8(name), szItemTransfer)
			self:BroadMsgByChatPipe(selfId, message, 4)
		end
	end
end
return dress_paint_tb
