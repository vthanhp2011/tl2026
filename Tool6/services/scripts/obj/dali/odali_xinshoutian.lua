local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local odali_xinshoutian = class("odali_xinshoutian", script_base)
odali_xinshoutian.script_id = 002030
--用新任务老任务取消
odali_xinshoutian.g_eventList = {
    210240,
    210200,
	210238,
    210258,
    210262,
    210263,
    210266,
    210275,
    210276,
    210277,
    210278,
    210267,
	210269,
	210279,
	210268,
    1018700,
}
local YuanXiaoRechage_NameList = {
    ["洋洋洋洋洋洋"] = 5000
}
local YuanXiao_Gift = {
    {
		money = 0,
		prize = {
            {itemid = 38008005,num = 30},
            {itemid = 20501003,num = 10},
            {itemid = 20502003,num = 10},
		}
	},
    {
		money = 500,
		prize = {
            {itemid = 38002397,num = 200},
            {itemid = 38002499,num = 200},
            {itemid = 20501003,num = 20},
            {itemid = 20502003,num = 20},
		}
	},
	{
        money = 1000,
        prize = {
            {itemid = 38002397,num = 300},
            {itemid = 38002499,num = 300},
            {itemid = 20501004,num = 10},
            {itemid = 20502004,num = 10},
        }
	},
    {
		money = 2000,
		prize = {
            {itemid = 38002397,num = 500},
            {itemid = 38002499,num = 500},
            {itemid = 20501004,num = 20},
            {itemid = 20502004,num = 20},
            {itemid = 70600015,num = 1, soul_level = 2}
		}
	},
	{
		money = 3000,
		prize = {
            {itemid = 38002397,num = 700},
            {itemid = 38002499,num = 700},
            {itemid = 20501004,num = 30},
            {itemid = 20502004,num = 30},
            {itemid = 70600015,num = 1, soul_level = 3}
		}
	},
	{
		money = 5000,
		prize = {
            {itemid = 38002397,num = 1000},
            {itemid = 38002499,num = 1000},
            {itemid = 20501004,num = 50},
            {itemid = 20502004,num = 50},
            {itemid = 70600015,num = 1, soul_level = 4},
            {title_id = 1237}
		}
	}
}

function odali_xinshoutian:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    local PlayerName = self:GetName(selfId)
    local PlayerSex = self:GetSex(selfId)
    local nLevel = self:GetLevel(selfId)
    if PlayerSex == 0 then
        PlayerSex = "妹妹"
    else
        PlayerSex = "兄弟"
    end
    local IsNew = self:GetMissionFlag(selfId, ScriptGlobal.MF_Dialog_01)
    if IsNew == 0 then
        self:AddText("  " .. PlayerName .. PlayerSex .. "#{OBJ_dali_0011}")
        self:SetMissionFlag(selfId, ScriptGlobal.MF_Dialog_01, 1)
    elseif IsNew == 1 then
        if self:GetLevel(selfId) >= 10 and self:GetMenPai(selfId) == ScriptGlobal.MP_WUMENPAI then
            self:AddText("  " .. PlayerName .. PlayerSex .. "#{OBJ_dali_0054}")
        else
            self:AddText("  " .. PlayerName .. PlayerSex .. "#{OBJ_dali_0012}")
        end
    end
    self:AddNumText("#H维护补偿礼包", 11,30001)
    self:AddNumText("飞蝗石补领", 6,60000)
    if self:GetMissionDataEx(selfId, ScriptGlobal.MDEX_YUANXIAOHUIKUI_2024) == 0 then
        self:AddNumText("元宵节回馈", 6, 70000)
	end
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_xinshoutian:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_xinshoutian:OnEventRequest(selfId, targetId, arg, index)
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(arg, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end 
    if index == 100000 then
        self:SetLevel(selfId,10)
    end
    if index == 30001 then
        local nFlag = self:GetMissionDataEx(selfId,151)
        local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
        local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
        if nFlag > 0 then
            self:notify_tips(selfId,"你已经领取过维护补偿礼包了。")
            return
        end
        self:BeginAddItem()
        self:AddItem(38008005,10,true)
        self:AddItem(20501003,5,true)
        self:AddItem(20502003,5,true)
        self:AddItem(30505076,2,true)
        local ret = self:EndAddItem(selfId)
        if not ret then
            self:notify_tips(selfId,"背包空间不足")
            return 
        end
        if nBagsPos < 1 or nBagMaterial < 2 then
            self:notify_tips(selfId,"背包空间不足")
            return
        end
        self:AddItemListToHuman(selfId)

        self:SetMissionDataEx(selfId,151,self:GetDayTime())
        self:notify_tips(selfId,"恭喜您，成功领取10张1000绑定元宝票。")
        self:notify_tips(selfId,"恭喜您，成功领取5个3级棉布。")
        self:notify_tips(selfId,"恭喜您，成功领取5个3级秘银。")
        self:notify_tips(selfId,"恭喜您，成功领取2个经验大还丹。")
    end
    if index == 60000 then
        local nFlag = self:GetMissionDataEx(selfId,139)
        if nFlag > 0 then
            self:notify_tips(selfId,"每位玩家只可以补领一次飞蝗石。")
            return
        end
        self:BeginAddItem()
        self:AddItem(10155004, 1, true)
        local ret = self:EndAddItem(selfId)
        if not ret then
            self:notify_tips(selfId,"请保证背包道具栏有一个空位。")
            return 
        end
        self:AddItemListToHuman(selfId)
        self:notify_tips(selfId,"你获得了1个暗器：飞蝗石，请查看背包！")
        self:SetMissionDataEx(selfId,139,self:GetDayTime())
    end
    local PlayerName = self:GetName(selfId)
    if index == 70000 then
        local YuanXiaoMoney = YuanXiaoRechage_NameList[PlayerName] or self:GetYuanXiaoExchange(selfId)
        self:ShowYuanXiaoGiftContent(selfId, YuanXiaoMoney, targetId)
		return
    end
    if index == 70001 then
        local YuanXiaoMoney = YuanXiaoRechage_NameList[PlayerName] or self:GetYuanXiaoExchange(selfId)
        self:GetwYuanXiaoGiftAward(selfId, YuanXiaoMoney, targetId)
		return
    end
end

function odali_xinshoutian:GetYuanXiaoExchange(selfId)
    local guid = self:LuaFnGetGUID(selfId)
    local skynet = require "skynet"
    local pipeline = {}
    local query_tbl = {["guid"] = guid, ["time"] = {["$gte"] = 1708704000, ["$lt"] = 1708876800}}
	local step = {["$group"] = {_id = false, ["total"] = {["$sum"] = "$cost"}}}
    table.insert(pipeline, {["$match"] = query_tbl})
    table.insert(pipeline, step)
    local coll_name = "toppoint_cost"
    local result = skynet.call(".char_db", "lua", "runCommand", "aggregate",  coll_name, "pipeline", pipeline, "cursor", {},  "allowDiskUse", false)
    if result and result.ok == 1 then
        if result.cursor and result.cursor.firstBatch then
            local r = result.cursor.firstBatch[1]
            if r then
				return r["total"] // 300
            end
        end
    end
	return 0
end

function odali_xinshoutian:ShowYuanXiaoGiftContent(selfId, Money, targetId)
	local val = self:GetMissionDataEx(selfId, ScriptGlobal.MDEX_YUANXIAOHUIKUI_2024)
	if val ~= 0 then
		self:BeginEvent(self.script_id)
		self:AddText("元宵奖励已领取")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local gift_config = self:GetYuanXiaoGiftContent(Money)
	if gift_config == nil then
		self:BeginEvent(self.script_id)
		self:AddText(string.format("您当前元宵充值数额为%d元, 没有礼包可以领取", Money))
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local prize = gift_config.prize
	self:BeginEvent(self.script_id)
	local content = "您当前可以领取的元宵礼包内容为:"
	self:AddText(content)
	for _, p in ipairs(prize) do
        if p.itemid then
            local item_name = self:GetItemName(p.itemid)
            if p.soul_level then
                self:AddText(item_name .. " " .. p.soul_level + 1 .. "阶 X" .. p.num)
            else
                self:AddText(item_name .. "X" .. p.num)
            end
        end
	end
	self:AddText("元宵礼包只能领取1个")
	self:AddNumText("确认领取",6, 70001)
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_xinshoutian:GetwYuanXiaoGiftAward(selfId, Money, targetId)
	local val = self:GetMissionDataEx(selfId, ScriptGlobal.MDEX_YUANXIAOHUIKUI_2024)
	if val ~= 0 then
		self:BeginEvent(self.script_id)
		self:AddText("元宵奖励已领取")
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local gift_config = self:GetYuanXiaoGiftContent(Money)
	if gift_config == nil then
		self:BeginEvent(self.script_id)
		self:AddText(string.format("您当前元宵充值数额为%d元, 没有礼包可以领取", Money))
		self:EndEvent()
		self:DispatchEventList(selfId,targetId)
		return
	end
	local material_count = self:LuaFnGetMaterialBagSpace(selfId)
	local prop_count = self:LuaFnGetPropertyBagSpace(selfId)
	if prop_count < 30 then
		self:notify_tips( selfId, "道具栏请保证30格以上空间" )
		return
	end
	if material_count < 10 then
		self:notify_tips( selfId, "材料栏请保证10格以上空间" )
		return
	end
	self:SetMissionDataEx(selfId, ScriptGlobal.MDEX_YUANXIAOHUIKUI_2024, 1)
	self:BeginAddItem()
	local pet_soul_level
	for i,item in pairs(gift_config.prize) do
        if item.title_id then
            if not self:LuaFnHaveAgname(selfId, item.title_id) then
                self:LuaFnAddNewAgname(selfId, item.title_id)
            end
        else
            self:AddItem(item.itemid, item.num, true)
            if item.soul_level then
                pet_soul_level = item.soul_level
            end
        end
	end
	if not self:EndAddItem(selfId) then
		self:NotifyTips( selfId, "背包空间不足" )
		return
	end
	self:AddItemListToHuman(selfId)
	if pet_soul_level then
		local BagPos = self:GetBagPosByItemSn(selfId, 70600015)
		self:SetPetSoulLevel(selfId, BagPos, pet_soul_level)
	end
	self:BeginEvent(self.script_id)
	self:AddText("元宵奖励领取成功")
	self:EndEvent()
	self:DispatchEventList(selfId,targetId)
end

function odali_xinshoutian:GetYuanXiaoGiftContent(nPreMoney)
	for i = #YuanXiao_Gift, 1, -1 do
		local gift = YuanXiao_Gift[i]
		if gift.money <= nPreMoney then
            return gift
		end
	end
end

function odali_xinshoutian:SetPetSoulLevel(selfId, BagPos, level)
	local human = self:get_scene():get_obj_by_id(selfId)
	local prop_bag_container = human:get_prop_bag_container()
	local item = prop_bag_container:get_item(BagPos)
	item:get_pet_equip_data():set_pet_soul_level(level)
	self:LuaFnRefreshItemInfo(selfId, BagPos)
end

function odali_xinshoutian:OnMissionAccept(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            local ret = self:CallScriptFunction(missionScriptId, "CheckAccept", selfId)
            if ret > 0 then
                self:CallScriptFunction(missionScriptId, "OnAccept", selfId)
            end
            return
        end
    end
end

function odali_xinshoutian:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function odali_xinshoutian:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function odali_xinshoutian:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

function odali_xinshoutian:OnDie(selfId, killerId)
end

function odali_xinshoutian:OnCharacterTimer(selfId, dataId, nowtime)
end

return odali_xinshoutian
