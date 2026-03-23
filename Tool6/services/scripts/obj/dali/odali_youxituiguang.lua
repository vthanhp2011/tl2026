local class = require "class"
local ScriptGlobal = require "scripts.ScriptGlobal"
local define = require "define"
local script_base = require "script_base"
local odali_youxituiguang = class("odali_youxituiguang", script_base)
odali_youxituiguang.script_id = 002084
local LevelGiftInfo = {
    {
        level = 1,
        prize = {
            { itemid = 30900056, num = 1 }, { itemid = 30008002, num = 1 }, { itemid = 38002168, num = 1 },
        }
    },
    {
        level = 10,
        prize = {
            { itemid = 30900056, num = 1 }, { itemid = 10141036, num = 1 }, { itemid = 10141026, num = 1 },
			{ itemid = 38002168, num = 1 },
        }
    },
    {
        level = 15,
        prize = {
            { itemid = 30900056, num = 1 }, { itemid = 10141208, num = 1 }, { itemid = 38002168, num = 1 },
        }
    },
    {
        level = 25,
        prize = {
            { itemid = 30008102, num = 1 }, { itemid = 30505076, num = 1 }, { itemid = 10155001, num = 1 },
			{ itemid = 38008021, num = 1 }
        }
    },
    {
        level = 30,
        prize = {
            { itemid = 30008002, num = 1 }, { itemid = 30505801, num = 5 }, { itemid = 30900045, num = 1 },
			{ itemid = 38008021, num = 1 }
        }
    },
    {
        level = 40,
        prize = {
            { itemid = 20310173, num = 40 }, { itemid = 30503149, num = 2 }, { itemid = 10156003, num = 1 },
            { itemid = 10156004, num = 1 }
        }
    },
    {
        level = 50,
        prize = {
            { itemid = 38002397, num = 10 }, { itemid = 20310168, num = 50 }, { itemid = 30700241, num = 5 },
			{ itemid = 38008005, num = 1 }
        }
    },
    {
        level = 70,
        prize = {
            { itemid = 50513004, num = 1 }, { itemid = 20501003, num = 5 }, { itemid = 20502003, num = 5 },
			{ itemid = 38008005, num = 1 }
        }
    },
    {
        level = 90,
        prize = {
            { itemid = 30505806, num = 2 }, { itemid = 30501361, num = 5 }, { itemid = 38008005, num = 3 }
        }
    },

}
function odali_youxituiguang:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{TLWS_20200908_01}")
    if self:GetMissionDataEx(selfId,132) == 0 then
        self:AddNumText("#{TLWS_20200908_02}", 2, 200)
    end
    self:AddNumText("#{TLWS_20200908_03}", 2, 300)
    self:AddNumText("#{TLWS_20200908_04}", 11, 400)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_youxituiguang:OnEventRequest(selfId, targetId, arg, index)
    if index == 200 then
        self:SetMissionDataEx(selfId, 132, 12020)
        self:notify_tips(selfId,"激活成功，请重新与我进行兑换领取财富卡奖励。")
        return
    end
    if index == 300 then
        if self:GetMissionDataEx(selfId,132) > 0 then
            self:BeginEvent(self.script_id)
            for i = 1, #(LevelGiftInfo) do
                self:AddNumText("领取" .. tostring(LevelGiftInfo[i].level) .. "级奖励", 6, 1000 + i)
            end
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        else
            self:notify_tips(selfId, "没有激活财富卡")
        end
        return
    end
    if index > 1000 and index < 1100 then
        local nFlag = self:GetMissionDataEx(selfId,132)
        if nFlag < 1 then
            self:notify_tips(selfId, "没有激活财富卡")
            return
        end
        local nSelect = index - 1000
        local nStateIdx = (nSelect % 10)
        if LevelGiftInfo[nSelect] == nil then
            return
        end
        local nLevel = self:GetLevel(selfId)
        if nLevel < LevelGiftInfo[nSelect].level then
            self:notify_tips(selfId, string.format("等级不足%s，无法领取当前奖励。",
                LevelGiftInfo[nSelect].level))
            return
        end
        local nStateData = self:GetMissionDataEx(selfId, 131);
        local tState = self:MathCilCompute_1_InEx(nStateData);
        if tState[nStateIdx + 1] == 1 then
            self:notify_tips(selfId, "该奖励已经领取过了。")
            return
        end
        --检测背包够不够
        self:BeginAddItem()
        for i = 1, #(LevelGiftInfo[nSelect].prize) do
            self:AddItem(LevelGiftInfo[nSelect].prize[i].itemid, LevelGiftInfo[nSelect].prize[i].num,true)
        end
        if not self:EndAddItem(selfId) then
            self:notify_tips(selfId, "背包空间不足。")
            return
        end
        self:AddItemListToHuman(selfId)
        --标记兑换
        tState[nStateIdx + 1] = 1;
        nStateData = self:MathCilCompute_1_OutEx(tState)
        self:SetMissionDataEx(selfId, 131, nStateData)
        self:notify_tips(selfId, "领取财富卡奖励成功，请查看你的背包。")
    end
    if index == 400 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TLWS_20200908_05}")
        self:AddNumText("#{TLWS_20200908_06}", 11, 402)
        self:AddNumText("#{TLWS_20200908_07}", 11, 403)
        self:AddNumText("#{TLWS_20200908_08}", 11, 404)
        self:AddNumText("#{TLWS_20200908_09}", 11, 405)
        self:AddNumText("#{TLWS_20200908_10}", 11, 406)
        self:AddNumText("#{TLWS_20200908_81}", 11, 407)
        self:AddNumText("#{INTERFACE_XML_602}", -1, 401)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 402 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TLWS_20200908_11}")
        self:AddNumText("#{INTERFACE_XML_602}", -1, 400)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 403 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TLWS_20200908_12}")
        self:AddNumText("#{INTERFACE_XML_602}", -1, 400)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 404 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TLWS_20200908_13}")
        self:AddNumText("#{INTERFACE_XML_602}", -1, 400)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 405 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TLWS_20200908_14}")
        self:AddNumText("#{INTERFACE_XML_602}", -1, 400)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 406 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TLWS_20200908_15}")
        self:AddNumText("#{INTERFACE_XML_602}", -1, 400)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 407 then
        self:BeginEvent(self.script_id)
        self:AddText("#{TLWS_20200908_16}")
        self:AddNumText("#{INTERFACE_XML_602}", -1, 400)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function odali_youxituiguang:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function odali_youxituiguang:NotifyTip(selfId, Msg)
    self:BeginEvent(self.script_id)
    self:AddText(Msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return odali_youxituiguang
