local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local p_expelprentice = class("p_expelprentice", script_base)
p_expelprentice.script_id = 806009
p_expelprentice.g_ExpelPrentice = {}

p_expelprentice.g_ExpelPrentice["Id"] = 1006
p_expelprentice.g_ExpelPrentice["Name"] = "我要把徒弟逐出师门"
p_expelprentice.g_msg = {["gld"] = "  逐出徒弟需要交纳#{_EXCHG%d}。", ["con"] = "  开除徒弟将会被扣除#{_EXCHG%d}，是否真的要开除玩家：%s。"}

p_expelprentice.g_Gold = 25000
function p_expelprentice:OnDefaultEvent(selfId, targetId, index)
    local key = index
    local guid
    local PrenticeName
    local log = 0
    local str
    if key == -1 then
        self:BeginEvent(self.script_id)
        for i = 1, 8 do
            guid = self:LuaFnGetPrenticeGUID(selfId, i)
            if guid ~= -1 then
                log = 1
                PrenticeName = self:LuaFnGetFriendName(selfId, guid)
                self:AddNumText("将" .. PrenticeName .. "逐出师门", 6, i)
            end
        end
        if log == 0 then
            self:AddText("  你还没有徒弟！")
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if key >= 1 and key <= 8 then
        guid = self:LuaFnGetPrenticeGUID(selfId, key)
        if guid ~= -1 then
            PrenticeName = self:LuaFnGetFriendName(selfId, guid)
        end
        str = string.format(self.g_msg["con"], self.g_Gold, PrenticeName)
        self:BeginEvent(self.script_id)
        self:AddText(str)
        self:AddNumText("是", 6, (key + 1) * 100)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    if key >= 100 then
        if self:CheckAccept(selfId, targetId) > 0 then
            self:OnAccept(selfId, targetId, math.floor(key / 100) - 1)
        end
    end
end

function p_expelprentice:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, self.g_ExpelPrentice["Name"], 6, -1)
end

function p_expelprentice:CheckAccept(selfId, targetId)
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

function p_expelprentice:OnAccept(selfId, targetId, nIndex)
    local PrenticeGUID = self:LuaFnGetPrenticeGUID(selfId, nIndex)
    if PrenticeGUID == -1 then
        self:BeginEvent(self.script_id)
        self:AddText("  你还没有徒弟！")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local PrenticeName = self:LuaFnGetFriendName(selfId, PrenticeGUID)
    local selfName = self:LuaFnGetName(selfId)
    local nMoneyJZ, nMoneyJB = self:LuaFnCostMoneyWithPriority(selfId, self.g_Gold)
    if nMoneyJZ == 0 then
        local str = string.format("解除师徒关系，扣除#{_MONEY%d}。", self.g_Gold)
        self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    if nMoneyJB == 0 then
        local str = string.format("解除师徒关系，扣除#{_EXCHG%d}。", self.g_Gold)
        self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    if nMoneyJB ~= 0 and nMoneyJZ ~= 0 then
        local str = string.format("解除师徒关系，扣除#{_EXCHG%d}和#{_MONEY%d}。", nMoneyJZ, nMoneyJB)
        self:Msg2Player(selfId, str, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    self:MsgBox(selfId, targetId, "  你解除了和" .. PrenticeName .. "的师徒关系。")
    self:LuaFnSendSystemMail(PrenticeName, "你的师父" .. selfName .. "无意于继续教导你，已与你脱离了师徒关系。")
    self:LuaFnSendScriptMail(PrenticeName, ScriptGlobal.MAIL_EXPELPRENTICE, 0, 0, 0)
    self:LuaFnExpelPrentice(selfId, PrenticeGUID)
end

function p_expelprentice:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return p_expelprentice
