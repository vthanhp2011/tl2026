local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local gp_diaoyu = class("gp_diaoyu", script_base)
gp_diaoyu.script_id = 712000
gp_diaoyu.g_AbilityId = define.ABILITY_DIAOYU
gp_diaoyu.g_RandNum = 1000000
gp_diaoyu.g_GPInfo = {}

gp_diaoyu.g_rare = {
    [1] = {["Id"] = 20103106, ["Name"] = "个丝线[1级]", ["Odds"] = 40000},
    [2] = {["Id"] = 20103107, ["Name"] = "个丝线[2级]", ["Odds"] = 35000},
    [3] = {["Id"] = 20103108, ["Name"] = "个丝线[3级]", ["Odds"] = 30000},
    [4] = {["Id"] = 20103109, ["Name"] = "个染料[1级]", ["Odds"] = 4000},
    [5] = {["Id"] = 20103110, ["Name"] = "个染料[2级]", ["Odds"] = 3500},
    [6] = {["Id"] = 20103111, ["Name"] = "个染料[3级]", ["Odds"] = 3000},
    [7] = {["Id"] = 20102025, ["Name"] = "只花蛤", ["Odds"] = 25000},
    [8] = {["Id"] = 20102026, ["Name"] = "棵紫菜", ["Odds"] = 25000},
    [9] = {["Id"] = 20102027, ["Name"] = "只白虾", ["Odds"] = 25000},
    [10] = {["Id"] = 20102028, ["Name"] = "只龙虾", ["Odds"] = 10000},
    [11] = {["Id"] = 20102029, ["Name"] = "只青蟹", ["Odds"] = 10000},
    [12] = {["Id"] = 20102030, ["Name"] = "只文蛤", ["Odds"] = 10000},
    [13] = {["Id"] = 20102031, ["Name"] = "只贻贝", ["Odds"] = 4000},
    [14] = {["Id"] = 20102032, ["Name"] = "只对虾", ["Odds"] = 4000},
    [15] = {["Id"] = 20102033, ["Name"] = "只杂色蛤", ["Odds"] = 4000},
    [16] = {["Id"] = 20102034, ["Name"] = "只河蚌", ["Odds"] = 4000},
    [17] = {["Id"] = 20102035, ["Name"] = "只蛙蟹", ["Odds"] = 4000},
    [18] = {["Id"] = 20102036, ["Name"] = "只玉蟹", ["Odds"] = 4000},
    [19] = {["Id"] = 20102048, ["Name"] = "只盐壳蚌", ["Odds"] = 4000},
    [20] = {["Id"] = 20102049, ["Name"] = "朵孢子尘", ["Odds"] = 4000},
    [21] = {["Id"] = 20102050, ["Name"] = "棵裸藻", ["Odds"] = 4000},
    [22] = {["Id"] = 20102051, ["Name"] = "只蠃母", ["Odds"] = 4000},
    [23] = {["Id"] = 20102078, ["Name"] = "河蚬", ["Odds"] = 50000},
    [24] = {["Id"] = 20102080, ["Name"] = "青苔", ["Odds"] = 50000}
}

gp_diaoyu.g_GPInfo[201] = {
    ["name"] = "草鱼",
    ["mainId"] = 20102001,
    ["rareId"] = {1, 4, 7},
    ["needLevel"] = 1
}

gp_diaoyu.g_GPInfo[202] = {
    ["name"] = "鲫鱼",
    ["mainId"] = 20102002,
    ["rareId"] = {1, 4, 8},
    ["needLevel"] = 2
}

gp_diaoyu.g_GPInfo[203] = {
    ["name"] = "鲢鱼",
    ["mainId"] = 20102003,
    ["rareId"] = {1, 4, 9},
    ["needLevel"] = 3
}

gp_diaoyu.g_GPInfo[204] = {
    ["name"] = "平鱼",
    ["mainId"] = 20102004,
    ["rareId"] = {2, 5, 10},
    ["needLevel"] = 4
}

gp_diaoyu.g_GPInfo[205] = {
    ["name"] = "鳝鱼",
    ["mainId"] = 20102005,
    ["rareId"] = {2, 5, 11},
    ["needLevel"] = 5
}

gp_diaoyu.g_GPInfo[206] = {
    ["name"] = "黑鱼",
    ["mainId"] = 20102006,
    ["rareId"] = {2, 5, 12},
    ["needLevel"] = 6
}

gp_diaoyu.g_GPInfo[207] = {
    ["name"] = "斗鱼",
    ["mainId"] = 20102007,
    ["rareId"] = {3, 6, 13},
    ["needLevel"] = 7
}

gp_diaoyu.g_GPInfo[208] = {
    ["name"] = "鲳鱼",
    ["mainId"] = 20102008,
    ["rareId"] = {3, 6, 14},
    ["needLevel"] = 8
}

gp_diaoyu.g_GPInfo[209] = {
    ["name"] = "银鱼",
    ["mainId"] = 20102009,
    ["rareId"] = {3, 6, 15},
    ["needLevel"] = 9
}

gp_diaoyu.g_GPInfo[210] = {
    ["name"] = "鲑鱼",
    ["mainId"] = 20102010,
    ["rareId"] = {3, 6, 16},
    ["needLevel"] = 10
}

gp_diaoyu.g_GPInfo[211] = {
    ["name"] = "骨舌鱼",
    ["mainId"] = 20102011,
    ["rareId"] = {3, 6, 17},
    ["needLevel"] = 11
}

gp_diaoyu.g_GPInfo[212] = {
    ["name"] = "六线鱼",
    ["mainId"] = 20102012,
    ["rareId"] = {3, 6, 18},
    ["needLevel"] = 12
}

gp_diaoyu.g_GPInfo[213] = {
    ["name"] = "青鱼",
    ["mainId"] = 20102013,
    ["rareId"] = {1, 4, 7},
    ["needLevel"] = 1
}

gp_diaoyu.g_GPInfo[214] = {
    ["name"] = "箭鱼",
    ["mainId"] = 20102014,
    ["rareId"] = {1, 4, 8},
    ["needLevel"] = 2
}

gp_diaoyu.g_GPInfo[215] = {
    ["name"] = "鲈鱼",
    ["mainId"] = 20102015,
    ["rareId"] = {1, 4, 9},
    ["needLevel"] = 3
}

gp_diaoyu.g_GPInfo[216] = {
    ["name"] = "扁头鱼",
    ["mainId"] = 20102016,
    ["rareId"] = {2, 5, 10},
    ["needLevel"] = 4
}

gp_diaoyu.g_GPInfo[217] = {
    ["name"] = "油力鱼",
    ["mainId"] = 20102017,
    ["rareId"] = {2, 5, 11},
    ["needLevel"] = 5
}

gp_diaoyu.g_GPInfo[218] = {
    ["name"] = "秋刀鱼",
    ["mainId"] = 20102018,
    ["rareId"] = {2, 5, 12},
    ["needLevel"] = 6
}

gp_diaoyu.g_GPInfo[219] = {
    ["name"] = "梭鱼",
    ["mainId"] = 20102019,
    ["rareId"] = {3, 6, 13},
    ["needLevel"] = 7
}

gp_diaoyu.g_GPInfo[220] = {
    ["name"] = "光背鱼",
    ["mainId"] = 20102020,
    ["rareId"] = {3, 6, 14},
    ["needLevel"] = 8
}

gp_diaoyu.g_GPInfo[221] = {
    ["name"] = "钩鱼",
    ["mainId"] = 20102021,
    ["rareId"] = {3, 6, 15},
    ["needLevel"] = 9
}

gp_diaoyu.g_GPInfo[222] = {
    ["name"] = "摆鳍鱼",
    ["mainId"] = 20102022,
    ["rareId"] = {3, 6, 16},
    ["needLevel"] = 10
}

gp_diaoyu.g_GPInfo[223] = {
    ["name"] = "珍珠鱼",
    ["mainId"] = 20102023,
    ["rareId"] = {3, 6, 17},
    ["needLevel"] = 11
}

gp_diaoyu.g_GPInfo[224] = {
    ["name"] = "文昌鱼",
    ["mainId"] = 20102024,
    ["rareId"] = {3, 6, 18},
    ["needLevel"] = 12
}

gp_diaoyu.g_GPInfo[225] = {
    ["name"] = "草鱼",
    ["mainId"] = 20102001,
    ["rareId"] = {1, 4, 7},
    ["needLevel"] = 1
}

gp_diaoyu.g_GPInfo[226] = {
    ["name"] = "鲫鱼",
    ["mainId"] = 20102002,
    ["rareId"] = {1, 4, 8},
    ["needLevel"] = 2
}

gp_diaoyu.g_GPInfo[227] = {
    ["name"] = "鲢鱼",
    ["mainId"] = 20102003,
    ["rareId"] = {1, 4, 9},
    ["needLevel"] = 3
}

gp_diaoyu.g_GPInfo[228] = {
    ["name"] = "平鱼",
    ["mainId"] = 20102004,
    ["rareId"] = {2, 5, 10},
    ["needLevel"] = 4
}

gp_diaoyu.g_GPInfo[229] = {
    ["name"] = "鳝鱼",
    ["mainId"] = 20102005,
    ["rareId"] = {2, 5, 11},
    ["needLevel"] = 5
}

gp_diaoyu.g_GPInfo[230] = {
    ["name"] = "黑鱼",
    ["mainId"] = 20102006,
    ["rareId"] = {2, 5, 12},
    ["needLevel"] = 6
}

gp_diaoyu.g_GPInfo[231] = {
    ["name"] = "斗鱼",
    ["mainId"] = 20102007,
    ["rareId"] = {3, 6, 13},
    ["needLevel"] = 7
}

gp_diaoyu.g_GPInfo[232] = {
    ["name"] = "鲳鱼",
    ["mainId"] = 20102008,
    ["rareId"] = {3, 6, 14},
    ["needLevel"] = 8
}

gp_diaoyu.g_GPInfo[233] = {
    ["name"] = "银鱼",
    ["mainId"] = 20102009,
    ["rareId"] = {3, 6, 15},
    ["needLevel"] = 9
}

gp_diaoyu.g_GPInfo[234] = {
    ["name"] = "鲑鱼",
    ["mainId"] = 20102010,
    ["rareId"] = {3, 6, 16},
    ["needLevel"] = 10
}

gp_diaoyu.g_GPInfo[235] = {
    ["name"] = "骨舌鱼",
    ["mainId"] = 20102011,
    ["rareId"] = {3, 6, 17},
    ["needLevel"] = 11
}

gp_diaoyu.g_GPInfo[236] = {
    ["name"] = "六线鱼",
    ["mainId"] = 20102012,
    ["rareId"] = {3, 6, 18},
    ["needLevel"] = 12
}

gp_diaoyu.g_GPInfo[237] = {
    ["name"] = "青鱼",
    ["mainId"] = 20102013,
    ["rareId"] = {1, 4, 7},
    ["needLevel"] = 1
}

gp_diaoyu.g_GPInfo[238] = {
    ["name"] = "箭鱼",
    ["mainId"] = 20102014,
    ["rareId"] = {1, 4, 8},
    ["needLevel"] = 2
}

gp_diaoyu.g_GPInfo[239] = {
    ["name"] = "鲈鱼",
    ["mainId"] = 20102015,
    ["rareId"] = {1, 4, 9},
    ["needLevel"] = 3
}

gp_diaoyu.g_GPInfo[240] = {
    ["name"] = "扁头鱼",
    ["mainId"] = 20102016,
    ["rareId"] = {2, 5, 10},
    ["needLevel"] = 4
}

gp_diaoyu.g_GPInfo[241] = {
    ["name"] = "油力鱼",
    ["mainId"] = 20102017,
    ["rareId"] = {2, 5, 11},
    ["needLevel"] = 5
}

gp_diaoyu.g_GPInfo[242] = {
    ["name"] = "秋刀鱼",
    ["mainId"] = 20102018,
    ["rareId"] = {2, 5, 12},
    ["needLevel"] = 6
}

gp_diaoyu.g_GPInfo[243] = {
    ["name"] = "梭鱼",
    ["mainId"] = 20102019,
    ["rareId"] = {3, 6, 13},
    ["needLevel"] = 7
}

gp_diaoyu.g_GPInfo[244] = {
    ["name"] = "光背鱼",
    ["mainId"] = 20102020,
    ["rareId"] = {3, 6, 14},
    ["needLevel"] = 8
}

gp_diaoyu.g_GPInfo[245] = {
    ["name"] = "钩鱼",
    ["mainId"] = 20102021,
    ["rareId"] = {3, 6, 15},
    ["needLevel"] = 9
}

gp_diaoyu.g_GPInfo[246] = {
    ["name"] = "摆鳍鱼",
    ["mainId"] = 20102022,
    ["rareId"] = {3, 6, 16},
    ["needLevel"] = 10
}

gp_diaoyu.g_GPInfo[247] = {
    ["name"] = "珍珠鱼",
    ["mainId"] = 20102023,
    ["rareId"] = {3, 6, 17},
    ["needLevel"] = 11
}

gp_diaoyu.g_GPInfo[248] = {
    ["name"] = "文昌鱼",
    ["mainId"] = 20102024,
    ["rareId"] = {3, 6, 18},
    ["needLevel"] = 12
}

gp_diaoyu.g_GPInfo[249] = {
    ["name"] = "胭脂鱼",
    ["mainId"] = 20102040,
    ["rareId"] = {3, 6, 19},
    ["needLevel"] = 9
}

gp_diaoyu.g_GPInfo[250] = {
    ["name"] = "七星鱼",
    ["mainId"] = 20102041,
    ["rareId"] = {3, 6, 20},
    ["needLevel"] = 10
}

gp_diaoyu.g_GPInfo[251] = {
    ["name"] = "长吻鱼",
    ["mainId"] = 20102042,
    ["rareId"] = {3, 6, 21},
    ["needLevel"] = 11
}

gp_diaoyu.g_GPInfo[252] = {
    ["name"] = "多鳍鱼",
    ["mainId"] = 20102043,
    ["rareId"] = {3, 6, 22},
    ["needLevel"] = 12
}

gp_diaoyu.g_GPInfo[253] = {
    ["name"] = "翘嘴红鲌",
    ["mainId"] = 20102044,
    ["rareId"] = {3, 6, 19},
    ["needLevel"] = 9
}

gp_diaoyu.g_GPInfo[254] = {
    ["name"] = "秋白鲑",
    ["mainId"] = 20102045,
    ["rareId"] = {3, 6, 20},
    ["needLevel"] = 10
}

gp_diaoyu.g_GPInfo[255] = {
    ["name"] = "蝶鳍鱼",
    ["mainId"] = 20102046,
    ["rareId"] = {3, 6, 21},
    ["needLevel"] = 11
}

gp_diaoyu.g_GPInfo[256] = {
    ["name"] = "文鳐鱼",
    ["mainId"] = 20102047,
    ["rareId"] = {3, 6, 22},
    ["needLevel"] = 12
}

gp_diaoyu.g_GPInfo[820] = {
    ["name"] = "清江鱼",
    ["mainId"] = 20102077,
    ["rareId"] = {3, 6, 23},
    ["needLevel"] = 10
}

gp_diaoyu.g_GPInfo[821] = {
    ["name"] = "黄鳝",
    ["mainId"] = 20102079,
    ["rareId"] = {3, 6, 24},
    ["needLevel"] = 10
}

gp_diaoyu.g_FishTime = {}
gp_diaoyu.g_FishTime[0] = {["time"] = 31000, ["rand"] = 10000}
gp_diaoyu.g_FishTime[1] = {["time"] = 25000, ["rand"] = 10000}
gp_diaoyu.g_FishTime[2] = {["time"] = 20000, ["rand"] = 10000}
gp_diaoyu.g_FishTime[3] = {["time"] = 15000, ["rand"] = 10000}
gp_diaoyu.g_FishBaitImpactID = {19, 20, 21}
gp_diaoyu.g_TaiGongYuGan = 10100032
gp_diaoyu.g_impact_id = 77
function gp_diaoyu:OnCreate(growPointType, x, y)
    local ItemCount = 0
    self:ItemBoxEnterScene(x, y, growPointType, define.QUALITY_MUST_BE_CHANGE, ItemCount)
end

function gp_diaoyu:OnOpen(selfId, targetId)
    local growPointType = self:LuaFnGetItemBoxGrowPointType(targetId)
    local GPInfo = self.g_GPInfo[growPointType]
    if not GPInfo then
        return define.OPERATE_RESULT.OR_INVALID_TARGET
    end
    local AbilityLevel = self:QueryHumanAbilityLevel(selfId, self.g_AbilityId)
    if AbilityLevel < GPInfo["needLevel"] then
        self:NotifyFailTips(selfId, "需要钓鱼技能 " .. GPInfo["needLevel"] .. " 级，当前 " .. AbilityLevel .. " 级")
        return define.OPERATE_RESULT.OR_NO_LEVEL
    end
    local FishTime = self.g_FishTime[0]
    for i = 1, #(self.g_FishBaitImpactID) do
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, self.g_FishBaitImpactID[i]) then
            FishTime = self.g_FishTime[i]
            break
        end
    end
    self:SetAbilityOperaTime(selfId, (FishTime["time"] + math.random(FishTime["rand"])))
    return define.OPERATE_RESULT.OR_OK
end

function gp_diaoyu:OnProcOver(selfId, targetId)
    local growPointType = self:LuaFnGetItemBoxGrowPointType(targetId)
    local GPInfo = self.g_GPInfo[growPointType]
    if not GPInfo then
        return define.OPERATE_RESULT.OR_INVALID_TARGET
    end
    self:CallScriptFunction(define.ABILITYLOGIC_ID, "GainExperience", selfId, self.g_AbilityId, GPInfo["needLevel"])
    self:LuaFnAuditAbility(selfId, self.g_AbilityId, -1, -1)
    local ret1 = self:TryRecieveItem(selfId, GPInfo["mainId"], true)
    if ret1 then
        self:Msg2Player(selfId, "你钓到一条" .. GPInfo["name"] .. "。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    else
        self:Msg2Player(selfId, "你钓到一条" .. GPInfo["name"] .. "，但是背包已满，你随手把它扔到了一边。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    if
        self:LuaFnGetItemCount(selfId, self.g_TaiGongYuGan) > 0 and self:LuaFnGetHumanPKValue(selfId) < 1 and
            self:GetPlayerPvpMode(selfId) == 0
     then
        self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, self.g_impact_id, 0)
    end
    local rareNum = #(GPInfo["rareId"])
    if (rareNum < 0) then
        return define.OPERATE_RESULT.OR_OK
    end
    for i = 1, rareNum do
        local rareInfo = self.g_rare[GPInfo["rareId"][i]]
        if (not rareInfo) then
            return define.OPERATE_RESULT.OR_OK
        end
        if (math.random(self.g_RandNum) <= rareInfo["Odds"]) then
            local ret1 = self:TryRecieveItem(selfId, rareInfo["Id"], define.QUALITY_MUST_BE_CHANGE)
            if (ret1 > 0) then
                self:Msg2Player(selfId, "你钓到一" .. rareInfo["Name"] .. "。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            elseif (ret1 == -1) then
                self:Msg2Player(selfId, "你钓到一" .. rareInfo["Name"] .. "，但是背包已满，你随手把它扔到了一边。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            end
        end
    end
    return define.OPERATE_RESULT.OR_OK
end

function gp_diaoyu:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function gp_diaoyu:OnTickCreateFinish(growPointType, tickCount)
end

return gp_diaoyu
