local class = require "class"
local define = require "define"
local script_base = require "script_base"
local weekactive = class("weekactive", script_base)
local g_ZhouHuoYueItemId = {
	[1] = {item = 30008102, num = 10},
	[2] = {item = 30900045, num = 2},
	[3] = {item = 20502003, num = 10},
	[4] = {item = 20501003, num = 10},
	[5] = {item = 20500003, num = 5},
	[6] = {item = 20310167, num = 50},
	[7] = {item = 50613004, num = 1},
	[8] = {item = 30900016, num = 2},
	[9] = {item = 20800012, num = 50},
	[10] = {item = 38003055, num = 5},
	[11] = {item = 38008005, num = 5},
	[12] = {item = 38008005, num = 5},
	[13] = {item = 38008005, num = 5},
	[14] = {item = 38008005, num = 5},
	[15] = {item = 38008005, num = 10},
	[16] = {item = 38008005, num = 10},
	[17] = {item = 38008005, num = 20},
	[18] = {item = 38008005, num = 20},
	[19] = {item = 38008005, num = 30},
	[20] = {item = 38008005, num = 50},
}

local g_ProcessLimit = {
	[1] = {neednum = 200, itemspace = 2, materialspace = 0},
	[2] = {neednum = 400, itemspace = 2, materialspace = 0},
	[3] = {neednum = 600, itemspace = 1, materialspace = 1},
	[4] = {neednum = 800, itemspace = 2, materialspace = 0},
	[5] = {neednum = 1000, itemspace = 1, materialspace = 1},
	[6] = {neednum = 1200, itemspace = 1, materialspace = 1},
	[7] = {neednum = 1400, itemspace = 1, materialspace = 1},
	[8] = {neednum = 1600, itemspace = 1, materialspace = 1},
	[9] = {neednum = 1800, itemspace = 1, materialspace = 1},
	[10] = {neednum = 2000, itemspace = 2, materialspace = 0},
}
function weekactive:OpenUI(selfId)
    self:DispatchWeekActive(selfId)
end

function weekactive:AddHuoYueZhi(selfId, id)
    self:WeekActiveAddHuoYueZhi(selfId, id)
    self:DispatchWeekActive(selfId)
end

function weekactive:GetZhouHuoYueAward(selfId)
    local index = self:GetWeekActiveGetAwardIndex(selfId)
    index = index + 1
    local limit = g_ProcessLimit[index]
    local huoyue = self:GetWeekActiveHuoYue(selfId)
    if limit == nil then
        self:notify_tips(selfId, "已经全部领完")
        return
    end
    if huoyue < limit.neednum then
        self:notify_tips(selfId, "活跃值不足")
        return
    end
    local awards = { g_ZhouHuoYueItemId[2 * index - 1], g_ZhouHuoYueItemId[2 * index]}
    if #awards > 0 then
        for _, award in ipairs(awards) do
            self:TryRecieveItemWithCount(selfId, award.item, award.num,true)
        end
        self:SetWeekActiveGetAwardIndex(selfId, index)
        self:DispatchWeekActive(selfId)
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 149, 0)
    end
end

return weekactive