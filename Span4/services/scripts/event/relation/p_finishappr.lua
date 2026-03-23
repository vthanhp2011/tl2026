local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_finishappr = class("p_finishappr", script_base)
p_finishappr.script_id = 806007
p_finishappr.g_FinishAppr = {}

p_finishappr.g_FinishAppr["Id"] = 1004
p_finishappr.g_FinishAppr["Name"] = "我带着徒弟来出师了"
p_finishappr.g_msg = {}

p_finishappr.g_msg["tem"] = "  需要师徒2人组队来找我才能出师。"
p_finishappr.g_msg["ner"] = "  只有2人都走到我身边才可以出师。"
p_finishappr.g_msg["lev"] = "  徒弟等级达到40级才能出师。"
p_finishappr.g_msg["dad"] = "  你还没有收徒。"
p_finishappr.g_msg["itm"] = "  师徒2人的背包中，分别至少要有一个普通物品的空格。"
p_finishappr.g_itm = {30008001, "出师糖豆"}

function p_finishappr:OnDefaultEvent(selfId, targetId)
    local tId = self:CheckAccept(selfId, targetId)
    if tId == 0 then
        return
    end
    self:OnAccept(selfId, targetId, tId)
end

function p_finishappr:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, self.g_FinishAppr["Name"], 6, -1)
end

function p_finishappr:CheckAccept(selfId, targetId)
    if not self:LuaFnHasTeam(selfId) or self:LuaFnGetTeamSize(selfId) ~= 2 then
        self:MsgBox(selfId, targetId, self.g_msg["tem"])
        return 0
    end
    if self:LuaFnGetTeamSceneMemberCount(selfId) ~= 1 then
        self:MsgBox(selfId, targetId, self.g_msg["ner"])
        return 0
    end
    local tId = self:LuaFnGetTeamSceneMember(selfId, 1)
    if not self:LuaFnIsCanDoScriptLogic(selfId) or not self:LuaFnIsCanDoScriptLogic(tId) then
        return 0
    end
    if self:LuaFnGetLevel(tId) < 40 then
        self:MsgBox(selfId, targetId, self.g_msg["lev"])
        return 0
    end
    if not self:LuaFnIsPrentice(selfId, tId) then
        self:MsgBox(selfId, targetId, self.g_msg["dad"])
        return 0
    end
    self:LuaFnBeginAddItem()
    self:LuaFnAddItem(self.g_itm[1], 1)
    if not self:LuaFnEndAddItem(selfId) or not self:LuaFnEndAddItem(tId) then
        self:MsgBox(selfId, targetId, self.g_msg["itm"])
        return 0
    end
    return tId
end

function p_finishappr:OnAccept(selfId, targetId, tId)
    local fp_st = self:LuaFnGetFriendPoint(selfId, tId)
    local fp_ts = self:LuaFnGetFriendPoint(tId, selfId)
    local lv_t = self:LuaFnGetLevel(tId)
    if lv_t >= 40 and lv_t <= 45 and fp_st >= 300 and fp_ts >= 300 then
        self:MsgBox(selfId, targetId, "  出师成功！")
        self:Msg2Player(selfId, "出师成功！", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:Msg2Player(selfId, "你得到" .. self.g_itm[2] .. "一个。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:MsgBox(tId, targetId, "  出师成功！")
        self:Msg2Player(tId, "出师成功！", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:Msg2Player(tId, "你得到" .. self.g_itm[2] .. "一个。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        local title
        local MasterName = self:LuaFnGetName(selfId)
        title = MasterName .. "之徒"
        self:AwardShiTuTitle(tId, title)
        self:DispatchAllTitle(tId)
        self:Msg2Player(tId, "获得称号：" .. title .. "。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    else
        local msg = "由于友好度不到300或者徒弟等级大于45级，没有奖励。"
        self:MsgBox(selfId, targetId, "  出师成功！" .. msg)
        self:Msg2Player(selfId, "出师成功！", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:Msg2Player(selfId, msg, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:MsgBox(tId, targetId, "  出师成功！" .. msg)
        self:Msg2Player(tId, "出师成功！", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:Msg2Player(tId, msg, define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    end
    self:LuaFnFinishAprentice(tId, selfId)
end

function p_finishappr:GetTitle(MoralPoint)
    return ""
end

function p_finishappr:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return p_finishappr
