local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
-- local packet_def = require "game.packet"
local script_base = require "script_base"
local RemotecontrolPaiPai = class("RemotecontrolPaiPai", script_base)
RemotecontrolPaiPai.script_id = 999973

RemotecontrolPaiPai.world_id1 = ScriptGlobal.WORLD_ID_PAIPAI_1
RemotecontrolPaiPai.world_id2 = ScriptGlobal.WORLD_ID_PAIPAI_2
RemotecontrolPaiPai.world_id3 = ScriptGlobal.WORLD_ID_PAIPAI_3
RemotecontrolPaiPai.open_id = ScriptGlobal.WORLD_ID_PAIPAI_4
RemotecontrolPaiPai.open_id_two = ScriptGlobal.WORLD_ID_PAIPAI_5

function RemotecontrolPaiPai:OnDefaultEvent( selfId,targetId )
	local GmFlag = self:CallScriptFunction(700489,"HavePermission",selfId)
	if GmFlag then
		local msg = ""
		local nTab,nF1 = self:Cameraobscura();
		if nF1 == 0 then
			msg = "当前为默认抽奖机率,下面可自由设置";
		else
			msg = string.format("物品1概率约:%d%%\n物品2概率约:%d%%\n物品3概率约:%d%%\n物品4概率约:%d%%\n物品5概率约:%d%%\n物品6概率约:%d%%\n物品7概率约:%d%%\n物品8概率约:%d%%",
						 math.floor(nTab[1]/nF1*100),
						 math.floor(nTab[2]/nF1*100),
						 math.floor(nTab[3]/nF1*100),
						 math.floor(nTab[4]/nF1*100),
						 math.floor(nTab[5]/nF1*100),
						 math.floor(nTab[6]/nF1*100),
						 math.floor(nTab[7]/nF1*100),
						 math.floor(nTab[8]/nF1*100)
			)
		end
		local curmsg = "#G(当前:关)"
		local curflag = self:LuaFnGetWorldGlobalDataEx(self.open_id_two)
		if curflag ~= 0 then
			curmsg = "#G(当前:开)"
		end
		self:BeginEvent()
			self:AddText(msg)
			self:AddNumText( "设置物品一概率", 6, 1 )
			self:AddNumText( "设置物品二概率", 6, 2 )
			self:AddNumText( "设置物品三概率", 6, 3 ) 
			self:AddNumText( "设置物品四概率", 6, 4 )
			self:AddNumText( "设置物品五概率", 6, 5 )
			self:AddNumText( "设置物品六概率", 6, 6 )
			self:AddNumText( "设置物品七概率", 6, 7 )
			self:AddNumText( "设置物品八概率", 6, 8 )
			self:AddNumText( "恢复默认", 6, 9 )
			self:AddNumText( "打开拍拍", 6, 900 )
			self:AddNumText( "开关其他玩家抽奖"..curmsg, 6, 999 )
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	else
		local PlayerName=self:GetName(selfId)	
		local PlayerSex=self:GetSex(selfId)
		if PlayerSex == 0 then
			PlayerSex = "姑娘"
		else
			PlayerSex = "少侠"
		end
		local msg = "    "..PlayerName..PlayerSex.."您是来参加拍拍大抽奖活动的吗。"
		self:BeginEvent(sceneId)
			self:AddText(msg)
			self:AddNumText( "是的。", 6, 900 )
			self:AddNumText( "nonono~我只是来瞧瞧。", 6, 1000 )
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	end
end
function RemotecontrolPaiPai:OnEventRequest(selfId, targetId, arg, index)
	if index == 1000 then
		self:BeginUICommand( sceneId )
		self:DispatchUICommand(selfId,index)
		return
	elseif index == 900 then
		self:CallScriptFunction(999972,"LuckyDraw",selfId,4)
		return
	end
	local GmFlag = self:CallScriptFunction(700489,"HavePermission",selfId)
	if not GmFlag then
		return
	end
	if index >= 1 and index <= 8 then
		local nF1 = index * 10 + 1;
		local nF2 = nF1 + 1;
		local nF3 = nF2 + 1;
		local nF4 = nF3 + 1;
		local msg = ""
		local nTab,nFs = self:Cameraobscura();
		if nTab[index] == 0 then
			msg = string.format("当前物品%d不可能抽中",index);
		else
			msg = string.format("当前物品%d抽中的概率约:%d%%",index,math.floor(nTab[index]/nFs*100))
		end
		self:BeginEvent(sceneId)
			self:AddText(msg)
			self:AddNumText( "增加概率", 6, nF1 )
			self:AddNumText( "减少概率", 6, nF2 )
			self:AddNumText( "不出", 6, nF3 ) 
			self:AddNumText( "返回主页", 6, nF4 )
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	elseif index == 9 then
		local _,nFs = self:Cameraobscura();
		if nFs == 0 then
			self:notify_tips(selfId, "当前为默认概率无需恢复")
			return
		end
		self:LuaFnSetWorldGlobalDataEx(self.world_id1,0);
		self:LuaFnSetWorldGlobalDataEx(self.world_id2,0);
		self:LuaFnSetWorldGlobalDataEx(self.world_id3,0);
		self:OnDefaultEvent( selfId,targetId );
	elseif index >= 11 and index <= 84 then
		local nF1 = math.floor(index/10);
		local nF2 = (index % 10);
		if nF2 == 1 then
			local nTab,nFs = self:Cameraobscura();
			if nTab[nF1] == 100 then
				self:notify_tips(selfId, "当前增加已达上限,可返回主页减少其它物品概率来增加此物品的概率")
				return
			else
				nTab[nF1] = nTab[nF1] + 1;
			end
			if nTab[nF1] > 100 then
				nTab[nF1] = 100;
			end
			if nF1 >= 1 and nF1 <= 3 then
				local nF3 = nTab[1] * 10^6 + nTab[2] * 1000 + nTab[3];
				self:LuaFnSetWorldGlobalDataEx(self.world_id1,nF3);
			elseif nF1 >= 4 and nF1 <= 6 then
				local nF3 = nTab[4] * 10^6 + nTab[5] * 1000 + nTab[6];
				self:LuaFnSetWorldGlobalDataEx(self.world_id2,nF3);
			else
				local nF3 = nTab[7] * 1000 + nTab[8];
				self:LuaFnSetWorldGlobalDataEx(self.world_id3,nF3);
			end
			nFs = 0;
			for _,j in ipairs(nTab) do
				nFs = nFs + j;
			end
			if nTab[nF1] == 0 then
				msg = string.format("当前物品%d不可能抽中",nF1);
			else
				msg = string.format("当前物品%d抽中的概率约:%d%%",nF1,math.floor(nTab[nF1]/nFs*100))
			end
			self:BeginEvent(sceneId)
				self:AddText(msg)
				self:AddNumText( "增加概率", 6, index )
				self:AddNumText( "减少概率", 6, index+1 )
				self:AddNumText( "不出", 6, index+2 ) 
				self:AddNumText( "返回主页", 6, index+3 )
			self:EndEvent(sceneId)
			self:DispatchEventList(selfId,targetId)
		elseif nF2 == 2 then
			local nTab,nFs = self:Cameraobscura();
			if nTab[nF1] == 0 then
				self:notify_tips(selfId, "当前物品已经不可能出现,不用再进行减少")
				return
			else
				nTab[nF1] = nTab[nF1] - 1;
			end
			if nTab[nF1] < 0 then
				nTab[nF1] = 0
			end
			if nF1 >= 1 and nF1 <= 3 then
				local nF3 = nTab[1] * 10^6 + nTab[2] * 1000 + nTab[3];
				self:LuaFnSetWorldGlobalDataEx(self.world_id1,nF3);
			elseif nF1 >= 4 and nF1 <= 6 then
				local nF3 = nTab[4] * 10^6 + nTab[5] * 1000 + nTab[6];
				self:LuaFnSetWorldGlobalDataEx(self.world_id2,nF3);
			else
				local nF3 = nTab[7] * 1000 + nTab[8];
				self:LuaFnSetWorldGlobalDataEx(self.world_id3,nF3);
			end
			nFs = 0;
			for _,j in ipairs(nTab) do
				nFs = nFs + j;
			end
			if nTab[nF1] == 0 then
				msg = string.format("当前物品%d不可能抽中",nF1);
			else
				msg = string.format("当前物品%d抽中的概率约:%d%%",nF1,math.floor(nTab[nF1]/nFs*100))
			end
			self:BeginEvent(sceneId)
				self:AddText(msg)
				self:AddNumText( "增加概率", 6, index-1 )
				self:AddNumText( "减少概率", 6, index )
				self:AddNumText( "不出", 6, index+1 ) 
				self:AddNumText( "返回主页", 6, index+2 )
			self:EndEvent(sceneId)
			self:DispatchEventList(selfId,targetId)
		elseif nF2 == 3 then
			local nTab,nFs = self:Cameraobscura();
			if nTab[nF1] == 0 then return end
			nTab[nF1] = 0;
			if nF1 >= 1 and nF1 <= 3 then
				local nF3 = nTab[1] * 10^6 + nTab[2] * 1000 + nTab[3];
				self:LuaFnSetWorldGlobalDataEx(self.world_id1,nF3);
			elseif nF1 >= 4 and nF1 <= 6 then
				local nF3 = nTab[4] * 10^6 + nTab[5] * 1000 + nTab[6];
				self:LuaFnSetWorldGlobalDataEx(self.world_id2,nF3);
			else
				local nF3 = nTab[7] * 1000 + nTab[8];
				self:LuaFnSetWorldGlobalDataEx(self.world_id3,nF3);
			end
			nFs = 0;
			for _,j in ipairs(nTab) do
				nFs = nFs + j;
			end
			if nTab[nF1] == 0 then
				msg = string.format("当前物品%d不可能抽中",nF1);
			else
				msg = string.format("当前物品%d抽中的概率约:%d%%",nF1,math.floor(nTab[nF1]/nFs*100))
			end
			self:BeginEvent(sceneId)
				self:AddText(msg)
				self:AddNumText( "增加概率", 6, index-2 )
				self:AddNumText( "减少概率", 6, index-1 )
				self:AddNumText( "不出", 6, index ) 
				self:AddNumText( "返回主页", 6, index+1 )
			self:EndEvent(sceneId)
			self:DispatchEventList(selfId,targetId)
		elseif nF2 == 4 then
			self:OnDefaultEvent(  selfId,targetId );
		end
	elseif index == 999 then
		local curflag = self:LuaFnGetWorldGlobalDataEx(self.open_id_two)
		local msg = ""
		if curflag == 0 then
			curflag = 1
			msg = "其他玩家抽奖开启成功"
		else
			curflag = 0
			msg = "其他玩家抽奖关闭成功"
		end
		self:LuaFnSetWorldGlobalDataEx(self.open_id_two,curflag)
		self:notify_tips(selfId,msg)
	end
end
function RemotecontrolPaiPai:Cameraobscura()
	local nTab = {};
	local nF1 = self:LuaFnGetWorldGlobalDataEx(self.world_id1);
	nTab[1] = math.floor(nF1/10^6);
	nF1 = (nF1 % 10^6);
	nTab[2] = math.floor(nF1/1000);
	nTab[3] = (nF1 % 1000);
	nF1 = self:LuaFnGetWorldGlobalDataEx(self.world_id2);
	nTab[4] = math.floor(nF1/10^6);
	nF1 = (nF1 % 10^6);
	nTab[5] = math.floor(nF1/1000);
	nTab[6] = (nF1 % 1000);
	nF1 = self:LuaFnGetWorldGlobalDataEx(self.world_id3);
	nTab[7] = math.floor(nF1/1000);
	nTab[8] = (nF1 % 1000);
	nF1 = 0;
	for _,j in ipairs(nTab) do
		nF1 = nF1 + j;
	end
	return nTab,nF1;
end
return RemotecontrolPaiPai
