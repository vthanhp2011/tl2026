-- 宠物幻化
local gbk = require "gbk"
local class = require "class"
local script_base = require "script_base"
local pet_holy = class("pet_holy", script_base)
local g_m_money = { 10000 , 12000 , 14400 ,17280 , 20736,  24883 , 29860 , 35832 ,42998 , 51598}
local g_PetJingHun = {20310116,20310160,20310175}
-- 灵性等级对应元宝
local m_YuanBaoCosts = {
	[0] = 179280,
	[1] = 178560,
	[2] = 177120,
	[3] = 175320,
	[4] = 171720,
	[5] = 165600,
	[6] = 156240,
	[7] = 47120,
	[8] = 116040,
	[9] = 77760,
}
function pet_holy:Pet_HH(selfId, mainPetGuidH, mainPetGuidL, keep_model)
    local huan_huad = self:GetPetHaveHuanHua(selfId, mainPetGuidH, mainPetGuidL)
    if huan_huad then
        return
    end
    --检查携带等级
    local data_id = self:GetPetDataID(selfId, mainPetGuidH, mainPetGuidL)
    local takeLevel = self:GetPetTakeLevel(data_id)
	if takeLevel < 85 and keep_model == 0 then
        return
	end
    local item_index = 30502005
    if self:LuaFnGetAvailableItemCount(selfId, 30502005) < 1 then
        item_index = 30502006
        if self:LuaFnGetAvailableItemCount(selfId, 30502006) < 1 then
            self:notify_tips(selfId, "您身上缺少幻化材料：珍兽幻化丹。")
            return
        end
    end
    local pet_type = self:GetPetType(selfId, mainPetGuidH, mainPetGuidL)
    if pet_type == 2 then
        self:notify_tips(selfId, "#{RXZS_090804_4}")
        return
    end
    local nSavvy = self:GetPetSavvy(selfId,mainPetGuidH,mainPetGuidL)
    if nSavvy < 5 then
        self:notify_tips(selfId, "#{RXZS_090804_4}")
        return
    end
    local data_id = self:GetPetDataID(selfId,mainPetGuidH,mainPetGuidL)
    if data_id == nil then
        return
    end
    local model_1, model_2, cost = self:GetPetHuanHuaData(data_id)
    local nMoneySelf = self:GetMoney(selfId) + self:GetMoneyJZ(selfId)
	if nMoneySelf < cost then
        self:notify_tips(selfId,  "#{BSZK_121012_39}" )
        return
	end
    local costRet = self:LuaFnCostMoneyWithPriority(selfId, cost)
	if not costRet then
		return
	end
    local del = self:LuaFnDelAvailableItem(selfId, item_index, 1)
    if not del then
        return
    end
    local huanhua_model = model_1
    if keep_model == 0 then
        huanhua_model = model_2
    end
    self:PetHuanHua(selfId, mainPetGuidH, mainPetGuidL, huanhua_model)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
end

function pet_holy:Pet_LXUP(selfId, mainPetGuidH, mainPetGuid)
    local have = self:GetPetHaveHuanHua(selfId, mainPetGuidH, mainPetGuid)
    if not have then
		self:notify_tips(selfId, "你选择的珍兽还未幻化，只有幻化后的珍兽才能提升灵性。" )
		return
	end
    local lingxing = self:GetPetLingXing(selfId, mainPetGuidH, mainPetGuid)
    if lingxing >= 10 then
		self:notify_tips(selfId, "你选择的珍兽灵性等级已经达到最高，不能再次提升灵性。" )
		return
	end
    local need_money = g_m_money[lingxing + 1]
    if need_money == nil then
        need_money = g_m_money[10]
    end
    local nMoneySelf = self:GetMoney(selfId) + self:GetMoneyJZ(selfId)
	if nMoneySelf < need_money then
        self:notify_tips(selfId,  "#{WH_090729_18}" )
        return
	end
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(g_PetJingHun) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
	
	
    if allnum < 1 then
        self:notify_tips(selfId, "您身上缺少灵兽精魄。")
        return
    end
    -- if self:LuaFnMtl_GetCostNum(selfId, g_PetJingHun) < 1 then
        -- self:notify_tips(selfId, "您身上缺少灵兽精魄。")
        -- return
    -- end
    local costRet = self:LuaFnCostMoneyWithPriority(selfId, need_money)
    if not costRet then
		return
	end
    local del = self:LuaFnMtl_CostMaterial(selfId, 1, costtab)
    if not del then
        self:notify_tips(selfId, "您身上缺少灵兽精魄。")
        return
    end
    local nSuccessRate = {100,60,36,20,12,8,5,3,2,1}
    lingxing = lingxing + 1
	local nNowRate = nSuccessRate[lingxing]
	local nRand = math.random(100)
	if nRand > nNowRate then
		self:notify_tips( selfId,  "#{RXZS_090804_17}" )
        return
	end
    self:SetPetLingXing(selfId, mainPetGuidH, mainPetGuid, lingxing)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    self:notify_tips(selfId,  "#{RXZS_090804_18}".. lingxing .."#{RXZS_090804_19}")
    if lingxing > 2 then
		local PetName = self:LuaFnGetPetTransferByGUID(selfId, mainPetGuidH, mainPetGuid )
        local item_name = gbk.fromutf8(self:GetItemName(g_PetJingHun[1]))
		local nMsg = string.format("#{_INFOMSG%s}",PetName).."#{RC_14}#G".. item_name .."#{RC_15}".. lingxing .."#{RC_16}"
		self:AddGlobalCountNews(nMsg, true)
    end
end

function pet_holy:Quick_Pet_LXUP(selfId, mainPetGuidH, mainPetGuid)
    local have = self:GetPetHaveHuanHua(selfId, mainPetGuidH, mainPetGuid)
    if not have then
		self:notify_tips(selfId, "你选择的珍兽还未幻化，只有幻化后的珍兽才能提升灵性。" )
		return
	end
    local lingxing = self:GetPetLingXing(selfId, mainPetGuidH, mainPetGuid)
    if lingxing >= 10 then
		self:notify_tips(selfId, "你选择的珍兽灵性等级已经达到最高，不能再次提升灵性。" )
		return
	end
    local cost = m_YuanBaoCosts[lingxing]
    local my_yuanbao = self:GetYuanBao(selfId)
    if my_yuanbao < cost then
		self:notify_tips(selfId, "元宝不足" )
		return
    end
    self:LuaFnCostYuanBao(selfId, cost)
    lingxing = 10
    self:SetPetLingXing(selfId, mainPetGuidH, mainPetGuid, lingxing)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    self:notify_tips(selfId,  "#{RXZS_090804_18}".. lingxing .."#{RXZS_090804_19}")
end

function pet_holy:PetLingxing_Yuanbao_Pay(selfId, ItemIndex, check)
    local hint = "#{ZSYB_151109_14"
	local index, merchadise = self:GetMerchadiseByItemIndex(selfId, ItemIndex)
	if index == nil then
		return
	end
    local item_name = self:GetItemName(merchadise.id)
	self:BeginUICommand()
	self:UICommand_AddInt(check)
    self:UICommand_AddInt(10)
	self:UICommand_AddInt(5)
	self:UICommand_AddInt(merchadise.price)
	self:UICommand_AddInt(index - 1)
    self:UICommand_AddInt(0)
	self:UICommand_AddInt(131071)
	local str = self:ContactArgs(hint, item_name, merchadise.price, item_name) .. "}"
	self:UICommand_AddStr(str)
	self:EndUICommand()
	self:DispatchUICommand(selfId, 2015101514)
end

return pet_holy