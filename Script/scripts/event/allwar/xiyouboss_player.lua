local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local xiyouboss_player = class("xiyouboss_player", script_base)
xiyouboss_player.script_id = 999981

xiyouboss_player.act_isopen = 2
xiyouboss_player.GoBackScene = 0
xiyouboss_player.GoBackPosx = 160
xiyouboss_player.GoBackPosz = 105

function xiyouboss_player:OnWarScene(selfId)
	local scene = self:get_scene()
	local obj = scene:get_obj_by_id(selfId)
	if not obj then
		return
	end
	local sceneId = scene:get_id()
	if sceneId >= 713 and sceneId <= 715 then
		local act_isopen = self:GetActivityParamEx(define.ACTIVITY_XIYOU_ID,self.act_isopen)
		if act_isopen > 0 then
			self:BeginUICommand()
			self:UICommand_AddInt(329042021)
			self:UICommand_AddInt(1)
			self:UICommand_AddInt(4)
			self:UICommand_AddInt(999983)
			self:UICommand_AddInt(999983)
			self:UICommand_AddStr("GetJingZhuZengLiMsg")
			self:UICommand_AddStr("GetJingZhuZengLiMsg")
			self:EndUICommand()
			self:DispatchUICommand(selfId,329042021)
			return
		else
			obj:notify_tips("活动未开启。")
		end
	end
	self:NewWorld(selfId,self.GoBackScene,nil,self.GoBackPosx,self.GoBackPosz)
end

function xiyouboss_player:OnSceneHumanDie(selfId,killerId)
end

return xiyouboss_player
