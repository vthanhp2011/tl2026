local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local p_betraymaster = class("p_betraymaster", script_base)
p_betraymaster.script_id = 806006
p_betraymaster.g_BetrayMaster = {}

p_betraymaster.g_BetrayMaster["Id"] = 1005
p_betraymaster.g_BetrayMaster["Name"] = "我想与师傅解除关系"
p_betraymaster.g_msg = {["gld"] = "  解除师徒关系需要交纳#{_EXCHG%d}。", ["con"] = "  叛师将会被扣除#{_EXCHG%d}，您是否真的要叛师？"}

p_betraymaster.g_Gold = 25000
function p_betraymaster:OnDefaultEvent(selfId, targetId, index)
    local key = index
    local str
    if key == -1 then
        str = string.format(self.g_msg["con"], self.g_Gold)
        self:BeginEvent(self.script_id)
        if not self:LuaFnHaveMaster(selfId) then
            if self:GetMissionFlag(selfId, ScriptGlobal.MF_ShiTu_ChuShi_Flag) == 1 then
                self:AddText("  您已经出师了，不能再有叛师行为。")
            else
                self:AddText("  你还没有拜师！")
            end
        else
            self:AddText(str)
            self:AddNumText("是", 6, 1)
            self:AddNumText("否", 6, 2)
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == 1 then
        if self:CheckAccept(selfId, targetId) > 0 then
            self:OnAccept(selfId, targetId)
        end
    elseif key == 2 then
        self:DispatchUICommand(selfId, 1000)
    end
end

function p_betraymaster:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, self.g_BetrayMaster["Name"], 6, -1)
end

function p_betraymaster:CheckAccept(selfId, targetId)
    local nMoneyJZ = self:GetMoneyJZ(selfId)
    local nMoneyJB = self:LuaFnGetMoney(selfId)
    local nMoneySelf = nMoneyJZ + nMoneyJB
    if nMoneySelf < self.g_Gold then
        local str = string.format(self.g_msg["gld"], self.g_Gold)
        self:MsgBox(selfId, targetId, str)
        return 0
    end
    return 1
end

function p_betraymaster:OnAccept(selfId, targetId)
    local MasterGUID = self:LuaFnGetMasterGUID(selfId)
    if MasterGUID == -1 then
        return
    end
    if not self:LuaFnHaveMaster(selfId) then
        self:BeginEvent(self.script_id)
        self:AddText("  你还没有拜师！")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local MasterName = self:LuaFnGetFriendName(selfId, MasterGUID)
    local selfName = self:LuaFnGetName(selfId)
    local _, nMoneyJZ, nMoneyJB = self:LuaFnCostMoneyWithPriority(selfId, self.g_Gold)
    if nMoneyJZ == 0 then
        local str = string.format("解除师徒关系，扣除#{_MONEY%d}。", self.g_Gold)
        self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    if nMoneyJB == 0 then
        local str = string.format("解除师徒关系，扣除#{_EXCHG%d}。", self.g_Gold)
        self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    if nMoneyJB ~= 0 and nMoneyJZ ~= 0 then
        local str = string.format("解除师徒关系，扣除#{_EXCHG%d}和" .. "#{_MONEY%d}。", nMoneyJZ, nMoneyJB)
        self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    self:MsgBox(selfId, targetId, "  你解除了和" .. MasterName .. "的师徒关系。")
    self:LuaFnSendSystemMail(MasterName, "你的徒弟" .. selfName .. "无意于继续在你门下，已与你脱离了师徒关系。")
    local MyGUID = self:LuaFnGetGUID(selfId)
    self:LuaFnSendScriptMail(MasterName, ScriptGlobal.MAIL_BETRAYMASTER, MyGUID, 0, 0)
    self:AwardShiTuTitle(selfId, "")
    self:DispatchAllTitle(selfId)
    self:LuaFnBetrayMaster(selfId)
end

function p_betraymaster:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return p_betraymaster
