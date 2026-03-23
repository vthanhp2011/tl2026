local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local changefacestyle = class("changefacestyle", script_base)

function changefacestyle:UnlockAndChangeExteriorFaceId(selfId, ...)
    print("hangeheadstyle:UnlockAndChangeExteriorFaceId", ...)
    local styleId, check = ...
	if self:HaveThisFaceStyle(selfId, styleId) then
		self:ChangePlayerFaceModel(selfId, styleId)
		self:notify_tips(selfId, "已经拥有该脸型，已经为您切换" )
		return
	end

	-- 得到调整头像所需物品的id及其数量
	local ItemId, ItemCount = self:GetChangeFaceItemIdAndItemCount(styleId)
	-- 返回值非法
	if ItemId < 0 or ItemCount < 0 then
		return
	end
	local nItemNum = self:LuaFnGetAvailableItemCount(selfId, ItemId )
	--消耗物品是否够用或锁定
	if ItemCount > nItemNum then
		self:UnlockAndChangeExteriorFaceId_YuanbaoPay(selfId, ItemId, check)
		return
	end

    local ItemPos = self:LuaFnGetItemPosByItemDataID(selfId, ItemId, 0)
	local szItemTransfer = self:GetBagItemTransfer(selfId, ItemPos)

	-- 物品检测通过，再检查玩家金钱
	local moneyJZ = self:GetMoneyJZ (selfId)
	local money = self:GetMoney (selfId)

	-- 物品和金钱检测都通过
	if (moneyJZ + money >= 50000)	then
		-- 设置玩家新脸型
        local ret = self:ChangePlayerFaceModel(selfId, styleId)
        if not ret then
            self:notify_tips(selfId, "已经拥有该脸型" )
            return
        end
        self:LuaFnDelAvailableItem(selfId,ItemId,1) --材料扣除
        self:LuaFnCostMoneyWithPriority(selfId, 50000) --扣钱
        self:notify_tips(selfId, "修改脸型成功。" )
	-- 金钱不足
	else
		self:notify_tips(selfId, "金钱不足" )
		return
	end

	-- 发布公告
	-- 发送广播
	local message
	local randMessage = math.random(3)
	local nsex = self:GetSex(selfId)
	local str1,str2
	if nsex == 0  then
		str1 = "她"
		str2 = "美"
	else
		str1 = "他"
		str2 = "帅"
	end
    local name = self:GetName(selfId)
	if randMessage == 1 then
        local fmt = "#H人要面子树要皮，#W#{_INFOUSR%s}#H深知这个道理，今天用#W#{_INFOMSG%s}#H这一整容更不得了，简直就是气死潘安，羡煞貂蝉！"
		message = string.format(gbk.fromutf8(fmt), gbk.fromutf8(name), szItemTransfer)
	elseif randMessage == 2 then
        local fmt = gbk.fromutf8("#H魔镜说这个世界上最" .. str2 .. "的人诞生了！那就是刚才让天上大雁掉下来的#W#{_INFOUSR%s}#H，快去看看" .. str1 .. "吧，这#W#{_INFOMSG%s}#H用完后果然效果出众！")
		message = string.format(fmt,  gbk.fromutf8(name), szItemTransfer)
	else
        local fmt = gbk.fromutf8("#H咦？怎么小溪中的鱼儿都翻了肚皮？难道是中毒身亡？不对，原来是#W#{_INFOUSR%s}#H刚刚走过去，鱼儿们羞得晕了过去。天呀！" .. str1 .. "用了#W#{_INFOMSG%s}#H以后竟然会有这样的绝世容颜！")
		message = string.format(fmt, gbk.fromutf8(name), szItemTransfer)
	end
	self:BroadMsgByChatPipe(selfId, message, 4)
end

function changefacestyle:UnlockAndChangeExteriorFaceId_YuanbaoPay(selfId, ItemIndex, check)
	local hint = "#{XFYH_20120221_29"
	local index, merchadise = self:GetMerchadiseByItemIndex(selfId, ItemIndex)
	if index == nil then
		self:notify_tips(selfId, "您没有该定颜珠，或者该定颜珠被锁定。" )
		return
	end
	self:BeginUICommand()
	self:UICommand_AddInt(3)
	self:UICommand_AddInt(5)
	self:UICommand_AddInt(merchadise.price)
	self:UICommand_AddInt(index - 1)
	self:UICommand_AddInt(0)
	self:UICommand_AddInt(self.script_id)
	self:UICommand_AddInt(check)
	self:UICommand_AddInt(-1)
	self:UICommand_AddInt(1)
	local str = self:ContactArgs(hint, merchadise.id, merchadise.price, "#{XFYH_20120221_10}", "#{XFYH_20120221_12}", merchadise.pnum or 1) .. "}"
	self:UICommand_AddStr(str)
	self:EndUICommand()
	self:DispatchUICommand(selfId, 20120222)
end

return changefacestyle