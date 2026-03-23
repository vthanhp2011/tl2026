local class = require "class"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local osiwang_mengpo = class("osiwang_mengpo", script_base)

function osiwang_mengpo:OnDefaultEvent_bf(selfId, targetId)
	self:BeginEvent(self.script_id)
		self:AddText("年轻人，再见！再见就是不见，回去后一切小心。你想去哪里？")
		if  self:GetLevel(selfId)<10	then
			self:AddNumText("大理",9,2)
		end
		if	self:GetLevel(selfId)>=10	then
			self:AddNumText("洛阳",9,0)
			--self:AddNumText("洛阳-2",9,10)
			self:AddNumText("苏州",9,1)
			--self:AddNumText("苏州-2",9,11)
			self:AddNumText("大理",9,2)
			--self:AddNumText("大理-2",9,12)
		end
		self:AddNumText("#{DFBZ_081016_01}",11,3)
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
end

function osiwang_mengpo:OnEventRequest_bf(selfId, targetId, arg, index)
	-- 洛阳
	if index == 0 then
		local scenes = {0,1311}
		local idx = math.random(1,#scenes)
        --self:change_scene(selfId, scenes[idx], 132, 183
		self:change_scene(selfId, 0, 132, 183)
	-- 苏州
	elseif index == 1 then
		local scenes = {1,1312}
		local idx = math.random(1,#scenes)
        self:change_scene(selfId, scenes[idx], 114, 162)
	-- 大理
	elseif index == 2 then
		local scenes = {2,71}
		local idx = math.random(1,#scenes)
        self:change_scene(selfId, scenes[idx], 241, 138)
	elseif index == 10 then
        --self:change_scene(selfId, 1311, 132, 183)
	elseif index == 11 then
        self:change_scene(selfId, 1312, 114, 162)
	elseif index == 12 then
        self:change_scene(selfId, 71, 241, 138)
    end
end

osiwang_mengpo.error_max_count = 3			--连续验证错误次数进入保护时间
osiwang_mengpo.error_protection_time = 60	--保护时间 单位:秒
function osiwang_mengpo:OnDefaultEvent(selfId, targetId)
	local error_time = self:GetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO_3)
	local cur_time = os.time()
	if cur_time < error_time then
		local msg = string.format("    由于你连续验证错误%d次，已进入防护机制，请在%d秒后再进行操作。",self.error_max_count,error_time - cur_time)
		self:BeginEvent(self.script_id)
			self:AddText(msg)
			-- self:AddNumText("返回首页",11,0)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	self:BeginEvent(self.script_id)
		self:AddText("    最近，快乐游戏，需要眼睛~\n正确的验证码是？")
		local str = "set:YuanDan_PaiHang image:YuanDan_PaiHang_B_%d"
		local values = {}
		local back_images = {}
		for i = 1,4 do
			values[i] = math.random(0,9)
			back_images[i] = string.format(str,values[i])
		end
		str = table.concat(values)
		local value = tonumber(str)
		local error_fun = function(rdm)
			if value >= 1000 then
				if rdm >= 9000 then
					rdm = rdm - math.random(1,1000)
				elseif rdm <= 1000 then
					rdm = rdm + math.random(1,1000)
				else
					if math.random(2) == 1 then
						rdm = rdm + math.random(1,1000)
					else
						rdm = rdm - math.random(1,1000)
					end
				end
			else
				if rdm >= 900 then
					rdm = rdm - math.random(1,100)
				elseif rdm <= 100 then
					rdm = rdm + math.random(1,100)
				else
					if math.random(2) == 1 then
						rdm = rdm + math.random(1,100)
					else
						rdm = rdm - math.random(1,100)
					end
				end
			end
		end
		values = {1,2,3,4,5,6,7,8,9}
		local last_selected = self:GetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO_2)
		last_selected = last_selected % 10
		if last_selected > 0 and last_selected < 10 then
			table.remove(values,last_selected)
		end
		local yes = values[math.random(1,#values)]
		self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO,yes)
		local idx
		values = {}
		if value >= 1000 then
			for i = 1,9 do
				if i ~= yes then
					idx = math.random(1000,9999)
					if idx ~= value then
						if not values[idx] then
							values[idx] = true
							str = string.format("没错，是%d",idx)
							self:AddNumText(str,9,i)
						else
							idx = error_fun(idx)
							values[idx] = true
							str = string.format("没错，是%d",idx)
							self:AddNumText(str,9,i)
						end
					else
						idx = error_fun(idx)
						values[idx] = true
						str = string.format("没错，是%d",idx)
						self:AddNumText(str,9,i)
					end
				else
					str = string.format("没错，是%d",value)
					self:AddNumText(str,9,i)
				end
			end
		else
			for i = 1,9 do
				if i ~= yes then
					idx = math.random(100,999)
					if idx ~= value then
						if not values[idx] then
							values[idx] = true
							str = string.format("没错，是%d",idx)
							self:AddNumText(str,9,i)
						else
							idx = error_fun(idx)
							values[idx] = true
							str = string.format("没错，是%d",idx)
							self:AddNumText(str,9,i)
						end
					else
						idx = error_fun(idx)
						values[idx] = true
						str = string.format("没错，是%d",idx)
						self:AddNumText(str,9,i)
					end
				else
					str = string.format("没错，是%d",value)
					self:AddNumText(str,9,i)
				end
			end
		end
    self:EndEvent()
    self:DispatchEventList(selfId,targetId)
	self:BeginUICommand()
	self:UICommand_AddStr("Image")
	for _,image in ipairs(back_images) do
		self:UICommand_AddStr(image)
	end
	self:EndUICommand()
	self:DispatchUICommand(selfId,527052021)
end

function osiwang_mengpo:OnEventRequest(selfId, targetId, arg, index)
	if index == 0 then
		self:OnDefaultEvent(selfId, targetId)
		return
	end
	local correct_answer = self:GetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO)
	if correct_answer < 1 or correct_answer > 10 then
		self:BeginEvent(self.script_id)
			self:AddText("验证失败。")
			self:AddNumText("返回首页",11,0)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	elseif correct_answer == index then
		self:BeginEvent(self.script_id)
			self:AddText("年轻人，再见！再见就是不见，回去后一切小心。你想去哪里？")
			if  self:GetLevel(selfId) < 10	then
				self:AddNumText("大理",9,13)
			else
				self:AddNumText("洛阳",9,11)
				self:AddNumText("苏州",9,12)
				self:AddNumText("大理",9,13)
			end
			self:AddNumText("#{DFBZ_081016_01}",11,14)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO_2,index)
		self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO,10)
		return
	else
		if index >= 1 and index <= 9 then
			local value = self:GetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO_2)
			local error_count = value // 10
			error_count = error_count + 1
			local msg = ""
			if error_count > self.error_max_count then
				msg = string.format("连续验证失败次数超过%d次，进入%d秒的保护机制，期间无法进行验证。",self.error_max_count,self.error_protection_time)
				self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO_2,index)
				self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO_3,os.time() + self.error_protection_time)
			else
				msg = string.format("验证失败(连续失败次数:%d)。\n#G    小提示:当连续失败次数超过%d次将进入保护机制，%d秒内无法再次验证。",error_count,self.error_max_count,self.error_protection_time)
				self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO_2,error_count * 10 + index)
			end
			self:BeginEvent(self.script_id)
				self:AddText(msg)
				self:AddNumText("返回首页",11,0)
			self:EndEvent()
			self:DispatchEventList(selfId,targetId)
			return
		end
	end
	if correct_answer ~= 10 then
		self:OnDefaultEvent(selfId, targetId)
		return
	end
	self:SetMissionDataEx(selfId,ScriptGlobal.MDEX_MENGPO,0)
	-- 洛阳
	if index == 11 then
		if math.random(1,2) == 1 then
			self:change_scene(selfId, 0, 132, 183)
		else
--			self:change_scene(selfId, 1311, 132, 183)
		end
	-- 苏州
	elseif index == 12 then
		if math.random(1,2) == 1 then
			self:change_scene(selfId, 1, 114, 162)
		else
			self:change_scene(selfId, 1312, 114, 162)
		end
	-- 大理
	elseif index == 13 then
		if math.random(1,2) == 1 then
			self:change_scene(selfId, 2, 241, 138)
		else
			self:change_scene(selfId, 71, 241, 138)
		end
	elseif index == 14 then
		self:BeginEvent(self.script_id)
			self:AddText("电子竞技需要视力。")
			self:AddNumText("返回首页",11,0)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
	else
		self:BeginEvent(self.script_id)
			self:AddText("验证失败。")
			self:AddNumText("返回首页",11,0)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
    end
end

return osiwang_mengpo