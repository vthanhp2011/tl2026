local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
-- local gbk = require "gbk"
-- local skynet = require "skynet"
local packet_def = require "game.packet"
local gem_mingjing = class("gem_mingjing", script_base)
gem_mingjing.script_id = 888814
gem_mingjing.max_level = 8
function gem_mingjing:GemZhuoKe(selfId,item_ms,item_js,item_fu)
	if not item_ms then
		self:notify_tips( selfId,"冥石参数异常。" )
		return
	elseif not item_js then
		self:notify_tips( selfId,"晶石参数异常。" )
		return
	elseif not item_fu then
		self:notify_tips( selfId,"琢刻符参数异常。" )
		return
	elseif self:LuaFnGetMaterialBagSpace(selfId) < 1 then
		self:notify_tips( selfId,"请给材料栏预留1个空位。" )
		return
	end
	local ms_id = self:LuaFnGetItemTableIndexByIndex(selfId,item_ms)
	if ms_id == -1 or ms_id // 10000000 ~= 5 then
		self:notify_tips( selfId,"未放入冥石。" )
		return
	end
	local param1 = ms_id % 1000000
	local ms_lv = param1 // 100000
	param1 = param1 % 100000
	local ms_type = param1 // 1000
	local ms_idx = param1 % 1000
	if ms_lv < 3 then
		self:notify_tips( selfId,"3级及以上等级冥石才可琢刻。" )
		return
	elseif ms_lv > self.max_level then
		self:notify_tips( selfId,"当前未开放的宝石等级。" )
		return
	elseif ms_type ~= 21 then
		self:notify_tips( selfId,"请放入冥石。" )
		return
	elseif ms_idx > 100 then
		self:notify_tips( selfId,"请放入冥石。。" )
		return
	end
	local js_id = self:LuaFnGetItemTableIndexByIndex(selfId,item_js)
	if js_id == -1 or ms_id // 10000000 ~= 5 then
		self:notify_tips( selfId,"未放入纯净晶石。" )
		return
	end
	param1 = js_id % 1000000
	local js_lv = param1 // 100000
	param1 = param1 % 100000
	local js_type = param1 // 1000
	local js_idx = param1 % 1000
	if js_type ~= 2 then
		self:notify_tips( selfId,"请放入纯净晶石。" )
		return
	elseif js_idx < 5 or js_idx > 8 then
		self:notify_tips( selfId,"请放入纯净晶石。。" )
		return
	elseif js_idx - 4 ~= ms_idx then
		self:notify_tips( selfId,"晶石与冥石类型不符。" )
		return
	elseif js_lv > ms_lv then
		self:notify_tips( selfId,"晶石等级不能超过冥石等级。" )
		return
	end
	local js_count = self:LuaFnGetAvailableItemCount(selfId,js_id)
	if js_count < 3 then
		self:notify_tips( selfId,"你背包里的晶石不足3颗。" )
		return
	end
	local fu_id = self:LuaFnGetItemTableIndexByIndex(selfId,item_fu)
	if fu_id ~= 38000445 and fu_id ~= 38000446 then
		self:notify_tips( selfId,"请放入琢刻符。" )
		return
	end
	local newid = tonumber(string.format("50%d21%d%02d",ms_lv,ms_idx,js_lv))
	if self:LuaFnIsItemExists(newid) ~= 3 then
		local msg = string.format("error:%s",tostring(newid))
		self:notify_tips( selfId,msg )
		return
	end
	self:LuaFnDecItemLayCount(selfId,item_fu,1)
	local lay_count = self:GetBagItemLayCount(selfId,item_js)
	if lay_count >= 3 then
		self:LuaFnDecItemLayCount(selfId,item_js,3)
	else
		self:EraseItem(selfId,item_js)
		self:LuaFnDelAvailableItem(selfId,js_id,3 - lay_count)
	end
	self:LuaFnDecItemLayCount(selfId,item_ms,1)
	self:TryRecieveItem(selfId,newid,true)
	self:GiveItemTip(selfId,newid,1,18)
end
function gem_mingjing:GemFenLi(selfId,item_mj,item_fu)
	if not item_mj then
		self:notify_tips( selfId,"冥晶石参数异常。" )
		return
	elseif not item_fu then
		self:notify_tips( selfId,"分离符参数异常。" )
		return
	elseif self:LuaFnGetMaterialBagSpace(selfId) < 2 then
		self:notify_tips( selfId,"请给材料栏预留2个空位。" )
		return
	end
	local ms_id = self:LuaFnGetItemTableIndexByIndex(selfId,item_mj)
	if ms_id == -1 or ms_id // 10000000 ~= 5 then
		self:notify_tips( selfId,"未放入冥晶石。" )
		return
	end
	local param1 = ms_id % 1000000
	local ms_lv = param1 // 100000
	param1 = param1 % 100000
	local ms_type = param1 // 1000
	local ms_idx = param1 % 1000
	if ms_lv < 3 then
		self:notify_tips( selfId,"3级及以上等级冥石才可琢刻。" )
		return
	elseif ms_lv > self.max_level then
		self:notify_tips( selfId,"当前未开放的宝石等级。" )
		return
	elseif ms_type ~= 21 then
		self:notify_tips( selfId,"请放入冥晶石。" )
		return
	elseif ms_idx < 100 then
		self:notify_tips( selfId,"请放入冥晶石。。" )
		return
	end
	local fu_id = self:LuaFnGetItemTableIndexByIndex(selfId,item_fu)
	if fu_id ~= 38000447 and fu_id ~= 38000448 then
		self:notify_tips( selfId,"请放入分离符。" )
		return
	end
	local new_idx = ms_idx // 100
	local newid = tonumber(string.format("50%d21%03d",ms_lv,new_idx))
	if self:LuaFnIsItemExists(newid) ~= 3 then
		local msg = string.format("error:%s。",tostring(newid))
		self:notify_tips( selfId,msg )
		return
	end
	new_idx = new_idx + 4
	ms_idx = ms_idx % 100
	local newid2 = tonumber(string.format("50%d02%03d",ms_idx,new_idx))
	if self:LuaFnIsItemExists(newid2) ~= 3 then
		local msg = string.format("error:%s。。",tostring(newid2))
		self:notify_tips( selfId,msg )
		return
	end
	self:LuaFnDecItemLayCount(selfId,item_fu,1)
	self:LuaFnDecItemLayCount(selfId,item_mj,1)
	self:BeginAddItem()
	self:AddItem(newid,1,true)
	self:AddItem(newid2,3,true)
	if not self:EndAddItem(selfId) then
		return
	end
	self:AddItemListToHuman(selfId)
	self:GiveItemTip(selfId,newid,1)
	self:GiveItemTip(selfId,newid2,3,18)
end
return gem_mingjing
