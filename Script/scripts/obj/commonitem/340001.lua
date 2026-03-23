local class = require "class"
local define = require "define"
local script_base = require "script_base"
local common_item = class("common_item", script_base)

function common_item:IsSkillLikeScript()
    return 1
end

function common_item:CancelImpacts()
    return 0
end

local dests = {
    [0] = { sceneid = 9, x = 93, y = 72},
    [1] = { sceneid = 11, x = 106, y = 59},
    [2] = { sceneid = 10, x = 91, y = 100},
    [3] = { sceneid = 12, x = 80, y = 87},
    [4] = { sceneid = 15, x = 96, y = 48},
    [5] = { sceneid = 16, x = 86, y = 73},
    [6] = { sceneid = 13, x = 96, y = 88},
    [7] = { sceneid = 17, x = 89, y = 47},
    [8] = { sceneid = 14, x = 122, y = 141},
    [10] = { sceneid = 184, x = 129, y = 106},
	[11] = { sceneid = 1063, x = 125, y = 152},
}

function common_item:OnConditionCheck(selfId)
    if not self:LuaFnVerifyUsedItem(selfId) then
		return 0
	end
    local menpai = self:GetMenPai(selfId)
    local dest = dests[menpai]
    if dest == nil then
        self:notify_tips(selfId, "没有加入门派，不能使用此物品")
        return 0
    end
    return 1
end

function common_item:OnDeplete(selfId)
    return self:LuaFnDepletingUsedItem(selfId)
end

function common_item:OnActivateOnce(selfId)
    local menpai = self:GetMenPai(selfId)
    local dest = dests[menpai]
    local sceneid = self.scene:get_id()
    if sceneid == dest.sceneid then
        self:TelePort(selfId, dest.x, dest.y)
    else
        self:CallScriptFunction((400900), "TransferFunc", selfId, dest.sceneid, dest.x, dest.y)
    end
    return 1
end

return common_item