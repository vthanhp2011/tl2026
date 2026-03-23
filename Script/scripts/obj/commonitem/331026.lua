local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
common_item.g_itemList = {}
common_item.g_itemList[30509029] = {effect=2, time=60,
	msg1="#W#{_INFOUSR%s}#H见久旱无雨，田地龟裂，树木枯黄，心生不忍，遂掏出一个%s#H，口中念念有词，一时间只见天空乌云密布，风雨大作。",
	msg2="#W#{_INFOUSR%s}#H见#G%s#H久旱无雨，田地龟裂，树木枯黄，心生不忍，遂掏出一个%s#H，口中念念有词，一时间只见天空乌云密布，风雨大作。"}
common_item.g_itemList[30509030] = {effect=3, time=60,
	msg1="#W#{_INFOUSR%s}#H正在爱人面前赌咒发誓，若负对方将来必被天打雷劈。不料话音刚落，竟然真的雷声大作，闪电阵阵，顿时吓得面如土色，后来发现是身上的%s#H所致，方才松了口气。",
	msg2="#W#{_INFOUSR%s}#H正在爱人面前赌咒发誓，若负对方将来必被天打雷劈。不料话音刚落，#G%s#H竟然真的雷声大作，闪电阵阵，顿时吓得面如土色，后来发现是身上的%s#H所致，方才松了口气。"}
common_item.g_itemList[30509031] = {effect=4, time=60,
	msg1="#W#{_INFOUSR%s}#H被几个想打雪仗的小屁孩缠得没了办法，只得掏出珍藏已久%s#H，大叫一声“冤！”，天空登时下起鹅毛般的大雪来，众小屁孩才雀跃着跑开。",
	msg2="#W#{_INFOUSR%s}#H在#G%s#H被几个想打雪仗的小屁孩缠得没了办法，只得掏出珍藏已久%s#H，大叫一声“冤！”，天空登时下起鹅毛般的大雪来，众小屁孩才雀跃着跑开。"}
common_item.g_itemList[30509032] = {effect=5, time=60,
	msg1="#W#{_INFOUSR%s}#H为了增加与爱人花前月下的浪漫气氛，忍痛使用了得来不易的%s#H。",
	msg2="#W#{_INFOUSR%s}#H为了增加与爱人在#G%s#H花前月下的浪漫气氛，忍痛使用了得来不易的%s#H。"}
common_item.g_itemList[30509033] = {effect=6, time=60,
	msg1="#W#{_INFOUSR%s}#H正要与某武林高手比武，心中一动，提前使用了一个%s#H，但见满天竹叶飞舞，登时变得气势淩人起来。",
	msg2="#W#{_INFOUSR%s}#H正要与某武林高手在#G%s#H比武，心中一动，提前使用了一个%s#H，但见满天竹叶飞舞，登时变得气势淩人起来。"}
common_item.g_itemList[30509034] = {effect=7, time=60,
	msg1="#W#{_INFOUSR%s}#H在散步时，忽而诗兴大发，随手使用了一个%s#H，看着满天飞舞的枫叶，竟随口吟出“霜叶红于二月花”的佳句来，令路人刮目相看。",
	msg2="#W#{_INFOUSR%s}#H在#G%s#H散步时，忽而诗兴大发，随手使用了一个%s#H，看着满天飞舞的枫叶，竟随口吟出“霜叶红于二月花”的佳句来，令路人刮目相看。"}
common_item.g_itemList[30509035] = {effect=8, time=60,
	msg1="#W#{_INFOUSR%s}#H总被人讥笑脸嫩，心中不忿，一气之下使用了一个%s#H，从漫天的沙尘中走出后，满意地发现自己已经沧桑了许多。",
	msg2="#W#{_INFOUSR%s}#H总被人讥笑脸嫩，心中不忿，一气之下在#G%s#H使用了一个%s#H，从漫天的沙尘中走出后，满意地发现自己已经沧桑了许多。"}
common_item.g_itemList[30509036] = {effect=9, time=60,
	msg1="#W#{_INFOUSR%s}#H做梦都想发财，于是使用了一个%s#H，登时天空中元宝有如雨下，人们欢呼雀跃。",
	msg2="#W#{_INFOUSR%s}#H做梦都想发财，于是在#G%s#H使用了一个%s#H，登时中元宝有如雨下，人们欢呼雀跃。"}
common_item.g_itemList[30509052] = {effect=10, time=60,
	msg1="#H五月，是一场雷鸣后大雨来临，南飞的大雁跋山涉水归家的日子；在这烂漫的季节#W#{_INFOUSR%s}#H使用了一个#W%s#H，藉以赞美这冬麦扬穗农民挥汗荷锄，辛勤耕耘的好光景。",
	msg2="#H劳动是神奇的，劳动是伟大的。劳动者用勤劳的双手和智慧，编织了这个五彩班斓的世界，创造了人类的文明。#W#{_INFOUSR%s}#H在这个特别的日子里，在#G%s#H使用了一个#W%s#H向全世界的劳动者致敬！"}
common_item.g_itemList[30509066] = {effect=20, time=60,
	msg1="#H七夕将至，#W#{_INFOUSR%s}#H昨夜梦见牛郎织女鹊桥相会，羡慕无比，于是使用了一个#W%s#H，以此来向所有单身的人们散播爱的讯号！",
	msg2="#H七夕，鹊桥，银河，牛郎织女......#W#{_INFOUSR%s}#H在这个特别的日子里，突然心有所感，向#G%s#H的天空掷去一把#W%s#H，登时花雨纷飞。"}
common_item.g_itemList[30509071] = {effect=21, time=60,
	msg1="#{AOYYH_8804_01}#W#{_INFOUSR%s}#H激情澎湃地#{AOYYH_8804_03}%s#{AOYYH_8804_04}",
	msg2="#{AOYYH_8804_01}#W#{_INFOUSR%s}#H激情澎湃地在#G%s#{AOYYH_8804_03}%s#{AOYYH_8804_04}"}
common_item.g_itemList[30509083] = {effect=22, time=60,
	msg1="#H时至挚友生辰，#W#{_INFOUSR%s}#H亦喜不自禁，于是使用了一个#W%s#H，以此来表达对朋友最真挚的生日祝福！",
	msg2="#W#{_INFOUSR%s}#H在至交生日之际，于#G%s#H燃放了一个#W%s#H，并祝福道：愿所有的快乐、所有的幸福、所有的温馨、所有的好运都围绕在你身边，生日快乐！"}

function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
	--校验使用的物品
	if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end

	local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId );
	local curItem = self.g_itemList[itemTblIndex];
	if not curItem then
		self:notify_tips(selfId, "未开放道具，无法使用。");
		return 0;
	end
	local curWeather = self:LuaFnGetSceneWeather();
	if not curWeather or curWeather ~= -1 then
		self:notify_tips(selfId, "特殊天气下无法使用该物品。");
		return 0;
	end

	return 1; --不需要任何条件，并且始终返回1。
end 

function common_item:OnDeplete(selfId)
	local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem( selfId );
	local curItem = self.g_itemList[itemTblIndex];
	if not curItem then
		self:notify_tips(selfId, "未开放道具，无法使用。");
		return 0;
	end
	local itemBagIndex = self:LuaFnGetBagIndexOfUsedItem(selfId);
	local szTransferItem = self:GetBagItemTransfer(selfId, itemBagIndex);
	local selfName = self:GetName(selfId);
	if(self:LuaFnDepletingUsedItem(selfId)) then
		if szTransferItem and selfName then
			local sceneType = self:LuaFnGetSceneType()
			local strMsg
			selfName = gbk.fromutf8(selfName)
			if sceneType and sceneType == 0 then
				local sceneName = self:GetSceneName()
				sceneName = gbk.fromutf8(sceneName)
				local msg2 = gbk.fromutf8(curItem.msg2)
				strMsg = string.format(msg2, selfName, sceneName, "#{_INFOMSG"..szTransferItem.."}")
			else
				local msg1 = gbk.fromutf8(curItem.msg1)
				strMsg = string.format(msg1, selfName, "#{_INFOMSG"..szTransferItem.."}")
			end
			self:BroadMsgByChatPipe(selfId, strMsg, 4)
		end
		return 1
	end
	return 0
end

function common_item:OnActivateOnce(selfId)
	local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local curItem = self.g_itemList[itemTblIndex];
	if not curItem then
		self:notify_tips(selfId, "未开放道具，无法使用。");
		return 0;
	end
	self:LuaFnSetSceneWeather(curItem.effect, curItem.time * 1000 );
	return 1;
end

return common_item