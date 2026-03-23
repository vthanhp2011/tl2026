local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local xiyouboss_die = class("xiyouboss_die", script_base)
-- local gbk = require "gbk"
xiyouboss_die.script_id = 999982

--最后一击掉落专属盒子 isbind = true捡起绑定  = false不绑     rate = 两者总和 按概率大小出一个
xiyouboss_die.killbox = 
{
  --{itemid = 20310101,count = 1,isbind = false,rate = 500},  --2者必掉其1
  --{itemid = 20310102,count = 1,isbind = false,rate = 500},

}
--掉落盒子 isbind = true捡起绑定  = false不绑     rate = 0不掉落  = 1000必掉   1-999千分之概率掉落
xiyouboss_die.boxs = 
{
	--牛魔王
	--[[
	[52704] = {
		--极品箱 箱子群中必有 box_num 个  没有则删掉整个键
		item_lv1 = {
			box_num = 1,
			item = {
			  {itemid = 38008168,count = 1,isbind = true},
			},
		},
		--精品箱 箱子群中必有 box_num 个  没有则删掉整个键
		item_lv2 = {
			box_num = 1,
			item = {
			  {itemid = 38008168,count = 1,isbind = true},
			},
		},
		--良品箱 箱子群中必有 box_num 个  没有则删掉整个键
		item_lv3 = {
			box_num = 1,
			item = {
			  {itemid = 38008168,count = 1,isbind = true},
			},
		},
		--普通箱
		item = {
			{itemid = 38008168,count = 1,isbind = true,rate = 100},
			{itemid = 38008169,count = 1,isbind = true,rate = 200},
			{itemid = 38008170,count = 1,isbind = true,rate = 300},
			{itemid = 38008011,count = 1,isbind = true,rate = 500},
			{itemid = 38008012,count = 1,isbind = true,rate = 400},
			{itemid = 38008013,count = 1,isbind = true,rate = 300},
			{itemid = 38008014,count = 1,isbind = true,rate = 200},
		},
	
	},
	--孙悟空
	[52705] = {
		--极品箱 箱子群中必有 box_num 个  没有则删掉整个键
		item_lv1 = {
			box_num = 1,
			item = {
			  {itemid = 38008168,count = 1,isbind = true},
			},
		},
		--精品箱 箱子群中必有 box_num 个  没有则删掉整个键
		item_lv2 = {
			box_num = 1,
			item = {
			  {itemid = 38008168,count = 1,isbind = true},
			},
		},
		--良品箱 箱子群中必有 box_num 个  没有则删掉整个键
		item_lv3 = {
			box_num = 1,
			item = {
			  {itemid = 38008168,count = 1,isbind = true},
			},
		},
		--普通箱
		item = {
			{itemid = 38008168,count = 1,isbind = true,rate = 100},
			{itemid = 38008169,count = 1,isbind = true,rate = 200},
			{itemid = 38008170,count = 1,isbind = true,rate = 300},
			{itemid = 38008011,count = 1,isbind = true,rate = 500},
			{itemid = 38008012,count = 1,isbind = true,rate = 400},
			{itemid = 38008013,count = 1,isbind = true,rate = 300},
			{itemid = 38008014,count = 1,isbind = true,rate = 200},
		},
	
	},--]]
	--二郎神
	[52706] = {
		--极品箱 箱子群中必有 box_num 个  没有则删掉整个键
		--普通箱 按照 rate / 1000 的概率产出里面道具 没有则删掉整个键
		item = {
			{itemid = 38008169,count = 1,isbind = true,rate = 300},
			{itemid = 38008170,count = 1,isbind = true,rate = 300},
			{itemid = 38008172,count = 1,isbind = true,rate = 100},
			{itemid = 38008200,count = 1,isbind = true,rate = 300},
		},
	
	},
}


function xiyouboss_die:OnDie(objId,killerId)
	local scene = self:get_scene()
	local obj = self.scene:get_obj_by_id(objId)
	if not obj or obj:get_obj_type() ~= "monster" then
		return
	end
	local dataid = obj:get_scene_params(define.MONSTER_DATAID)
	if obj:get_model() ~= dataid then
		return
	end
	local playerboxprotecttime = obj:get_scene_params(define.MONSTER_KILLBOX_PROTECT_TIME)
	local kill_boxdeltime = obj:get_scene_params(define.MONSTER_KILLBOX_DELTIME)
	local boxcount = obj:get_scene_params(define.MONSTER_DROPBOX_COUNT)
	local boxdeltime = obj:get_scene_params(define.MONSTER_DROPBOX_DELTIME)
	local guid,name
	local playerid
	if objId ~= killerId then
		local human = scene:get_obj_by_id(killerId)
		if human then
			if human:get_obj_type() == "human" then
				guid = human:get_guid()
				name = human:get_name()
				playerid = killerId
			elseif human:get_obj_type() == "pet" then
				playerid = human:get_owner_obj_id()
				human = scene:get_obj_by_id(playerid)
				if human then
					guid = human:get_guid()
					name = human:get_name()
				end
			end
		end
	end
	local boxs = self.boxs[dataid]
	if boxs then
		local bossname = obj:get_name()
		local world_pos = obj:get_world_pos()
		local bossposx = math.floor(world_pos.x)
		local bossposz = math.floor(world_pos.y)
		local scenename = scene:get_name()
		local minposx = bossposx - 5
		if minposx < 0 then
			minposx = 0
		end
		local minposz = bossposz - 5
		if minposz < 0 then
			minposz = 0
		end
		local maxposx = bossposx + 5
		local maxposz = bossposz + 5
		local iscreate = 0
		local iscreate_2 = 0
		if playerboxprotecttime > 0 then
			if guid and name then
				local boxname = bossname.."宝箱"
				local boxtitle = name.."击杀专属"
				local boxId = self:LuaFnCreateMonster(52346,bossposx,bossposz,3,0,-1)
				-- local boxId = self:LuaFnCreateMonster(52387,bossposx,bossposz,3,0,-1)52346
				if boxId then
					obj = scene:get_obj_by_id(boxId)
					if obj then
						obj:set_die_time(kill_boxdeltime)
						obj:set_name(boxname)
						obj:set_title(boxtitle)
						obj:set_scene_params(define.MONSTER_KILLBOX_GUID,guid)
						obj:set_scene_params(define.MONSTER_KILLBOX_PROTECT_TIME,playerboxprotecttime + os.time())
						local item_num = 0
						local index = define.MONSTER_DROPBOX_ITEM_COUNT + 1
						local item
						if math.random(1000) <= self.killbox[1].rate then
							item = self.killbox[1]
						else
							item = self.killbox[2]
						end
						if item then
							obj:set_scene_params(index,item.itemid)
							index = index + 1
							obj:set_scene_params(index,item.count)
							index = index + 1
							obj:set_scene_params(index,item.isbind)
							index = index + 1
							item_num = item_num + 1
							obj:set_scene_params(define.MONSTER_DROPBOX_ITEM_COUNT,item_num)
						end
						iscreate = kill_boxdeltime
					end
				end
			end
		end
		if boxcount > 0 then
			local item_lv0 = boxcount
			local keys = {item_lv1 = 0,item_lv2 = 0,item_lv3 = 0,}
			for key,_ in pairs(keys) do
				if boxs[key] and boxs[key].box_num then
					if boxs[key].box_num <= item_lv0 then
						keys[key] = boxs[key].box_num
						item_lv0 = item_lv0 - keys[key]
					else
						keys[key] = item_lv0
						item_lv0 = 0
						break
					end
				end
			end
			keys.item = item_lv0
			local box_keys = {}
			for key,num in pairs(keys) do
				for i = 1,num do
					table.insert(box_keys,key)
				end
			end
			local create_boxs = {}
			boxcount = #box_keys
			for i = 1,boxcount do
				table.insert(create_boxs,table.remove(box_keys,math.random(1,#box_keys)))
			end
			local posx,posz
			local item_num
			local index
			local boxname = bossname.."宝箱"
			for _,key in ipairs(create_boxs) do
				if boxs[key] then
					posx = math.random(minposx,maxposx)
					posz = math.random(minposz,maxposz)
					local boxId = self:LuaFnCreateMonster(49471,posx,posz,3,0,-1)
					-- local boxId = self:LuaFnCreateMonster(52388,posx,posz,3,0,-1)49471
					if boxId then
						obj = scene:get_obj_by_id(boxId)
						if obj then
							obj:set_die_time(boxdeltime)
							obj:set_name(boxname)
							item_num = 0
							index = define.MONSTER_DROPBOX_ITEM_COUNT + 1
							if key == "item" then
								local max_rate = 0
								local idx = 0
								for i,dj in ipairs(boxs[key]) do
									if dj.rate > max_rate then
										idx = i
										max_rate = dj.rate
									end
									max_rate = dj.rate > max_rate and dj.rate or max_rate
									if math.random(1000) <= dj.rate then
										obj:set_scene_params(index,dj.itemid)
										index = index + 1
										obj:set_scene_params(index,dj.count)
										index = index + 1
										obj:set_scene_params(index,dj.isbind)
										index = index + 1
										item_num = item_num + 1
									end
								end
								if item_num == 0 and idx > 0 then
									local dj = boxs[key][idx]
									if dj then
										obj:set_scene_params(index,dj.itemid)
										index = index + 1
										obj:set_scene_params(index,dj.count)
										index = index + 1
										obj:set_scene_params(index,dj.isbind)
										index = index + 1
										item_num = item_num + 1
									end
								end
							else
								for _,dj in ipairs(boxs[key].item) do
									obj:set_scene_params(index,dj.itemid)
									index = index + 1
									obj:set_scene_params(index,dj.count)
									index = index + 1
									obj:set_scene_params(index,dj.isbind)
									index = index + 1
									item_num = item_num + 1
								end
							end
							obj:set_scene_params(define.MONSTER_DROPBOX_ITEM_COUNT,item_num)
							iscreate_2 = boxdeltime
						end
					end
				end
			end
		end
		local have = math.max(iscreate,iscreate_2)
		if have > 0 then
			local boxId = self:LuaFnCreateMonster(52338,bossposx,bossposz,3,0,-1)
			if boxId  then
				obj = scene:get_obj_by_id(boxId)
				if obj then
					obj:set_die_time(have)
				end
			end
			self:NotifyCrystalOne(1,"宝箱",{x = bossposx,y = bossposz})
		end
	end
end
return xiyouboss_die