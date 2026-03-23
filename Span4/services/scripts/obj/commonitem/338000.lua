local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)
local g_SkillBooks = {}
--**********************************************************
--下面是第七本心法35级  2019-9-23 12:32:24修正
--**********************************************************
g_SkillBooks[30308002] = { type = 1, id = 55, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--少林
g_SkillBooks[30308003] = { type = 1, id = 56, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--明教
g_SkillBooks[30308004] = { type = 1, id = 57, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--丐帮
g_SkillBooks[30308005] = { type = 1, id = 58, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--武当
g_SkillBooks[30308006] = { type = 1, id = 59, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--峨眉
g_SkillBooks[30308007] = { type = 1, id = 60, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--星宿
g_SkillBooks[30308008] = { type = 1, id = 61, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--天龙
g_SkillBooks[30308009] = { type = 1, id = 62, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--天山
g_SkillBooks[30308010] = { type = 1, id = 63, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--逍遥
g_SkillBooks[30308140] = { type = 1, id = 70, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MANTUOSHANZHUANG, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }--曼陀山庄
--***********************************************************
--下面是45级要诀  2019-9-23 12:32:18修正
--***********************************************************
g_SkillBooks[30308045] = { type = 2, id = 305, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN, needLevel = 45, needXinfa = 55, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308070] = { type = 2, id = 334, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO, needLevel = 45, needXinfa = 56, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308060] = { type = 2, id = 364, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG, needLevel = 45, needXinfa = 57, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308066] = { type = 2, id = 394, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG, needLevel = 45, needXinfa = 58, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308043] = { type = 2, id = 424, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI, needLevel = 45, needXinfa = 59, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308067] = { type = 2, id = 454, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU, needLevel = 45, needXinfa = 60, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308068] = { type = 2, id = 487, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, needLevel = 45, needXinfa = 61, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308071] = { type = 2, id = 515, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN, needLevel = 45, needXinfa = 62, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308069] = { type = 2, id = 544, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO, needLevel = 45, needXinfa = 63, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308141] = { type = 2, id = 784, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MANTUOSHANZHUANG, needLevel = 45, needXinfa = 70, needXinfaLevel = 1, specialEffectID = 18 }
--***********************************************************
--下面是65级要诀  2019-9-23 12:32:13 修正
--***********************************************************
g_SkillBooks[30308011] = { type = 2, id = 301, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN, needLevel = 65, needXinfa = 55, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308012] = { type = 2, id = 331, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO, needLevel = 65, needXinfa = 56, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308013] = { type = 2, id = 361, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG, needLevel = 65, needXinfa = 57, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308014] = { type = 2, id = 391, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG, needLevel = 65, needXinfa = 58, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308015] = { type = 2, id = 421, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI, needLevel = 65, needXinfa = 59, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308016] = { type = 2, id = 451, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU, needLevel = 65, needXinfa = 60, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308017] = { type = 2, id = 481, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, needLevel = 65, needXinfa = 61, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308018] = { type = 2, id = 511, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN, needLevel = 65, needXinfa = 62, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308019] = { type = 2, id = 541, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO, needLevel = 65, needXinfa = 63, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308142] = { type = 2, id = 785, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MANTUOSHANZHUANG, needLevel = 65, needXinfa = 70, needXinfaLevel = 1, specialEffectID = 18 }
--***********************************************************
--下面是80级要诀  
--***********************************************************
g_SkillBooks[30308075] = { type = 2, id = 306, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN, needLevel = 80, needXinfa = 55, needXinfaLevel = 1, specialEffectID = 18 }--修正技能id
g_SkillBooks[30308091] = { type = 2, id = 335, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO, needLevel = 80, needXinfa = 56, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308089] = { type = 2, id = 365, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG, needLevel = 80, needXinfa = 57, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308087] = { type = 2, id = 395, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG, needLevel = 80, needXinfa = 58, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308093] = { type = 2, id = 426, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI, needLevel = 80, needXinfa = 59, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308088] = { type = 2, id = 455, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU, needLevel = 80, needXinfa = 60, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308076] = { type = 2, id = 488, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, needLevel = 80, needXinfa = 61, needXinfaLevel = 1, specialEffectID = 18 }--修正技能id
g_SkillBooks[30308092] = { type = 2, id = 516, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN, needLevel = 80, needXinfa = 62, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308090] = { type = 2, id = 545, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO, needLevel = 80, needXinfa = 63, needXinfaLevel = 1, specialEffectID = 18 }
g_SkillBooks[30308143] = { type = 2, id = 786, menpaiId = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MANTUOSHANZHUANG, needLevel = 80, needXinfa = 70, needXinfaLevel = 1, specialEffectID = 18 }

g_SkillBooks[30308055] = { type = 2, id = 37, menpaiId = -1, needLevel = 40, needXinfa = -1, needXinfaLevel = -1, specialEffectID = 18 }

local g_TypeNames = {}
g_TypeNames[1] = "秘籍"
g_TypeNames[2] = "要诀"
g_TypeNames[3] = "进阶技能"

local MenPaiName = {}
MenPaiName[10] = "慕容"
MenPaiName[11] = "唐门"
MenPaiName[12] = "鬼谷"
MenPaiName[13] = "桃花岛"

function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

function common_item:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end
    local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId)
    local skillBook = g_SkillBooks[itemTblIndex]
    if not skillBook then
        return 0
    end
	local menpai = self:GetMenPai(selfId )
	if -1~=skillBook.menpaiId then
		if menpai ~= skillBook.menpaiId then
			if skillBook.menpaiId < 9 then
				self:notify_tips(selfId, "你不是#{_MENPAI" .. skillBook.menpaiId .. "}弟子，不能学习该" .. g_TypeNames[skillBook.type] .. "。" )
			else
				self:notify_tips( selfId, "你不是"..MenPaiName[skillBook.menpaiId].."弟子，不能学习该" .. g_TypeNames[skillBook.type] .. "。" )
			end
			return 0
		end
	end
    if self:GetLevel(selfId) < skillBook.needLevel then
		self:notify_tips(selfId, "你还不能学习该" .. g_TypeNames[skillBook.type] .. "。" )
		return 0
	end

	if skillBook.needXinfa ~= -1 then
		local xinfaLevel = self:HaveXinFa(selfId, skillBook.needXinfa )
		if xinfaLevel < 1 then
			self:notify_tips(selfId, "需要先学习心法：#{_XINFA" .. skillBook.needXinfa .. "}。" )
			return 0
		end

		if xinfaLevel < skillBook.needXinfaLevel then
			-- 需要测试这个地方，跨行而且没有分号
			self:notify_tips(selfId, "需要心法：#{_XINFA" .. skillBook.needXinfa .. "} ".. skillBook.needXinfaLevel .. " 级，当前 " .. xinfaLevel .. " 级。" )
			return 0
		end
	end

	if skillBook.type == 1 then					-- 心法
		if self:HaveXinFa(selfId, skillBook.id ) > 0 then
			self:notify_tips(selfId, "你已经学会了该心法。" )
			return 0
		end
	elseif skillBook.type == 2 then				-- 要诀
		if self:HaveSkill(selfId, skillBook.id ) then
			self:notify_tips(selfId, "你已经学会了该技能。" )
			return 0
		end
	end
    return 1
end

function common_item:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function common_item:OnActivateOnce(selfId)
	local itemTblIndex = self:LuaFnGetItemIndexOfUsedItem(selfId)
	local skillBook = g_SkillBooks[itemTblIndex]
	if not skillBook then
		return 0
	end
	-- 学习
	if skillBook.type == 1 then					-- 心法
		if self:HaveXinFa(selfId, skillBook.id ) > 0 then
			self:notify_tips(selfId, "你已经学会了该心法。" )
			return 0
		else
			self:AddXinFa(selfId, skillBook.id )
			self:notify_tips(selfId, "恭喜您，成功学习心法：#{_ITEM"..itemTblIndex.."}" )
		end
	elseif skillBook.type == 2 then				-- 要诀
		if self:HaveSkill(selfId, skillBook.id ) then
			self:notify_tips(selfId, "你已经学会了该技能。" )
			return 0
		else
			self:AddSkill(selfId, skillBook.id )
			self:notify_tips(selfId, "恭喜您，成功学习要诀：#{_ITEM"..itemTblIndex.."}" )
		end
	end
	self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, skillBook.specialEffectID, 0 )
    return 1
end

return common_item