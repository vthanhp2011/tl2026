local class = require "class"
local define = require "define"
local script_base = require "script_base"
local onanzhao_chargetransfer = class("onanzhao_chargetransfer", script_base)
onanzhao_chargetransfer.script_id = 400961
onanzhao_chargetransfer.g_name = "车传福"
onanzhao_chargetransfer.g_transfer_target = {
    [1] = {["x"] = 120, ["z"] = 200, ["scene_num"] = 0},
    [2] = {["x"] = 235, ["z"] = 156, ["scene_num"] = 1},
    [3] = {["x"] = 246, ["z"] = 106, ["scene_num"] = 2},
    [4] = {["x"] = 294, ["z"] = 90, ["scene_num"] = 186},
    [5] = {["x"] = 206, ["z"] = 266, ["scene_num"] = 34},
    [6] = {["x"] = 158, ["z"] = 113, ["scene_num"] = 22}
}

onanzhao_chargetransfer.g_transfer_cost = 5000
function onanzhao_chargetransfer:OnDefaultEvent(selfId, targetId)
    self:UpdateEventList(selfId, targetId)
end

function onanzhao_chargetransfer:UpdateEventList(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{SFCS_80828_02}")
    self:AddNumText("洛阳", 9, 1)
    self:AddNumText("苏州", 9, 2)
    self:AddNumText("大理", 9, 3)
    self:AddNumText("楼兰", 9, 4)
    self:AddNumText("南海", 9, 5)
    self:AddNumText("长白山", 9, 6)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function onanzhao_chargetransfer:OnEventRequest(selfId, targetId, arg, index)
    if self:GetItemCount(selfId, 40002000) >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText("  你身上有银票，正在跑商！我不能帮助你。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:GetTeamId(selfId) >= 0 and self:IsTeamFollow(selfId) and self:LuaFnIsTeamLeader(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText("  非常抱歉，由于路途太过遥远，我们这里运输能力有限，所以不接受组队传送，请您离开队伍单独前来吧！")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if self:IsHaveMission(selfId, 4021) then
        self:BeginEvent(self.script_id)
        self:AddText("  你有漕运货舱在身，我们驿站不能为你提供传送服务。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local id = index
    if id >= 1 and id <= 6 then
        self:BeginEvent(self.script_id)
        self:AddText("#{FFCS_081210_1}")
        if id == 1 then
            self:AddNumText("确定", 0, 11)
        elseif id == 2 then
            self:AddNumText("确定", 0, 21)
        elseif id == 3 then
            self:AddNumText("确定", 0, 31)
        elseif id == 4 then
            self:AddNumText("确定", 0, 41)
        elseif id == 5 then
            self:AddNumText("确定", 0, 51)
        elseif id == 6 then
            self:AddNumText("确定", 0, 61)
        end
        self:AddNumText("取消", 0, 100)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif id == 100 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    else
        local index = math.floor(id / 10)
        if index == 4 then
            if self:GetLevel(selfId) < 75 then
                self:BeginEvent(self.script_id)
                self:AddText("  你的等级不到75，无法传送。")
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
                return
            end
            if self:LuaFnGetDRideFlag(selfId) == 1 then
                local objId = self:LuaFnGetDRideTargetID(selfId)
                if objId ~= -1 and self:GetLevel(objId) < 75 then
                    self:BeginEvent(self.script_id)
                    self:AddText("#{SRCS_090203_1}")
                    self:EndEvent()
                    self:DispatchEventList(selfId, targetId)
                    return
                end
            end
        end
        local minLevel = 10
        if index == 4 then
            minLevel = 75
        end
        if self:LuaFnGetDRideFlag(selfId) then
            local objId = self:LuaFnGetDRideTargetID(selfId)
            if objId ~= -1 and self:GetLevel(objId) < minLevel then
                local Tip = string.format("#{CQTS_90227_1}%d#{CQTS_90227_2}", minLevel)
                self:NotifyFailTips(selfId, targetId, Tip)
                return
            end
        end
        local pos_x = self.g_transfer_target[index]["x"]
        local pos_z = self.g_transfer_target[index]["z"]
        local scene_num = self.g_transfer_target[index]["scene_num"]
        local nMoneyJZ = self:GetMoneyJZ(selfId)
        local nMoney = self:GetMoney(selfId)
        if (nMoneyJZ + nMoney) >= self.g_transfer_cost then
            if not self:LuaFnCostMoneyWithPriority(selfId, self.g_transfer_cost) then
                self:BeginEvent(self.script_id)
                self:AddText("收费失败！")
                self:EndEvent()
                self:DispatchMissionTips(selfId)
                return
            else
                self:CallScriptFunction((400900), "TransferFunc", selfId, scene_num, pos_x, pos_z, minLevel)
            end
        else
            self:BeginEvent(self.script_id)
            self:AddText("金钱不足")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
    end
end

function onanzhao_chargetransfer:NotifyFailTips(selfId, targetId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return onanzhao_chargetransfer
