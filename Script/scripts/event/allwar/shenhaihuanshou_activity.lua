--蜃海幻兽
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local shenhaihuanshou_activity = class("shenhaihuanshou_activity", script_base)
shenhaihuanshou_activity.script_id = 999979
shenhaihuanshou_activity.DataValidator = 0
--公告
shenhaihuanshou_activity.text = "#{HDSJBOSS_Text1}"
--随机场景数
shenhaihuanshou_activity.randomscene = 3
--boss信息
shenhaihuanshou_activity.bossinfo = 
{
	{
		sceneId = 708,
		scenename = "地火岛",
		bossId = 51925,
		lifetime = 3600 * 1000,			--存活时间  单位毫秒
		bossHp = 0,						--该项 > 0 时则修正BOSS血量    = 0 时则以怪物表血量为准
		monsterpos = 
		{
			{125,60,false},
			{80,185,false},
			{180,190,false},
			-- {78,107,false},
			-- {184,90,false},
			-- {180,189,false},
			-- {77,190,false},
		},
	},
	{
		sceneId = 707,
		scenename = "沉月岛",
		bossId = 51923,
		lifetime = 3600 * 1000,			--存活时间  单位毫秒
		bossHp = 0,						--该项 > 0 时则修正BOSS血量    = 0 时则以怪物表血量为准
		monsterpos = 
		{
			{70,80,false},
			{62,184,false},
			{150,200,false},
			-- {188,153,false},
			-- {62,182,false},
			-- {161,203,false},
			-- {131,103,false},
		},
	},
	{
		sceneId = 709,
		scenename = "繁林岛",
		bossId = 51927,
		lifetime = 3600 * 1000,			--存活时间  单位毫秒
		bossHp = 0,						--该项 > 0 时则修正BOSS血量    = 0 时则以怪物表血量为准
		monsterpos = 
		{
			{60,60,false},
			{188,50,false},
			{132,174,false},
			-- {208,219,false},
			-- {143,185,false},
			-- {104,221,false},
			-- {36,144,false},
			-- {122,109,false},
		},
	},
}
--以下单位：小时  创建一次
shenhaihuanshou_activity.openhours = {
		[1] = true,
		[2] = true,
		[3] = true,
		[5] = true,
		[7] = true,
		[9] = true,
		[10] = true,
		[12] = true,
		[13] = true,
		[16] = true,
		[17] = true,
		[19] = true,
		[21] = true,
}

--非配置内容
shenhaihuanshou_activity.minutetick = 2


function shenhaihuanshou_activity:GetDataValidator(param1,param2)
	self.DataValidator = math.random(1,2100000000)
	return self.DataValidator
end
function shenhaihuanshou_activity:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5, param6)
	if param6 ~= self.DataValidator then
		return
	elseif not iNoticeType or not param2 or not param3 or not param4 or not param5 then
		return
	-- elseif self.scene:get_id() ~= self.scene:get_param(1) then
		-- return
	end
	if not self:HaveActivity(newId) then
		self:StartOneActivity(actId,2100000000,iNoticeType,nil,nil,-1)
	end
end

function shenhaihuanshou_activity:CreateBoss(actId,sceneId)
	if not actId or actId >= 0 then
		return
	end
	actId = -1 * actId
	if self:get_scene():get_id() ~= sceneId
	or actId ~= define.ACTIVITY_SIZHOU_ID then
		return
	end
	local bossinfo
	for i,j in ipairs(self.bossinfo) do
		if j.sceneId == sceneId then
			bossinfo = j
			break
		end
	end
	if not bossinfo then return end
	local objId,obj
	for i,j in ipairs(bossinfo.monsterpos) do
		objId = self:LuaFnCreateMonster(bossinfo.bossId,j[1],j[2],4,0,-1)
		if objId then
			self:SetCharacterDieTime(objId,bossinfo.lifetime or 3600000)
			if bossinfo.bossHp > 0 then
				self:LuaFnSetLifeTimeAttrRefix_MaxHP(objId,bossinfo.bossHp)
				self:RestoreHp(objId)
			end
			-- self:SetCharacterName(objId, "")
			self:SetCharacterTitle(objId,bossinfo.scenename.."BOSS")
			self:SetUnitReputationID(objId,objId,29)
		end
	end
	-- self:AddGlobalCountNews("@*;SrvMsg;SCA:"..bossinfo.scenename..":"..self.text)
end
--*********************************
-- 心跳
--*********************************
function shenhaihuanshou_activity:OnTimer_Hour(actId,minute,hminute,hour)
	if not actId or actId >= 0 then
		return
	end
	-- actId = -1 * actId
	if self.openhours[hour] and minute == 0 then
		local idxtab = {}
		for i = 1,#self.bossinfo do
			idxtab[i] = self.bossinfo[i].sceneId
		end
		local scenetab = {}
		local index
		for i = 1,self.randomscene do
			if i <= #self.bossinfo then
				index = math.random(#idxtab)
				table.insert(scenetab,idxtab[index])
				table.remove(idxtab,index)
			end
		end
		local skynet = require "skynet"
		for i,j in ipairs(scenetab) do
			local name = string.format(".SCENE_%d", j)
			skynet.send(name, "lua", "char_excute_Script", self.script_id, "CreateBoss", actId, j)
		end
		self:AddGlobalCountNews("@*;SrvMsg;SCA:"..self.text)
	end
end
function shenhaihuanshou_activity:OnTimer(actId, uTime, param1)
end
		
return shenhaihuanshou_activity
