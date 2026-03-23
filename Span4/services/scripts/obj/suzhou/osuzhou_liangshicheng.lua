local class = require "class"
local define = require "define"
local script_base = require "script_base"
local osuzhou_liangshicheng = class("osuzhou_liangshicheng", script_base)
osuzhou_liangshicheng.script_id = 001067
osuzhou_liangshicheng.g_eventList = {1018716,1018717}
--所有兑换内容全部集中在这个组里
osuzhou_liangshicheng.g_ItemDataInfo =
{ 
    [1] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10413007, ["nPrizeItemNum"] = 1 },
    [2] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10421007, ["nPrizeItemNum"] = 1 },
    [3] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10412007, ["nPrizeItemNum"] = 1 },
    [4] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10411007, ["nPrizeItemNum"] = 1 },
    [5] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10413001, ["nPrizeItemNum"] = 1 },
    [6] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10421001, ["nPrizeItemNum"] = 1 },
    [7] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10412001, ["nPrizeItemNum"] = 1 },
    [8] = { ["needItem"] = 20309010, ["needItemNum"] = 6, ["nPrizeItem"] = 10411001, ["nPrizeItemNum"] = 1 },
    [9] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10413008, ["nPrizeItemNum"] = 1 },
    [10] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10421008, ["nPrizeItemNum"] = 1 },
    [11] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10412008, ["nPrizeItemNum"] = 1 },
    [12] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10411008, ["nPrizeItemNum"] = 1 },
    [13] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10413002, ["nPrizeItemNum"] = 1 },
    [14] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10421002, ["nPrizeItemNum"] = 1 },
    [15] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10412002, ["nPrizeItemNum"] = 1 },
    [16] = { ["needItem"] = 20309011, ["needItemNum"] = 8, ["nPrizeItem"] = 10411002, ["nPrizeItemNum"] = 1 },
    [17] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10413009, ["nPrizeItemNum"] = 1 },
    [18] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10421009, ["nPrizeItemNum"] = 1 },
    [19] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10412009, ["nPrizeItemNum"] = 1 },
    [20] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10411009, ["nPrizeItemNum"] = 1 },
    [21] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10414024, ["nPrizeItemNum"] = 1 },
    [22] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10413003, ["nPrizeItemNum"] = 1 },
    [23] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10421003, ["nPrizeItemNum"] = 1 },
    [24] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10412003, ["nPrizeItemNum"] = 1 },
    [25] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10411003, ["nPrizeItemNum"] = 1 },
    [26] = { ["needItem"] = 20309012, ["needItemNum"] = 10, ["nPrizeItem"] = 10414020, ["nPrizeItemNum"] = 1 },
    [27] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10413010, ["nPrizeItemNum"] = 1 },
    [28] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10421010, ["nPrizeItemNum"] = 1 },
    [29] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10412010, ["nPrizeItemNum"] = 1 },
    [30] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10411010, ["nPrizeItemNum"] = 1 },
    [31] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10414025, ["nPrizeItemNum"] = 1 },
    [32] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10413004, ["nPrizeItemNum"] = 1 },
    [33] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10421004, ["nPrizeItemNum"] = 1 },
    [34] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10412004, ["nPrizeItemNum"] = 1 },
    [35] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10411004, ["nPrizeItemNum"] = 1 },
    [36] = { ["needItem"] = 20309013, ["needItemNum"] = 12, ["nPrizeItem"] = 10414021, ["nPrizeItemNum"] = 1 },
    [37] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10413011, ["nPrizeItemNum"] = 1 },
    [38] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10421011, ["nPrizeItemNum"] = 1 },
    [39] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10412011, ["nPrizeItemNum"] = 1 },
    [40] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10411011, ["nPrizeItemNum"] = 1 },
    [41] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10414026, ["nPrizeItemNum"] = 1 },
    [42] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10415018, ["nPrizeItemNum"] = 1 },
    [43] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10413005, ["nPrizeItemNum"] = 1 },
    [44] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10421005, ["nPrizeItemNum"] = 1 },
    [45] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10412005, ["nPrizeItemNum"] = 1 },
    [46] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10411005, ["nPrizeItemNum"] = 1 },
    [47] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10414022, ["nPrizeItemNum"] = 1 },
    [48] = { ["needItem"] = 20309014, ["needItemNum"] = 14, ["nPrizeItem"] = 10415016, ["nPrizeItemNum"] = 1 },
    [49] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10413012, ["nPrizeItemNum"] = 1 },
    [50] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10421012, ["nPrizeItemNum"] = 1 },
    [51] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10412012, ["nPrizeItemNum"] = 1 },
    [52] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10411012, ["nPrizeItemNum"] = 1 },
    [53] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10414027, ["nPrizeItemNum"] = 1 },
    [54] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10415019, ["nPrizeItemNum"] = 1 },
    [55] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10413006, ["nPrizeItemNum"] = 1 },
    [56] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10421006, ["nPrizeItemNum"] = 1 },
    [57] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10412006, ["nPrizeItemNum"] = 1 },
    [58] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10411006, ["nPrizeItemNum"] = 1 },
    [59] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10414023, ["nPrizeItemNum"] = 1 },
    [60] = { ["needItem"] = 20309015, ["needItemNum"] = 16, ["nPrizeItem"] = 10415017, ["nPrizeItemNum"] = 1 },
    [61] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10413017, ["nPrizeItemNum"] = 1 },
    [62] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10421014, ["nPrizeItemNum"] = 1 },
    [63] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10412017, ["nPrizeItemNum"] = 1 },
    [64] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10411014, ["nPrizeItemNum"] = 1 },
    [65] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10414028, ["nPrizeItemNum"] = 1 },
    [66] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10415020, ["nPrizeItemNum"] = 1 },
    [67] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10413018, ["nPrizeItemNum"] = 1 },
    [68] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10421015, ["nPrizeItemNum"] = 1 },
    [69] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10412018, ["nPrizeItemNum"] = 1 },
    [70] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10411015, ["nPrizeItemNum"] = 1 },
    [71] = { ["needItem"] = 20309016, ["needItemNum"] = 32, ["nPrizeItem"] = 10414029, ["nPrizeItemNum"] = 1 },
    [72] = { ["needItem"] = 20309016, ["needItemNum"] = 48, ["nPrizeItem"] = 10415021, ["nPrizeItemNum"] = 1 },
    [73] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10413019, ["nPrizeItemNum"] = 1 },
    [74] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10421016, ["nPrizeItemNum"] = 1 },
    [75] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10412019, ["nPrizeItemNum"] = 1 },
    [76] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10411016, ["nPrizeItemNum"] = 1 },
    [77] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10414030, ["nPrizeItemNum"] = 1 },
    [78] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10415022, ["nPrizeItemNum"] = 1 },
    [79] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10413020, ["nPrizeItemNum"] = 1 },
    [80] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10421017, ["nPrizeItemNum"] = 1 },
    [81] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10412020, ["nPrizeItemNum"] = 1 },
    [82] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10411017, ["nPrizeItemNum"] = 1 },
    [83] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10414031, ["nPrizeItemNum"] = 1 },
    [84] = { ["needItem"] = 20309017, ["needItemNum"] = 48, ["nPrizeItem"] = 10415023, ["nPrizeItemNum"] = 1 },
    [85] = { ["needItem"] = 20310101, ["needItemNum"] = 20, ["nPrizeItem"] = 10422150, ["nPrizeItemNum"] = 1 },
    [86] = { ["needItem"] = 20310102, ["needItemNum"] = 20, ["nPrizeItem"] = 10423024, ["nPrizeItemNum"] = 1 },
}
osuzhou_liangshicheng.MenPaiEquipInfo = 
{
    [1] = {{10513001,10514001},{10520002,10521002,10522002},{10514003,10522003}},
    [2] = {{10521011,10522011},{10510012,10511012,10512012},{10520013,10523013}},
    [3] = {{10511021,10512021},{10513022,10514022,10515022},{10510023,10522023}},
    [4] = {{10513031,10514031},{10520032,10521032,10522032},{10514033,10522033}},
    [5] = {{10521041,10520041},{10510042,10511042,10512042},{10510043,10523043}},
    [6] = {{10511051,10512051},{10513052,10514052,10515052},{10510053,10522053}},
    [7] = {{10510081,10511081},{10513082,10514082,10515082},{10512083,10522083}},
    [8] = {{10513061,10514061},{10520062,10521062,10522062},{10512063,10514063}},
    [9] = {{10521071,10522071},{10510072,10511072,10512072},{10510073,10523073}},
    [11] = {{10521119,10522119},{10510118,10511119,10512118},{10510119,10523119}},
}
osuzhou_liangshicheng.BiaoQiEquipInfo = 
{
    [1] = {{10400076,10402076,10404073,10405072},{10410128,10410132},{10415045,10415049},{10413087,10413091},{10412084,10412088},{10414045,10414049},{10421078,10421082},{10411088,10411092},{10420080,10420084},{10422141,10422145},{10423050,10423054}},
    [2] = {{10400077,10402077,10404074,10405073},{10410129,10410133},{10415046,10415050},{10413088,10413092},{10412085,10412089},{10414046,10414050},{10421079,10421083},{10411089,10411093},{10420081,10420085},{10422142,10422146},{10423051,10423055}},
    [3] = {{10400078,10402078,10404075,10405074},{10410130,10410134},{10415047,10415051},{10413089,10413093},{10412086,10412090},{10414047,10414051},{10421080,10421084},{10411090,10411094},{10420082,10420086},{10422143,10422147},{10423052,10423056}},
    [4] = {{10400079,10402079,10404076,10405075},{10410131,10410135},{10415048,10415052},{10413090,10413094},{10412087,10412091},{10414048,10414052},{10421081,10421085},{10411091,10411095},{10420083,10420087},{10422144,10422148},{10423053,10423057}},
}
function osuzhou_liangshicheng:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  #{JPZB_0610_01}")
    self:AddNumText("兑换师门套装", 6, 1000)
    self:AddNumText("兑换18级套装", 6, 2000)
    self:AddNumText("兑换30级套装", 6, 3000)
    self:AddNumText("兑换40级套装", 6, 4000)
    self:AddNumText("兑换50级套装", 6, 5000)
    self:AddNumText("兑换60级套装", 6, 6000)
    self:AddNumText("兑换70级套装", 6, 7000)
    self:AddNumText("兑换80级套装", 6, 8000)
    self:AddNumText("兑换90级套装", 6, 9000)
    self:AddNumText("魔兵天降介绍", 11, 11000)
    self:AddNumText("魔兵天降", 6, 10000)
    self:AddNumText("兑换骠骑套装", 6, 14000)
    self:AddNumText("关于骠骑套装", 11, 13000)
    self:AddNumText("离开……", 0, 0)
    for i, eventId in pairs(self.g_eventList) do
        self:CallScriptFunction(eventId, "OnEnumerate", self, selfId, targetId)
    end
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function osuzhou_liangshicheng:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function osuzhou_liangshicheng:OnEventRequest(selfId, targetId, arg, index)
    local nNumText = index
    for i, findId in pairs(self.g_eventList) do
        if arg == findId then
            self:CallScriptFunction(findId, "OnDefaultEvent", selfId, targetId, arg, index)
            return
        end
    end
    --师门套装兑换列
    if nNumText == 1000 then
        self:BeginEvent(self.script_id)
        self:AddNumText("1级新人令牌兑换20级师门套装", 0, 1100)
        self:AddNumText("2级新人令牌兑换30级师门套装", 0, 1200)
        self:AddNumText("3级新人令牌兑换40级师门套装", 0, 1300)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 1100 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{YD_20080421_215}")
        self:AddText(" #{YD_20080421_216}"..self:GetItemName(40004448).."”".."1#{YD_20080421_217}")
        for i = 1,2 do
            self:AddRadioItemBonus(self.MenPaiEquipInfo[self:GetMenPai(selfId) + 1][1][i],4)
        end
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId,targetId,23100601, 0)
    elseif nNumText == 1200 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{YD_20080421_215}")
        self:AddText(" #{YD_20080421_216}"..self:GetItemName(40004449).."”".."1#{YD_20080421_217}")
        for i = 1,3 do
            self:AddRadioItemBonus(self.MenPaiEquipInfo[self:GetMenPai(selfId) + 1][2][i],4)
        end
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId,targetId,23100601, 0)
    elseif nNumText == 1300 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{YD_20080421_215}")
        self:AddText(" #{YD_20080421_216}"..self:GetItemName(40004450).."”".."1#{YD_20080421_217}")
        for i = 1,2 do
            self:AddRadioItemBonus(self.MenPaiEquipInfo[self:GetMenPai(selfId) + 1][3][i],4)
        end
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId,targetId,23100601, 0)
    end
    --御赐套装系列兑换
    if nNumText >= 2000 and nNumText <= 3000 then
        self:BeginEvent(self.script_id)
            self:AddText(" #{JPZB_0610_02}")
            self:AddNumText("兑换衣服", 0, nNumText + 100)
            self:AddNumText("兑换腰带", 0, nNumText + 200)
            self:AddNumText("兑换手套", 0, nNumText + 300)
            self:AddNumText("兑换鞋子", 0, nNumText + 400)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText >= 4000 and nNumText <= 5000 then
        self:BeginEvent(self.script_id)
            self:AddText(" #{JPZB_0610_02}")
            self:AddNumText("兑换衣服", 0, nNumText + 100)
            self:AddNumText("兑换腰带", 0, nNumText + 200)
            self:AddNumText("兑换手套", 0, nNumText + 300)
            self:AddNumText("兑换鞋子", 0, nNumText + 400)
            self:AddNumText("兑换护腕", 0, nNumText + 500)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText >= 6000 and nNumText <= 9000 then
        self:BeginEvent(self.script_id)
            self:AddText(" #{JPZB_0610_02}")
            self:AddNumText("兑换衣服", 0, nNumText + 100)
            self:AddNumText("兑换腰带", 0, nNumText + 200)
            self:AddNumText("兑换手套", 0, nNumText + 300)
            self:AddNumText("兑换鞋子", 0, nNumText + 400)
            self:AddNumText("兑换护腕", 0, nNumText + 500)
            self:AddNumText("兑换衬肩", 0, nNumText + 600)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    local nIndex,nIndex_2 = 0,0
    if nNumText == 2100 then
        nIndex,nIndex_2 = 1,5
    elseif nNumText == 2200 then
        nIndex,nIndex_2 = 2,6
    elseif nNumText == 2300 then
        nIndex,nIndex_2 = 3,7
    elseif nNumText == 2400 then
        nIndex,nIndex_2 = 4,8
    elseif nNumText == 3100 then
        nIndex,nIndex_2 = 9,13
    elseif nNumText == 3200 then
        nIndex,nIndex_2 = 10,14
    elseif nNumText == 3300 then
        nIndex,nIndex_2 = 11,15
    elseif nNumText == 3400 then
        nIndex,nIndex_2 = 12,16
    elseif nNumText == 4100 then
        nIndex,nIndex_2 = 17,22
    elseif nNumText == 4200 then
        nIndex,nIndex_2 = 18,23
    elseif nNumText == 4300 then
        nIndex,nIndex_2 = 19,24
    elseif nNumText == 4400 then
        nIndex,nIndex_2 = 20,25
    elseif nNumText == 4500 then
        nIndex,nIndex_2 = 21,26
    elseif nNumText == 5100 then
        nIndex,nIndex_2 = 27,32
    elseif nNumText == 5200 then
        nIndex,nIndex_2 = 28,33
    elseif nNumText == 5300 then
        nIndex,nIndex_2 = 29,34
    elseif nNumText == 5400 then
        nIndex,nIndex_2 = 30,35
    elseif nNumText == 5500 then
        nIndex,nIndex_2 = 31,36
    elseif nNumText == 6100 then
        nIndex,nIndex_2 = 37,43
    elseif nNumText == 6200 then
        nIndex,nIndex_2 = 38,44
    elseif nNumText == 6300 then
        nIndex,nIndex_2 = 39,45
    elseif nNumText == 6400 then
        nIndex,nIndex_2 = 40,46
    elseif nNumText == 6500 then
        nIndex,nIndex_2 = 41,47
    elseif nNumText == 6600 then
        nIndex,nIndex_2 = 42,48
    elseif nNumText == 7100 then
        nIndex,nIndex_2 = 49,55
    elseif nNumText == 7200 then
        nIndex,nIndex_2 = 50,56
    elseif nNumText == 7300 then
        nIndex,nIndex_2 = 51,57
    elseif nNumText == 7400 then
        nIndex,nIndex_2 = 52,58
    elseif nNumText == 7500 then
        nIndex,nIndex_2 = 53,59
    elseif nNumText == 7600 then
        nIndex,nIndex_2 = 54,60
    elseif nNumText == 8100 then
        nIndex,nIndex_2 = 61,67
    elseif nNumText == 8200 then
        nIndex,nIndex_2 = 62,68
    elseif nNumText == 8300 then
        nIndex,nIndex_2 = 63,69
    elseif nNumText == 8400 then
        nIndex,nIndex_2 = 64,70
    elseif nNumText == 8500 then
        nIndex,nIndex_2 = 65,71
    elseif nNumText == 8600 then
        nIndex,nIndex_2 = 66,72
    elseif nNumText == 9100 then
        nIndex,nIndex_2 = 73,79
    elseif nNumText == 9200 then
        nIndex,nIndex_2 = 74,80
    elseif nNumText == 9300 then
        nIndex,nIndex_2 = 75,81
    elseif nNumText == 9400 then
        nIndex,nIndex_2 = 76,82
    elseif nNumText == 9500 then
        nIndex,nIndex_2 = 77,83
    elseif nNumText == 9600 then
        nIndex,nIndex_2 = 78,84
    end
    if nNumText >= 2100 and nNumText <= 9600 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{YD_20080421_215}")
        self:AddText(" #{YD_20080421_216}"..self:GetItemName(self.g_ItemDataInfo[nIndex]["needItem"]).."“"..self.g_ItemDataInfo[nIndex]["needItemNum"].."”#{YD_20080421_217}")
        self:AddRadioItemBonus(self.g_ItemDataInfo[nIndex]["nPrizeItem"],4)
        self:AddRadioItemBonus(self.g_ItemDataInfo[nIndex_2]["nPrizeItem"],4)
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId,targetId,self.script_id, 0)
    end
    --骠骑套装兑换
    if nNumText == 14000 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{JJTZ_090826_06}")
        self:AddNumText("兑换30级骠骑套装", 6, nNumText + 100)
        self:AddNumText("兑换50级骠骑套装", 6, nNumText + 200)
        self:AddNumText("兑换70级骠骑套装", 6, nNumText + 300)
        self:AddNumText("兑换90级骠骑套装", 6, nNumText + 400)
        self:AddNumText("#{JJTZ_090826_24}", 0, 20000)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 20000 then
        self:OnDefaultEvent(selfId, targetId)
    end
    if nNumText >= 14100 and nNumText <= 14400 then
        self:BeginEvent(self.script_id)
        self:AddText(" #{JPZB_0610_02}")
        self:AddNumText("#{JJTZ_090826_13}", 0, nNumText + 1001)
        self:AddNumText("#{JJTZ_090826_14}", 0, nNumText + 1002)
        self:AddNumText("#{JJTZ_090826_15}", 0, nNumText + 1003)
        self:AddNumText("#{JJTZ_090826_16}", 0, nNumText + 1004)
        self:AddNumText("#{JJTZ_090826_17}", 0, nNumText + 1005)
        self:AddNumText("#{JJTZ_090826_18}", 0, nNumText + 1006)
        self:AddNumText("#{JJTZ_090826_19}", 0, nNumText + 1007)
        self:AddNumText("#{JJTZ_090826_20}", 0, nNumText + 1008)
        self:AddNumText("#{JJTZ_090826_21}", 0, nNumText + 1009)
        self:AddNumText("#{JJTZ_090826_22}", 0, nNumText + 1010)
        self:AddNumText("#{JJTZ_090826_23}", 0, nNumText + 1011)
		self:AddNumText("#{JJTZ_090826_24}", 0, 14000)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText >= 15101 and nNumText <= 15411 then
        self:BeginEvent(self.script_id)
        self:AddText("  #{JJTZ_090826_25}")
        for i = 1,#self.BiaoQiEquipInfo[(math.floor(nNumText/100)) % 10][(nNumText % 100)] do
            self:AddRadioItemBonus(self.BiaoQiEquipInfo[(math.floor(nNumText/100)) % 10][(nNumText % 100)][i],4)
        end
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId,targetId,23100602, 0)
    end
    --重楼兑换
    if nNumText == 10000 then
        self:BeginEvent(self.script_id)
        self:AddText("  #{JPZB_0610_06}")
        for i = 85,86 do
            self:AddRadioItemBonus(self.g_ItemDataInfo[i]["nPrizeItem"],4)
        end
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId,targetId,self.script_id, 0)
    end
    if nNumText == 0 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
        return
    end
    if nNumText == 11000 then
        self:BeginEvent(self.script_id)
        self:AddText("#{JPZB_20080523_01}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if nNumText == 13000 then
        self:BeginEvent(self.script_id)
        self:AddText("#{JJTZ_090826_05}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function osuzhou_liangshicheng:OnMissionAccept(selfId, targetId, missionScriptId)
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

function osuzhou_liangshicheng:OnMissionRefuse(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:UpdateEventList(selfId, targetId)
            return
        end
    end
end

function osuzhou_liangshicheng:OnMissionContinue(selfId, targetId, missionScriptId)
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnContinue", selfId, targetId)
            return
        end
    end
end

function osuzhou_liangshicheng:ExchangeItem(selfId, targetId, selectRadioId)
    local nItemIndex = -1
    for i = 1, #(self.g_ItemDataInfo) do
        if self.g_ItemDataInfo[i]["nPrizeItem"] == selectRadioId then
            nItemIndex = i
            break
        end
    end
    if nItemIndex == -1 then
        return
    end
    local HaveItenCost = self:LuaFnGetAvailableItemCount(selfId, self.g_ItemDataInfo[nItemIndex]["needItem"])
    if HaveItenCost < self.g_ItemDataInfo[nItemIndex]["needItemNum"] then
        self:BeginEvent(self.script_id)
        self:AddText(
            string.format(
                "您缺少：#G%s个%s，没有兑换资格。",
                self.g_ItemDataInfo[nItemIndex]["needItemNum"],
                self:GetItemName(self.g_ItemDataInfo[nItemIndex]["needItem"])
            )
        )
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:BeginAddItem()
    self:AddItem(self.g_ItemDataInfo[nItemIndex]["nPrizeItem"], self.g_ItemDataInfo[nItemIndex]["nPrizeItemNum"])
    if not self:EndAddItem(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText("背包空间不足。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if
        not self:LuaFnDelAvailableItem(
            selfId,
            self.g_ItemDataInfo[nItemIndex]["needItem"],
            self.g_ItemDataInfo[nItemIndex]["needItemNum"]
        )
    then
        self:BeginEvent(self.script_id)
        self:AddText("物品扣除失败")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:AddItemListToHuman(selfId)
end

function osuzhou_liangshicheng:OnDie(selfId, killerId)
end

function osuzhou_liangshicheng:OnMissionSubmit(selfId, targetId, missionScriptId, selectRadioId)
    if missionScriptId == self.script_id then
        self:ExchangeItem(selfId, targetId, selectRadioId)
        return
    end
    if missionScriptId == 23100601 then
        local nIndex,EquipIdx = 0,0
        local DuiHuanItem = {40004448,40004449,40004450}
        for i = 1,#self.MenPaiEquipInfo[self:GetMenPai(selfId) + 1] do
            for j = 1,#self.MenPaiEquipInfo[self:GetMenPai(selfId) + 1][i] do
                if selectRadioId == self.MenPaiEquipInfo[self:GetMenPai(selfId) + 1][i][j] then
                    nIndex = i
                    EquipIdx = j
                    break
                end
            end
        end
        if self:LuaFnGetAvailableItemCount(selfId,DuiHuanItem[nIndex]) < 1 then
            self:notify_tips(selfId,"#{YD_20080421_218}"..self:GetItemName(DuiHuanItem[nIndex]))
            return
        end
        --先判断背包格子够不够装下
        self:BeginAddItem()
        self:AddItem(self.MenPaiEquipInfo[self:GetMenPai(selfId) + 1][nIndex][EquipIdx],1)
        if not self:EndAddItem(selfId) then
            self:BeginEvent(self.script_id)
            self:AddText("背包空间不足。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        if not self:LuaFnDelAvailableItem(selfId,DuiHuanItem[nIndex],1) then
            self:BeginEvent(self.script_id)
            self:AddText("#{YD_20080421_220}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:notify_tips(selfId,"#{YD_20080421_221}")
        self:AddItemListToHuman(selfId)
        return
    end
    if missionScriptId == 23100602 then
        if self:LuaFnGetAvailableItemCount(selfId,30505197) < 1 then
            self:notify_tips(selfId,"#{JJTZ_090826_27}")
            return
        end
        --先判断背包格子够不够装下
        self:BeginAddItem()
        self:AddItem(selectRadioId,1)
        if not self:EndAddItem(selfId) then
            self:BeginEvent(self.script_id)
            self:AddText("#{JJTZ_090826_28}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        if not self:LuaFnDelAvailableItem(selfId,30505197,1) then
            self:notify_tips(selfId,"#{JJTZ_090826_27}")
            return
        end
        self:notify_tips(selfId,"#{JJTZ_090826_29}")
        self:AddItemListToHuman(selfId)
        return
    end
    for i, findId in pairs(self.g_eventList) do
        if missionScriptId == findId then
            self:CallScriptFunction(missionScriptId, "OnSubmit", selfId, targetId, selectRadioId)
            return
        end
    end
end

return osuzhou_liangshicheng
