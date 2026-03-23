local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ScriptGlobal = require "scripts.ScriptGlobal"
local oprison_jailer = class("oprison_jailer", script_base)
oprison_jailer.script_id = 077011
oprison_jailer.g_Key = { ["dlg"] = 10, ["out"] = 11, ["sn0"] = 0, ["sn1"] = 1, ["sn2"] = 2 }
oprison_jailer.g_PKMinVal = 8
function oprison_jailer:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{PRISON_081120_01}")
    self:AddNumText("我要出去", 9, self.g_Key["out"])
    self:AddNumText("这里是哪儿？", 11, self.g_Key["dlg"])
    self:AddNumText("我要伸冤", 9, 21)
    self:AddNumText("我有特赦令", 9, 15)
    self:AddNumText("什么是伸冤？", 11, 22)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oprison_jailer:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    local val = self:LuaFnGetHumanPKValue(selfId)
    if key == 15 then
        local nItemCount = self:LuaFnGetAvailableItemCount(selfId, 30008019)
        if nItemCount < 1 then
            self:MsgBox(selfId, targetId, "#{TeSheLing_00}")
            return 0
        end
        local bRet = 0
        local nItemNum = self:LuaFnGetAvailableItemCount(selfId, 30008019)
        if nItemNum < 1 then
            self:MsgBox(selfId, targetId, "此物品已被锁定！")
            return 0
        end
        bRet = 1
        if bRet > 0 then
            self:BeginEvent(self.script_id)
            self:AddText("  恭喜你，你终于可以出去了，记得出去之后切莫再乱杀无辜，否则我是不会饶你的，你想去哪个城市？")
            self:AddNumText("洛阳", 9, 3)
            self:AddNumText("苏州", 9, 4)
            self:AddNumText("大理", 9, 5)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
        return 0
    end
    if key == 21 then
        self:ShenYuan(selfId, targetId)
        return 0
    elseif key == 22 then
        self:MsgBox(selfId, targetId, "#{PRISON_SHENYUAN_00}")
        return 0
    end
    if key == self.g_Key["dlg"] then
        self:MsgBox(selfId, targetId, "#{function_help_087}")
        return 0
    elseif key == self.g_Key["out"] then
        if val >= self.g_PKMinVal then
            self:MsgBox(selfId, targetId, "  您现在的杀气为" .. val .. "，只有小于" .. self.g_PKMinVal .. "点的时候才能出去。")
            return 0
        end
        self:LuaFnCancelSpecificImpact(selfId, 42)
        self:BeginEvent(self.script_id)
        self:AddText("  恭喜你，你终于可以出去了，记得出去之后切莫再乱杀无辜，否则我是不会饶你的，你想去哪个城市？")
        self:AddNumText("洛阳", 9, self.g_Key["sn0"])
        self:AddNumText("苏州", 9, self.g_Key["sn1"])
        self:AddNumText("大理", 9, self.g_Key["sn2"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["sn0"] then
        self:LuaFnCancelSpecificImpact(selfId,42)
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 132, 183,10)
    elseif key == self.g_Key["sn1"] then
        self:LuaFnCancelSpecificImpact(selfId,42)
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 114, 162,10)
    elseif key == self.g_Key["sn2"] then
        self:LuaFnCancelSpecificImpact(selfId,42)
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 242, 137)
    elseif key == 3 then
        local nItemNum = self:LuaFnGetAvailableItemCount(selfId, 30008019)
        if nItemNum < 1 then
            self:MsgBox(selfId, targetId, "此物品已被锁定！")
            return 0
        end
        self:LuaFnDelAvailableItem(selfId, 30008019, 1)
        if val > 4 then
            self:SetPKValue(selfId,4)
        end
        self:LuaFnCancelSpecificImpact(selfId,42)
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 132, 183,10)
    elseif key == 4 then
        local nItemNum = self:LuaFnGetAvailableItemCount(selfId, 30008019)
        if nItemNum < 1 then
            self:MsgBox(selfId, targetId, "此物品已被锁定！")
            return 0
        end
        self:LuaFnDelAvailableItem(selfId, 30008019, 1)
        if val > 4 then
            self:SetPKValue(selfId,4)
        end
        self:LuaFnCancelSpecificImpact(selfId,42)
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 114, 162,10)
    elseif key == 5 then
        local nItemNum = self:LuaFnGetAvailableItemCount(selfId, 30008019)
        if nItemNum < 1 then
            self:MsgBox(selfId, targetId, "此物品已被锁定！")
            return 0
        end
        self:LuaFnDelAvailableItem(selfId, 30008019, 1)
        if val > 4 then
            self:SetPKValue(selfId,4)
        end
        self:LuaFnCancelSpecificImpact(selfId,42)
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 242, 137)
    end
    return 1
end

function oprison_jailer:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oprison_jailer:ShenYuan(selfId, targetId)
    if self:LuaFnGetHumanPKValue(selfId) >= self.g_PKMinVal then
        self:MsgBox(selfId, targetId, "#{PRISON_SHENYUAN_01}")
        return
    end
    local lastDayTime = self:GetMissionDataEx(selfId, ScriptGlobal.MDEX_PRISON_SHENYUAN_DAYTIME)
    local CurDayTime = self:GetDayTime()
    if CurDayTime <= lastDayTime then
        self:MsgBox(selfId, targetId, "#{PRISON_SHENYUAN_03}")
        return
    end
    self:SetMissionDataEx(selfId, ScriptGlobal.MDEX_PRISON_SHENYUAN_DAYTIME, CurDayTime)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
    self:LuaFnSendGuajiQuestion(selfId)
end

return oprison_jailer
