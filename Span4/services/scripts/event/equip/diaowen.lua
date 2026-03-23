--雕纹
--脚本号
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local diaowen = class("diaowen", script_base)

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
	if self:LuaFnMtl_GetCostNum(selfId, shike_materials) < 1 then
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
	if not self:LuaFnMtl_CostMaterial(selfId, 1, shike_materials) then
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
	if dw_config.danqing_count ~= -1 then
		if self:LuaFnMtl_GetCostNum(selfId, dw_config.danqing_material) < dw_config.danqing_material_count then
			self:notify_tips(selfId, "丹青不足，请检查背包中未加锁的丹青是否足够！" )
			return
		end
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
	if not self:LuaFnMtl_CostMaterial(selfId, dw_config.danqing_material_count, dw_config.danqing_material) then
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
    local HaveJSC = self:LuaFnMtl_GetCostNum(selfId, cost_materials_id)
	local yuanbao_pay_count = 0
	local true_cost_material_count = Num
	if Num > HaveJSC then
		yuanbao_pay_count = (Num - HaveJSC) * 85
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
			self:LuaFnCostBindYuanBao(selfId, bind_yuanbao)
			local left = yuanbao_pay_count - bind_yuanbao
			self:LuaFnCostYuanBao(selfId, left)
		end
	end
	self:LuaFnMtl_CostMaterial(selfId, true_cost_material_count, cost_materials_id)
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

return diaowen