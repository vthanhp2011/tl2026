--武魂
--脚本号
local gbk = require "gbk"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local wuhun = class("wuhun", script_base)

function wuhun:OnAction(selfId, operate, ...)
    if operate == 1 then
        self:KfsAttrExLevelUp(selfId, ...)
    elseif operate == 2 then
        self:KfsAttrExStudy(selfId, ...)
    elseif operate == 3 then
        self:KfsCompoud(selfId, ...)
    elseif operate == 4 then
        self:AddKfsLife(selfId, ...)
    elseif operate == 5 then
        self:KfsStudySkill(selfId, ...)
    elseif operate == 6 then
        self:AskWashKfsSkill(selfId, ...)
    elseif operate == 7 then
        self:KfsSkillUp(selfId, ...)
    elseif operate == 8 then
        self:KfsAttrExDelete(selfId, ...)
    elseif operate == 9 then
        self:AddKfsSlot(selfId, ...)
    elseif operate == 12 then
        self:KfsReWashGrowEx(selfId, ...)
    elseif operate == 13 then
        self:DoReplaceKfsSkill(selfId, ...)
    end
end

--**********************************
--武魂合成
--**********************************
function wuhun:KfsCompoud(selfId, nKfsMain, nKfsCom)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "在安全时间内无法进行此操作。打开包裹栏，点击安全中心可以自行设置安全时间。")
        return
    end
    if nKfsMain == nil or nKfsCom == nil then
        return
    end
    if self:LuaFnIsItemLocked(selfId, nKfsCom) then
        self:notify_tips(selfId, "被上锁的武魂不能作材料武魂")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfsMain)
    local nKfsComPoint = self:LuaFnGetBagEquipType(selfId, nKfsCom)
    if nKfsMainPoint ~= 18 or nKfsComPoint ~= 18 then
        self:notify_tips(selfId, "此处只能放入武魂")
        return
    end
    local gem_count = self:GetGemEmbededCount(selfId, nKfsCom)
    if gem_count > 0 then
        self:notify_tips(selfId, "镶嵌有宝石的武魂不能作为合成材料！") --WH_20090904_01 镶嵌有宝石的武魂不能作为合成材料！
        return
    end
    local main_data = self:GetEquipWuHunData(selfId, nKfsMain)
    local con_data = self:GetEquipWuHunData(selfId, nKfsCom)
    if main_data.hecheng_level ~= con_data.hecheng_level then
        self:notify_tips(selfId, "参与合成的武魂和需要提升的武魂，合成等级必须相同") --参与合成的武魂灵力等级需要等于要提升灵力等级的武魂
        return
    end
    if main_data.hecheng_level >= 7 then
        self:notify_tips(selfId, "7级以上的武魂的合成暂未开放。") --5级以上合成暂不开放。
        return
    end
    local needMoney = 10000
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < needMoney then
        self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
        return
    end
    main_data.hecheng_level = main_data.hecheng_level + 1
    self:LuaFnCostMoneyWithPriority(selfId, needMoney)
    self:SetEquipWuHunData(selfId, nKfsMain, {hecheng_level = main_data.hecheng_level})
    --设置绑定状态
    if self:LuaFnGetItemBindStatus(selfId, nKfsCom) then
        self:LuaFnItemBind(selfId, nKfsMain)
    end
    self:LuaFnEraseItem(selfId, nKfsCom)
    self:notify_tips(selfId, "#{WH_090729_19}")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

--**********************************
--增加武魂拓展属性栏
--**********************************
function wuhun:AddKfsSlot(selfId, nKfspos, nMaterialPos, nCheck)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    if nKfspos == nil or nMaterialPos == nil or nCheck == nil then
        return
    end
    if nMaterialPos == -1 then
        return
    end
    local nKfsID = self:LuaFnGetItemTableIndexByIndex(selfId, nMaterialPos)
    if nKfsID == 0 then
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfspos)
    if nKfsData_main == nil then
        return
    end
    local kfs_slot = self:GetKfsSlotConfig()
    kfs_slot = kfs_slot[nKfsData_main.hecheng_level - 1]
    if nKfsID ~= kfs_slot.materials[1] and nKfsID ~= kfs_slot.materials[2] then
        self:notify_tips(selfId, "#{WHYH_161121_134}") --此处只能放入麟木箭、破天剑
        return
    end
    local mat_index = 1
    if nKfsID == kfs_slot.materials[2] then
        mat_index = 2
    end
    if self:LuaFnIsItemLocked(selfId, nMaterialPos) then
        self:notify_tips(selfId, "#{WHYH_161121_38}")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfspos)
    if nKfsMainPoint ~= 18 then
        self:notify_tips(selfId, "#{WH_090729_13}")
        return
    end

    if nKfsData_main.ex_attr_number >= nKfsData_main.hecheng_level then
        if nKfsData_main.ex_attr_number == 10 then
            self:notify_tips(selfId, "#{WH_090817_13}") -- 武魂的扩展属性栏数已经到达最大值10栏。
        else
            self:notify_tips(selfId, "#{WH_090729_50}") -- 该武魂不能开辟新的属性栏。提升灵力等级后，可以开辟新的属性栏。
        end
        return
    end
    local needMoney = kfs_slot.cost_moneys[mat_index]
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < needMoney then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, needMoney)
    self:LuaFnDelAvailableItem(selfId, nKfsID, 1)
    local odd = kfs_slot.odd
    local rand = math.random(1000)
    if odd < rand then
        nKfsData_main.ex_attr_number = nKfsData_main.ex_attr_number + 1
        self:notify_tips(selfId, "#{WH_090729_55}")
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    else
        self:notify_tips(selfId, "#{WH_090729_54}")
    end
    self:SetEquipWuHunData(selfId, nKfspos, {ex_attr_number = nKfsData_main.ex_attr_number})
end

--**********************************
--武魂拓展属性学习
--**********************************
function wuhun:KfsAttrExStudy(selfId, nKfsPos, nBookPos)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    if self:LuaFnIsItemLocked(selfId, nBookPos) then
        self:notify_tips(selfId, "#{WHYH_161121_38}")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfsPos)
    if nKfsMainPoint ~= 18 then
        self:notify_tips(selfId, "#{WH_090729_13}")
        return
    end
    local nKfsBookID = self:LuaFnGetItemTableIndexByIndex(selfId, nBookPos)
    local kfs_attr_ex_book = self:GetKfsAttrExBookConfig()
    if kfs_attr_ex_book[nKfsBookID] == nil then
        self:notify_tips(selfId, "#{WH_090729_20}")
        return
    end
    if not self:LuaFnIsItemAvailable(selfId, nBookPos) then
        self:notify_tips(selfId, "#{WH_090729_20}")
        return
    end
    local attr = kfs_attr_ex_book[nKfsBookID].attr
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        return
    end
    local ex_attr_number = nKfsData_main.ex_attr_number
    local attr_count = 0
    local slot_index
    local exist_attr = false
    for i, v in ipairs(nKfsData_main.ex_attr) do
        if v ~= 0 then
            attr_count = attr_count + 1
            if (v - 1) // 10 == (attr - 1) // 10 then
                exist_attr = true
            end
        elseif slot_index == nil then
            slot_index = i
        end
    end
    assert(slot_index)
    if attr_count >= ex_attr_number and ex_attr_number >= 0 then
        self:notify_tips(selfId, "#{WH_090729_56}") -- 需要有空余的属性栏，才能学习扩展属性。
        return
    end
    if exist_attr then
        self:notify_tips(selfId, "相同的扩展属性已存在，无法学习")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < 80000 then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    self:SetEquipWuHunData(selfId, nKfsPos, {ex_attr = {[slot_index] = attr }})
    self:LuaFnCostMoneyWithPriority(selfId, 80000)
    self:EraseItem(selfId, nBookPos)
    self:notify_tips(selfId, "#{WH_090729_61}")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

--**********************************
--武魂拓展属性升级
--**********************************
function wuhun:KfsAttrExLevelUp(selfId, nKfsPos, nMaterialPos, nIndex)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    nIndex = nIndex + 1
    if nIndex < 1 or nIndex > 10 then
        self:notify_tips(selfId, "#{WHYH_161121_41}")
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        self:notify_tips(selfId, "ERROR:NULL")
        return
    end
    local attr_ext_id = nKfsData_main.ex_attr[nIndex]
    local kfs_attr_ext = self:GetKfsAttrExConfig()
    kfs_attr_ext = kfs_attr_ext[attr_ext_id]
    local needItem, needMoney = kfs_attr_ext.level_up_material, kfs_attr_ext.level_up_money
    local nKfsID = self:LuaFnGetItemTableIndexByIndex(selfId, nMaterialPos)
    if nKfsID ~= needItem then
        self:notify_tips(selfId, "#{WH_xml_XX(98)}" .. self:GetItemName(needItem))
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < needMoney then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    attr_ext_id = kfs_attr_ext.next_id
    if attr_ext_id == 0 then
        self:notify_tips(selfId, "#{WHYH_161121_42}")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, needMoney)
    self:LuaFnDecItemLayCount(selfId, nMaterialPos, 1)
    self:SetEquipWuHunData(selfId, nKfsPos, {ex_attr = {[nIndex] = attr_ext_id}})
    self:notify_tips(selfId, "#{WH_090729_32}")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    --4级以上小喇叭
    if attr_ext_id % 10 > 4 then
        kfs_attr_ext = self:GetKfsAttrExConfig()
        kfs_attr_ext = kfs_attr_ext[attr_ext_id]
        local format = "#H武惊日月，魂慑乾坤！#G#{_INFOUSR%s}#H在#G大理#{_INFOAIM140,195,2,无崖子}#R无崖子#H处通过武魂技能#G提升#H之法，终于使%s学会了#G%s#H！"
        local name = self:GetName(selfId)
        local item_name = self:GetItemName(self:LuaFnGetItemTableIndexByIndex(selfId, nKfsPos))
        local nGlobalText = string.format(format, name, item_name, kfs_attr_ext.name)
        nGlobalText = gbk.fromutf8(nGlobalText)
        self:BroadMsgByChatPipe(selfId, nGlobalText, 4)
    end
end

--**********************************
--增加武魂经验
--**********************************
function wuhun:AddKfsExp(selfId, nExp)
    local nKfsData_main = self:GetEquipWuHunData(selfId)
    local ret = self:AddWuHunExp(selfId, nExp)
    if ret then
        local nKfsData_main_new = self:GetEquipWuHunData(selfId)
        self:notify_tips(selfId, "#{WH_090729_10}" .. nExp)
        if nKfsData_main_new.level > nKfsData_main.level then
            self:notify_tips(selfId, "#{WH_090729_11}" .. tonumber(nKfsData_main_new.level) .. "#{WH_090729_12}")
        end
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
        return true
    else
        self:notify_tips(selfId, "#{WH_090729_09}")
        return false
    end
end
--**********************************
--武魂技能学习
--**********************************
function wuhun:KfsStudySkill(selfId, nKfsPos)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfsPos)
    if nKfsMainPoint ~= 18 then
        self:notify_tips(selfId, "#{WHXCZL_091026_03}")
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        self:notify_tips(selfId, "#{WH_090729_23}")
        return
    end
    local nCanHaveSkill = define.INVAILD_ID
    if nKfsData_main.level >= 40 and nKfsData_main.level < 70 then
        nCanHaveSkill = 1
    elseif nKfsData_main.level >= 70 and nKfsData_main.level < 90 then
        nCanHaveSkill = 2
    elseif nKfsData_main.level >= 90 then
        nCanHaveSkill = 3
    end
    local nSkillNum = 0
    for i = 1, 3 do
        local skill = nKfsData_main.skill[i]
        if skill ~= define.INVAILD_ID then
            nSkillNum = nSkillNum + 1
        end
    end
    if nSkillNum >= nCanHaveSkill then
        self:notify_tips(selfId, "#{WH_090729_23}") --对不起，你的武魂还没有达到领悟下一个技能的级别
        return
    end
    local needMoney
    if nSkillNum == 0 then
        needMoney = 50000 --第一个技能5金
    elseif nSkillNum == 1 then
        needMoney = 100000 --第二个技能10金
    elseif nSkillNum == 2 then
        needMoney = 150000 --第三个技能15金
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < needMoney then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    self:WuHunUnstandSkill(selfId, nKfsPos, nSkillNum + 1)
    self:LuaFnCostMoneyWithPriority(selfId, needMoney)
    self:notify_tips(selfId, "#{WH_090729_24}")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

--**********************************
--武魂技能重洗请求
--**********************************
local KfsItem_YiHunShi = {30700213, 30700236, 30700249}
function wuhun:AskWashKfsSkill(selfId, nKfsPos)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "在安全时间内不能进行此操作。打开包裹栏，点击防盗号按钮可以自行设置安全时间。")
        return
    end
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(KfsItem_YiHunShi) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
    if allnum < 1 then
        self:notify_tips(selfId, "#cfff263本次重洗武魂技能，需要消耗1个#G忆魂石#cfff263。您背包道具栏中没有#cfff263的#G忆魂石#cfff263。")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfsPos)
    if nKfsMainPoint ~= 18 then
        self:notify_tips(selfId, "#{WHYH_161121_48}")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < 50000 then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        self:notify_tips(selfId, "#{WHYH_161121_49}")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, 50000)
    self:GenWuHunSkillForBagItem(selfId, nKfsPos)
    self:LuaFnMtl_CostMaterial(selfId, 1, costtab)
end

function wuhun:DoReplaceKfsSkill(selfId, BagPos)
    self:ReplaceKfsSkill(selfId, BagPos)
end

--**********************************
--武魂技能升级
--**********************************
function wuhun:KfsSkillUp(selfId, nKfsPos, _, nIndex)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    nIndex = nIndex + 1
    if nIndex < 1 or nIndex > 3 then
        self:notify_tips(selfId, "#{WHYH_161121_72}")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfsPos)
    if nKfsMainPoint ~= 18 then
        self:notify_tips(selfId, "#{WHYH_161121_70}")
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        self:notify_tips(selfId, "#{WHYH_161121_71}")
        return
    end
    local skill = nKfsData_main.skill[nIndex]
    if skill == define.INVAILD_ID then
        self:notify_tips(selfId, "#{WHYH_161121_71}")
        return
    end
    local kfs_skill_level_up = self:GetKfsSkillLevelUpConfig()
    kfs_skill_level_up = kfs_skill_level_up[skill]
    if kfs_skill_level_up.level >= 6 then --目前最高开放6级，其实最高应该是8级，但是为了符合策划 (滑.稽)，想开6级以上的缺的自己补吧
        self:notify_tips(selfId, "#{WHYH_161121_73}")
        return
    end
    local upSkillID, needItem, nMoney = kfs_skill_level_up.next, kfs_skill_level_up.material, kfs_skill_level_up.money
    -- 武魂的当前技能是否已提升至最高级
    if upSkillID == define.INVAILD_ID then
        self:notify_tips(selfId, "#{WHYH_161121_66}") --该技能已经达到最高等级，不能继续升级！
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < nMoney then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs({needItem,needItem - 44}) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
	
    -- if self:LuaFnMtl_GetCostNum(selfId, {needItem,needItem - 44}) < 1 then
        -- local needItemName = self:GetItemName(needItem)
        -- local skillname = self:GetSkillName(upSkillID)
        -- local strSkillName = "#{XYJ_KFS_SKILL_NAME_" .. skillname .. "}"
        -- local tips = string.format("升级至%s#H技能需要使用一颗%s#H。您当前放入的魂冰珠不符合升级条目的需要，请重新放置。", strSkillName, needItemName)
        -- self:notify_tips(selfId, tips)
        -- return
    -- end
    if allnum < 1 then
        local needItemName = self:GetItemName(needItem)
        local skillname = self:GetSkillName(upSkillID)
        local strSkillName = "#{XYJ_KFS_SKILL_NAME_" .. skillname .. "}"
        local tips = string.format("升级至%s#H技能需要使用一颗%s#H。您当前放入的魂冰珠不符合升级条目的需要，请重新放置。", strSkillName, needItemName)
        self:notify_tips(selfId, tips)
        return
    end
    --数据存储完毕，恭喜玩家了
    if not self:LuaFnMtl_CostMaterial(selfId, 1, costtab) then
        self:notify_tips(selfId, "材料扣除失败")
        return
    end
    self:SetEquipWuHunData(selfId, nKfsPos, {skill = {[nIndex] = upSkillID}})
    self:LuaFnCostMoneyWithPriority(selfId, nMoney)
    self:notify_tips(selfId, "#{WH_090729_28}")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    kfs_skill_level_up = self:GetKfsSkillLevelUpConfig()
    kfs_skill_level_up = kfs_skill_level_up[upSkillID]
    --3级以上发小喇叭
    if kfs_skill_level_up.level >= 3 then
        local skillname = self:GetSkillName(upSkillID)
        local format = gbk.fromutf8("#P皇天不负有心人，辛苦的付出终有回报。#G#{_INFOUSR%s}#P经过不懈的努力，终于使%s学会了#G%s#P！")
        local nGlobalText =
            string.format(
            format,
            gbk.fromutf8(self:GetName(selfId)),
            gbk.fromutf8(self:GetItemName(self:LuaFnGetItemTableIndexByIndex(selfId, nKfsPos))),
            "#{XYJ_KFS_SKILL_NAME_" ..  gbk.fromutf8(skillname) .. "}"
        )
        self:BroadMsgByChatPipe(selfId, nGlobalText, 4)
    end
end

--**********************************
--武魂延寿
--**********************************
local KfsItem_YanShouDan = 30700233
function wuhun:AddKfsLife(selfId, nKfsPos, nMaiterialPos)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    if nMaiterialPos == -1 then
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        self:notify_tips(selfId, "#{WHYH_161121_71}")
        return
    end
    local nKfsID = self:LuaFnGetItemTableIndexByIndex(selfId, nMaiterialPos)
    if nKfsID == 0 then
        return
    end
    local nMoney = 50000
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < nMoney then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    if nKfsID == KfsItem_YanShouDan then
        if nKfsData_main.life == 300 then
            self:notify_tips(selfId, "武魂没有损害，不用延寿。")
        else
            self:notify_tips(selfId, "#{WH_090729_37}")
            self:LuaFnDelAvailableItem(selfId, KfsItem_YanShouDan, 1)
            self:LuaFnCostMoneyWithPriority(selfId, nMoney)
            self:SetEquipWuHunData(selfId, nKfsPos, {life = 300})
            self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
        end
    else
        self:notify_tips(selfId, "#{WH_090729_36}")
        return
    end
end

--**********************************
--武魂拓展属性删除
--**********************************
function wuhun:KfsAttrExDelete(selfId, nKfsPos, _, nIndex)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    nIndex = nIndex + 1
    if nIndex < 1 or nIndex > 10 then
        self:notify_tips(selfId, "#{WH_090729_67}")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfsPos)
    if nKfsMainPoint ~= 18 then
        self:notify_tips(selfId, "#{WH_090729_13}")
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < 1000 then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        self:notify_tips(selfId, "#{WHYH_161121_71}")
        return
    end
    if nKfsData_main.ex_attr[nIndex] == 0 then
        self:notify_tips(selfId, "#{WH_090729_57}")
        return
    end
    self:LuaFnCostMoneyWithPriority(selfId, 1000)
    self:SetEquipWuHunData(selfId, nKfsPos, {ex_attr = {[nIndex] = 0}})
    self:notify_tips(selfId, "#{WH_090729_58}")
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
end

--**********************************
--重洗武魂成长率
--**********************************
local KfsItem_HuiTianShenShi = {30700240, 30700241, 30700242}
function wuhun:KfsReWashGrowEx(selfId, nKfsPos)
    if self:IsPilferLockFlag(selfId) then
        self:notify_tips(selfId, "#{OR_PILFER_LOCK_FLAG}")
        return
    end
    local nKfsMainPoint = self:LuaFnGetBagEquipType(selfId, nKfsPos)
    if nKfsMainPoint ~= 18 then
        self:notify_tips(selfId, "#{WHXCZL_091026_03}")
        return
    end
	local costtab = {}
	local itemcount
	local allnum = 0
	for i,j in ipairs(KfsItem_HuiTianShenShi) do
		itemcount = self:LuaFnGetAvailableItemCount(selfId, j)
		if itemcount > 0 then
			allnum = allnum + itemcount
			table.insert(costtab,j)
		end
	end
    if allnum < 1 then
        return
    end
    local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
    if nMoneySelf < 50000 then
        self:notify_tips(selfId, "#{WH_090729_18}")
        return
    end
    local nKfsData_main = self:GetEquipWuHunData(selfId, nKfsPos)
    if nKfsData_main == nil then
        self:notify_tips(selfId, "#{WHYH_161121_71}")
        return
    end
    local nNewGrow = 0
    nNewGrow = math.random(1, 100)
    if nNewGrow == 100 then
        nNewGrow = math.random(820, 900)
    elseif nNewGrow >= 98 then
        nNewGrow = math.random(750, 820)
    elseif nNewGrow >= 95 then
        nNewGrow = math.random(700, 750)
    elseif nNewGrow >= 80 then
        nNewGrow = math.random(650, 700)
    else
        nNewGrow = math.random(600, 650)
    end
    local del = self:LuaFnMtl_CostMaterial(selfId, 1, costtab)
	if not del then return end
    del = self:LuaFnCostMoneyWithPriority(selfId, 50000)
	if not del then return end
    self:LuaFnItemBind(selfId, nKfsPos)
    --新成长低于旧成长则不改变
    if nNewGrow < nKfsData_main.grow_rate then
        self:notify_tips(selfId, "#{WHXCZL_091026_06}")
    else
        self:SetEquipWuHunData(selfId, nKfsPos, { grow_rate = nNewGrow})
        self:notify_tips(selfId, "#{WHXCZL_091026_07}")
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
    end
end

local runhunshi = {
    [1] = {
        { item = 20310122, count = 3, target = 20310123, cost_money = 5000},
        { item = 20310123, count = 3, target = 20310124, cost_money = 5000},
        { item = 20310124, count = 3, target = 20310125, cost_money = 10000},
        { item = 20310125, count = 3, target = 20310126, cost_money = 10000},
        { item = 20310126, count = 2, target = 20310127, cost_money = 15000},
        { item = 20310127, count = 2, target = 20310128, cost_money = 15000},
    },
    [2] = {
        { item = 20310131, count = 3, target = 20310132, cost_money = 5000},
        { item = 20310132, count = 3, target = 20310133, cost_money = 5000},
        { item = 20310133, count = 3, target = 20310134, cost_money = 10000},
        { item = 20310134, count = 3, target = 20310135, cost_money = 10000},
        { item = 20310135, count = 2, target = 20310136, cost_money = 15000},
        { item = 20310136, count = 2, target = 20310137, cost_money = 15000},
    },
    [3] = {
        { item = 20310140, count = 3, target = 20310141, cost_money = 5000},
        { item = 20310141, count = 3, target = 20310142, cost_money = 5000},
        { item = 20310142, count = 3, target = 20310143, cost_money = 10000},
        { item = 20310143, count = 3, target = 20310144, cost_money = 10000},
        { item = 20310144, count = 2, target = 20310145, cost_money = 15000},
        { item = 20310145, count = 2, target = 20310146, cost_money = 15000},
    },
    [4] = {
        { item = 20310149, count = 3, target = 20310150, cost_money = 5000},
        { item = 20310150, count = 3, target = 20310151, cost_money = 5000},
        { item = 20310151, count = 3, target = 20310152, cost_money = 10000},
        { item = 20310152, count = 3, target = 20310153, cost_money = 10000},
        { item = 20310153, count = 2, target = 20310154, cost_money = 15000},
        { item = 20310154, count = 2, target = 20310155, cost_money = 15000},
    },
}

function wuhun:RunHunShiCompound_New(selfId, targetId, ...)
    print("wuhun:RunHunShiCompound_New =", selfId, targetId, ...)
    local operate, type, stype = ...
    if operate == 2 then
        local config = runhunshi[type][stype]
        if config == nil then
            self:notify_tips(selfId, "#{WH_090729_38}")
            return
        end
        local item = config.item
        local num = config.count
        if self:LuaFnGetAvailableItemCount(selfId, item) < num then
            self:notify_tips(selfId, "材料不足")
            return
        end
        local needMoney = config.cost_money
        local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
        if nMoneySelf < needMoney then
            self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
            return
        end
		local del
        del = self:LuaFnDelAvailableItem(selfId, item, num)
		if del then
			del = self:LuaFnCostMoneyWithPriority(selfId, needMoney)
			if del then
				self:TryRecieveItem(selfId, config.target)
				self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
			end
		end
    elseif operate == 1 then
        local config = runhunshi[type][stype]
        if config == nil then
            self:notify_tips(selfId, "#{WH_090729_38}")
            return
        end
        local num = 1
		-- local needMoney = runhunshi[1][1].cost_money
        for i = 1, stype do
            num = num * runhunshi[type][i].count
			-- if i > 1 then
				-- needMoney = needMoney + runhunshi[type][i - 1].cost_money * runhunshi[type][i - 1].count
			-- end
        end
		
		
        local rf
        rf = function(i, money, count)
            money = money + runhunshi[type][i].cost_money * count
            if runhunshi[type][i - 1] then
                return rf(i - 1, money, runhunshi[type][i].count)
            else
                return money
            end
        end
        local needMoney = rf(stype, 0, 1)
        print("num =", num, ";needMoney =", needMoney)
        local item = runhunshi[type][1].item
        if self:LuaFnGetAvailableItemCount(selfId, item) < num then
            self:notify_tips(selfId, "材料不足")
            return
        end
        local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
        if nMoneySelf < needMoney then
            self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
            return
        end
		local del
        del = self:LuaFnDelAvailableItem(selfId, item, num)
		if del then
			del = self:LuaFnCostMoneyWithPriority(selfId, needMoney)
			if del then
				self:TryRecieveItem(selfId, config.target)
				self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
			end
		end
    else
        assert(false, operate)
    end
end
-- 20310161-20310165
-- 20310117-20310121
local hunbingzhu = {
    [1] = {
        item = 20310117,itemBind = 20310161, count = 5, target = 20310118,targetbind = 20310162, cost_money = 5000
    },
    [2] = {
        item = 20310118,itemBind = 20310162, count = 5, target = 20310119,targetbind = 20310163, cost_money = 5000
    },
    [3] = {
        item = 20310119,itemBind = 20310163, count = 5, target = 20310120,targetbind = 20310164, cost_money = 10000
    },
    [4] = {
        item = 20310120,itemBind = 20310164, count = 5, target = 20310121,targetbind = 20310165, cost_money = 10000
    },
}
function wuhun:OnHunBingZhuCompoundNew(selfId, target, ...)
    print("wuhun:OnHunBingZhuCompoundNew =", selfId, target, ...)
    local operate, index = ...
    if operate == 1 then
        local config = hunbingzhu[index]
        if config == nil then
            self:notify_tips(selfId, "#{WH_090729_38}")
            return
        end
        local item = config.item
		local itembind = config.itemBind
        local num = config.count
		local count = self:LuaFnGetAvailableItemCount(selfId, item)
		local countbind = self:LuaFnGetAvailableItemCount(selfId, itembind)
        if count + countbind < num then
            self:notify_tips(selfId, "材料不足")
            return
        end
        local needMoney = config.cost_money
        local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
        if nMoneySelf < needMoney then
            self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
            return
        end
		local additem
		local del
		if countbind >= num then
			additem = config.targetbind
			del = self:LuaFnDelAvailableItem(selfId, itembind, num)
			if not del then
				self:notify_tips(selfId, "道具扣除失败")
				return
			end
		else
			if countbind > 0 then
				additem = config.targetbind
				del = self:LuaFnDelAvailableItem(selfId, itembind, countbind)
				if not del then
					self:notify_tips(selfId, "道具扣除失败")
					return
				end
				num = num - countbind
			end
			additem = config.target
			del = self:LuaFnDelAvailableItem(selfId, item, num)
			if not del then
				self:notify_tips(selfId, "道具扣除失败")
				return
			end
		end
		if additem then
			del = self:LuaFnCostMoneyWithPriority(selfId, needMoney)
			if not del then
				self:notify_tips(selfId, "金钱扣除失败")
				return
			end
			self:TryRecieveItem(selfId, additem)
			self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
		end
    elseif operate == 2 then
        local config = hunbingzhu[index]
        if config == nil then
            self:notify_tips(selfId, "#{WH_090729_38}")
            return
        end
        local num = 1
		-- local needMoney = hunbingzhu[1].cost_money
        for i = 1, index do
            num = num * hunbingzhu[i].count
			-- if i > 1 then
				-- needMoney = needMoney + hunbingzhu[i - 1].cost_money * 5
			-- end
        end
        local rf
        rf = function(i, money, count)
            money = money + hunbingzhu[i].cost_money * count
            if hunbingzhu[i - 1] then
                return rf(i - 1, money, hunbingzhu[i].count)
            else
                return money
            end
        end
        local needMoney = rf(index, 0, 1)
        -- print("num =", num, ";needMoney =", needMoney)
        local item = hunbingzhu[1].item
		local itembind = hunbingzhu[1].itemBind
		local count = self:LuaFnGetAvailableItemCount(selfId, item)
		local countbind = self:LuaFnGetAvailableItemCount(selfId, itembind)
        if count + countbind < num then
            self:notify_tips(selfId, "材料不足")
            return
        end
        local nMoneySelf = self:GetMoneyJZ(selfId) + self:GetMoney(selfId)
        if nMoneySelf < needMoney then
            self:notify_tips(selfId, "对不起，你身上金钱不足，无法继续进行")
            return
        end
		local additem
		local del
		if countbind >= num then
			additem = config.targetbind
			del = self:LuaFnDelAvailableItem(selfId, itembind, num)
			if not del then
				self:notify_tips(selfId, "道具扣除失败")
				return
			end
		else
			if countbind > 0 then
				additem = config.targetbind
				del = self:LuaFnDelAvailableItem(selfId, itembind, countbind)
				if not del then
					self:notify_tips(selfId, "道具扣除失败")
					return
				end
				num = num - countbind
			end
			additem = config.target
			del = self:LuaFnDelAvailableItem(selfId, item, num)
			if not del then
				self:notify_tips(selfId, "道具扣除失败")
				return
			end
		end
		if additem then
			del = self:LuaFnCostMoneyWithPriority(selfId, needMoney)
			if not del then
				self:notify_tips(selfId, "金钱扣除失败")
				return
			end
			self:TryRecieveItem(selfId, additem)
			self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 49, 0)
		end
    else
        assert(false, operate)
    end
end

return wuhun
