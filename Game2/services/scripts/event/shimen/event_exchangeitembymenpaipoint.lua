local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ScriptGlobal = require "scripts.ScriptGlobal"
local event_exchangeitembymenpaipoint = class("event_exchangeitembymenpaipoint", script_base)
event_exchangeitembymenpaipoint.script_id = 229009
event_exchangeitembymenpaipoint.g_ExchangeItem = "兑换物品"
event_exchangeitembymenpaipoint.g_ExchangeTitle = "兑换称号"
event_exchangeitembymenpaipoint.g_MissionInfo = "为了鼓励各位门下弟子将本门派发扬光大，为师特准备了一些奖品，使用#R400#W点门派贡献度即可兑换。"
event_exchangeitembymenpaipoint.g_MissionTarget = ""
event_exchangeitembymenpaipoint.g_ContinueInfo = ""
event_exchangeitembymenpaipoint.g_MissionComplete = ""
event_exchangeitembymenpaipoint.g_exchangeitembymenpaipoint_Index = 23
event_exchangeitembymenpaipoint.g_menpainpc_table =
{
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN,
        ["menpainame"] = "少林",
        ["name"] = "玄慈",
        ["title"] = "少林寺方丈",
        ["x"] = 38,
        ["z"] = 98
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO,
        ["menpainame"] = "明教",
        ["name"] = "林世长",
        ["title"] = "明教教主",
        ["x"] = 98,
        ["z"] = 52
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG,
        ["menpainame"] = "丐帮",
        ["name"] = "宋慈",
        ["title"] = "丐帮长老",
        ["x"] = 91,
        ["z"] = 63
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG,
        ["menpainame"] = "武当",
        ["name"] = "张玄素",
        ["title"] = "武当派掌门",
        ["x"] = 73,
        ["z"] = 82
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI,
        ["menpainame"] = "峨嵋",
        ["name"] = "孟青青",
        ["title"] = "峨嵋派掌门",
        ["x"] = 96,
        ["z"] = 73
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["menpainame"] = "天龙",
        ["name"] = "本因",
        ["title"] = "天龙寺方丈",
        ["x"] = 96,
        ["z"] = 66
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU,
        ["menpainame"] = "星宿",
        ["name"] = "丁春秋",
        ["title"] = "星宿派掌门",
        ["x"] = 142,
        ["z"] = 55
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN,
        ["menpainame"] = "天山",
        ["name"] = "梅剑",
        ["title"] = "天山派大师姐",
        ["x"] = 91,
        ["z"] = 44
    }
    ,
    {
        ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO,
        ["menpainame"] = "逍遥",
        ["name"] = "苏星河",
        ["title"] = "逍遥派代掌门",
        ["x"] = 125,
        ["z"] = 144
    }
    ,
    {
        ["menpaiid"] = ScriptGlobal.MP_MANTUO,
        ["menpainame"] = "曼陀山庄",
        ["name"] = "王夫人",
        ["title"] = "曼陀山庄庄主",
        ["x"] = 140,
        ["z"] = 75
    }
}
event_exchangeitembymenpaipoint.g_MaleTitleInfoA = {
    {
        ["tlvl"] = 1,
        ["mpp"] = 0,
        ["slt"] = 145,
        ["mjt"] = 153,
        ["gbt"] = 161,
        ["wdt"] = 169,
        ["emt"] = 177,
        ["xxt"] = 185,
        ["tlt"] = 193,
        ["tst"] = 201,
        ["xyt"] = 209,
        ["mtt"] = 376
    }
    ,
    {
        ["tlvl"] = 2,
        ["mpp"] = 1000,
        ["slt"] = 146,
        ["mjt"] = 154,
        ["gbt"] = 162,
        ["wdt"] = 170,
        ["emt"] = 178,
        ["xxt"] = 186,
        ["tlt"] = 194,
        ["tst"] = 202,
        ["xyt"] = 210,
        ["mtt"] = 377
    }
    ,
    {
        ["tlvl"] = 3,
        ["mpp"] = 2500,
        ["slt"] = 147,
        ["mjt"] = 155,
        ["gbt"] = 163,
        ["wdt"] = 171,
        ["emt"] = 179,
        ["xxt"] = 187,
        ["tlt"] = 195,
        ["tst"] = 203,
        ["xyt"] = 211,
        ["mtt"] = 378
    }
    ,
    {
        ["tlvl"] = 4,
        ["mpp"] = 5000,
        ["slt"] = 148,
        ["mjt"] = 156,
        ["gbt"] = 164,
        ["wdt"] = 172,
        ["emt"] = 180,
        ["xxt"] = 188,
        ["tlt"] = 196,
        ["tst"] = 204,
        ["xyt"] = 212,
        ["mtt"] = 379
    }
}
event_exchangeitembymenpaipoint.g_femaleTitleInfoA = {
    {
        ["tlvl"] = 1,
        ["mpp"] = 0,
        ["slt"] = 149,
        ["mjt"] = 157,
        ["gbt"] = 165,
        ["wdt"] = 173,
        ["emt"] = 181,
        ["xxt"] = 189,
        ["tlt"] = 197,
        ["tst"] = 205,
        ["xyt"] = 213,
        ["mtt"] = 380
    }
    ,
    {
        ["tlvl"] = 2,
        ["mpp"] = 1000,
        ["slt"] = 150,
        ["mjt"] = 158,
        ["gbt"] = 166,
        ["wdt"] = 174,
        ["emt"] = 182,
        ["xxt"] = 190,
        ["tlt"] = 198,
        ["tst"] = 206,
        ["xyt"] = 214,
        ["mtt"] = 381
    }
    ,
    {
        ["tlvl"] = 3,
        ["mpp"] = 2500,
        ["slt"] = 151,
        ["mjt"] = 159,
        ["gbt"] = 167,
        ["wdt"] = 175,
        ["emt"] = 183,
        ["xxt"] = 191,
        ["tlt"] = 199,
        ["tst"] = 207,
        ["xyt"] = 215,
        ["mtt"] = 382
    }
    ,
    {
        ["tlvl"] = 4,
        ["mpp"] = 5000,
        ["slt"] = 152,
        ["mjt"] = 160,
        ["gbt"] = 168,
        ["wdt"] = 176,
        ["emt"] = 184,
        ["xxt"] = 192,
        ["tlt"] = 200,
        ["tst"] = 208,
        ["xyt"] = 216,
        ["mtt"] = 383
    }
}
event_exchangeitembymenpaipoint.g_MaleTitleInfo = {
    {
        ["tlvl"] = 1,
        ["mpp"] = 0,
        ["slt"] = "少林侠士",
        ["mjt"] = "明教侠士",
        ["gbt"] = "丐帮侠士",
        ["wdt"] = "武当侠士",
        ["emt"] = "峨嵋侠士",
        ["xxt"] = "星宿侠士",
        ["tlt"] = "天龙侠士",
        ["tst"] = "天山侠士",
        ["xyt"] = "逍遥侠士",
        ["mtt"] = "曼陀侠士"
    }
    ,
    {
        ["tlvl"] = 2,
        ["mpp"] = 1000,
        ["slt"] = "灰衣护法",
        ["mjt"] = "侍火侠士",
        ["gbt"] = "青莲弟子",
        ["wdt"] = "青冥居士",
        ["emt"] = "清风居士",
        ["xxt"] = "行瘟郎君",
        ["tlt"] = "藏经侠士",
        ["tst"] = "阳天部众",
        ["xyt"] = "抚琴居士",
        ["mtt"] = "凝徽琴师"
    }
    ,
    {
        ["tlvl"] = 3,
        ["mpp"] = 2500,
        ["slt"] = "金身罗汉",
        ["mjt"] = "护教法王",
        ["gbt"] = "玄武长老",
        ["wdt"] = "无为真人",
        ["emt"] = "玉龙侠士",
        ["xxt"] = "催命判官",
        ["tlt"] = "崇圣天师",
        ["tst"] = "天山苍鹰",
        ["xyt"] = "洛神侠士",
        ["mtt"] = "拂晓琴宗"
    }
    ,
    {
        ["tlvl"] = 4,
        ["mpp"] = 5000,
        ["slt"] = "地藏菩萨",
        ["mjt"] = "光明神使",
        ["gbt"] = "掌棒龙头",
        ["wdt"] = "武当天尊",
        ["emt"] = "峨嵋仙人",
        ["xxt"] = "毒手医仙",
        ["tlt"] = "天南龙王",
        ["tst"] = "混元山神",
        ["xyt"] = "逍遥神龙",
        ["mtt"] = "渡情琴仙"
    }
}
event_exchangeitembymenpaipoint.g_femaleTitleInfo = {
    {
        ["tlvl"] = 1,
        ["mpp"] = 0,
        ["slt"] = "少林侠女",
        ["mjt"] = "明教侠女",
        ["gbt"] = "丐帮侠女",
        ["wdt"] = "武当侠女",
        ["emt"] = "峨嵋侠女",
        ["xxt"] = "星宿侠女",
        ["tlt"] = "天龙侠女",
        ["tst"] = "天山侠女",
        ["xyt"] = "逍遥侠女",
        ["mtt"] = "曼陀侠女"
    }
    ,
    {
        ["tlvl"] = 2,
        ["mpp"] = 1000,
        ["slt"] = "白衣侍者",
        ["mjt"] = "侍火侠女",
        ["gbt"] = "白莲弟子",
        ["wdt"] = "白云居士",
        ["emt"] = "明月居士",
        ["xxt"] = "行瘟娘子",
        ["tlt"] = "藏经侠女",
        ["tst"] = "昊天部众",
        ["xyt"] = "莳花居士",
        ["mtt"] = "聆韵琴师"
    }
    ,
    {
        ["tlvl"] = 3,
        ["mpp"] = 2500,
        ["slt"] = "渡世观音",
        ["mjt"] = "护教散人",
        ["gbt"] = "朱雀长老",
        ["wdt"] = "清静散人",
        ["emt"] = "金凤侠女",
        ["xxt"] = "夺命夜叉",
        ["tlt"] = "崇圣天女",
        ["tst"] = "天山雪雕",
        ["xyt"] = "淩波侠女",
        ["mtt"] = "清照琴宗"
    }
    ,
    {
        ["tlvl"] = 4,
        ["mpp"] = 5000,
        ["slt"] = "迦蓝菩萨",
        ["mjt"] = "光明圣女",
        ["gbt"] = "掌钵龙女",
        ["wdt"] = "武当仙子",
        ["emt"] = "峨嵋仙子",
        ["xxt"] = "毒手药王",
        ["tlt"] = "天南龙女",
        ["tst"] = "混元花神",
        ["xyt"] = "逍遥圣女",
        ["mtt"] = "观情琴仙"
    }
}
event_exchangeitembymenpaipoint.g_shimentitle_bonusitem = {
    { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN, ["bonusItem"] = 10113004 }
    , { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO, ["bonusItem"] = 10113004 }
, { ["menpaiid"] = ScriptGlobal.MP_MANTUO, ["bonusItem"] = 10113004 }
}
function event_exchangeitembymenpaipoint:OnDefaultEvent(selfId, targetId, arg, index)
    for i, v in pairs(self.g_menpainpc_table) do
        if v["name"] == self:GetName(targetId) then
            if v["menpaiid"] == self:GetMenPai(selfId) then
                if 10 <= index and index <= 14 then
                    self:ExchangeTitleBymenpaipoint(selfId, targetId, index - 10)
                elseif 7 == index then
                    self:ExchangeItemBymenpaipoint(selfId, targetId)
                    break
                elseif 8 == index then
                    self:AddExchangeTitleList(selfId, targetId)
                    break
                end
            else
                local str = "你不是本门派弟子，我只为本门派弟子服务。"
                self:BeginEvent(self.script_id)
                self:AddText(str)
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            end
        end
    end
end

function event_exchangeitembymenpaipoint:OnEnumerate(caller, selfId, targetId, arg, index)
    self:AddNumText(self.g_ExchangeItem, 3, 7)
    self:AddNumText(self.g_ExchangeTitle, 3, 8)
end

function event_exchangeitembymenpaipoint:ExchangeItemBymenpaipointFn(selfId, targetId, needPoint)
    if (needPoint < 0) then
        return
    end
    local menpaipoint = self:GetHumanMenpaiPoint(selfId)
    if menpaipoint < 400 then
        local str = "你的师门贡献度目前为" .. self:tostring(menpaipoint) .. "，还不足400点，多加努力吧。"
        self:BeginEvent(self.script_id)
        self:AddText(str)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    else
        local nItemId, strItemName, strItemDesc = self:GetOneMissionItem(self.g_exchangeitembymenpaipoint_Index)
        self:BeginAddItem()
        self:AddItem(nItemId, 1)
        local ret = self:EndAddItem(selfId)
        if ret <= 0 then
            self:BeginEvent(self.script_id)
            self:AddText("你的背包已满， 无法兑换！")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        else
            self:AddItemListToHuman(selfId)
            self:SetHumanMenpaiPoint(selfId, menpaipoint - 400)
            local str = string.format("扣除400点门派贡献度，您获得了%s。", strItemName)
            self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
            str = string.format("你得到了%s。", strItemName)
            self:BeginEvent(self.script_id)
            self:AddText(str)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        end
    end
end

function event_exchangeitembymenpaipoint:ExchangeItemBymenpaipoint(selfId, targetId)
    self:BeginUICommand()
    self:UICommand_AddInt(self.script_id)
    self:UICommand_AddInt(targetId)
    self:UICommand_AddStr("ExchangeItemBymenpaipointFn")
    self:UICommand_AddStr(self.g_MissionInfo)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 24)
end

function event_exchangeitembymenpaipoint:GetCurShimenTitleLevel(menpai, title)
    local titlelevel = 0
    if menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["slt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["slt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["mjt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["mjt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["gbt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["gbt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["wdt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["wdt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["emt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["emt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["tlt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["tlt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["xxt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["xxt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["tst"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["tst"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["xyt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["xyt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    elseif menpai == ScriptGlobal.MP_MANTUO then
        for i = 1, 4 do
            if title == self.g_MaleTitleInfo[i]["mtt"] then
                titlelevel = self.g_MaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
            if title == self.g_femaleTitleInfo[i]["mtt"] then
                titlelevel = self.g_femaleTitleInfo[i]["tlvl"]
                return titlelevel
            end
        end
    end
    return titlelevel
end

function event_exchangeitembymenpaipoint:GetSelectedTitle(menpai, titleinfo, level)
    if level < 1 or level > 4 then
        return 0
    end
    local title = ""
    if menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN then
        title = titleinfo[level]["slt"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO then
        title = titleinfo[level]["mjt"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG then
        title = titleinfo[level]["gbt"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG then
        title = titleinfo[level]["wdt"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI then
        title = titleinfo[level]["emt"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI then
        title = titleinfo[level]["tlt"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU then
        title = titleinfo[level]["xxt"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN then
        title = titleinfo[level]["tst"]
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO then
        title = titleinfo[level]["xyt"]
    elseif menpai == ScriptGlobal.MP_MANTUO then
        title = titleinfo[level]["mtt"]
    end
    return titleinfo[level]["tlvl"]
end

function event_exchangeitembymenpaipoint:AddExchangeTitleList(selfId, targetId)
    local level = self:GetLevel(selfId)
    local menpai = self:GetMenPai(selfId)
    local titleinfo
    local sex = self:GetSex(selfId)
    if 1 == sex then
        titleinfo = self.g_MaleTitleInfo
    elseif 0 == sex then
        titleinfo = self.g_femaleTitleInfo
    end
    local step = 10
    self:BeginEvent(self.script_id)
    if menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    elseif menpai == ScriptGlobal.MP_MANTUO then
        for i = 1, 4 do
            local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, i)
            local str = seltitle .. "（需要" .. needpoint .. "点师门贡献）"
            self:AddNumText(str, 3, i + step)
        end
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function event_exchangeitembymenpaipoint:GetShimenTitle_BonusItem(selfId)
    local menpai = self:GetMenPai(selfId)
    for i, v in pairs(self.g_shimentitle_bonusitem) do
        if v["menpaiid"] == menpai then
            return v["bonusItem"]
        end
    end
    return 0
end

function event_exchangeitembymenpaipoint:ExchangeTitleBymenpaipoint(selfId, targetId, level)
    local titleinfo, titleIdInfo
    local menpai = self:GetMenPai(selfId)
    local sex = self:GetSex(selfId)
    if 1 == sex then
        titleinfo = self.g_MaleTitleInfo
        titleIdInfo = self.g_MaleTitleInfoA
    elseif 0 == sex then
        titleinfo = self.g_femaleTitleInfo
        titleIdInfo = self.g_femaleTitleInfoA
    end
    local title = self:GetShimenTitle(selfId)
    local seltitlelvl, needpoint, seltitle = self:GetSelectedTitle(menpai, titleinfo, level)
    local seltitlelvlEx, needpointEx, seltitleEx = self:GetSelectedTitle(menpai, titleIdInfo, level)
    local curtitlelvl = self:GetCurShimenTitleLevel(menpai, title)
    local str
    if seltitlelvl == curtitlelvl or self:GetCurTitle(selfId) == seltitleEx then
        str = "你已经拥有了此称号，不需要兑换。"
    elseif seltitlelvl > curtitlelvl then
        local menpaipoint = self:GetHumanMenpaiPoint(selfId)
        if needpoint <= menpaipoint then
            if seltitlelvl == 2 then
                self:BeginAddItem()
                self:AddItem(self:GetShimenTitle_BonusItem(selfId), 1)
                local ret = self:EndAddItem(selfId)
                if ret then
                    self:AddItemListToHuman(selfId)
                    str = "恭喜你获得#Y" .. seltitle .. "#W的称号，希望继续为本门的发扬光大而努力。这里有一套本门的衣服，就算为师对你这段时间辛苦的一个奖励吧。"
                    self:LuaFnSetCharTitleNewData(selfId, seltitleEx, 1)
                    self:SetHumanMenpaiPoint(selfId, menpaipoint - needpoint)
                else
                    str = "你的背包已经满了，为师准备送点小礼物给你，整理好背包之後再来找我吧。"
                end
            else
                str = "恭喜你获得#Y" .. seltitle .. "#W的称号，希望继续为本门的发扬光大而努力。"
                self:LuaFnSetCharTitleNewData(selfId, seltitleEx, 1)
                self:SetHumanMenpaiPoint(selfId, menpaipoint - needpoint)
            end
        else
            str = "你的门派贡献度不够，无法兑换。"
        end
    end
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function event_exchangeitembymenpaipoint:Tips(selfId, str)
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return event_exchangeitembymenpaipoint
