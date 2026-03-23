--动态生成的夺宝马贼
--普通
local gbk = require "gbk"
local define = require "define"
local class = require "class"
local script_base = require "script_base"
local object_chengxiongdatu_CorpseMonster = class("object_chengxiongdatu_CorpseMonster", script_base)

function object_chengxiongdatu_CorpseMonster:OnDefaultEvent(selfId, targetId)
    --判断是否能够激活该npc的条件
	local npcLevel =  self:GetLevel(targetId)
	local teamLeaderID = self:GetTeamLeader(selfId)
	--取得玩家附近的队友数量（包括自己）
	local nearteammembercount = self:GetNearTeamCount(selfId )
	if teamLeaderID == define.INVAILD_ID or  nearteammembercount < 3 then
        self:BeginEvent(self.script_id)
			self:AddText("胆敢小看我，至少3人组队才行噢, 哈哈。")
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
		return
    end

    local teamLeaderLevel = self:GetLevel(teamLeaderID)
	if teamLeaderLevel < npcLevel then
		self:BeginEvent(self.script_id)
			self:AddText("胆敢小看我，等级再高些就知道我的厉害了")
        self:EndEvent()
        self:DispatchEventList(selfId,targetId)
		return
	else
		--设置对怪为敌对的 目前是28号是敌对的，如果有人改变了相应的势力声望那我就惨了！！:-(((
	    self:SetUnitReputationID(selfId, targetId, 28)
	end
end

function object_chengxiongdatu_CorpseMonster:OnEventRequest(selfId, targetId, arg, index)
end


function object_chengxiongdatu_CorpseMonster:OnDie(selfId, killerId)
	local nearteammembercount = self:GetNearTeamCount(killerId)
	for i=1, nearteammembercount  do
		local nPlayerId = self:GetNearTeamMember(killerId, i)
		self:LuaFnAddMissionHuoYueZhi(nPlayerId, 7)
	end
end


return object_chengxiongdatu_CorpseMonster