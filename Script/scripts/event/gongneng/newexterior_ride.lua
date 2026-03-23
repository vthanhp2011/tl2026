local class = require "class"
local define = require "define"
local gbk = require "gbk"
-- local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local newexterior_ride = class("newexterior_ride", script_base)
newexterior_ride.script_id = 999900

function newexterior_ride:ReverseExteriorRideToItem(selfId,nExteriorID)
	if 1 == 1 then
		self:notify_tips(selfId, "暂未开放。")
		return
	end
	self:notify_tips(selfId, "nExteriorID。"..nExteriorID)
	if not nExteriorID or nExteriorID < 1 then
		return
	end
	if not self:CheckHaveExteriorRide(selfId,nExteriorID) then
		self:notify_tips(selfId, "你没有激活该坐骑。")
		return
	elseif self:LuaFnGetPropertyBagSpace(selfId) < 1 then
		self:notify_tips(selfId, "请给道具栏预留1空位。")
		return
	end
	local ret,itemname = self:LuaFnReverseExteriorRideToItemEx(selfId,nExteriorID)
	if ret == -1 then
		self:notify_tips(selfId, "你没有激活该坐骑。")
	elseif ret == -2 then
		self:notify_tips(selfId, "坐骑取出失败。")
	elseif ret == -3 then
		self:notify_tips(selfId, "不存在该坐骑。")
	elseif itemname ~= "" then
		local newpos = self:TryRecieveItem(selfId,ret)
		if newpos ~= -1 then
			self:GiveItemTip(selfId,ret,1,18)
		end
	else
		self:notify_tips(selfId, "未知错误。")
	end
end
return newexterior_ride

