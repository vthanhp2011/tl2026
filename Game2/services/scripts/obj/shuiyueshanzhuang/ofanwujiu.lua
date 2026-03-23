--水月山庄副本
--梵无救对话脚本

local class = require "class"
local script_base = require "script_base"
local ofanwujiu = class("ofanwujiu", script_base)
--副本逻辑脚本号....
ofanwujiu.g_FuBenScriptId = 892328
ofanwujiu.script_id = 892336

--**********************************
--任务入口函数....
--**********************************
function ofanwujiu:OnDefaultEvent(selfId, targetId )
	self:BeginEvent(self.script_id)
	self:AddText("#{SYSZ_20210203_41}" )
	self:AddNumText("挑战", 10, 1 )
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function ofanwujiu:OnEventRequest(selfId, targetId, eventId )
	--是不是队长....
	if not self:IsCaptain(selfId) then
		self:BeginEvent(self.script_id)
		self:AddText("#{SYSZ_20210203_32}" )
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	--取得当前场景里的人数
	local nHumanCount = self:LuaFnGetCopyScene_HumanCount()
	local nHumanID;
	for i = 1,nHumanCount do
		nHumanID = self:LuaFnGetCopyScene_HumanObjId(i)
		if self:LuaFnIsObjValid(nHumanID)and self:LuaFnIsCanDoScriptLogic(nHumanID) then
			self:DoNpcTalk(nHumanID,108)
			self:BeginEvent(self.script_id)
			self:AddText("#{SYSZ_20210203_76}")
			self:EndEvent()
			self:DispatchMissionTips(nHumanID)
		end
	end
	--开启计时器来激活自己....
	self:CallScriptFunction(self.g_FuBenScriptId, "CreateBOSS", "FanWuJiu_BOSS", -1, -1)
	self:CallScriptFunction(self.g_FuBenScriptId, "DeleteBOSS", "FanWuJiu_NPC")
	self:BeginUICommand()
	self:EndUICommand()
	self:DispatchUICommand(selfId, 1000)
end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function ofanwujiu:OnSYSZTimer(step)
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
		self:CallScriptFunction(self.g_FuBenScriptId, "DeleteBOSS", "FanWuJiu_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		self:CallScriptFunction(self.g_FuBenScriptId, "CreateBOSS", "FanWuJiu_BOSS", -1, -1 )
		return
	end

end

return ofanwujiu