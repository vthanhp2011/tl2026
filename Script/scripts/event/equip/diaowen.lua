--雕纹
--脚本号
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local diaowen = class("diaowen", script_base)
diaowen.script_id = 809272
diaowen.g_LCS_Yuanbao = 98			--灵蚕丝元宝售价   客户端有定义显示
	-- 金蚕丝, 强化用的道具, 按照 绑定 -> 元宝交易 -> 随便交易 顺序使用
diaowen.g_DWJinJieQianghua_ToolItem = {20310168, 20310166, 20310167}
diaowen.g_DWJinJieQianghua_ToolItem2 = 20310174
diaowen.g_LCS2JCS = 5

diaowen.g_EquipPoint2DWJinJie_Tool_ItemID = {
	[0] = 30900200,--武器
	[1] = 30900206,--帽子
	[2] = 30900205,--衣服
	[3] = 30900209,--手套
	[4] = 30900211,--鞋
	[5] = 30900210,--腰带
	[6] = 30900212,--戒指
	[7] = 30900204,--项链
	[11] = 30900212,--戒指2
	[12] = 30900213,--护符
	[13] = 30900213,--护符2
	[14] = 30900208,--护腕
	[15] = 30900207,--护肩
	[17] = 30900201,--暗器
	[18] = 30900202,--武魂
	[37] = 30900203,--七情刃
}

function diaowen:OnDefaultEvent( selfId,targetId )
	local npcname = self:GetName(targetId)
	if npcname == "张伏虎" then
		self:BeginEvent()
			self:AddText("#{DWJJ_240329_04}")
			self:AddNumText( "#{DWJJ_240329_05}", 6, 1 )
			self:AddNumText( "#{DWJJ_240329_06}", 6, 2 )
			self:AddNumText( "#{DWJJ_240329_08}", 6, 3 )
			self:AddNumText( "#{DWJJ_240329_11}", 11, 100 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	elseif npcname == "张笑狮" then
		self:BeginEvent()
			self:AddText("#{DWJJ_240329_195}")
			self:AddNumText( "#{DWJJ_240329_67}", 6, 4 )
			self:AddNumText( "#{DWJJ_240329_196}", 6, 5 )
			self:AddNumText( "#{DWJJ_240329_193}", 11, 104 )
			self:AddNumText( "#{DWJJ_240329_355}", 11, 105 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	end
end
function diaowen:OnEventRequest(selfId, targetId, arg, index)
	if index == 0 then
		self:OnDefaultEvent( selfId,targetId )
	elseif index == 1 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId,89030501)
	elseif index == 2 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId,89030502)
	elseif index == 3 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId,89030504)
	elseif index == 4 then
		self:BeginUICommand()
		self:UICommand_AddInt(1)
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId,89030506)
	elseif index == 5 then
		self:BeginUICommand()
		self:UICommand_AddInt(targetId)
		self:EndUICommand()
		self:DispatchUICommand(selfId,89030505)
	elseif index == 100 then
		self:BeginEvent()
			self:AddNumText( "#{DWJJ_240329_11}", 11, 101 ) 
			self:AddNumText( "#{DWJJ_240329_352}", 11, 102 ) 
			self:AddNumText( "#{DWJJ_240329_354}", 11, 103 ) 
			self:AddNumText( "返回首页", 11, 0 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	elseif index == 101 then
		self:BeginEvent()
			self:AddText("#{DWJJ_240329_351}")
			self:AddNumText( "返回首页", 11, 0 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	elseif index == 102 then
		self:BeginEvent()
			self:AddText("#{DWJJ_240329_353}")
			self:AddNumText( "返回首页", 11, 0 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	elseif index == 103 then
		self:BeginEvent()
			self:AddText("#{DWJJ_240329_12}")
			self:AddNumText( "返回首页", 11, 0 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	elseif index == 104 then
		self:BeginEvent()
			self:AddText("#{DWJJ_240329_194}")
			self:AddNumText( "返回首页", 11, 0 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	elseif index == 105 then
		self:BeginEvent()
			self:AddText("#{DWJJ_240329_356}")
			self:AddNumText( "返回首页", 11, 0 ) 
		self:EndEvent(sceneId)
		self:DispatchEventList(selfId,targetId)
	end
end
function diaowen:CheckNpcDist( selfId,npcid )
	if npcid ~= -1 then
		if not self:IsInDist(selfId, npcid, 5) then
			self:notify_tips(selfId,"#{DWJJ_240329_28}")
			return true
		end
	end
	return false
end

function diaowen:DoDiaowenJinJie( selfId,npcid,eqpos,itempos )
	if self:CheckNpcDist( selfId,npcid ) then
		return
	elseif not eqpos or eqpos < 0 then
		return
	elseif not itempos or itempos < 0 then
		return
	end
	local eqid = self:LuaFnGetItemTableIndexByIndex(selfId,eqpos)
	if eqid == define.INVAILD_ID then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local eqpoint = self:GetItemEquipPoint(eqid)
	if not eqpoint then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local needitem = self.g_EquipPoint2DWJinJie_Tool_ItemID[eqpoint]
	if not needitem then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local itemid = self:LuaFnGetItemTableIndexByIndex(selfId,itempos)
	if itemid ~= needitem then
		self:notify_tips(selfId,"#{DWJJ_240329_31}")
		return
	end
	local g_DWJinJieNeedMoney = 500000
	if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < g_DWJinJieNeedMoney then
		self:notify_tips(selfId,"#{HSWQ_20220607_38}")
		return
	end
	local dwlv,dw_advance_level = self:GetDiaoWenFineDraw(selfId, eqpos)
	if dwlv < 4 then
		self:notify_tips(selfId,"4级以上的雕纹方可进行精绘操作。")
		return
	end
	if dw_advance_level > 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_30}")
		return
	end
	self:LuaFnDecItemLayCount(selfId, itempos, 1)
	self:LuaFnCostMoneyWithPriority(selfId, g_DWJinJieNeedMoney)
	local isok = self:SetDiaoWenFineDraw(selfId, eqpos)
	if isok then
		self:notify_tips(selfId,"#{DWJJ_240329_37}")
		self:ShowObjBuffEffect(selfId,selfId,-1,18)
		if isok ~= "" then
			-- self:notify_tips(selfId,"您同时激活新的纹刻:"..isok)
		end
	end
end
function diaowen:DoDiaowenJinJieQiangHua( selfId,npcid,eqpos,count1,count2 )
	if self:CheckNpcDist( selfId,npcid ) then
		return
	elseif not eqpos or eqpos < 0 then
		return
	elseif not count1 or not count2 then
		self:notify_tips(selfId,"数量异常。")
		return
	end
	local eqid = self:LuaFnGetItemTableIndexByIndex(selfId,eqpos)
	if eqid == define.INVAILD_ID then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local eqpoint = self:GetItemEquipPoint(eqid)
	if not eqpoint then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local needitem = self.g_EquipPoint2DWJinJie_Tool_ItemID[eqpoint]
	if not needitem then
		self:notify_tips(selfId,"#{DWJJ_240329_42}")
		return
	end
	local dwlv,dw_advance_level,dw_rankexp = self:GetDiaoWenFineDraw(selfId, eqpos)
	if dwlv < 4 then
		self:notify_tips(selfId,"error。")
		return
	end
	local finedrawlv = dwlv * 5
	if dw_advance_level == 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_57}")
		return
	elseif dw_advance_level >= finedrawlv then
		self:notify_tips(selfId,"#{DWJJ_240329_60}")
		return
	elseif dw_advance_level >= 50 then
		self:notify_tips(selfId,"#{DWJJ_240329_58}")
		return
	end
	local itemcount = {0,0,0}
	local itemallcount = 0
	local itemcount2 = 0
	local addexp = 0
	if count1 > 0 then
		for i,j in ipairs(self.g_DWJinJieQianghua_ToolItem) do
			itemcount[i] = self:LuaFnGetAvailableItemCount(selfId, j)
			itemallcount = itemallcount + itemcount[i]
		end
		if itemallcount < count1 then
			self:notify_tips(selfId,"#{DWJJ_240329_61}")
			return
		end
		addexp = count1
	end
	if count2 > 0 then
		itemcount2 = self:LuaFnGetAvailableItemCount(selfId, self.g_DWJinJieQianghua_ToolItem2)
		if itemcount2 < count2 then
			self:notify_tips(selfId,"#{DWJJ_240329_66}")
			return
		end
		addexp = addexp + count2 * self.g_LCS2JCS
	end
	addexp = addexp + dw_rankexp
	local needexp = self:GetDiaoWenFineDrawNeedExp(selfId, dw_advance_level, finedrawlv - 1)
	if addexp > needexp then
		local msg = "精绘经验超出当前可提升层级的上限，共需"..tostring(needexp).."经验，避免给您造成损失，请重新设置材料数量升级。"
		self:notify_tips(selfId,msg)
		return
	end
	
	
	if count1 > 0 then
		local delcount = count1
		for i,j in ipairs(itemcount) do
			if j >= delcount then
				self:LuaFnDelAvailableItem(selfId, self.g_DWJinJieQianghua_ToolItem[i], delcount)
				delcount = 0
				break
			elseif j > 0 then
				self:LuaFnDelAvailableItem(selfId, self.g_DWJinJieQianghua_ToolItem[i], j)
				delcount = delcount - j
				if delcount <= 0 then
					break
				end
			end
		end
		if delcount > 0 then
			self:notify_tips(selfId,"del count1 error.")
			return
		end
	end
	if count2 > 0 then
		self:LuaFnDelAvailableItem(selfId, self.g_DWJinJieQianghua_ToolItem2, count2)
	end
	self:AddDiaoWenFineDrawExp(selfId, eqpos, dwlv, dw_advance_level, addexp)
	self:notify_tips(selfId,"#{DWJJ_240329_63}")
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
function diaowen:DoDiaowenJinJieShengJi( selfId,npcid,eqpos,buyflag,boxflag,tarlevel )
	if self:CheckNpcDist( selfId,npcid ) then
		return
	elseif not eqpos or eqpos < 0 then
		return
	elseif not tarlevel or tarlevel < 1 then
		return
	end
	local eqid = self:LuaFnGetItemTableIndexByIndex(selfId,eqpos)
	if eqid == define.INVAILD_ID then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local eqpoint = self:GetItemEquipPoint(eqid)
	if not eqpoint then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local needitem = self.g_EquipPoint2DWJinJie_Tool_ItemID[eqpoint]
	if not needitem then
		self:notify_tips(selfId,"#{DWJJ_240329_42}")
		return
	end
	local dwlv,dw_advance_level,dw_rankexp = self:GetDiaoWenFineDraw(selfId, eqpos)
	if dwlv < 4 then
		self:notify_tips(selfId,"error。")
		return
	end
	local finedrawlv = dwlv * 5
	if dw_advance_level == 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_57}")
		return
	elseif dw_advance_level >= finedrawlv or tarlevel > finedrawlv then
		self:notify_tips(selfId,"#{DWJJ_240329_91}")
		return
	elseif dw_advance_level >= 50 then
		self:notify_tips(selfId,"#{DWJJ_240329_90}")
		return
	end
	local needexp = self:GetDiaoWenFineDrawNeedExp(selfId, dw_advance_level, tarlevel - 1)
	needexp = needexp - dw_rankexp
	if needexp == 0 then
		self:notify_tips(selfId,"error。。")
		return
	end
	local needcount = math.ceil(needexp / self.g_LCS2JCS)
	local havecount = self:LuaFnGetAvailableItemCount(selfId, self.g_DWJinJieQianghua_ToolItem2)
	--未添加元宝购买
	if havecount < needcount then
		self:notify_tips(selfId,"#{DWJJ_240329_66}")
		return
	end
	self:LuaFnDelAvailableItem(selfId, self.g_DWJinJieQianghua_ToolItem2, needcount)
	self:SetDiaoWenFineDrawDetails(selfId, eqpos, tarlevel, 0)
	self:notify_tips(selfId,"#{DWJJ_240329_63}")
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end

function diaowen:DoDiaowenJinJieHuiTui( selfId,npcid,eqpos,boxflag )
	if self:CheckNpcDist( selfId,npcid ) then
		return
	elseif not eqpos or eqpos < 0 then
		return
	end
	local eqid = self:LuaFnGetItemTableIndexByIndex(selfId,eqpos)
	if eqid == define.INVAILD_ID then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local eqpoint = self:GetItemEquipPoint(eqid)
	if not eqpoint then
		self:notify_tips(selfId,"#{DWJJ_240329_29}")
		return
	end
	local needitem = self.g_EquipPoint2DWJinJie_Tool_ItemID[eqpoint]
	if not needitem then
		self:notify_tips(selfId,"#{DWJJ_240329_42}")
		return
	end
	local dwlv,dw_advance_level,dw_rankexp = self:GetDiaoWenFineDraw(selfId, eqpos)
	if dwlv < 4 then
		self:notify_tips(selfId,"#{DWJJ_240329_42}")
		return
	elseif dw_advance_level == 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_42}")
		return
	end
	local spacecount = self:LuaFnGetPropertyBagSpace(selfId)
	if spacecount < 2 then
		self:notify_tips(selfId,"#{DWJJ_240329_113}")
		return
	end
	dw_rankexp = dw_rankexp + self:GetDiaoWenFineDrawNeedExp(selfId, 1, dw_advance_level - 1)
	local backlcs = math.ceil(dw_rankexp / self.g_LCS2JCS)
	local Value = backlcs * self.g_LCS_Yuanbao
	local needyb = math.ceil(Value * 0.4)
	if needyb > self:GetYuanBao(selfId) then
		self:notify_tips(selfId,"#{DWJJ_240329_112}")
		return
	end
	if boxflag == 0 then
		self:BeginUICommand()
		self:UICommand_AddInt(npcid)
		self:UICommand_AddInt(eqpos)
		self:UICommand_AddInt(needyb)
		self:UICommand_AddInt(backlcs)
		self:UICommand_AddInt(Value)
		self:EndUICommand()
		self:DispatchUICommand(selfId,89030513)
		return
	end
	self:EmptyDiaoWenJinJie(selfId,eqpos,needyb,needitem,38000960,backlcs)
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
function diaowen:DoTeXingQiangHua( selfId,npcid,dw_featuresid )
	-- if 0 == 0 then
		-- self:notify_tips(selfId,"正在维护中。")
		-- return
	-- end


	if self:CheckNpcDist( selfId,npcid ) then
		return
	elseif not dw_featuresid or dw_featuresid < 1 then
		self:notify_tips(selfId,"#{DWJJ_240329_180}")
		return
	end
	local level,nexp = self:LuaFnGetFeaturesDetails(selfId,dw_featuresid)
	if not level then
		level,nexp = 0,0
	end
	local needexp,_,_,needitem = self:GetDiaoWenJinJieFeaturesDetails(dw_featuresid,level)
	if needexp == 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_188}")
		return
	elseif needexp < 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_180}")
		return
	elseif needexp <= nexp then
		self:notify_tips(selfId,"#{DWJJ_240329_182}")
		return
	end
	local havecount = self:LuaFnGetAvailableItemCount(selfId,needitem)
	if havecount < 1 then
		local msg = self:ScriptGlobal_Format("#{DWJJ_240329_183}",self:GetItemName(needitem))
		self:notify_tips(selfId,msg)
		return
	end
	self:LuaFnDelAvailableItem(selfId, needitem, 1)
	nexp = nexp + 1
	self:LuaFnSetFeaturesDetails(selfId,dw_featuresid,level,nexp)
	self:notify_tips(selfId,"#{DWJJ_240329_184}")
	self:BeginUICommand()
	self:UICommand_AddInt(2)
	self:EndUICommand()
	self:DispatchUICommand(selfId,89030506)
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
function diaowen:DoTeXingShengJi( selfId,npcid,dw_featuresid )
	-- if 0 == 0 then
		-- self:notify_tips(selfId,"正在维护中。")
		-- return
	-- end
	if self:CheckNpcDist( selfId,npcid ) then
		return
	elseif not dw_featuresid or dw_featuresid < 1 then
		self:notify_tips(selfId,"#{DWJJ_240329_180}")
		return
	end
	local level,nexp = self:LuaFnGetFeaturesDetails(selfId,dw_featuresid)
	if not level then
		self:notify_tips(selfId,"#{DWJJ_240329_189}")
		return
	end
	local needexp,needmoney,needcount = self:GetDiaoWenJinJieFeaturesDetails(dw_featuresid,level)
	if needexp == 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_188}")
		return
	elseif needexp < 0 then
		self:notify_tips(selfId,"#{DWJJ_240329_180}")
		return
	elseif needexp > nexp then
		self:notify_tips(selfId,"#{DWJJ_240329_189}")
		return
	end
	if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < needmoney then
		self:notify_tips(selfId,"#{HSWQ_20220607_38}")
		return
	end
	if needcount > 0 then
		local havecount = self:LuaFnGetAvailableItemCount(selfId,20310175)
		if havecount < needcount then
			self:notify_tips(selfId,"#{DWJJ_240329_190}")
			return
		end
		self:LuaFnDelAvailableItem(selfId, 20310175, needcount)
	end
	self:LuaFnCostMoneyWithPriority(selfId, needmoney)
	level = level + 1
	nexp = 0
	self:LuaFnSetFeaturesDetails(selfId,dw_featuresid,level,nexp)
	self:notify_tips(selfId,"#{DWJJ_240329_191}")
	self:BeginUICommand()
	self:UICommand_AddInt(2)
	self:EndUICommand()
	self:DispatchUICommand(selfId,89030506)
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
function diaowen:DoDiaowenJinJieTeXingGengHuan( selfId,npcid,eqpoint,dw_featureId,useflag )
	-- if 0 == 0 then
		-- self:notify_tips(selfId,"正在维护中。")
		-- return
	-- end
	if self:CheckNpcDist( selfId,npcid ) then
		return
	elseif not eqpoint or not self.g_EquipPoint2DWJinJie_Tool_ItemID[eqpoint] then
		return
	elseif not dw_featureId or dw_featureId < 1 then
		return
	end
	--更换或卸下时还有些相关BUFF在角色身上时不给卸下且给提示  备忘
	if useflag == 0 then
		if self:UnDiaoWenFeatures(selfId,eqpoint) then
			self:notify_tips(selfId,"#{DWJJ_240329_200}")
		end
	else
	local dwlv,dw_advance_level = self:GetDiaoWenFineDraw(selfId, eqpoint,eqpoint)
		if dwlv < 4 then
			self:notify_tips(selfId,"该装备尚未进行精绘。")
			return
		elseif dw_advance_level < 1 then
			self:notify_tips(selfId,"该装备尚未进行精绘。")
			return
		end
		if dw_featureId == 15 then
			if dw_advance_level < 5 then
				self:notify_tips(selfId,"骛远效果需要装备精绘等级达到1级0等及以上方可更换。")
				return
			end
			local feature_lv = self:LuaFnGetFeaturesDetails(selfId,dw_featureId)
			if not feature_lv or feature_lv < 1 then
				self:notify_tips(selfId,"骛远效果需要1级及以上方可更换。")
				return
			end
		end
		local haveid = self:LuaFnGetFeaturesDetails(selfId,dw_featureId)
		if not haveid then
			self:notify_tips(selfId,"#{DWJJ_240329_201}")
			return
		end
		self:UseDiaoWenFeatures(selfId,eqpoint,dw_featureId)
	end
	-- self:BeginUICommand()
	-- self:UICommand_AddInt(dw_featureId)
	-- self:EndUICommand()
	-- self:DispatchUICommand(selfId,89030505)
end


function diaowen:DoDiaowenAction(selfId, DataType, ...)
    if self:GetLevel(selfId) < 52 then
		self:notify_tips(selfId, "你的江湖历练不够啊，请到52级以后再来找我吧！")
	    return
	end
	
	if DataType == 1 then
		self:DWShike(selfId, ...)
		return
	end
	if DataType == 2 then --雕纹强化
		self:DWQiangHua(selfId,...)
		return
	end
	if DataType == 3 then --雕纹拆除
		self:DWChaiChu(selfId,...)
		return
	end
    if DataType == 4 then
		self:DWHecheng(selfId, ...)
		return
	end
	if DataType == 5 then --雕纹融合
		self:DWRongHe(selfId,...)
		return
	end
	if DataType == 99 then --直接升级雕纹
		self:DWLeveUp(selfId,...)
		return
	end
	if DataType == 100 then --直接升级雕纹
		self:DWDivert(selfId,...)
		return
	end
	if DataType == 101 then --购买熔金粉提示【直接买】
		self:BuyItem_OK(selfId,0)
		return
	end
	if DataType == 102 then --购买熔金粉提示
		self:BuyItem_OK(selfId,1)
	end
	if DataType == 103 then --雕纹拆解用
		self:DWChaiJie(selfId, ...)
		return
	end
end

--**********************************
--雕纹蚀刻
--**********************************
function diaowen:DWShike(selfId, arg1,arg2,arg3)
	local EquipPoint = self:LuaFnGetBagEquipType(selfId, arg1 )
	local nMaterial = self:LuaFnGetItemTableIndexByIndex(selfId, arg2 )
	local nDiaoWen =  self:LuaFnGetItemTableIndexByIndex(selfId, arg3 )
    local dw_config = self:GetDiaoWenInfoByProduct(nDiaoWen)
    local dw_rules = self:GetDiaoWenRuleByProduct(dw_config.rule)
    local shike_materials = { 30503149 }
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(shike_materials) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
	if allnum < 1 then
		self:notify_tips(selfId, "#{ZBDW_091105_8}")
		return
	end
	--开始检测雕纹类型和装备的对应关系
	if nDiaoWen == nil then
		self:notify_tips(selfId, "#{ZBDW_091105_10}")--请放入雕纹。
		return
	end
    local rule = dw_rules[EquipPoint] or 0
    if rule == 0 then
        self:notify_tips(selfId, "#{ZBDW_091105_23}")
        return
    end
	if not self:LuaFnMtl_CostMaterial(selfId, 1, costtab) then
        self:notify_tips(selfId, "雕纹蚀刻溶剂不足")
		return
	end
    self:DiaoWenShiKe(selfId, arg1, nDiaoWen)
	if self:LuaFnGetItemBindStatus(selfId,arg1) or self:LuaFnGetItemBindStatus(selfId,arg3) then
		self:LuaFnItemBind(selfId,arg1)
	end
	self:LuaFnDelAvailableItem(selfId,nDiaoWen,1)--扣除雕纹
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 149, 0)
    self:notify_tips(selfId, "恭喜你，蚀刻成功！" )
end
--**********************************
--雕纹合成
--**********************************
local g_needMoeny = 50000
function diaowen:DWHecheng(selfId, itemPos )
	local itemTableIndex = self:LuaFnGetItemTableIndexByIndex(selfId, itemPos)
    local dw_config = self:GetDiaoWenInfoByTupu(itemTableIndex)
		local costtab = {}
	if dw_config.danqing_count ~= -1 then
		local itemcount
		local allnum = 0
		for i,j in ipairs(dw_config.danqing_material) do
			itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
			if itemcount > 0 then
				allnum = allnum + itemcount
				table.insert(costtab,j)
			end
		end
		if allnum < dw_config.danqing_material_count then
			self:notify_tips(selfId, "丹青不足，请检查背包中未加锁的丹青是否足够！" )
			return
		end
		-- if self:LuaFnMtl_GetCostNum(selfId, dw_config.danqing_material) < dw_config.danqing_material_count then
			-- self:notify_tips(selfId, "丹青不足，请检查背包中未加锁的丹青是否足够！" )
			-- return
		-- end
	end
	if dw_config.huangzhi_count ~= -1 then
		if self:LuaFnGetAvailableItemCount(selfId, dw_config.huangzhi_material) < dw_config.huangzhi_material_count then
			self:notify_tips(selfId, "黄纸不足，请检查背包中未加锁的黄纸是否足够！" )
			return
		end
	end
	if not self:LuaFnCostMoneyWithPriority(selfId, g_needMoeny) then
		self:notify_tips(selfId, "#{ResultText_154}" )
		return
	end
	if not self:LuaFnMtl_CostMaterial(selfId, dw_config.danqing_material_count, costtab) then
        self:notify_tips(selfId, "丹青不足，请检查背包中未加锁的丹青是否足够")
		return
	end
	if not self:LuaFnDelAvailableItem(selfId, dw_config.huangzhi_material, dw_config.huangzhi_material_count) then
        self:notify_tips(selfId, "所需黄纸不足20个。")
	   return
	end
	self:LuaFnEraseItem(selfId, itemPos)
	self:TryRecieveItem(selfId, dw_config.product, 1)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 148, 0)
	self:notify_tips(selfId, "恭喜你，成功合成了一个".. self:GetItemName(dw_config.product) )
end

--**********************************
--雕纹强化
--**********************************
function diaowen:DWQiangHua(selfId,nPos,Num)
    local cost_materials_id = { 20310166, 20310167, 20310168 }
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(cost_materials_id) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
    -- local HaveJSC = self:LuaFnMtl_GetCostNum(selfId, cost_materials_id)
	local HaveJSC = allnum
	local yuanbao_pay_count = 0
	local true_cost_material_count = Num
	if Num > HaveJSC then
		yuanbao_pay_count = (Num - HaveJSC) * 160
		true_cost_material_count = HaveJSC
	end
	if yuanbao_pay_count > 0 then
		local yuanbao = self:GetYuanBao(selfId)
		local bind_yuanbao = self:GetBindYuanBao(selfId)
		if yuanbao + bind_yuanbao < yuanbao_pay_count then
			self:notify_tips(selfId, "元宝不足")
			return
		end
		if yuanbao_pay_count <= bind_yuanbao then
			self:LuaFnCostBindYuanBao(selfId, yuanbao_pay_count)
		else
			if bind_yuanbao > 0 then
				self:LuaFnCostBindYuanBao(selfId, bind_yuanbao)
			end
			local left = yuanbao_pay_count - bind_yuanbao
			self:LuaFnCostYuanBao(selfId, left)
		end
	end
	if true_cost_material_count > 0 then
		local del = self:LuaFnMtl_CostMaterial(selfId, true_cost_material_count, costtab)
		if not del then
			self:notify_tips(selfId, "金蚕丝扣除失败")
			return
		end
	end
	local diaowen_id, diaowen_material_count = self:GetEquipDiaoWenData(selfId, nPos)
	diaowen_material_count = diaowen_material_count + Num

    local dw_config = self:GetDiaoWenInfoByIndex(diaowen_id)
    local ori_level = dw_config.level
    while diaowen_material_count >= dw_config.enhance_material_count do
        if dw_config.level == 10 then
            diaowen_material_count = 0
            break
        end
        diaowen_id = diaowen_id + 1
        diaowen_material_count = diaowen_material_count - dw_config.enhance_material_count
        dw_config = self:GetDiaoWenInfoByIndex(diaowen_id)
    end
    if true then
        self:LuaFnItemBind(selfId, nPos)
    end
    self:SetEquipDiaoWenData(selfId, nPos, diaowen_id, diaowen_material_count)
    self:notify_tips( selfId, "恭喜您，雕纹强化成功")
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 149, 0)
	local szItemTransfer = self:GetItemName(self:LuaFnGetItemTableIndexByIndex(selfId, nPos))
	if ori_level ~= dw_config.level and dw_config.level > 3 then
        local format = gbk.fromutf8("#H#{_INFOUSR%s}在#G洛阳#{_INFOAIM152,101,0,张降龙}#Y张降龙#H处，成功使用#G雕纹升级#H功能将蚀刻在#Y%s#H上的#Y%s#H升级到了#G%s级#H。")
	    local nGlobalMsg = string.format(format,
                    gbk.fromutf8(self:GetName(selfId)),
					gbk.fromutf8(szItemTransfer),
					ori_level,
					dw_config.level)
        self:BroadMsgByChatPipe(selfId, nGlobalMsg, 4)
	end
	return
end

function diaowen:DoEquipDWLevelUp(selfId, BagPos, targetLevel, check)
    local diaowen_id, diaowen_material_count = self:GetEquipDiaoWenData(selfId, BagPos)
    local dw_config = self:GetDiaoWenInfoByIndex(diaowen_id)
    local all = 0
    while dw_config.level < targetLevel do
        if dw_config.level == 10 then
            break
        end
        diaowen_id = diaowen_id + 1
        all = all + dw_config.enhance_material_count
        dw_config = self:GetDiaoWenInfoByIndex(diaowen_id)
    end
    local need = all - diaowen_material_count
    self:DWQiangHua(selfId, BagPos, need)
end

--**********************************
--雕纹拆除
--**********************************
function diaowen:DWChaiChu(selfId,nPos_1,nPos_2)
	if self:LuaFnGetPropertyBagSpace(selfId) < 2  then
		self:notify_tips(selfId,"#{SSXDW_140819_58}" ) --H背包道具栏空位不足，请至少留出两个空位。
		return
	end
	local nMaterial = self:LuaFnGetItemTableIndexByIndex(selfId, nPos_2 )
	if nMaterial ~= 30503150 and nMaterial ~= 30121002 then
		self:notify_tips(selfId, "#{ZBDW_091105_20}") --必须放入熔金粉
		return
	end
	if self:LuaFnIsItemLocked(selfId, nPos_2) then
		self:notify_tips(selfId, "#{SSXDW_140819_42}")--该物品已经加锁，不可进行该操作
		return
	end
    local diaowen_id, diaowen_enhance_material_count = self:GetEquipDiaoWenData(selfId, nPos_1)
	if diaowen_id == 0 then
		self:notify_tips(selfId, "没有雕纹可以摘除" )
		return
	end
	if not self:LuaFnCostMoneyWithPriority(selfId, g_needMoeny) then
		self:notify_tips(selfId, "#{ResultText_154}" )
		return
	end
    local dw_config = self:GetDiaoWenInfoByIndex(diaowen_id)
    local product = dw_config.product
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 149, 0)
	self:LuaFnDelAvailableItem(selfId,nMaterial,1)
    self:SetEquipDiaoWenData(selfId, nPos_1, 0, 0)
    self:TryRecieveItem(selfId, product,true)
	 if diaowen_enhance_material_count > 0 then --金蚕丝也要拆除下来的
	   self:BeginAddItem()
	   self:AddItem(20310166, diaowen_enhance_material_count,true)
	   self:EndAddItem(selfId)
	   self:AddItemListToHuman(selfId)
	 end
     self:notify_tips( selfId, "#{SSXDW_140819_56}" )
     local format = gbk.fromutf8("#{_INFOUSR%s}#H拿着%s端详良久，终于将#Y熔金粉#H缓缓洒下，一阵光华闪动，只见一个#Y雕纹融合符#H和#Y%s#H完好无损的呈现在眼前。")
     local nGlobalMsg = string.format(format, gbk.fromutf8(self:GetName(selfId)), gbk.fromutf8(self:GetItemName(self:LuaFnGetItemTableIndexByIndex(selfId, nPos_1 ))), gbk.fromutf8(self:GetItemName(product)))
     self:BroadMsgByChatPipe(selfId, nGlobalMsg, 4)
end

--拆解信息
local g_DWChaiJieInfo={
	[2]={kangxing={28,2},jiankang={84,6},normal={28,2}},
	[3]={kangxing={154,11},jiankang={462,33},normal={154,11}},
	[4]={kangxing={854,61},jiankang={2562,183},normal={854,61}},
	[5]={kangxing={2072,148},jiankang={6216,444},normal={2072,148}},
	[6]={kangxing={4382,313},jiankang={13146,939},normal={4382,313}},
	[7]={kangxing={8358,597},jiankang={25074,1791},normal={8358,597}},
	[8]={kangxing={19712,1408},jiankang={59136,4224},normal={19712,1408}},
	[9]={kangxing={48944,3496},jiankang={146832,10488},normal={48944,3496}},
	[10]={kangxing={87164,6226},jiankang={261492,18678},normal={98924,7066}},
}
function diaowen:DoDiaoWenChaiJie(selfId,bag_pos)
	local diaowen_id = self:LuaFnGetItemTableIndexByIndex(selfId,bag_pos)
	if diaowen_id == -1 then
		self:notify_tips(selfId, "#{DWCJJ_140606_13}" )
		return
	end
    local dw_config = self:GetDiaoWenInfoByProduct(diaowen_id)
	if not dw_config then
		self:notify_tips(selfId, "#{DWCJJ_140606_13}" )
		return
	end
    local ori_level = dw_config.level
	local cj_info = g_DWChaiJieInfo[ori_level]
	if not cj_info then
		self:notify_tips(selfId, "#{DWCJJ_140606_11}" )
		return
	end
	local need_yb,back_jcs
	local ntype = dw_config.dw_type
	if ntype == 1 then
		need_yb = cj_info.normal[1]
		back_jcs = cj_info.normal[2]
	elseif ntype == 2 then
		need_yb = cj_info.jiankang[1]
		back_jcs = cj_info.jiankang[2]
	elseif ntype == 3 then
		need_yb = cj_info.kangxing[1]
		back_jcs = cj_info.kangxing[2]
	else
		self:notify_tips(selfId, "配表中没有该雕纹数据" )
		return
	end
	if self:GetYuanBao(selfId) < need_yb then
		self:notify_tips(selfId, "#{DWCJJ_140606_15}" )
		return
	end
	self:EraseItem(selfId,bag_pos)
	self:LuaFnCostYuanBao(selfId, need_yb)
	self:LuaFnAddJCSJ(selfId,38000959,back_jcs)
	local item_name = self:GetItemName(diaowen_id)
	local msg = self:ScriptGlobal_Format("#{DWCJJ_140606_18}",1,item_name)
	self:notify_tips(selfId, msg)
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
function diaowen:CheckDiaoWenChaiJie(selfId,bag_pos)
	local diaowen_id = self:LuaFnGetItemTableIndexByIndex(selfId,bag_pos)
	if diaowen_id == -1 then
		self:notify_tips(selfId, "#{DWCJJ_140606_13}" )
		return
	end
    local dw_config = self:GetDiaoWenInfoByProduct(diaowen_id)
	if not dw_config then
		self:notify_tips(selfId, "#{DWCJJ_140606_13}" )
		return
	end
    local ori_level = dw_config.level
	local cj_info = g_DWChaiJieInfo[ori_level]
	if not cj_info then
		self:notify_tips(selfId, "#{DWCJJ_140606_11}" )
		return
	end
	local need_yb,back_jcs
	local ntype = dw_config.dw_type
	if ntype == 1 then
		need_yb = cj_info.normal[1]
		back_jcs = cj_info.normal[2]
	elseif ntype == 2 then
		need_yb = cj_info.jiankang[1]
		back_jcs = cj_info.jiankang[2]
	elseif ntype == 3 then
		need_yb = cj_info.kangxing[1]
		back_jcs = cj_info.kangxing[2]
	else
		self:notify_tips(selfId, "配表中没有该雕纹数据" )
		return
	end
	self:BeginUICommand()
	self:UICommand_AddInt(bag_pos)
	self:UICommand_AddInt(need_yb)
	self:UICommand_AddInt(back_jcs)
	self:EndUICommand()
	self:DispatchUICommand(selfId, 8092720)
end

--雕纹转移
function diaowen:DoDiaowenDivert(selfId,src_pos,dsc_pos,vip_flag)
	if src_pos == dsc_pos then
		return
	end
	local src_index = self:GetItemEquipID(selfId,src_pos)
	local dsc_index = self:GetItemEquipID(selfId,dsc_pos)
	if src_index == -1 then
		self:notify_tips(selfId, "#{DWZY_141216_29}" )
		return
	elseif dsc_index == -1 then
		self:notify_tips(selfId, "#{DWZY_141216_33}" )
		return
	elseif self:GetItemEquipPoint(src_index) ~= self:GetItemEquipPoint(dsc_index) then
		self:notify_tips(selfId, "#{DWZY_141216_24}" )
		return
	elseif self:GeEquipReqLevel(src_index) < 50 then
		self:notify_tips(selfId, "#{DWZY_141216_21}" )
		return
	elseif self:GeEquipReqLevel(dsc_index) < 50 then
		self:notify_tips(selfId, "#{DWZY_141216_37}" )
		return
	elseif not self:CheckMoney(selfId,100000) then
		return
	end
    local src_dw = self:GetEquipDiaoWenData(selfId, src_pos)
	if src_dw == 0 then
		self:notify_tips(selfId, "#{DWZY_141216_31}" )
		return
	end
    local dsc_dw = self:GetEquipDiaoWenData(selfId, dsc_pos)
	if dsc_dw ~= 0 then
		self:notify_tips(selfId, "#{DWZY_141216_35}" )
		return
	end
	self:LuaFnCostMoneyWithPriority(selfId,100000)
	self:LuaFnItemBind(selfId,dsc_pos)
	self:DiaowenDivert(selfId,src_pos,dsc_pos)
	self:notify_tips(selfId, "#{DWZY_141216_41}" )
	self:ShowObjBuffEffect(selfId,selfId,-1,18)
end
return diaowen