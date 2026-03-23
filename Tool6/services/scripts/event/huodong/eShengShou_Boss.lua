--圣兽山宝箱争夺
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local eShengShou_Boss = class("eShengShou_Boss", script_base)
eShengShou_Boss.script_id = 3000001
eShengShou_Boss.MonsterID	= 51660
eShengShou_Boss.PosX		= 42
eShengShou_Boss.PosY		= 174
eShengShou_Boss.MonsterName = "天外Boss"
eShengShou_Boss.g_BigBox = {
	Name			= "天外Boss的宝箱",
	MonsterID	= 5011,
	PosX		= 42,
	PosY		= 174,
	ScriptID	= 3000002
}
eShengShou_Boss.g_IsBigBoxOpening = 0
eShengShou_Boss.g_OpeningPlayerName = "(ERROR)"
eShengShou_Boss.g_PlayerOpeningTime = 0
eShengShou_Boss.IDX_ITEM_ID = 1
eShengShou_Boss.IDX_ITEM_NUM = 2
eShengShou_Boss.IDX_BOX_OPEN_OID = 3
eShengShou_Boss.IDX_BOX_OPEN_TIME = 4
eShengShou_Boss.Boxs = {
	{ content = { id = 20501003, num = 10 }, count = 10},
	{ content = { id = 20502003, num = 10 }, count = 10},

	{ content = { id = 38002515, num = 5 }, count = 1},
	{ content = { id = 38002516, num = 5 }, count = 1},
	{ content = { id = 38002517, num = 5 }, count = 1},
	{ content = { id = 38002518, num = 5 }, count = 1},
	{ content = { id = 38002519, num = 5 }, count = 1},

	{ content = { id = 20600003, num = 5 }, count = 5},
	{ content = { id = 30509014, num = 10 }, count = 5},

	{ content = { id = {
		50601001, 50601002, 50602001, 50602002,
		50602003, 50602004, 50602005, 50602006,
		50602007, 50602008, 50603001, 50604002,
		50611001, 50611002, 50612001, 50612002,
		50612003, 50612004, 50612005, 50612006,
		50612007, 50612008, 50613001, 50613002,
		50613003, 50613004, 50613005, 50614001,
	}, num = 1 }, count = 4},

	{ content = { id = {20310101, 20310102}, num = 1 }, count = 1},
}

function eShengShou_Boss:OnDefaultEvent(actId, param1, param2, param3, param4, param5 )
	if self:CurSceneHaveMonster(self.MonsterID) then
		return
	end
	--雷电交加天气效果....
	local curWeather = self:LuaFnGetSceneWeather(sceneId)
	if not curWeather or curWeather ~= -1 then
		--已经有天气了则不改变天气....
	else
		self:LuaFnSetSceneWeather(3, 5*60*1000 )
	end
	--没有则创建NPC大宝箱....
	local MstId = self:LuaFnCreateMonster(self.MonsterID, self.PosX, self.PosY, 3, 0, self.script_id)
	self:SetCharacterName(MstId, self.MonsterName)
	local NotifyMsg = "@*;SrvMsg;SCA:#G天外Boss#P已降临长春谷-不老殿#G(42, 174)#P，请从洛阳龙霸天对话前往，击败后开启宝箱，可获得海量珍稀奖励"
	self:AddGlobalCountNews(NotifyMsg)
end

function eShengShou_Boss:OnDie(objId, killerId)
	for _, box in ipairs(self.Boxs) do
		for i = 1, box.count do
			local MstId = self:LuaFnCreateMonster(self.g_BigBox.MonsterID, self.g_BigBox.PosX + math.random(10), self.g_BigBox.PosY + math.random(10), 3, 0, self.g_BigBox.ScriptID )
			self:SetCharacterName(MstId, self.g_BigBox.Name )
			self:SetCharacterDieTime(MstId, 60 * 60 * 1000)
			local id = box.content.id
			if type(id) == "table" then
				id = id[math.random(#id)]
			end
			self:MonsterAI_SetIntParamByIndex(MstId, self.IDX_ITEM_ID, id)
			self:MonsterAI_SetIntParamByIndex(MstId, self.IDX_ITEM_NUM, box.content.num)
		end
	end
end

function eShengShou_Boss:CheckOpenBigBox(activatorId, selfId)
	local opening_oid = self:MonsterAI_GetIntParamByIndex(selfId, self.IDX_BOX_OPEN_OID)
	--如果有人正在开大宝箱....
	local NowTime = self:LuaFnGetCurrentTime()
	if opening_oid ~= 0 then
		--如果是自己在开....
		if opening_oid == activatorId then
			return 1, "(ERROR)"
		end
		local opening_time = self:MonsterAI_GetIntParamByIndex(selfId, self.IDX_BOX_OPEN_TIME)
		--如果是别人在开并且他已经超时了....则让位给我来开....
		if (NowTime - opening_time) > 150 then
			self:MonsterAI_SetIntParamByIndex(selfId, self.IDX_BOX_OPEN_TIME, NowTime)
			self:MonsterAI_SetIntParamByIndex(selfId, self.IDX_BOX_OPEN_OID, activatorId)
			return 1, "(ERROR)"
		else
			return -1, self:GetName(opening_oid)
		end
	end
	--没有人在开大宝箱....
	self:MonsterAI_SetIntParamByIndex(selfId, self.IDX_BOX_OPEN_TIME, NowTime)
	self:MonsterAI_SetIntParamByIndex(selfId, self.IDX_BOX_OPEN_OID, activatorId)
	return 1, "(ERROR)"
end

function eShengShou_Boss:OnCancelOpen(selfId)
	self:MonsterAI_SetIntParamByIndex(selfId, self.IDX_BOX_OPEN_OID, 0)
end

function eShengShou_Boss:OnBigBoxOpen( selfId, activatorId )
	local item_id = self:MonsterAI_GetIntParamByIndex(selfId, self.IDX_ITEM_ID)
	local item_num = self:MonsterAI_GetIntParamByIndex(selfId, self.IDX_ITEM_NUM)
	local BagIndex = self:TryRecieveItemWithCount(activatorId, item_id, item_num, false)
	if BagIndex ~= -1 then
		self:BeginEvent(self.script_id)
        self:AddText("你获得了" .. item_num .. "个#{_ITEM"..item_id.."}" )
		self:EndEvent()
		self:DispatchMissionTips(activatorId )

		--公告....
		local ItemTransfer = self:GetBagItemTransfer(activatorId,BagIndex)
		local PlayerName = self:GetName(activatorId)
		local fmt = gbk.fromutf8("#W#{_INFOUSR%s}#P在#G长春谷-不老殿#P举烟放火不小心熏了眼睛，模糊之中撞在#Y" .. self.g_BigBox.Name .. "#P上，打开一看，竟然是#{_INFOMSG%s}#G" .. item_num .. "#P个。")
		local str = string.format(fmt, gbk.fromutf8(PlayerName), ItemTransfer)
		self:BroadMsgByChatPipe(activatorId, str, 4 )
	end
	--kill大宝箱....大宝箱死亡动画为打开盖子....
	self:LuaFnSendSpecificImpactToUnit( selfId, selfId, selfId, 169, 0);
	self:LuaFnGmKillObj(selfId, activatorId)

	self:LOGI(string.format("玩家%d打开天外宝箱, 获得了道具%d一共%d个", self:LuaFnGetGUID(activatorId), item_id, item_num))
end

function eShengShou_Boss:TestOpenBox()
	local MstId = self:LuaFnCreateMonster(self.g_BigBox.MonsterID, self.g_BigBox.PosX + math.random(10), self.g_BigBox.PosY + math.random(10), 3, 0, self.g_BigBox.ScriptID )
	self:SetCharacterName(MstId, self.g_BigBox.Name )
	self:SetCharacterDieTime(MstId, 60 * 60 * 1000)
	local id = 38002515
	self:MonsterAI_SetIntParamByIndex(MstId, self.IDX_ITEM_ID, id)
	self:MonsterAI_SetIntParamByIndex(MstId, self.IDX_ITEM_NUM, 1)
end


return eShengShou_Boss