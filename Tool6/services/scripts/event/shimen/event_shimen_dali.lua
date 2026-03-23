local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ScriptGlobal = require "scripts.ScriptGlobal"
local event_shimen_dali = class("event_shimen_dali", script_base)
event_shimen_dali.script_id = 229004
event_shimen_dali.g_Position_X = 95.9574
event_shimen_dali.g_Position_Z = 88.6181
event_shimen_dali.g_SceneID = 13
event_shimen_dali.g_AccomplishNPC_Name = "本凡"
event_shimen_dali.g_Name = "本凡"
event_shimen_dali.g_MissionId = 1080
event_shimen_dali.g_MissionKind = 24
event_shimen_dali.g_MissionLevel = 10000
event_shimen_dali.g_IfMissionElite = 0
event_shimen_dali.g_IsMissionOkFail = 0
event_shimen_dali.g_MissionName = "师门任务"
event_shimen_dali.g_MissionInfo = ""
event_shimen_dali.g_MissionTarget = "%f"
event_shimen_dali.g_ContinueInfo = "干得不错"
event_shimen_dali.g_MissionComplete = "我交给你的事情已经做完了吗？"
event_shimen_dali.g_MissionRound = 17
event_shimen_dali.g_DoubleExp = 48
event_shimen_dali.g_AccomplishCircumstance = 1
event_shimen_dali.g_ShimenTypeIndex = 1
event_shimen_dali.g_Parameter_Kill_AllRandom = { {
    ["id"] = 7,
    ["numa"] = 3,
    ["numb"] = 3,
    ["bytenuma"] = 0,
    ["bytenumb"] = 1
}
}
event_shimen_dali.g_Parameter_Item_IDRandom = { { ["id"] = 6, ["num"] = 5 }
}
event_shimen_dali.g_NpcIdIndicator = { { ["key"] = 2, ["npcIdIndex"] = 5 }
, { ["key"] = 9, ["npcIdIndex"] = 7 }
}
event_shimen_dali.g_FormatList = {
    "好久没有见%n了，很是想念啊。这个%s是我的一点心意，请你把它送过去吧。#r  #e00f000小提示：#e000000#r  你可以在天龙寺找到#R破嗔#W#{_INFOAIM99,120,13,破嗔}，请他把你送往各大城市。#B#r  东西送到后，请到师门任务发布人#W本凡#{_INFOAIM95,88,13,本凡}处交还任务。#r#{SMRW_090206_01}",
    "我的%i怎么不见了？如果你能帮我找回来，我是不会亏待你的。#r  #e00f000小提示：#e000000#r  你可以在天龙寺找到#R破嗔#W#{_INFOAIM99,120,13,破嗔}，请他把你送往各大城市。#r#{SMRW_090206_01}",
    "%n为非作歹，我有心去教训一下，可惜没有时间，你能代劳吗？#r  #e00f000小提示：#e000000#r  你可以在天龙寺找到#R破嗔#W#{_INFOAIM99,120,13,破嗔}，请他把你送往各大城市。#r#{SMRW_090206_01}",
    "请你在天龙寺%s找到%s，在它附近使用%s来试炼你的能力。#r  #e00f000小提示：#e000000#r  当你来到要求试炼的铜人附近时，你可以按#gfff0f0Alt+A#g000000可以打开物品栏，点击#gfff0f0“任务”#g000000页面就可以打开任务物品栏，右键点击#gfff0f0医用金针#g000000，就可以完成试炼了。#r#{SMRW_090206_01}",
    "请你去找到%s， 他会带你去挑战%s的。#r  #e00f000小提示：#e000000#r  本相大师就在天龙寺#{_INFOAIM35,86,13,本相}。#r#{SMRW_090206_01}",
    "请你帮我抓一只%p来。#B#r  #e00f000小提示：#e000000#r  #G洛阳城的云涵儿#{_INFOAIM183,155,0,云涵儿}可以送你去玄武岛，而玄武岛有一条小路通往圣兽山。你可以在玄武岛或者圣兽山上捕捉我需要的珍兽。#r#{SMRW_090206_01}",
    "请你在天龙寺中四处看看，帮我找来5个%s。#r  #e00f000小提示：#e000000#r  你可以在屏幕右上角的小地图上找到黄色的指示点。#r#{SMRW_090206_01}",
    "请给%s送去一个%i吧，事成之后，我会给你报酬的！#r  #e00f000小提示：#e000000#r  伍忠大人就在天龙寺#{_INFOAIM94,126,13,伍忠}。#r  林国清大人就在天龙寺#{_INFOAIM96,126,13,林国清}。#r  齐归蝶夫人就在天龙寺#{_INFOAIM154,115,13,齐归蝶}。#B#r  东西送到后，请到师门任务发布人#W本凡#{_INFOAIM95,88,13,本凡}处交还任务。#r#{SMRW_090206_01}",
    "去杀死%s%s个%n。#r#{SMRW_090206_01}" }
event_shimen_dali.g_StrForePart = 4
event_shimen_dali.g_StrList = { "医用金针", "经脉铜人区", "经脉铜人区", "经脉铜人区", "经脉铜人区",
    "本相", "塔底副本", "满月", "眼儿媚", "红妆素裹", "伍忠", "林国清", "齐归蝶", "野生柴猫",
    "手太阴肺经铜人", "手阳明肠经铜人", "足阳明胃经铜人", "足太阴脾经铜人", "0", "1", "2",
    "3", "4", "5", "6", "7", "8", "9" }
event_shimen_dali.g_SubMissionTypeEnum = {
    ["XunWu"] = 1,
    ["SongXin"] = 2,
    ["DingDianYinDao"] = 3,
    ["FuBenZhanDou"] = 4,
    ["BuZhuo"] = 5,
    ["ShouJi"] = 6,
    ["KaiGuang"] = 7,
    ["otherMenpaiFuben"] = 8,
    ["killMonster"] = 9
}
event_shimen_dali.g_DingDianYinDaoList = {
    {
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["itemId"] = 40003024,
        ["itemName"] = "医用金针",
        ["scene"] = 13,
        ["AreaName"] = "经脉铜人区",
        ["subAreaName"] = "手太阴肺经铜人",
        ["posx1"] = 54,
        ["posz1"] = 87,
        ["posx2"] = 75,
        ["posz2"] = 99
    }
    ,
    {
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["itemId"] = 40003024,
        ["itemName"] = "医用金针",
        ["scene"] = 13,
        ["AreaName"] = "经脉铜人区",
        ["subAreaName"] = "手阳明肠经铜人",
        ["posx1"] = 81,
        ["posz1"] = 82,
        ["posx2"] = 90,
        ["posz2"] = 88
    }
    ,
    {
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["itemId"] = 40003024,
        ["itemName"] = "医用金针",
        ["scene"] = 13,
        ["AreaName"] = "经脉铜人区",
        ["subAreaName"] = "足阳明胃经铜人",
        ["posx1"] = 101,
        ["posz1"] = 81,
        ["posx2"] = 110,
        ["posz2"] = 88
    }
    ,
    {
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["itemId"] = 40003024,
        ["itemName"] = "医用金针",
        ["scene"] = 13,
        ["AreaName"] = "经脉铜人区",
        ["subAreaName"] = "足太阴脾经铜人",
        ["posx1"] = 120,
        ["posz1"] = 85,
        ["posx2"] = 140,
        ["posz2"] = 100
    }
}
event_shimen_dali.g_FuBen_List = {
    {
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["NpcName"] = "本相",
        ["scene"] = 13,
        ["posx"] = 35,
        ["posz"] = 86,
        ["FubenName"] = "塔底副本"
    }
}
event_shimen_dali.g_ShouJiList = {
    { ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, ["scene"] = 13, ["itemId"] = 40003000, ["itemName"] = "满月" }
    , { ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, ["scene"] = 13, ["itemId"] = 40003001, ["itemName"] = "眼儿媚" }
, { ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI, ["scene"] = 13, ["itemId"] = 40003002, ["itemName"] = "红妆素裹" }
}
event_shimen_dali.g_AbilityNpcList = {
    {
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["npcList"] = { { ["name"] = "伍忠", ["scene"] = 13, ["x"] = 94, ["z"] = 126 }
        , { ["name"] = "林国清", ["scene"] = 13, ["x"] = 96, ["z"] = 126 }
        , { ["name"] = "齐归蝶", ["scene"] = 13, ["x"] = 154, ["z"] = 115 }
        }
    }
}
event_shimen_dali.g_PetList = { { ["petDataId"] = 3000, ["petName"] = "野生柴猫", ["takeLevel"] = 10 }
}
event_shimen_dali.g_Xin_ItemId = 40002121
event_shimen_dali.g_ShimenPet_Index = 1
event_shimen_dali.g_MenpaiYiWuList = {
    {
        ["menpainame"] = "少林",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN,
        ["itemName"] = "少林弟子的度牒",
        ["scene"] = 9,
        ["itemId"] = 40004306
    }
    ,
    {
        ["menpainame"] = "天龙",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI,
        ["itemName"] = "天龙弟子的印章",
        ["scene"] = 13,
        ["itemId"] = 40004312
    }
    ,
    {
        ["menpainame"] = "峨嵋",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI,
        ["itemName"] = "峨嵋弟子的剑穗",
        ["scene"] = 15,
        ["itemId"] = 40004310
    }
    ,
    {
        ["menpainame"] = "丐帮",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG,
        ["itemName"] = "丐帮弟子的布袋",
        ["scene"] = 10,
        ["itemId"] = 40004307
    }
    ,
    {
        ["menpainame"] = "明教",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO,
        ["itemName"] = "明教弟子的火令",
        ["scene"] = 11,
        ["itemId"] = 40004308
    }
    ,
    {
        ["menpainame"] = "天山",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN,
        ["itemName"] = "天山弟子的冰牌",
        ["scene"] = 17,
        ["itemId"] = 40004314
    }
    ,
    {
        ["menpainame"] = "武当",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG,
        ["itemName"] = "武当弟子的拂尘",
        ["scene"] = 12,
        ["itemId"] = 40004309
    }
    ,
    {
        ["menpainame"] = "逍遥",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO,
        ["itemName"] = "逍遥弟子的标持",
        ["scene"] = 14,
        ["itemId"] = 40004313
    }
    ,
    {
        ["menpainame"] = "星宿",
        ["menpai"] = define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU,
        ["itemName"] = "星宿弟子的蛊皿",
        ["scene"] = 16,
        ["itemId"] = 40004311
    }
    ,
    {
        ["menpainame"] = "曼陀山庄",
        ["menpai"] = ScriptGlobal.MANTUO,
        ["itemName"] = "曼陀山庄弟子的古琴",
        ["scene"] = 184,
        ["itemId"] = 40005046
    }
}
event_shimen_dali.g_RateOfDropYiWuTable = { { ["playerLevel"] = 20, ["dropRate"] = 30 }
, { ["playerLevel"] = 30, ["dropRate"] = 30 }
, { ["playerLevel"] = 40, ["dropRate"] = 25 }
, { ["playerLevel"] = 50, ["dropRate"] = 25 }
, { ["playerLevel"] = 60, ["dropRate"] = 25 }
, { ["playerLevel"] = 70, ["dropRate"] = 20 }
, { ["playerLevel"] = 80, ["dropRate"] = 20 }
, { ["playerLevel"] = 90, ["dropRate"] = 20 }
, { ["playerLevel"] = 100, ["dropRate"] = 20 }
, { ["playerLevel"] = 110, ["dropRate"] = 20 }
, { ["playerLevel"] = 120, ["dropRate"] = 20 }
, { ["playerLevel"] = 130, ["dropRate"] = 20 }
, { ["playerLevel"] = 140, ["dropRate"] = 20 }
, { ["playerLevel"] = 150, ["dropRate"] = 20 }
}
event_shimen_dali.g_DemandKillcountTable = { { ["levelBegin"] = 10, ["levelEnd"] = 19, ["killcount"] = 20 }
, { ["levelBegin"] = 20, ["levelEnd"] = 39, ["killcount"] = 25 }
, { ["levelBegin"] = 40, ["levelEnd"] = 59, ["killcount"] = 30 }
, { ["levelBegin"] = 60, ["levelEnd"] = 79, ["killcount"] = 35 }
, { ["levelBegin"] = 80, ["levelEnd"] = 99, ["killcount"] = 40 }
, { ["levelBegin"] = 100, ["levelEnd"] = 109, ["killcount"] = 45 }
, { ["levelBegin"] = 110, ["levelEnd"] = 119, ["killcount"] = 50 }
, { ["levelBegin"] = 120, ["levelEnd"] = 150, ["killcount"] = 55 }
}
function event_shimen_dali:GetMenpaiYiWuInfo(selfId)
    for i, v in pairs(self.g_MenpaiYiWuList) do
        if v["menpai"] == self:GetMenPai(selfId) then
            return v["menpainame"]
        end
    end
end

function event_shimen_dali:GetRateOfDropYiWu(selfId)
    local playerLevel = self:GetLevel(selfId)
    for i, v in pairs(self.g_RateOfDropYiWuTable) do
        if v["playerLevel"] >= playerLevel and playerLevel < v["playerLevel"] then
            return v["dropRate"]
        end
    end
end

function event_shimen_dali:GetDemandKillCount(selfId)
    local playerLevel = self:GetLevel(selfId)
    for i, v in pairs(self.g_DemandKillcountTable) do
        if playerLevel >= v["levelBegin"] and playerLevel <= v["levelEnd"] then
            return v["killcount"]
        end
    end
end

function event_shimen_dali:KillMonster_Accept(selfId)
    local nMonsterId, strMonsterName, strMonsterScene, nScene, nPosX, nPosZ, strDesc, nSex, level
    local playerLevel = self:GetLevel(selfId)
    for i = 1, 100 do
        nMonsterId = self:GetOneMissionNpc(43)
        if self:abs(level - playerLevel) < 3 then
            break
        end
        if i == 100 then
            self:SongXin_Accept(selfId)
            return
        end
    end
    local bAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 1, 0, 1)
    if not bAdd then
        return
    end
    local killcount = self:GetDemandKillCount(selfId)
    local countpart1 = self:GetStrIndexByStrValue(self:tostring(math.floor(killcount / 10)))
    local countpart2 = self:GetStrIndexByStrValue(self:tostring(math.floor(killcount % 10)))
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["killMonster"])
    self:SetMissionParamByIndexEx(selfId, misIndex, 3, 0, killcount)
    self:SetMissionParamByIndexEx(selfId, misIndex, 3, 1, 0)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 8)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, countpart1)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 2, countpart2)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 3, nMonsterId)
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(888888, "AskThePos", selfId, nScene, nPosX, nPosZ, strMonsterName)
    local strMissionTarget = string.format("最近%s地区的%s经常扰乱周边的居民，特命你去惩戒他们。",
        strMonsterScene, strMonsterName)
    self:AddText(strMissionTarget)
end

function event_shimen_dali:GetStrIndexByStrValue(stringV)
    for i, v in pairs(self.g_StrList) do
        if v == stringV then
            return i - 1
        end
    end
    local strText = string.format("必须将%s注册到StrList中", stringV)
    return 0
end

function event_shimen_dali:GetItemDetailInfo(itemId)
    local itemId, itemName, itemDesc = self:GetItemInfoByItemId(itemId)
    if not itemId then
        local strText = string.format("%s物品在'MissionItem_HashTable.txt'没有找到!!", itemName)
    end
    return itemId
end

function event_shimen_dali:GetMissionItemIndex(selfId)
    local nPlayerLevel = self:GetLevel(selfId)
    if nPlayerLevel >= 10 and nPlayerLevel < 20 then
        return 0
    elseif nPlayerLevel >= 20 and nPlayerLevel < 30 then
        return 1
    elseif nPlayerLevel >= 30 and nPlayerLevel < 40 then
        return 2
    elseif nPlayerLevel >= 40 and nPlayerLevel < 60 then
        return 3
    elseif nPlayerLevel >= 60 and nPlayerLevel < 80 then
        return 4
    elseif nPlayerLevel >= 80 and nPlayerLevel < 100 then
        return 5
    elseif nPlayerLevel >= 100 and nPlayerLevel < 120 then
        return 167
    elseif nPlayerLevel >= 100 then
        return 168
    end
end

function event_shimen_dali:GetShiMenPhaseByPlayerLevel(selfId)
    local nPlayerLevel = self:GetLevel(selfId)
    if nPlayerLevel >= 10 and nPlayerLevel < 20 then
        return 0
    elseif nPlayerLevel >= 20 and nPlayerLevel < 40 then
        return 1
    elseif nPlayerLevel >= 40 and nPlayerLevel < 60 then
        return 2
    elseif nPlayerLevel >= 60 and nPlayerLevel < 80 then
        return 3
    elseif nPlayerLevel >= 80 and nPlayerLevel < 100 then
        return 4
    elseif nPlayerLevel >= 100 and nPlayerLevel < 120 then
        return 243
    elseif nPlayerLevel >= 120 then
        return 244
    end
end

function event_shimen_dali:RandomSubMission(selfId)
    local nRet = 1 + self:LuaFnGetHumanShimenRandom(selfId)
    if nRet then
        if nRet <= 4 then
            self:XunWu_Accept(selfId)
        elseif nRet <= 5 then
            self:SongXin_Accept(selfId)
        elseif nRet <= 6 then
            self:ShouJi_Accept(selfId)
        elseif nRet <= 7 then
            self:SongXin_Accept(selfId)
        elseif nRet <= 8 then
            self:DingDianYinDao_Accept(selfId)
        elseif nRet <= 12 then
            self:FuBenZhanDou_Accept(selfId)
        elseif nRet <= 16 then
            self:BuZhuo_Accept(selfId)
        else
            return -1
        end
    else
        return -1
    end
end

function event_shimen_dali:DoSomethingByPlayerLevel(selfId)
    self:CallScriptFunction(229000, "DoSomethingByPlayerLevel", selfId, self.script_id)
end

function event_shimen_dali:XunWu_Accept(selfId)
    local bCanAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 1)
    if not bCanAdd then
        return
    end
    local nitemId, strItemName, strItemDesc = self:GetOneMissionItem(self:GetMissionItemIndex(selfId))
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["XunWu"])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 1)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, nitemId)
    local strMissionTarget = string.format("我的%s怎么不见了？如果你能帮我找回来，我是不会亏待你的。",
        strItemName)
    self:AddText(strMissionTarget)
    local bHaveItem = self:HaveItem(selfId, nitemId)
    if bHaveItem == 1 then
        self:SetMissionByIndex(selfId, misIndex, 0, 1)
        self:ResetMissionEvent(selfId, self.g_MissionId, 2)
    end
end

function event_shimen_dali:SongXin_Accept(selfId)
    local roll = math.random(3)
    local shoujiItemId = self.g_ShouJiList[roll]["itemId"]
    self:BeginAddItem()
    self:AddItem(shoujiItemId, 1)
    local bAdd = self:EndAddItem(selfId)
    if not bAdd then
        return
    end
    bAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    if not bAdd then
        return
    end
    self:AddItemListToHuman(selfId)
    self:SetMissionEvent(selfId, self.g_MissionId, 4)
    local nPhase = self:GetShiMenPhaseByPlayerLevel(selfId)
    local nNpcId, strNpcName, strNpcScene, nSceneId, nPosX, nPosZ, strNPCDesc = self:GetOneMissionNpc(nPhase)
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(888888, "AskTheWay", selfId, nSceneId, nPosX, nPosZ, strNpcName)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["SongXin"])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 0)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, nNpcId)
    local ListIndex = self:GetStrIndexByStrValue(self.g_ShouJiList[roll]["itemName"])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 2, ListIndex)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 3, shoujiItemId)
    local strMissionTarget = string.format("好久没有见%s%s了，请你帮我把这个%s交给他。", strNpcScene,
        strNpcName, self.g_ShouJiList[roll]["itemName"])
    self:AddText(strMissionTarget)
end

function event_shimen_dali:DingDianYinDao_Accept(selfId)
    local playerMenpai = self:GetMenPai(selfId)
    local a = {}
    local index = 1
    for i, v in pairs(self.g_DingDianYinDaoList) do
        if v["menpai"] == playerMenpai then
            a[index] = i
            index    = index + 1
        end
    end
    local ct = #a
    if ct <= 0 then
        return 0
    end
    local ret = math.random(ct)
    self:BeginAddItem()
    self:AddItem(self.g_DingDianYinDaoList[a[ret]]["itemId"], 1)
    local bAdd = self:EndAddItem(selfId)
    if not bAdd then
        return
    end
    bAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    if not bAdd then
        return
    end
    self:AddItemListToHuman(selfId)
    self:Msg2Player(selfId, "#Y你得到了一个" .. self.g_DingDianYinDaoList[a[ret]]["itemName"],
        define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local strIndex_Area = self:GetStrIndexByStrValue(self.g_DingDianYinDaoList[a[ret]]["AreaName"])
    local strIndex_Item = self:GetStrIndexByStrValue(self.g_DingDianYinDaoList[a[ret]]["itemName"])
    local strIndex_subArea = self:GetStrIndexByStrValue(self.g_DingDianYinDaoList[a[ret]]["subAreaName"])
    local x1 = self.g_DingDianYinDaoList[a[ret]]["posx1"]
    local x2 = self.g_DingDianYinDaoList[a[ret]]["posx2"]
    local z1 = self.g_DingDianYinDaoList[a[ret]]["posz1"]
    local z2 = self.g_DingDianYinDaoList[a[ret]]["posz2"]
    local scene = self.g_DingDianYinDaoList[a[ret]]["scene"]
    local tip = self.g_DingDianYinDaoList[a[ret]]["AreaName"] .. self.g_DingDianYinDaoList[a[ret]]["subAreaName"]
    local x = x1 + (x2 - x1) / 2
    local z = z1 + (z2 - z1) / 2
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["DingDianYinDao"])
    self:SetMissionByIndex(selfId, misIndex, 2, a[ret])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 3)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, strIndex_Area)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 2, strIndex_subArea)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 3, strIndex_Item)
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(888888, "AskThePos", selfId, scene, x, z, tip)
    local strMissionTarget = string.format("请你在天龙寺%s找%s，在它附近使用%s来试炼你的能力。",
        self.g_DingDianYinDaoList[a[ret]]["AreaName"], self.g_DingDianYinDaoList[a[ret]]["subAreaName"],
        self.g_DingDianYinDaoList[a[ret]]["itemName"])
    self:AddText(strMissionTarget)
end

function event_shimen_dali:FuBenZhanDou_Accept(selfId)
    local playerMenpai = self:GetMenPai(selfId)
    if playerMenpai == ScriptGlobal.MP_WUMENPAI then
        return 0
    end
    local npcName, fubenName, nSceneId, posx, posz
    for i, v in pairs(self.g_FuBen_List) do
        if v["menpai"] == self:GetMenPai(selfId) then
            npcName = v["NpcName"]
            fubenName = v["FubenName"]
            nSceneId = v["scene"]
            posx = v["posx"]
            posz = v["posz"]
            break
        end
    end
    local bAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    if not bAdd then
        return
    end
    local nFormatIndex = self:GetMissionCacheData(selfId, 0)
    local i = self:GetMissionCacheData(selfId, 2)
    local NpcNameIndex = self:GetStrIndexByStrValue(npcName)
    local FubenNameIndex = self:GetStrIndexByStrValue(fubenName)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["FuBenZhanDou"])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 4)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, NpcNameIndex)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 2, FubenNameIndex)
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(888888, "AskTheWay", selfId, nSceneId, posx, posz, npcName)
    local strMissionTarget = string.format("请你去找到%s， 他会带你去挑战%s的。", npcName, fubenName)
    self:AddText(strMissionTarget)
end

function event_shimen_dali:BuZhuo_Accept(selfId)
    local playerLevel = self:GetLevel(selfId)
    local petId, petName, petDesc, takeLevel
    local petHashIndex = self:CallScriptFunction(229000, "GetMissionPetIndex", selfId)
    for i = 1, 100 do
        petId = self:GetOneMissionPet(petHashIndex)
        takeLevel = self:GetPetTakeLevel(petId)
        if playerLevel > takeLevel then
            break
        end
        if i == 100 then
            self:SongXin_Accept(selfId)
            return
        end
    end
    local bAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    if not bAdd then
        return
    end
    self:SetMissionEvent(selfId, self.g_MissionId, 3)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["BuZhuo"])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 5)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, petId)
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local strMissionTarget = string.format("请你帮我抓一只%s来。", petName)
    self:AddText(strMissionTarget)
    for i = 0, 6 do
        local petDataId = self:LuaFnGetPet_DataID(selfId, i)
        if petDataId == petId then
            self:SetMissionByIndex(selfId, misIndex, 0, 1)
            self:ResetMissionEvent(selfId, self.g_MissionId, 3)
            break
        end
    end
end

function event_shimen_dali:ShouJi_Accept(selfId)
    local playerMenpai = self:GetMenPai(selfId)
    if playerMenpai == ScriptGlobal.MP_WUMENPAI then
        return 0
    end
    local a = {}
    local index = 1
    for i, v in pairs(self.g_ShouJiList) do
        if v["menpai"] == playerMenpai then
            a[index] = i
            index    = index + 1
        end
    end
    local ct = #a
    if ct <= 0 then
        return 0
    end
    local ret = math.random(ct)
    local bAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 1)
    if not bAdd then
        return
    end
    local itemNameIndex = self:GetStrIndexByStrValue(self.g_ShouJiList[a[ret]]["itemName"])
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["ShouJi"])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 6)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, itemNameIndex)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 2, self.g_ShouJiList[a[ret]]["itemId"])
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local strMissionTarget = string.format("请你帮我弄5个%s来。", self.g_ShouJiList[a[ret]]["itemName"])
    self:AddText(strMissionTarget)
end

function event_shimen_dali:Ability_Accept(selfId)
    local strNpcName, scene, x, z
    for i, v in pairs(self.g_AbilityNpcList) do
        if v["menpai"] == self:GetMenPai(selfId) then
            local ct = #v["npcList"]
            local index = math.random(ct)
            strNpcName = v["npcList"][index]["name"]
            scene = v["npcList"][index]["scene"]
            x = v["npcList"][index]["x"]
            z = v["npcList"][index]["z"]
        end
    end
    local strNpcIndex = self:GetStrIndexByStrValue(strNpcName)
    local itemId, itemName = self:GetMenpaiItem(selfId)
    local bAdd = self:AddMission(selfId, self.g_MissionId, self.script_id, 0, 0, 0)
    if not bAdd then
        return
    end
    self:SetMissionEvent(selfId, self.g_MissionId, 2)
    self:SetMissionEvent(selfId, self.g_MissionId, 4)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, self.g_SubMissionTypeEnum["KaiGuang"])
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart, 7)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 1, strNpcIndex)
    self:SetMissionByIndex(selfId, misIndex, self.g_StrForePart + 2, itemId)
    self:Msg2Player(selfId, "#Y接受任务：师门任务", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:CallScriptFunction(888888, "AskTheWay", selfId, scene, x, z, strNpcName)
    local strMissionTarget = string.format("请给%s送一个%s吧, 我会给你报酬的！", strNpcName, itemName)
    self:AddText(strMissionTarget)
end

function event_shimen_dali:OnDefaultEvent(selfId, targetId)
    if self:IsHaveMission(selfId, self.g_MissionId) then
        if self:GetName(targetId) == self.g_Name then
            self:BeginEvent(self.script_id)
            self:AddText(self.g_MissionName)
            self:AddText("我交给你的事情已经做完了吗？")
            self:EndEvent()
            local bDone = self:CheckSubmit(selfId)
            self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, self.g_MissionId, bDone)
        else
            local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
            local demandItemId = 0
            local missionType = self:GetMissionParam(selfId, misIndex, 1)
            if missionType == self.g_SubMissionTypeEnum["SongXin"] then
                demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 3)
            else
                demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 2)
            end
            local _, strDemandItemName, _ = self:GetItemDetailInfo(demandItemId)
            local bHaveItem = self:HaveItemInBag(selfId, demandItemId)
            if bHaveItem then
                if self:LuaFnGetAvailableItemCount(selfId, demandItemId) >= 1 then
                    self:DelItem(selfId, demandItemId)
                    self:BeginEvent(self.script_id)
                    self:AddText("请你回去给你师傅说，我也很想你师傅了，谢谢你师傅给我送来的东西，这是我正急想要的。")
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    self:SetMissionByIndex(selfId, misIndex, 0, 1)
                    self:ResetMissionEvent(selfId, self.g_MissionId, 4)
                    return 1
                else
                    self:BeginEvent(self.script_id)
                    self:AddText("您的物品现在不可用或已被锁定。")
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return 0
                end
            else
                self:BeginEvent(self.script_id)
                self:AddText("我要的东西给我带来了吗？")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
                return 1
            end
        end
    elseif self:CheckAccept(selfId) > 0 then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionInfo)
        self:AddText("#{M_MUBIAO}#r")
        self:DoSomethingByPlayerLevel(selfId)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function event_shimen_dali:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        local strNpcName = self.g_Name
        if self:GetName(targetId) == strNpcName then
            caller:AddNumTextWithTarget(self.script_id,self.g_MissionName, 4, -1)
        end
    elseif self:CheckAccept(selfId) > 0 then
        if self:GetName(targetId) == self.g_Name then
            caller:AddNumTextWithTarget(self.script_id,self.g_MissionName, 3, -1)
        end
    end
end

function event_shimen_dali:OnAccept(selfId)
end

function event_shimen_dali:CheckAccept(selfId)
    local nLevel = self:GetLevel(selfId)
    if nLevel < 10 then
        return 0
    else
        local playerMenpai = self:GetMenPai(selfId)
        if playerMenpai ~= define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI then
            return 0
        end
    end
    return 1
end

function event_shimen_dali:OnAbandon(selfId)
    if self:IsHaveMission(selfId, self.g_MissionId) then
        local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
        local missionType = self:GetMissionParam(selfId, misIndex, 1)
        if missionType == self.g_SubMissionTypeEnum["SongXin"] then
            local missionItem = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 3)
            if self:HaveItemInBag(selfId, missionItem) then
                if self:LuaFnGetAvailableItemCount(selfId, missionItem) >= 1 then
                    self:DelItem(selfId, missionItem, 1)
                else
                    self:BeginEvent(self.script_id)
                    self:AddText("您的物品现在不可用或已被锁定。")
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
            end
        elseif missionType == self.g_SubMissionTypeEnum["DingDianYinDao"] then
            local index = self:GetMissionParam(selfId, misIndex, 2)
            if self:HaveItemInBag(selfId, self.g_DingDianYinDaoList[index]["itemId"]) == 1 then
                if self:LuaFnGetAvailableItemCount(selfId, self.g_DingDianYinDaoList[index]["itemId"]) >= 1 then
                    self:DelItem(selfId, self.g_DingDianYinDaoList[index]["itemId"])
                else
                    self:BeginEvent(self.script_id)
                    self:AddText("您的物品现在不可用或已被锁定。")
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
            end
        elseif missionType == self.g_SubMissionTypeEnum["ShouJi"] then
            local itemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 2)
            if self:HaveItemInBag(selfId, itemId) then
                if self:LuaFnGetAvailableItemCount(selfId, itemId) >= 1 then
                    self:DelItem(selfId, itemId, 5)
                else
                    self:BeginEvent(self.script_id)
                    self:AddText("您的物品现在不可用或已被锁定。")
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
            end
        end
        self:DelMission(selfId, self.g_MissionId)
        self:SetMissionData(selfId, ScriptGlobal.MD_SHIMEN_HUAN, 0)
    end
    self:CallScriptFunction(500501, "Abandon_Necessary", selfId)
end

function event_shimen_dali:OnContinue(selfId, targetId)
    if self:CheckAccept(selfId) > 0 then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionComplete)
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId, targetId, self.script_id, self.g_MissionId)
    end
end

function event_shimen_dali:CheckSubmit(selfId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then
        return 0
    end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local missionType = self:GetMissionParam(selfId, misIndex, 1)
    if missionType == self.g_SubMissionTypeEnum["XunWu"] then
        local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
        if self:GetItemCount(selfId, demandItemId) <= 0 then
            return 0
        end
        if self:IsEquipItem(demandItemId) and not self:IsWhiteEquip(demandItemId) then
            return 2
        else
            return 1
        end
    elseif missionType == self.g_SubMissionTypeEnum["ShouJi"] then
        local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 2)
        if self:GetItemCount(selfId, demandItemId) < 5 then
            return 0
        else
            return 1
        end
    elseif missionType == self.g_SubMissionTypeEnum["BuZhuo"] then
        return 2
    elseif self:GetMissionParam(selfId, misIndex, 0) then
        return 1
    end
    return 0
end

function event_shimen_dali:OnLockedTarget(selfId, objId)
    if self:GetName(objId) == self.g_Name then
        return 0
    end
    if self:IsHaveMission(selfId, self.g_MissionId) then
        local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
        local missionType = self:GetMissionParam(selfId, misIndex, 1)
        local nNpcId, strNpcName, strNpcScene, PosX, PosZ, desc
        if missionType == self.g_SubMissionTypeEnum["KaiGuang"] then
            local nNpcIndex = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
            strNpcName = self.g_StrList[nNpcIndex + 1]
        else
            nNpcId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
            nNpcId = self:GetNpcInfoByNpcId(nNpcId)
        end
        if self:GetName(objId) == strNpcName then
            self:TAddNumText(self.script_id, self.g_MissionName, 4, -1, self.script_id)
        end
    end
    return 0
end

function event_shimen_dali:CheckCondition_UseItem(selfId, targetId, eventId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local missionType = self:GetMissionParam(selfId, misIndex, 1)
    local sceneId = self:GetSceneID()
    if missionType ~= self.g_SubMissionTypeEnum["DingDianYinDao"] then
        return 0
    end
    local index = self:GetMissionParam(selfId, misIndex, 2)
    local targetSceneId = self.g_DingDianYinDaoList[index]["scene"]
    if sceneId ~= targetSceneId then
        self:BeginEvent(self.script_id)
        self:AddText("似乎在这个场景不能施放")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return 0
    end
    local posx1 = self.g_DingDianYinDaoList[index]["posx1"]
    local posz1 = self.g_DingDianYinDaoList[index]["posz1"]
    local posx2 = self.g_DingDianYinDaoList[index]["posx2"]
    local posz2 = self.g_DingDianYinDaoList[index]["posz2"]
    local PlayerX = self:GetHumanWorldX(selfId)
    local PlayerZ = self:GetHumanWorldZ(selfId)
    if PlayerX >= posx1 and PlayerX < posx2 then
        if PlayerZ >= posz1 and PlayerZ < posz2 then
            return 1
        end
    end
    self:BeginEvent(self.script_id)
    self:AddText("你必须在指定的区域才能使用!")
    self:EndEvent()
    self:DispatchMissionTips(selfId)
    return 0
end

function event_shimen_dali:Active_UseItem(selfId, param0)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local missionType = self:GetMissionParam(selfId, misIndex, 1)
    if missionType ~= self.g_SubMissionTypeEnum["DingDianYinDao"] then
        return 0
    end
    local index = self:GetMissionParam(selfId, misIndex, 2)
    if self:LuaFnGetAvailableItemCount(selfId, self.g_DingDianYinDaoList[index]["itemId"]) >= 1 then
        self:DelItem(selfId, self.g_DingDianYinDaoList[index]["itemId"])
        self:SetMissionByIndex(selfId, misIndex, 0, 1)
    else
        self:BeginEvent(self.script_id)
        self:AddText("您的物品现在不可用或已被锁定。")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
end

function event_shimen_dali:OnItemChanged(selfId, itemdataId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local missionType = self:GetMissionParam(selfId, misIndex, 1)
    if missionType == self.g_SubMissionTypeEnum["XunWu"] then
        local _, strItemName, _ = self:GetItemDetailInfo(itemdataId)
        local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
        local _, strDemandItemName, _ = self:GetItemDetailInfo(demandItemId)
        if strItemName == strDemandItemName then
            self:BeginEvent(self.script_id)
            local strText = string.format("已得到%s", strItemName)
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            self:SetMissionByIndex(selfId, misIndex, 0, 1)
            self:ResetMissionEvent(selfId, self.g_MissionId, 2)
        end
    elseif missionType == self.g_SubMissionTypeEnum["KaiGuang"] then
        local _, strItemName, _ = self:GetItemDetailInfo(itemdataId)
        local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 2)
        local _, strDemandItemName, _ = self:GetItemDetailInfo(demandItemId)
        if strItemName == strDemandItemName then
            self:BeginEvent(self.script_id)
            local strText = string.format("已得到%s", strItemName)
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            self:ResetMissionEvent(selfId, self.g_MissionId, 2)
        end
    elseif missionType == self.g_SubMissionTypeEnum["ShouJi"] then
        local itemCount = self:GetItemCount(selfId, itemdataId)
        local _, strItemName, _ = self:GetItemDetailInfo(itemdataId)
        local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 2)
        local _, strDemandItemName, _ = self:GetItemDetailInfo(demandItemId)
        if strItemName == strDemandItemName then
            self:BeginEvent(self.script_id)
            local _, strItemName, _ = self:GetItemDetailInfo(itemdataId)
            local strText = string.format("已得到%s%d/5", strItemName, itemCount)
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            if itemCount == 5 then
                self:SetMissionByIndex(selfId, misIndex, 0, 1)
                self:ResetMissionEvent(selfId, self.g_MissionId, 2)
            end
        end
    elseif missionType == self.g_SubMissionTypeEnum["killMonster"] then
        local _, _, itemId = self:GetMenpaiYiWuInfo(selfId)
        if itemdataId == itemId then
            self:SetMissionByIndex(selfId, misIndex, 0, 1)
            self:ResetMissionEvent(selfId, self.g_MissionId, 0)
            self:ResetMissionEvent(selfId, self.g_MissionId, 2)
        end
    end
end

function event_shimen_dali:OnPetChanged(selfId, petDataId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local missionType = self:GetMissionParam(selfId, misIndex, 1)
    if missionType == self.g_SubMissionTypeEnum["BuZhuo"] then
        local demandPetDataId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
        if petDataId == demandPetDataId then
            self:BeginEvent(self.script_id)
            local strText = string.format("已得到%s", self:GetPetName(petDataId))
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            self:SetMissionByIndex(selfId, misIndex, 0, 1)
            self:ResetMissionEvent(selfId, self.g_MissionId, 3)
        end
    end
end

function event_shimen_dali:OnSubmit(selfId, targetId, selectRadioId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    if self:CheckSubmit(selfId) >= 1 then
        local missionType = self:GetMissionParam(selfId, misIndex, 1)
        if missionType == self.g_SubMissionTypeEnum["XunWu"] then
            local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
            if self:LuaFnGetAvailableItemCount(selfId, demandItemId) then
                local ret = self:DelItem(selfId, demandItemId)
                if not ret then
                    self:BeginEvent(self.script_id)
                    self:AddText("没有足够的所需物品，任务无法提交")
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
            else
                self:BeginEvent(self.script_id)
                self:AddText("您的物品现在不可用或已被锁定。")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
        elseif missionType == self.g_SubMissionTypeEnum["ShouJi"] then
            local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 2)
            if self:LuaFnGetAvailableItemCount(selfId, demandItemId) then
                local ret = self:LuaFnDelAvailableItem(selfId, demandItemId, 5)
                if not ret then
                    self:BeginEvent(self.script_id)
                    self:AddText("没有足够的所需物品，任务无法提交")
                    self:EndEvent()
                    self:DispatchMissionTips(selfId)
                    return
                end
            else
                self:BeginEvent(self.script_id)
                self:AddText("您的物品现在不可用或已被锁定。")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            end
        end
        self:DelMission(selfId, self.g_MissionId)
        local Reward_Append, MissionRound = self:CallScriptFunction(500501, "OnSubmit_Necessary", selfId, targetId)
        if Reward_Append == 2 and MissionRound == 20 then
            self:CallScriptFunction(229010, "AddOtherMenpaiFubenMission", selfId, self.g_MissionId, targetId)
        end
    end
end

function event_shimen_dali:OnMissionCheck(selfId, npcid, scriptId, index1, index2, index3, petindex)
    if self:CheckSubmit(selfId) < 1 then
        return 0
    end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local missionType = self:GetMissionParam(selfId, misIndex, 1)
    if missionType == self.g_SubMissionTypeEnum["XunWu"] then
        local demandItemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
        local _, strDemandItemName, _ = self:GetItemDetailInfo(demandItemId)
        local find = self:CallScriptFunction(500501, "OnMissionCheck_NecessaryEx", selfId, index1, index2, index3,
            demandItemId)
        if find <= 0 then
            self:BeginEvent(self.script_id)
            local strText = string.format("你怎么没把%s拿到手就回来了呢？", strDemandItemName)
            self:AddText(strText)
            self:AddItemBonus(demandItemId, 1)
            self:EndEvent()
            self:DispatchEventList(selfId, -1)
            return
        end
        local ret = self:EraseItem(selfId, find)
        if ret then
            self:DelMission(selfId, self.g_MissionId)
            local Reward_Append, MissionRound = self:CallScriptFunction(500501, "OnSubmit_Necessary", selfId, -1)
            if Reward_Append == 2 and MissionRound == 20 then
                self:CallScriptFunction(229010, "AddOtherMenpaiFubenMission", selfId, self.g_MissionId)
            end
        else
            self:BeginEvent(self.script_id)
            local strText = string.format("你怎么没把%s拿到手就回来了呢？", strDemandItemName)
            self:AddText(strText)
            self:AddItemBonus(demandItemId, 1)
            self:EndEvent()
            self:DispatchEventList(selfId, -1)
        end
    elseif missionType == self.g_SubMissionTypeEnum["BuZhuo"] then
        local demandPetId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 1)
        local petId = self:LuaFnGetPet_DataID(selfId, petindex)
        if petId == demandPetId then
            if self:LuaFnIsPetAvailable(selfId, petindex) then
                self:LuaFnDeletePet(selfId, petindex)
                self:DelMission(selfId, self.g_MissionId)
                local Reward_Append, MissionRound = self:CallScriptFunction(500501, "OnSubmit_Necessary", selfId, -1)
                if Reward_Append == 2 and MissionRound == 20 then
                    self:CallScriptFunction(229010, "AddOtherMenpaiFubenMission", selfId, self.g_MissionId)
                end
            end
        else
            self:BeginEvent(self.script_id)
            self:AddText("你怎么没把我要的珍兽拿到手就回来了呢？")
            self:EndEvent()
            self:DispatchEventList(selfId, -1)
        end
    end
end

function event_shimen_dali:OnKillObject(selfId, objdataId, objId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local nMonsterId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 3)
    local _, strMonsterName = self:GetNpcInfoByNpcId(nMonsterId)
    local monsterName = self:GetMonsterNamebyDataId(objdataId)
    if strMonsterName == monsterName then
        local num = self:GetMonsterOwnerCount(objId)
        for i = 0, num - 1 do
            local humanObjId = self:GetMonsterOwnerID(objId, i)
            if self:IsHaveMission(humanObjId, self.g_MissionId) then
                local misIndex = self:GetMissionIndexByID(humanObjId, self.g_MissionId)
                if not self:GetMissionParam(humanObjId, misIndex, 0) then
                    local demandKillCount = self:GetMissionParamEx(humanObjId, misIndex, 3, 0)
                    local killedCount = self:GetMissionParamEx(humanObjId, misIndex, 3, 1)
                    killedCount = killedCount + 1
                    self:SetMissionParamByIndexEx(humanObjId, misIndex, 3, 1, killedCount)
                    self:BeginEvent(self.script_id)
                    local str = string.format("已经杀死%d/%d%s", killedCount, demandKillCount, monsterName)
                    self:AddText(str)
                    self:EndEvent()
                    self:DispatchMissionTips(humanObjId)
                    if killedCount >= demandKillCount then
                        self:SetMissionByIndex(humanObjId, misIndex, 0, 1)
                    end
                end
            end
        end
    end
end

function event_shimen_dali:HelpFinishOneHuan(selfId, targetId)
    if define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI ~= self:GetMenPai(selfId) then
        return
    end
    if not self:IsHaveMission(selfId, self.g_MissionId) then
        return
    end
    local ret = self:CallScriptFunction(229011, "CheckAndDepleteHelpFinishMenPaiPoint", selfId, targetId)
    if ret == 0 then
        return
    end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local missionType = self:GetMissionParam(selfId, misIndex, 1)
    local itemId = -1
    local itemCount = -1
    if missionType == self.g_SubMissionTypeEnum["SongXin"] then
        itemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 3)
        itemCount = self:LuaFnGetAvailableItemCount(selfId, itemId)
        if itemCount >= 1 then
            self:DelItem(selfId, itemId)
        end
    elseif missionType == self.g_SubMissionTypeEnum["DingDianYinDao"] then
        local index = self:GetMissionParam(selfId, misIndex, 2)
        itemId = self.g_DingDianYinDaoList[index]["itemId"]
        itemCount = self:LuaFnGetAvailableItemCount(selfId, itemId)
        if itemCount >= 1 then
            self:DelItem(selfId, itemId)
        end
    elseif missionType == self.g_SubMissionTypeEnum["ShouJi"] then
        itemId = self:GetMissionParam(selfId, misIndex, self.g_StrForePart + 2)
        itemCount = self:LuaFnGetAvailableItemCount(selfId, itemId)
        if itemCount > 5 then
            itemCount = 5
        end
        if itemCount > 0 then
            self:LuaFnDelAvailableItem(selfId, itemId, itemCount)
        end
    end
    self:DelMission(selfId, self.g_MissionId)
    local Reward_Append, MissionRound = self:CallScriptFunction(500501, "OnSubmit_Necessary", selfId, targetId, 1)
    if Reward_Append == 2 and MissionRound == 20 then
        self:CallScriptFunction(229010, "AddOtherMenpaiFubenMission", selfId, self.g_MissionId, targetId)
    end
end

return event_shimen_dali
