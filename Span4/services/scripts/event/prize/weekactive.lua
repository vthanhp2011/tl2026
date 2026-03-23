local class = require "class"
local define = require "define"
local script_base = require "script_base"
local weekactive = class("weekactive", script_base)
local g_ZhouHuoYueItemId = {
	[1] = {item = 30900006, num = 10},
	[2] = {item = 38008021, num = 1},
	[3] = {item = 30503133, num = 10},
	[4] = {item = 38008021, num = 1},
	[5] = {item = 20310168, num = 50},
	[6] = {item = 38008021, num = 1},
	[7] = {item = 30502002, num = 20},
	[8] = {item = 38008021, num = 1},
	[9] = {item = 20502003, num = 3},
	[10] = {item = 38008002, num = 1},
	[11] = {item = 20501003, num = 3},
	[12] = {item = 38008002, num = 1},
	[13] = {item = 50413004, num = 1},
	[14] = {item = 38008002, num = 1},
	[15] = {item = 20310168, num = 100},
	[16] = {item = 38008005, num = 1},
	[17] = {item = 20800013, num = 50},
	[18] = {item = 38008005, num = 1},
	[19] = {item = 38002221, num = 5},
	[20] = {item = 38008005, num = 2},
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