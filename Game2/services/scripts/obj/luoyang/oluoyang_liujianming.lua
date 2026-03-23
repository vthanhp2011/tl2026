-- 洛阳NPC
-- 刘健明
-- 普通
local class = require "class"
local script_base = require "script_base"
local oluoyang_liujianming = class("oluoyang_liujianming", script_base)
oluoyang_liujianming.script_id = 311002
local g_eventAddDETimeBegin = 200
local g_eventUpdateList = 100
local g_eventDETime_1 = 0
local g_eventDETime_2 = 1
local g_eventDETime_4 = 2
local g_eventDETime_Lock = 3
local g_eventDETime_Unlock = 4
local g_eventDETime_Ask = 5
local g_Abandon_Unlock = 7
local g_Do_Unlock = 6
local TIME_2000_01_03_ = 946828868

local g_BuffPalyer_25 = 60
local g_BuffAll_15 = 62
local g_BuffPet_25 = 61
local g_BuffPet_2 = 53
function oluoyang_liujianming:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function oluoyang_liujianming:OnEventRequest(selfId, targetId, arg, index)
    if index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_079}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetLevel(selfId) < 10 then
        self:BeginEvent(self.script_id)
        self:AddText("  你的等级还不到10级，还是再练练吧。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end

    local nCurTime = self:LuaFnGetCurrentTime()
    -- 上次刷新数据的时间
    local nPreTime = self:DEGetPreTime(selfId)
    if (nCurTime - nPreTime >= 3600 * 24 * 7) or
        (math.floor((nCurTime - TIME_2000_01_03_) / (3600 * 24 * 7)) ~=
            math.floor((nPreTime - TIME_2000_01_03_) / (3600 * 24 * 7))) then
        self:DEResetWeeklyFreeTime(selfId)
    end
    local nNowGetTime = 0
    if index == g_eventDETime_1 then
        nNowGetTime = 1
        self:AddDETime(selfId, targetId, 1, nCurTime, nPreTime)
    elseif index == g_eventDETime_2 then
        nNowGetTime = 2
        self:AddDETime(selfId, targetId, 2, nCurTime, nPreTime)
    elseif index == g_eventDETime_4 then
        nNowGetTime = 4
        self:AddDETime(selfId, targetId, 4, nCurTime, nPreTime)
    elseif index == g_eventDETime_Lock then
        -- 先检测一下是不是冻结状态，如果是，就返回，并直接提示
        if self:DEIsLock(selfId) then
            self:BeginEvent(self.script_id)
            self:AddText(
                "  你的双倍经验时间已经处于冻结状态了。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        -- 冻结的时候，
        local nCurHave = self:DEGetFreeTime(selfId)
        nCurHave = nCurHave + self:DEGetMoneyTime(selfId)

        -- 先计算下当前玩家身上剩下的时间
        local nTrueTime = nCurHave
        if nTrueTime <= 0 then
            self:BeginEvent(self.script_id)
            self:AddText("  你现在没有已领取的双倍时间啊！？")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:BeginUICommand()
        self:UICommand_AddInt(self.script_id)
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(50)
        self:UICommand_AddStr("LockTime")
        local str = string.format(
                        "\0你当前有%d分钟的双倍时间，你确定要冻结吗？",
                        math.floor(nTrueTime / 60))
        self:UICommand_AddStr(str)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 24)
    elseif index == g_eventDETime_Unlock then
        -- 解冻的时候，
        -- 先判断是不是有双倍经验时间可以解除
        if not self:DEIsLock(selfId) then
            self:BeginEvent(self.script_id)
            self:AddText(
                "  你没有在我这里冻结双倍经验时间啊！？")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end

        -- 如果玩家身上有药水的BUFF，需要给玩家一个提示
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, g_BuffPalyer_25) or
            self:LuaFnHaveImpactOfSpecificDataIndex(selfId, g_BuffAll_15) == 1 then
            self:BeginEvent(self.script_id)
            self:AddText(
                "  您身上已经存在了多倍经验时间，是否确认解冻？")
            self:AddNumText("确认解冻", 6, g_Do_Unlock)
            self:AddNumText("放弃解冻", 6, g_eventUpdateList)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end

        self:DESetLock(selfId, false)
        self:BeginEvent()
        self:AddText("  你冻结的双倍经验时间已经解冻了。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)

        -- 同步数据到客户端
        self:SendDoubleExpToClient(selfId)
    elseif index == g_Do_Unlock then
        self:DESetLock(selfId, false)
        self:BeginEvent(self.script_id)
        self:AddText("  你冻结的双倍经验时间已经解冻了。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        -- 同步数据到客户端
        self:SendDoubleExpToClient(selfId)
    elseif index == g_Abandon_Unlock then
        return
    elseif index == g_eventDETime_Ask then
        local nCount = self:DEGetCount(selfId)
        self:BeginEvent(self.script_id)
        if nCount and nCount > 0 then
            self:AddText(
                "可在我这里领取的你本周的双倍经验时间为#R" ..
                    tostring(math.floor(nCount)) ..
                    "小时#W，快好好利用吧。")
        else
            self:AddText(
                "真是遗憾，我能提供你本周的双倍经验时间为#R0小时#W了。")
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)

    elseif index == g_eventUpdateList then
        self:UpdateEventList(selfId, targetId)
    elseif index >= g_eventAddDETimeBegin then
        -- 验证并且增加
        local nPoint = index - g_eventAddDETimeBegin
        local nCount = self:DEGetCount(selfId)
        if nCount < nPoint then return end
        local nCurHave = self:DEGetFreeTime(selfId)
        nCurHave = nCurHave + self:DEGetMoneyTime(selfId)
        -- 先计算下当前玩家身上剩下的时间
        local nTrueTime = nCurHave;
        if nTrueTime < 0 then nTrueTime = 0 end
        self:WithDrawFreeDoubleExpTime(selfId, nPoint, 0, 0)
        self:BeginEvent(self.script_id)
        self:AddText("  你已成功领取了#R" .. nPoint ..
                         "小时#W的双倍经验时间。现在你一共拥有#Y" ..
                         tostring(math.floor((nTrueTime + nPoint * 3600) / 60)) ..
                         "分钟#W的双倍经验时间")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)

        self:notify_tips(selfId, "  你已成功领取了#R" .. nPoint ..
                             "小时#W的双倍经验时间。现在你一共拥有#Y" ..
                             tostring(
                                 math.floor((nTrueTime + nPoint * 3600) / 60)) ..
                             "分钟#W的双倍经验时间")
        -- 同步数据到客户端
        self:SendDoubleExpToClient(selfId)
    end
end

function oluoyang_liujianming:AddDETime(selfId, targetId, nPoint, nCurTime,
                                        nPreTime)
    local nCurHave = self:DEGetFreeTime(selfId)
    nCurHave = nCurHave + self:DEGetMoneyTime(selfId)

    local nFreeTime = self:DEGetFreeTime(selfId)
    -- 先计算下当前玩家身上剩下的时间
    local nTrueTime = nCurHave;

    if nTrueTime < 0 then nTrueTime = 0 end

    -- 看还有没有时间可以领取
    local nCount = self:DEGetCount(selfId)

    if (nCount <= 0) then
        self:BeginEvent(self.script_id)
        self:AddText(
            "  你本周从我这里可以领取的双倍经验时间，已经用完了。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end

    if nCount < nPoint then
        self:BeginEvent(self.script_id)
        self:AddText("  你没有这么多的时间可以领取了")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    -- 看身上是不是已经有比较多的时间了，2小时
    if nFreeTime >= 120 * 60 then
        self:BeginEvent(self.script_id)
        self:AddText(
            "  你在三大城市和自建城市中获得的双倍经验时间已经达到可领取的上限")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    -- 检测玩家不能拥有超过4个小时的时间
    if nFreeTime + nPoint * 3600 > 3600 * 4 then
        self:BeginEvent()
        self:AddText(
            "  你在三大城市和自建城市中获得的双倍经验时间已经达到可领取的上限")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    -- 看身上是不是有冻结了的时间
    if self:DEIsLock(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText(
            "  你还有冻结的双倍经验时间，还是先解冻再领取新的双倍经验时间吧。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end

    self:BeginEvent(self.script_id)
    if (nTrueTime / 60) > 0 then
        self:AddText("你本周双倍经验时间剩余#R" ..
                         tostring(math.floor(nCount)) ..
                         "小时#W，当前已有双倍经验时间#Y" ..
                         tostring(math.floor(nTrueTime / 60)) ..
                         "分钟#W，你确认要领取#Y" ..
                         tostring(math.floor(nPoint * 60)) ..
                         "分钟#W双倍经验时间吗？");
    else
        self:AddText("你本周双倍经验时间剩余#R" ..
                         tostring(math.floor(nCount)) ..
                         "小时#W，你确认要领取#Y" ..
                         tostring(math.floor(nPoint * 60)) ..
                         "分钟#W双倍经验时间吗？");
    end
    -- 如果这个时候玩家身上有双倍经验药水效果，需要给玩家提示
    if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, g_BuffPalyer_25) == 1 or
        self:LuaFnHaveImpactOfSpecificDataIndex(selfId, g_BuffAll_15) == 1 then
        self:AddText(
            "  #r  #R请注意:您身上已经存在了多倍经验时间，是否确认领取？");
    end
    self:AddNumText("是的，我要领取。", -1,
                    g_eventAddDETimeBegin + nPoint)
    self:AddNumText("不了，我点错了。", -1, g_eventUpdateList)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_liujianming:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("  #{LS_20080303}");
    self:AddNumText("我想领一小时双倍经验时间", 6, 0)
    self:AddNumText("我想领二小时双倍经验时间", 6, 1)
    self:AddNumText("我想领四小时双倍经验时间", 6, 2)
    self:AddNumText("我想冻结双倍经验时间", 6, 3)
    self:AddNumText("我想解冻双倍经验时间", 6, 4)
    self:AddNumText("我想查询我本周双倍经验时间", 6, 5)
    self:AddNumText("领双介绍", 11, 10)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_liujianming:LockTime(selfId, targetId)
    -- 获得服务器记录的实际的真实时间
    local nCurTime = self:LuaFnGetCurrentTime()
    local nCurHave = self:DEGetFreeTime(selfId)
    nCurHave = nCurHave + self:DEGetMoneyTime(selfId)
    -- 先计算下当前玩家身上剩下的时间
    local nTrueTime = nCurHave

    if nTrueTime < 0 then nTrueTime = 0 end

    self:DESetLock(selfId, true)

    local str = "  已经冻结了" .. tostring(math.floor(nTrueTime / 60)) ..
                    "分钟双倍经验时间"
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)

    self:notify_tips(selfId, str)

    -- 同步数据到客户端
    self:SendDoubleExpToClient(selfId)
end

return oluoyang_liujianming
