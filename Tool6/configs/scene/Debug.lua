--大理NPC
--测试专用NPC
--//////////////////////////////////////////////////////////////////////////////
--！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
--【【外放版本】】【【外放版本】】【【外放版本】】【【外放版本】】【【外放版本】】
--！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
--//////////////////////////////////////////////////////////////////////////////
x990005_g_scriptId = 990005
--**********************************
--事件交互入口
--**********************************
function x990005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "逍遥纪I DebugVersion #cff0000 0.00.1500 #r#G本版本为第一次外测版本")
--		AddNumText( sceneId, x990005_g_scriptId, "称号测试", 1, 666 )
		AddNumText( sceneId, x990005_g_scriptId, "恢复血、气、怒气", 1, 3 )
		--AddNumText( sceneId, x990005_g_scriptId, "内测领取YB【无限哟】", 1, 5 )
		AddNumText( sceneId, x990005_g_scriptId, "测试", 1, 6 )
		--AddNumText( sceneId, x990005_g_scriptId, "领取70000经验【限10次】", 1, 2 )
		--AddNumText( sceneId, x990005_g_scriptId, "了解本次测试内容", 11, 4 )
--		AddNumText( sceneId, x990005_g_scriptId, "看看我的身上有多少buff", 11, 5 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x990005_DebugItem(sceneId,selfId)
	
end
function x990005_ShowCharacterMsg(sceneId,selfId)
end
function x990005_OnEventRequest( sceneId, selfId, targetId, eventId)
	--////////////////////////////////////
	local nIndex = GetNumText()
--	if nIndex == 666 then
--		LuaFnAwardSpouseTitle(sceneId,selfId,"#Y#985龙游凤舞逍遥仙#986")
--		SetCurTitle( sceneId, selfId,22 );
--	end
	if nIndex == 5 then
		local YB = 10000000
		local strText
		YuanBao(sceneId,selfId,targetId,1,YB) 
		BeginEvent(sceneId)
			strText = "领取成功！ 获得"..YB.."点元宝"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)		
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)  --特效	
	end
	if nIndex == 1 then
		local nYuanBaoNum = GetMissionDataEx(sceneId,selfId,MD_CESHI_YUANBAO)
		if nYuanBaoNum >= 10 then
		    x990005_NotifyFailTips(sceneId, selfId, "本次测试期间只能领取十次哦！！！")
			return
		end
		x990005_NotifyFailTips(sceneId, selfId, "10000个元宝领取成功")
		SetMissionDataEx(sceneId,selfId,MD_CESHI_YUANBAO,nYuanBaoNum + 1)
	end
	if nIndex == 2 then
		local nYuanBaoNum = GetMissionDataEx(sceneId,selfId,MD_CESHI_JINGYAN)
		if nYuanBaoNum >= 10 then
		    x990005_NotifyFailTips(sceneId, selfId, "本次测试期间只能领取十次哦！！！")
			return
		end
		x990005_NotifyFailTips(sceneId, selfId, "70000点经验领取成功")
		SetMissionDataEx(sceneId,selfId,MD_CESHI_JINGYAN,nYuanBaoNum + 1)
	end
	if nIndex == 3 then
	    RestoreHp( sceneId, selfId ) ------满血
		RestoreMp( sceneId, selfId ) ------满气
		RestoreRage( sceneId, selfId ) ------满怒
		x990005_NotifyFailTips(sceneId, selfId, "你的生命数值已经完全恢复了！")
	end
	if nIndex == 4 then
	    x990005_NotifyFailBox( sceneId, selfId, targetId,"本次测试为《逍遥纪》第一次对外测试，主要测试程序的适配度以及新的服务器结构的稳定性！#r本次测试为删档测试，测试周期为一周，测试结束后，#G邀请码再下一次测试中依然有效！")
	end
	if nIndex == 5 then
		--CCBUF(sceneId, selfId,targetId)
	end
	--////////////////////////////////////
end
function CCBUF(sceneId, selfId,targetId)	 --查看人物buff	 
	local p = {}
	local u = 0 
	for i =1 ,50000 do 
		if  LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, i) == 1 then 
			u = u + 1
			p[u]=i
		end
	end
	local	str = ""
	for j = 1, getn(p) do 
		str =str ..p[j]..","
	end
	x990005_NotifyFailTips( sceneId, selfId, "BUFF NUM:"..u )		
	x990005_NotifyFailTips( sceneId, selfId, str )
	x990005_NotifyFailBox( sceneId, selfId, targetId, "BUFF NUM:"..u.."\n"..str )			
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x990005_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x990005_NotifyFailTips( sceneId, selfId, Tip )

	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )

	DispatchMissionTips( sceneId, selfId )
end