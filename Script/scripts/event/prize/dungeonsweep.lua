local ScriptGlobal = require "scripts.ScriptGlobal"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local dungeonsweep = class("dungeonsweep", script_base)
dungeonsweep.dungeons = {
    { name = "一个都不能跑", cost_sweep_point = 6, cost_money = 50000, script_id = 050100, day_count = 5, seck_num_up_limit = 120, require_level = 30 },
    { name = "除害", cost_sweep_point = 6, cost_money = 50000, script_id = 050101, day_count = 5, seck_num_up_limit = 120, require_level = 30 },
    { name = "剿匪", cost_sweep_point = 6, cost_money = 150000, script_id = 050102, day_count = 5, week_active = 10, seck_num_up_limit = 120, require_level = 30 },
    { name = "黄金之链", cost_sweep_point = 6, cost_money = 50000, script_id = 050220, day_count = 5, seck_num_up_limit = 120, require_level = 75 },
    { name = "玄佛珠", cost_sweep_point = 6, cost_money = 50000, script_id = 050221, day_count = 5, seck_num_up_limit = 120, require_level = 75},
    { name = "熔岩之地", cost_sweep_point = 6, cost_money = 150000, script_id = 050222, day_count = 5, week_active = 11, seck_num_up_limit = 120, require_level = 75 },
    { name = "讨伐燕子坞", cost_sweep_point = 8, boss_id = { 9320, 9380, 9430},cost_money = 200000, script_id = 401040, day_count = 3, week_active = 12, seck_num_up_limit = 80, require_level = 60 },
    --{ name = "杀星", cost_sweep_point = 8, boss_id = { 13434,13443, 13461, 13479,13524,13488},cost_money = 200000, script_id = 892009, day_count = 2, week_active = 15 },
    { name = "杀星", cost_sweep_point = 8, boss_id = { 13550,13550, 13550, 13550,13550,13550},cost_money = 200000, script_id = 892009, day_count = 2, week_active = 15, seck_num_up_limit = 80, require_level = 70 },
    { name = "初战飘渺峰", cost_sweep_point = 8, boss_id = { 9660, 9661, 9663, 9667, 9666}, script_id = 402276, day_count = 2, week_active = 13, seck_num_up_limit = 80, require_level = 75 },
    { name = "挑战飘渺峰", cost_sweep_point = 8, boss_id = { 9540, 9541, 9543, 9547, 9546}, script_id = 402263, day_count = 3, week_active = 14, seck_num_up_limit = 80, require_level = 90 },
    { name = "水月山庄", cost_sweep_point = 8, boss_id = {48504, 48510, 48517, 48521},cost_money = 200000, script_id = 892328, day_count = 2, week_active = 16, seck_num_up_limit = 80, require_level = 80},
    { name = "青丘试炼-普通", cost_sweep_point = 8, boss_id = {49713, 49715, 49717, 49719}, script_id = 893020, day_count = 2, week_active = 30, seck_num_up_limit = 80, require_level = 85},
    { name = "青丘试炼-困难", cost_sweep_point = 8, boss_id = {49735, 49737, 49739, 49741}, script_id = 893020, day_count = 1, week_active = 31, seck_num_up_limit = 80, require_level = 85},
}
dungeonsweep.double_exp_cost_yuanbao = 5
local g_SweepAll_SeckillTequanDayCount = 943
function dungeonsweep:OpenTeQuan(selfId, request_type)
    if request_type == 0 then
        self:BeginUICommand()
        self:UICommand_AddInt(0)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 20221115)
    elseif request_type == 1 then
        local ItemIndex = 38000206
        if self:LuaFnGetAvailableItemCount(selfId, ItemIndex) > 0 then
            self:LuaFnDelAvailableItem(selfId, ItemIndex, 1)
            self:notify_tips(selfId, "#{TQJF_221108_22}")
            self:BeginUICommand()
            self:UICommand_AddInt(0)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 89106202)

            self:SetMissionFlag(selfId, ScriptGlobal.MF_SWEEP_ALL_MONTH_CARD, 1)
            local time = self:TransferNowTime()
            self:SetMissionData(selfId, ScriptGlobal.MD_SweepAll_SeckillTequanData, time)
        else
            self:notify_tips(selfId, "#{TQJF_221108_43}")
            local index, merchadise = self:GetMerchadiseByItemIndex(selfId, ItemIndex)
            if index == nil then
                return
            end
            self:BeginUICommand()
            self:UICommand_AddInt(10)
            self:UICommand_AddInt(5)
            self:UICommand_AddInt(merchadise.price)
            self:UICommand_AddInt(index - 1)
            self:UICommand_AddInt(0)
            self:UICommand_AddInt(self.script_id)
            self:UICommand_AddInt(1)
            self:UICommand_AddInt(1245183)
            local str = self:ContactArgs("#{TQJF_221108_44", ItemIndex, merchadise.price, "#{XFYH_20120221_10}", "#{XFYH_20120221_12", ItemIndex) .. "}"
            self:UICommand_AddStr(str)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 89106201)
        end
    elseif request_type == 2 then
        local ItemIndex = 38000207
        if self:LuaFnGetAvailableItemCount(selfId, ItemIndex) > 0 then
            self:LuaFnDelAvailableItem(selfId, ItemIndex, 1)
            self:notify_tips(selfId, "#{TQJF_221108_23}")
            self:BeginUICommand()
            self:UICommand_AddInt(0)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 89106202)

            self:SetMissionFlag(selfId, ScriptGlobal.MF_SWEEP_ALL_DAY_CARD, 1)
        else
            self:notify_tips(selfId, "#{TQJF_221108_42}")
            local index, merchadise = self:GetMerchadiseByItemIndex(selfId, ItemIndex)
            if index == nil then
                return
            end
            self:BeginUICommand()
            self:UICommand_AddInt(10)
            self:UICommand_AddInt(5)
            self:UICommand_AddInt(merchadise.price)
            self:UICommand_AddInt(index - 1)
            self:UICommand_AddInt(0)
            self:UICommand_AddInt(self.script_id)
            self:UICommand_AddInt(1)
            self:UICommand_AddInt(1245183)
            local str = self:ContactArgs("#{TQJF_221108_44", ItemIndex, merchadise.price, "#{XFYH_20120221_10}", "#{XFYH_20120221_12", ItemIndex) .. "}"
            self:UICommand_AddStr(str)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 89106201)
        end
    end
end

function dungeonsweep:OpenSecKillPage(selfId, index, sweep_type)
	if not index or index < 0
	or not sweep_type then
		return
	end
    index = index + 1
    local sweep_config = self.dungeons[index]
    if sweep_config == nil then
        self:notify_tips(selfId, "该副本尚未开放扫荡")
    end
    local count = self:GetCampaignCount(selfId, index)
    if count >= sweep_config.day_count and not self:CanContinueSweep(selfId, index) then
        self:notify_tips(selfId, "#{SDYH_170110_06}")
        return
    end
    self:BeginUICommand()
    self:UICommand_AddInt(index)
    self:UICommand_AddInt(sweep_type)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 20150212)
end

function dungeonsweep:OnFuBenSecKill(selfId, index, boss_id, double_exp, _, sweep_type)
    index = index
    boss_id = boss_id
    local sweep_config = self.dungeons[index]
    if sweep_config == nil then
        self:notify_tips(selfId, "该副本尚未开放扫荡")
    end
    if not self:CheckCanSweep(selfId, index, boss_id, sweep_config) then
        return
    end
    if boss_id == 1 then
        if sweep_type == 0 then
            local sweep_point = self:GetSweepCount(selfId, index)
            if sweep_point < sweep_config.cost_sweep_point then
                self:notify_tips(selfId, "扫荡点不足")
                return
            end
            self:CostSweepPoint(selfId, index, sweep_config.cost_sweep_point)
        elseif sweep_type == 1 or sweep_type == 3 then
            if sweep_config.cost_money == nil then
                self:notify_tips(selfId, "该副本不能金币扫荡")
                return
            end
            local my_money = self:GetMoney(selfId)
            if my_money < sweep_config.cost_money then
                self:notify_tips(selfId, "金币不足")
                return
            end
            if sweep_config.cost_money ~= nil then
                self:CostMoney(selfId, sweep_config.cost_money)
            end
        elseif sweep_type == 2 then
            local time = self:GetMissionData(selfId, ScriptGlobal.MD_SweepAll_SeckillTequanData)
            time = self:DeTransferNowTime(time) + 30 * 24 * 60 * 60
            local now = os.time()
            if time < now then
                self:notify_tips(selfId, "征龙令已过期")
                return
            end
            local value = self:GetMissionData(selfId, g_SweepAll_SeckillTequanDayCount)
            if value > 2 then
                self:notify_tips(selfId, "异常扫荡2")
                return
            end
            if self:GetCampaignCount(selfId, index) == 0 and boss_id == 1 then
                value = value + 1
                self:SetMissionData(selfId, g_SweepAll_SeckillTequanDayCount, value)
            end
        else
            self:notify_tips(selfId, "未知扫荡方式")
            return
        end
        if double_exp == 1 then
            if self:GetYuanBao(selfId) < self.double_exp_cost_yuanbao then
                self:notify_tips(selfId, "元宝不足")
                return
            end
            self:LuaFnCostYuanBao(selfId, 5)
        end
    end
    local sec_kill_data, award_exp = self:GenSecKillData(selfId, index, boss_id)
    if double_exp == 1 then
        award_exp = award_exp * 2
    end
    self:AddExp(selfId, award_exp)
    self:SetSecKillData(selfId, sec_kill_data)
    if boss_id == 1 then
        self:DungeonDone(selfId, index)
        if sweep_config.week_active then
            self:LuaFnAddMissionHuoYueZhi(selfId, sweep_config.week_active)
        end
    end
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 0)
end

function dungeonsweep:GetSecKillData(selfId)
    local human = self:get_scene():get_obj_by_id(selfId)
    return human.dungeonsweep.sec_kill_data
end

function dungeonsweep:CheckCanSweep(selfId, fuben_index, boss_id, sweep_config)
    local sec_kill_data = self:GetSecKillData(selfId)
    local campaign_count = self:GetCampaignCount(selfId, fuben_index)
    if boss_id == 1 and campaign_count >= sweep_config.day_count then
        self:notify_tips(selfId, "扫荡次数已达上限")
        return false
    end
    if sec_kill_data.fuben_index == nil then
        if boss_id ~= 1 then
            self:notify_tips(selfId, "异常请求0")
            return false
        end
    end
    if (sec_kill_data.fuben_index and sec_kill_data.fuben_index + 1 == fuben_index) then
        if boss_id ~= 1 and boss_id <= sec_kill_data.boss_id then
            self:notify_tips(selfId, "该boss已扫荡")
            return false
        end
    else
        if boss_id ~= 1 then
            self:notify_tips(selfId, "异常请求4")
            return false
        end
    end
    if sweep_config.boss_id == nil then
        if boss_id ~= 1 then
            self:notify_tips(selfId, "异常请求1")
            return false
        end
    else
        if sweep_config.boss_id[boss_id] == nil then
            self:notify_tips(selfId, "异常请求2")
            return false
        end
    end
    local level = self:GetCharacterLevel(selfId)
    if level < sweep_config.require_level then
        self:notify_tips(selfId, "异常请求3")
        return false
    end
    return true
end

function dungeonsweep:OnContinueFuBenSecKill(selfId, index, sweep_type)
    local sweep_config = self.dungeons[index]
    if sweep_config == nil then
        self:notify_tips(selfId, "该副本尚未开放扫荡")
    end
    local count = self:GetCampaignCount(selfId, index)
    if count >= sweep_config.day_count and not self:CanContinueSweep(selfId, index) then
        self:notify_tips(selfId, "#{SDYH_170110_06}")
        return
    end
    self:BeginUICommand()
    self:UICommand_AddInt(index)
    self:UICommand_AddInt(sweep_type)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 20150212)
end

function dungeonsweep:GenSecKillData(selfId, index, boss_id)
    local data = { boss_id = 0, fuben_index = 0 }
    local dungeon = self.dungeons[index]
    local boss_data_index
    local drop_items
    local award_exp
    local selfLevel = self:GetLevel(selfId)
    selfLevel = math.floor(selfLevel/10)
    local monsterinfo = {0,1,2,3,4,5,6,7,8,9,30000}
    if type(dungeon.boss_id) == "table" then
        if dungeon.name == "讨伐燕子坞" then
            boss_data_index = dungeon.boss_id[boss_id] + monsterinfo[selfLevel]
        else
            boss_data_index = dungeon.boss_id[boss_id]
        end
        data.boss_id = boss_id
        data.fuben_index = index - 1
        data.have_next = boss_id < #dungeon.boss_id and 1 or 0
        drop_items = self:CalMonsterDropItems(boss_data_index)
        award_exp = self:CalMonsterAwardExp(boss_data_index)
        if boss_id == 1 then
            self:CallScriptFunction(dungeon.script_id, "CalSweepData", selfId, index, boss_id)
        end
    else
        data.have_next = 0
        drop_items, award_exp = self:CallScriptFunction(dungeon.script_id, "CalSweepData", selfId)
    end
    data.item_list = drop_items
    for i, item in ipairs(data.item_list) do
        item.index = i - 1
    end
    return data, award_exp
end

function dungeonsweep:CanContinueSweep(selfId, index)
    local human = self:get_scene():get_obj_by_id(selfId)
    local data = human.dungeonsweep.sec_kill_data
    if data == nil then
        return false
    end
    return (data.fuben_index == index - 1) and data.have_next == 1
end

function dungeonsweep:OnScenePlayerEnter(selfId)
    for i, config in ipairs(self.dungeons) do
        local sweep_point = self:GetSweepCount(selfId, i)
        sweep_point = sweep_point > config.seck_num_up_limit and config.seck_num_up_limit or sweep_point
        self:SetSweepCount(selfId, i, sweep_point)
    end
end

return dungeonsweep