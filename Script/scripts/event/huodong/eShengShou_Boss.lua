--圣兽山宝箱争夺
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local eShengShou_Boss = class("eShengShou_Boss", script_base)
eShengShou_Boss.DataValidator = 0
eShengShou_Boss.script_id = 3000001
eShengShou_Boss.MonsterID	= 51660
eShengShou_Boss.PosX		= 160
eShengShou_Boss.PosY		= 161
eShengShou_Boss.MonsterName = "天外Boss"
eShengShou_Boss.g_BigBox = {
	Name			= "天外Boss的宝箱",
	MonsterID	= 5011,
	PosX		= 160,
	PosY		= 161,
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
	{ content = { id = 20501003, num = 10 }, count = 5},
	{ content = { id = 20502003, num = 10 }, count = 5},

	{ content = { id = 30310104, num = 1 }, count = 1},
	{ content = { id = 30310104, num = 1 }, count = 1},
	{ content = { id = 10142415, num = 1 }, count = 1},
	{ content = { id = 10125626, num = 1 }, count = 1},

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
function eShengShou_Boss:GetDataValidator(param1,param2)
	eShengShou_Boss.DataValidator = math.random(1,2100000000)
	return eShengShou_Boss.DataValidator
end

function eShengShou_Boss:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5, param6)
	if param6 ~= eShengShou_Boss.DataValidator then
		return
	elseif not iNoticeType or not param2 or not param3 or not param4 or not param5 then
		return
	end
	if self:CurSceneHaveMonster(self.MonsterID) then
		return
	end
	--雷电交加天气效果....
	local curWeather = self:LuaFnGetSceneWeather()
	if not curWeather or curWeather ~= -1 then
		--已经有天气了则不改变天气....
	else
		self:LuaFnSetSceneWeather(3, 5*60*1000 )
	end
	--没有则创建NPC大宝箱....
    local sceneId = self:get_scene_id()
	local MstId = self:LuaFnCreateMonster(self.MonsterID, self.PosX, self.PosY, 3, 0, self.script_id,90)
	self:LuaFnSetNpcIntParameter(MstId, 1, sceneId)
	self:LuaFnSetNpcIntParameter(MstId, 2, 391 + 1)
	self:SetCharacterDieTime(MstId, 60 * 60 * 1000)
	self:SetCharacterName(MstId, self.MonsterName)
	local NotifyMsg = "@*;SrvMsg;SCA:#G天外Boss#P已降临长春谷-不老殿#G(160, 161)#P，请从洛阳龙霸天对话前往，击败后开启宝箱，可获得海量珍稀奖励"
	self:AddGlobalCountNews(NotifyMsg)
	self:LuaFnSetLifeTimeAttrRefix_MaxHP(MstId, 204779960 * 2)
	self:RestoreHp(MstId)
end
function eShengShou_Boss:OnTimer(actId, uTime, param1)
	if not uTime or uTime ~= param1 then
		return
	end
end
function eShengShou_Boss:OnDie(objId, killerId)
    local sceneId = self:get_scene_id()
	if self:LuaFnGetNpcIntParameter(targetId,1) ~= sceneId then
		-- self:LuaFnDeleteMonster(targetId)
		self:notify_tips(selfId, "非活动创建")
		return
	end
	local actId = self:LuaFnGetNpcIntParameter(targetId,2)
	if not actId or actId < 1 then
		-- self:LuaFnDeleteMonster(targetId)
		self:notify_tips(selfId, "非活动创建")
		return
	end
	actId = actId - 1
    if not self:CheckActiviyValidity(actId) then
        -- self:LuaFnDeleteMonster(targetId)
		self:notify_tips(selfId, "活动已结束")
        return
    end
	for _, box in ipairs(self.Boxs) do
		for i = 1, box.count do
			local MstId = self:LuaFnCreateMonster(self.g_BigBox.MonsterID, self.g_BigBox.PosX + math.random(10) - 5, self.g_BigBox.PosY + math.random(10) - 5, 3, 0, self.g_BigBox.ScriptID )
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

function eShengShou_Boss:OnCancelOpenXXX(selfId, activatorId)
	local opening_oid = self:MonsterAI_GetIntParamByIndex(selfId, self.IDX_BOX_OPEN_OID)
	if activatorId == opening_oid then
		self:MonsterAI_SetIntParamByIndex(selfId, self.IDX_BOX_OPEN_OID, 0)
		self:MonsterAI_SetIntParamByIndex(selfId, self.IDX_BOX_OPEN_TIME, 0)
	end
end

function eShengShou_Boss:OnBigBoxOpen( selfId, activatorId )
	local item_id = self:MonsterAI_GetIntParamByIndex(selfId, self.IDX_ITEM_ID)
	local item_num = self:MonsterAI_GetIntParamByIndex(selfId, self.IDX_ITEM_NUM)
		
	-- if self:LuaFnGmKillObj(selfId, activatorId) then
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
		-- if not self:LuaFnGmKillObj(selfId, activatorId) then
			-- self:LuaFnDeleteMonster(selfId)
		-- end
		self:LuaFnGmKillObj(selfId, activatorId)

		self:LOGI(string.format("玩家%d打开天外宝箱, 获得了道具%d一共%d个", self:LuaFnGetGUID(activatorId), item_id, item_num))
	-- end
end

return eShengShou_Boss