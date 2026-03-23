local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oHanYuBed_NPC = class("oHanYuBed_NPC", script_base)
oHanYuBed_NPC.script_id = 402106
oHanYuBed_NPC.g_PosTbl = {
    {["x"] = 28, ["y"] = 30}, {["x"] = 70, ["y"] = 25},
    {["x"] = 70, ["y"] = 70}, {["x"] = 26, ["y"] = 70},
    {["x"] = 66, ["y"] = 66}, {["x"] = 44, ["y"] = 44},
    {["x"] = 58, ["y"] = 58}, {["x"] = 50, ["y"] = 50},
    {["x"] = 48, ["y"] = 58}, {["x"] = 34, ["y"] = 56},
    {["x"] = 65, ["y"] = 43}, {["x"] = 33, ["y"] = 44}
}

function oHanYuBed_NPC:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    local sceneId = self:GetSceneID()
    if sceneId == 1 then
        self:AddText("#{HANYUBED_20071221_01}")
        self:AddText("#G每日可使用3次")
        self:AddText("#G每日可购买1本")
        self:AddNumText("进入寒玉谷", 9, 1)
    elseif sceneId == 194 then
        self:AddText("#{HANYUBED_20071221_02}")
        self:AddText("#G每日可使用3次")
        self:AddText("#G每日可购买1本")
        self:AddNumText("回到苏州", 9, 2)
    end
    self:AddNumText("购买古墓行功要诀", 6, 3)
    self:AddNumText("在寒玉谷中修行的四项注意", 11, 4)
    self:AddNumText("夫妻行功要诀使用说明", 11, 100)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oHanYuBed_NPC:OnEventRequest(selfId, targetId, arg, index)
    local NumText = index
    if NumText == 1 then
        local idx = math.random(#(self.g_PosTbl))
        self:CallScriptFunction((400900), "TransferFunc", selfId, 194,
                                self.g_PosTbl[idx]["x"], self.g_PosTbl[idx]["y"])
    elseif NumText == 2 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 178, 132)
    elseif NumText == 3 then
        local PlayerLevel = self:GetLevel(selfId)
        if PlayerLevel < 30 then
            self:BeginEvent(self.script_id)
            self:AddText("#{HANYUBED_20071221_06}")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local NeedMoney = self:CalcBookPrice(selfId)
        if NeedMoney <= 0 then return end
        self:BeginEvent(self.script_id)
        self:AddText("#{HANYUBED_20071221_04}#{_MONEY" .. NeedMoney ..
                         "}#{HANYUBED_20071221_05}")
        self:AddText("#G每日可使用3次")
        self:AddText("#G每日可购买1本")
        self:AddNumText("确定", 8, 5)
        self:AddNumText("取消", 8, 6)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif NumText == 4 then
        self:BeginEvent(self.script_id)
        self:AddText("#{HANYUBED_20071221_03}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif NumText == 5 then
        self:BuyBook(selfId, targetId)
    elseif NumText == 6 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    elseif NumText == 100 then
        self:BeginEvent(self.script_id)
        self:AddText("#{FUQIYAOJUE_1}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oHanYuBed_NPC:BuyBook(selfId, targetId)
    local PlayerLevel = self:GetLevel(selfId)
    if PlayerLevel < 30 then return end
    if self:LuaFnGetPropertyBagSpace(selfId) < 1 then
        self:BeginEvent(self.script_id)
        self:AddText("#{HANYUBED_20071221_07}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local MRGMCS = self:GetMissionData(selfId, define.MD_ENUM.MD_HANYUBED_CANADDEXP_COUNT)
    if MRGMCS >= 1 then
        self:ShowTips(selfId, "每日可购买1次古墓行功要诀，请明日在购买哦！")
        return 0
    end
    local NeedMoney = self:CalcBookPrice(selfId)
    if NeedMoney <= 0 then return end
    local CurMoney = self:LuaFnGetMoney(selfId)
    if CurMoney < NeedMoney then
        self:BeginEvent(self.script_id)
        self:AddText("#{HANYUBED_20071221_08}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:TryRecieveItem(selfId, 30700200, 1)
    self:LuaFnCostMoneyWithPriority(selfId, 1880000)
    self:SetMissionData(selfId, define.MD_ENUM.MD_HANYUBED_CANADDEXP_COUNT, 1)
    local str1 = "你付出了#{_MONEY" .. NeedMoney .. "}。"
    local str2 = "你购买了一个#{_ITEM" .. (30700200) .. "}。"
    self:BeginEvent(self.script_id)
    self:AddText(str1)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
    self:BeginEvent(self.script_id)
    self:AddText(str2)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
    self:Msg2Player(selfId, str1, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(selfId, str2, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
end

function oHanYuBed_NPC:CalcBookPrice(selfId) return 1880000 end

function oHanYuBed_NPC:ShowTips(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return oHanYuBed_NPC
