--缥缈峰副本....
--哈大霸对话脚本....

local class = require "class"
local script_base = require "script_base"
local ohadaba = class("ohadaba", script_base)
--副本逻辑脚本号....
ohadaba.g_FuBenScriptId = 402263

ohadaba.script_id = 402270
--**********************************
--任务入口函数....
--**********************************
function ohadaba:OnDefaultEvent(selfId, targetId )
	self:BeginEvent(self.script_id)
	self:AddText("#{PMF_20080521_06}" )
	self:AddNumText("挑战", 10, 1 )
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function ohadaba:OnEventRequest(selfId, targetId, eventId )
	--如果正在激活BOSS则返回....
	if 1 == self:CallScriptFunction(self.g_FuBenScriptId, "IsPMFTimerRunning") then
		return
	end
	--是不是队长....
	if not self:IsCaptain(selfId) then
		self:BeginEvent(self.script_id)
		self:AddText("#{PMF_20080521_07}" )
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end

	--如果正在和别的BOSS战斗则返回....
	local ret, msg = self:CallScriptFunction(self.g_FuBenScriptId, "CheckHaveBOSS")
	if 1 == ret then
		self:BeginEvent(self.script_id)
		self:AddText(msg)
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end

	--判断当前是否可以挑战桑哈大霸...
	if 2 == self:CallScriptFunction( self.g_FuBenScriptId, "GetBossBattleFlag", "HaDaBa" ) then
		self:BeginEvent(self.script_id)
		self:AddText("不能重复挑战")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	self:CallScriptFunction(self.g_FuBenScriptId, "OpenPMFTimer", 7, self.script_id, -1 ,-1 )
	self:BeginUICommand()
	self:EndUICommand()
	self:DispatchUICommand(selfId, 1000)
end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function ohadaba:OnPMFTimer(step)
	if 7 == step then
		self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		self:CallScriptFunction(self.g_FuBenScriptId, "TipAllHuman", "战斗开始" )
		--删除NPC....
		self:CallScriptFunction(self.g_FuBenScriptId, "DeleteBOSS", "HaDaBa_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		self:CallScriptFunction(self.g_FuBenScriptId, "CreateBOSS", "HaDaBa_BOSS", -1, -1 )
		return
	end

end

return ohadaba