local class = require "class"
local define = require "define"
local script_base = require "script_base"
local FeelFeedBack800 = class("FeelFeedBack800", script_base)
local ScriptGlobal = require("scripts.ScriptGlobal")
FeelFeedBack800.script_id = 792012
FeelFeedBack800.g_FeelFeedBack800_PrizeList = {
    [1] = 
    {
        [1] = { ["ItemID"] = 38002780, ["num"] = 1 },
        [2] = { ["ItemID"] = 30501361, ["num"] = 1 },
        [3] = { ["ItemID"] = 38000060, ["num"] = 1 },
    },
    [2] = 
    { 
        [1] = { ["ItemID"] = 30900045, ["num"] = 1 },
        [2] = { ["ItemID"] = 30502002, ["num"] = 1 },
        [3] = { ["ItemID"] = 38000060, ["num"] = 1 },
    },
    [3] = 
    {
        [1] = { ["ItemID"] = 38002779, ["num"] = 1 },
        [2] = { ["ItemID"] = 30008115, ["num"] = 1 },
        [3] = { ["ItemID"] = 38000060, ["num"] = 1 },
    },
    [4] = 
    { 
        [1] = { ["ItemID"] = 38002519, ["num"] = 1 },
        [2] = { ["ItemID"] = 30503133, ["num"] = 1 },
        [3] = { ["ItemID"] = 38000060, ["num"] = 1 },
    },
    [5] = 
    { 
        [1] = { ["ItemID"] = 20310168, ["num"] = 1 },
        [2] = { ["ItemID"] = 38002530, ["num"] = 1 },
        [3] = { ["ItemID"] = 38000060, ["num"] = 1 },
    },
    [6] = 
    { 
        [1] = { ["ItemID"] = 20502003, ["num"] = 1 },
        [2] = { ["ItemID"] = 38002524, ["num"] = 1 },
        [3] = { ["ItemID"] = 38000060, ["num"] = 1 },
    },
    [7] = { 
        [1] = { ["ItemID"] = 50313004, ["num"] = 1 },
        [2] = { ["ItemID"] = 20501003, ["num"] = 1 },
        [3] = { ["ItemID"] = 38000060, ["num"] = 1 },
    }
}
local FeelFeedBack800BagSpeace = 
{
    [1] = {["Property"] = 3,["Material"] = 0},
    [2] = {["Property"] = 3,["Material"] = 0},
    [3] = {["Property"] = 3,["Material"] = 0},
    [4] = {["Property"] = 2,["Material"] = 1},
    [5] = {["Property"] = 2,["Material"] = 1},
    [6] = {["Property"] = 2,["Material"] = 1},
    [7] = {["Property"] = 1,["Material"] = 2},
}
function FeelFeedBack800:CheckGetFullPrize(selfId)
    local nLingQu = self:GetMissionDataEx(selfId, 136)
    local IsShowButton = 1
    local IsShowTips = 1
    local nGetNum = 0
    local nTab = {}
    for i = 1, 7 do
        nTab[i] = (math.floor(nLingQu / 10 ^ (i - 1)) % 10)
        if nTab[i] ~= 0 then
            nGetNum = nGetNum + 1
        end
    end
    if nGetNum >= 7 then
        IsShowButton = 0
        IsShowTips = 0
    end
    self:BeginUICommand()
    self:UICommand_AddInt(IsShowButton)
    self:UICommand_AddInt(IsShowTips)
    self:EndUICommand()
    self:DispatchUICommand(selfId,79201201)
end

function FeelFeedBack800:GetPrize(selfId, Index)
	if self:GetLevel(selfId) < 15 then
		self:notify_tips(selfId,"#{QRDL_20211229_21}")
		return
	end
    local nLingQu = self:GetMissionDataEx(selfId, 136)
    local nTab = {}
    for i = 1, 7 do
        nTab[i] = (math.floor(nLingQu / 10 ^ (i - 1)) % 10)
    end
    if nTab[Index] == 1 then
        self:NotifySystemMsg(selfId, "#{QRDL_200915_24}")
        return
    end

    local nTime = self:GetMissionDataEx(selfId, 137)
    if Index > (nTime % 100) then
        self:NotifySystemMsg(selfId, "对不起，此奖励在满酒载歌贺此夕第"..tostring(Index).."天后开启，无法领取奖励。")
        return
    end
    self:BeginAddItem()
        self:AddItem(self.g_FeelFeedBack800_PrizeList[Index][1]["ItemID"], self.g_FeelFeedBack800_PrizeList[Index][1]["num"],true)
        self:AddItem(self.g_FeelFeedBack800_PrizeList[Index][2]["ItemID"], self.g_FeelFeedBack800_PrizeList[Index][2]["num"],true)
        self:AddItem(self.g_FeelFeedBack800_PrizeList[Index][3]["ItemID"], self.g_FeelFeedBack800_PrizeList[Index][3]["num"],true)
    if not self:EndAddItem(selfId) then
        self:NotifySystemMsg(selfId,"背包空间不足")
        return
    end
    local nBagsPos = self:LuaFnGetPropertyBagSpace(selfId)
    local nBagMaterial = self:LuaFnGetMaterialBagSpace(selfId)
    if nBagsPos < FeelFeedBack800BagSpeace[Index]["Property"] or nBagMaterial < FeelFeedBack800BagSpeace[Index]["Material"] then
        self:NotifySystemMsg(selfId,"背包空间不足。")
        return
    end
    self:AddItemListToHuman(selfId)
    nTab[Index]      = 1
    local nFinalData = 0
    for i = 1, 7 do
        nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
    end
    self:SetMissionDataEx(selfId, 136, nFinalData)
    self:NotifySystemMsg(selfId,string.format("您成功领取了%s个%s。",self.g_FeelFeedBack800_PrizeList[Index][1]["num"],self:GetItemName(self.g_FeelFeedBack800_PrizeList[Index][1]["ItemID"])))
    self:NotifySystemMsg(selfId,string.format("您成功领取了%s个%s。",self.g_FeelFeedBack800_PrizeList[Index][2]["num"],self:GetItemName(self.g_FeelFeedBack800_PrizeList[Index][2]["ItemID"])))
    self:NotifySystemMsg(selfId,string.format("您成功领取了%s个%s。",self.g_FeelFeedBack800_PrizeList[Index][3]["num"],self:GetItemName(self.g_FeelFeedBack800_PrizeList[Index][3]["ItemID"])))
    self:OnOpenMainWindow(selfId)
end

function FeelFeedBack800:OnOpenMainWindow(selfId)
    local nTime = self:GetMissionDataEx(selfId,137)
    local nLingQu = self:GetMissionDataEx(selfId,136)
	local NowTime = self:GetMissionData(selfId,522)
	local NewTime = self:GetDayTime()
    local nSevenDay = self:GetMissionData(selfId, 520)
	if NowTime ~= tonumber(NewTime) then
		if nSevenDay < 7 then
			self:SetMissionData(selfId,520,nSevenDay + 1) --记录登陆天数
		end
		if nTime < 7 then
			self:SetMissionDataEx(selfId,137,nTime + 1) --记录登陆天数
		end
		self:SetMissionData(selfId,522,tonumber(NewTime))
	end
    self:BeginUICommand()
    self:UICommand_AddInt(1)
    self:UICommand_AddInt(nTime)
    self:UICommand_AddInt(nLingQu)
	self:UICommand_AddInt(20231020)
	self:UICommand_AddInt(1)
	self:UICommand_AddInt(1)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 79201202)
end

function FeelFeedBack800:NotifySystemMsg(selfId, tip)
    self:BeginEvent(self.script_id)
    self:AddText(tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return FeelFeedBack800
