--珍兽繁殖
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local PetProcreateRegister = class("PetProcreateRegister", script_base)

function PetProcreateRegister:OnDefaultEvent(selfId, targetId)
	local checkRet = self:LuaFnCheckCallPetProcreateRegisterUI(selfId, targetId)
	if checkRet then
		local ret = self:LuaFnCallPetProcreateRegisterUI(selfId, targetId, 26)
		if ret then
			self:Msg2Player(selfId, "执行成功", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
		else
			self:Msg2Player(selfId, "执行失败",  define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
		end
	end
end

function PetProcreateRegister:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, "珍兽繁殖", 6, self.script_id)
end

local PetLoveNestItemIndex = 30309794
local g_rate = {}
g_rate[1] = {1000}
g_rate[2] = {300,1000}
g_rate[3] = {200,600,1000}
g_rate[4] = {100,300,600,1000}
g_rate[5] = {50,100,300,600,1000}
g_rate[6] = {100,200,300,400,500,1000}
g_rate[7] = {100,200,300,400,500,600,1000}
g_rate[8] = {100,200,300,400,500,600,700,1000}

--指定珍兽繁殖概率  
--[珍兽宝宝的ID] = {
-- rate = {多少变异的概率,随机总概率为1000},

-- str_perception -- 力量资质
-- spr_perception -- 灵气资质
-- con_perception -- 体力资质
-- int_perception -- 定力资质
-- dex_perception -- 身法资质

-- str_perception = {n_min = 2200,n_max = 2800}}

-- 虬龙出顶变概率变大  顶变灵气资质在2000-2300  其他资质照常
-- 老鼠出顶变概率变大  顶变力量资质在2200-2800  其他资质照常

-- 鸟人出顶变概率变大  顶变灵气资质在2200-2800  其他资质照常

-- 麒麟出顶变概率变大  顶变灵气资质在2200-2800  其他资质照常

-- 当扈出顶变概率变大  顶变灵气资质在2200-2800  其他资质照常

-- 穷奇出顶变概率变大  顶变力量资质在2200-2800  其他资质照常
local pet_special_procreate = {
	[22209]		= {rate = {100,200,300,400,500,1000},spr_perception = {n_min = 2200,n_max = 2300}},-- 虬龙
	[6619]		= {rate = {100,200,300,400,500,1000},str_perception = {n_min = 2200,n_max = 2800}},
	[6639]		= {rate = {100,200,300,400,500,1000},spr_perception = {n_min = 2200,n_max = 2800}},
	[22489]		= {rate = {50,100,150,200,300,400,500,1000},spr_perception = {n_min = 2200,n_max = 2800}},-- 麒麟
	[8339]		= {rate = {50,100,150,200,300,400,500,1000},spr_perception = {n_min = 2200,n_max = 2800}},-- 当扈
	[22059]		= {rate = {50,100,200,300,400,500,1000},str_perception = {n_min = 2200,n_max = 2800}},-- 穷奇
	[22069]		= {rate = {50,100,150,200,300,400,500,1000},str_perception = {n_min = 2200,n_max = 2800}},-- 穷奇

}


function PetProcreateRegister:OnSignalPetProcreateRegister(selfId,  targetId, mainPetGuidH, mainPetGuidL, assisPetGuidH, assisPetGuidL, LoveNestPos)
	print("PetProcreateRegister:OnSignalPetProcreateRegister", selfId, targetId, mainPetGuidH, mainPetGuidL, assisPetGuidH, assisPetGuidL, LoveNestPos)
	local LoveNestIndex = self:GetBagItemIndex(selfId, LoveNestPos)
	if LoveNestIndex ~= PetLoveNestItemIndex then
		self:notify_tips(selfId, "请放入爱心小窝")
		return
	end
	local ret1, SpouseGUID_1 = self:GetPetSpouseGUID(selfId, mainPetGuidH, mainPetGuidL)
	local ret2, SpouseGUID_2 = self:GetPetSpouseGUID(selfId, assisPetGuidH, assisPetGuidL)
	if not ret1 or not ret2 then
		self:notify_tips(selfId, "珍兽获取失败")
		return
	end
	local space_count = self:LuaFnGetPetContainerSpaceCount(selfId)
	if space_count < 2 then
		self:notify_tips(selfId, "珍兽栏空间不足，无法繁殖" )
		return
	end
	if not ((SpouseGUID_1:is_null() and SpouseGUID_2:is_null() )
		or ( SpouseGUID_1 == { m_uHighSection = assisPetGuidH , m_uLowSection = assisPetGuidL} and SpouseGUID_2 == { m_uHighSection = mainPetGuidH, m_uLowSection = mainPetGuidL} )) then
		self:notify_tips(selfId, "提交的珍兽不互为配偶")
		return
	end
	local PlayerMoney = self:GetMoney(selfId ) +  self:GetMoneyJZ(selfId)
	if PlayerMoney < 20000 then
		self:notify_tips(selfId, "您身上的交子或金币数量不足")
		return
	end
	local num_1 = self:GetPetNumOfReproductions(selfId, mainPetGuidH, mainPetGuidL)
	if num_1 <= 0 then
		self:notify_tips(selfId, "可繁殖次数不足")
		return
	end
	local num_2 = self:GetPetNumOfReproductions(selfId, assisPetGuidH, assisPetGuidL)
	if num_2 <= 0 then
		self:notify_tips(selfId, "可繁殖次数不足")
		return
	end
	local huanhua_1 = self:GetPetHaveHuanHua(selfId, mainPetGuidH, mainPetGuidL)
	if huanhua_1 then
		self:notify_tips(selfId, "幻化的珍兽，不能繁殖")
		return
	end
	local huanhua_2 = self:GetPetHaveHuanHua(selfId, assisPetGuidH, assisPetGuidL)
	if huanhua_2 then
		self:notify_tips(selfId, "幻化的珍兽，不能繁殖")
		return
	end
	local by_type_1 = self:GetPetByType(selfId, mainPetGuidH, mainPetGuidL)
	local data_id_1 = self:GetPetDataID(selfId, mainPetGuidH, mainPetGuidL)
	if by_type_1 ~= define.PET_TYPE.PET_TYPE_BABY or data_id_1 % 10 ~= 9 then
		self:notify_tips(selfId, "珍兽不是珍兽宝宝，只有珍兽宝宝才可以繁殖")
		return
	end
	local by_type_2 = self:GetPetByType(selfId, assisPetGuidH, assisPetGuidL)
	local data_id_2 = self:GetPetDataID(selfId, assisPetGuidH, assisPetGuidL)
	if by_type_2 ~= define.PET_TYPE.PET_TYPE_BABY or data_id_2 % 10 ~= 9 then
		self:notify_tips(selfId, "珍兽不是珍兽宝宝，只有珍兽宝宝才可以繁殖")
		return
	end
	local sex_1 = self:GetPetSex(selfId, mainPetGuidH, mainPetGuidL)
	local sex_2 = self:GetPetSex(selfId, assisPetGuidH, assisPetGuidL)
	if sex_1 == sex_2 then
		self:notify_tips(selfId, "繁殖的两只珍兽必须互为异性")
		return
	end
	if not self:LuaFnDelAvailableItem(selfId, PetLoveNestItemIndex, 1) then
		self:notify_tips(selfId, "你没有爱心小窝" )
		return
	end
	local variances,data_index = self:GetPetVariances(selfId, mainPetGuidH, mainPetGuidL)
	if #variances == 0 or not data_index then
		self:notify_tips(selfId, "该珍兽不能繁殖" )
		return
	end
	local growth_rate_1 = self:LuaFnGetPeGrowthRate(selfId, mainPetGuidH, mainPetGuidL)
	local growth_rate_2 = self:LuaFnGetPeGrowthRate(selfId, assisPetGuidH, assisPetGuidL)
	local average_growth_rate = (growth_rate_1 + growth_rate_2) / 2

	self:SetPetsSpouseGUID(selfId, mainPetGuidH, mainPetGuidL, assisPetGuidH, assisPetGuidL)
	self:SetPetNumOfReproductions(selfId, mainPetGuidH, mainPetGuidL, num_1 - 1)
	self:SetPetNumOfReproductions(selfId, assisPetGuidH, assisPetGuidL, num_2 -1)
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0 )
	self:notify_tips(selfId, "珍兽繁殖成功，请查看您的珍兽栏")
	self:LuaFnCostMoneyWithPriority(selfId, 20000)
	local PlayerName = self:GetName(selfId)
	PlayerName = gbk.fromutf8(PlayerName)
	local num = #variances
	local rates = g_rate[num]
	local is_special = pet_special_procreate[data_index]
	if is_special then
		rates = is_special.rate
	end
	local is_max = false
	local petGUID_H, petGUID_L
	for i = 1, 2 do
		local rate = math.random(1000)
		for j = 1, num do
			if rate <= rates[j] then
				if j == #variances then
					is_max = true
				end
				if petGUID_L then
					_, petGUID_H, petGUID_L = self:LuaFnCreatePetToHuman(selfId, variances[j], true, average_growth_rate, petGUID_L + 1)
					
					if is_max and petGUID_H and petGUID_L and is_special then
						for key,value in pairs(is_special) do
							if key ~= "rate" then
								local fix_value = math.random(value.n_min,value.n_max)
								self:LuaFnSetPetData(selfId, petGUID_H, petGUID_L, key, fix_value)
							end
						end
					end
					
					local transfer = self:GetPetTransString(selfId, petGUID_H, petGUID_L)
					local strMsg = string.format("#{PBB_2_A}#{_INFOUSR%s}#{PBB_2_B}#{_INFOMSG%s}#{PBB_2_C}", PlayerName, transfer)
					self:BroadMsgByChatPipe(selfId, strMsg, 4)
					break
				else
					_, petGUID_H, petGUID_L = self:LuaFnCreatePetToHuman(selfId, variances[j], true, average_growth_rate)
					
					if is_max and petGUID_H and petGUID_L and is_special then
						for key,value in pairs(is_special) do
							if key ~= "rate" then
								local fix_value = math.random(value.n_min,value.n_max)
								self:LuaFnSetPetData(selfId, petGUID_H, petGUID_L, key, fix_value)
							end
						end
					end
					
					
					local transfer = self:GetPetTransString(selfId, petGUID_H, petGUID_L)
					local strMsg = string.format("#{PBB_2_A}#{_INFOUSR%s}#{PBB_2_B}#{_INFOMSG%s}#{PBB_2_C}", PlayerName, transfer)
					self:BroadMsgByChatPipe(selfId, strMsg, 4)
					break
				end
			end
		end
	end
end

return PetProcreateRegister