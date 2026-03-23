local class = require "class"
local define = require "define"
local script_base = require "script_base"
local p_recruit = class("p_recruit", script_base)
p_recruit.script_id = 806008
p_recruit.g_Recruit = {}

p_recruit.g_Recruit["Id"] = 1003
p_recruit.g_Recruit["Name"] = "我的徒弟要向我拜师"
p_recruit.g_msg = {}

p_recruit.g_msg["tem"] = "  拜师的时候必须和徒弟为好友关系，并且需要两个人组队单独前来找我。"
p_recruit.g_msg["ner"] = "  只有2人都走到我身边才可以拜师。"
p_recruit.g_msg["mlv"] = "  师傅的等级必须大于等于徒弟10级。"
p_recruit.g_msg["slv"] = "  徒弟10级开始才可拜师。"
p_recruit.g_msg["sib"] = "  有结拜关系不能拜师。"
p_recruit.g_msg["mar"] = "  夫妻关系不能拜师。"
p_recruit.g_msg["frp"] = "  相互加为好友才能拜师。"
p_recruit.g_msg["msl"] = "  请提升您的师德等级、只有师德等级大于等于1的人才有资格收徒。"
p_recruit.g_msg["rec_3"] = "  强行解除师徒关系3天后才能再次拜师。"
p_recruit.g_msg["rec_2"] = "  收徒数量已达最大。"
p_recruit.g_msg["rec_1"] = "  已经有师傅的玩家无法拜师。"
p_recruit.g_msg["ts"] = "  已经是师徒关系了，不能拜师。"
function p_recruit:OnDefaultEvent(selfId, targetId, index)
    local key = index
    if key == -1 then
        local tId = self:CheckAccept(selfId, targetId)
        if tId == 0 then
            return
        end
        local MasterName = self:LuaFnGetName(selfId)
        local ApprenticeName = self:LuaFnGetName(tId)
        local targetName = self:LuaFnGetName(targetId)
        print("p_recruit targetName =", targetName)
        self:BeginEvent(self.script_id)
        self:AddText("  拜师之后，杀怪可以获得10％的额外经验加成，如果和师傅在一起组队，那么将会获得20％的经验加成。")
        self:AddText("  徒弟拜师之后将会获得“" .. MasterName .. "的弟子”的称号。")
        self:AddText("  你是否愿意拜" .. MasterName .. "为师？")
        self:AddNumText("是", 6, 1)
        self:AddNumText("否", 8, 0)
        self:EndEvent()
        self:DispatchEventList(tId, targetId)
        self:BeginEvent(self.script_id)
        self:AddText("  等待" .. ApprenticeName .. "答复。。。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == 0 then
        self:OnCancel(selfId, targetId)
    elseif key == 1 then
        self:OnConfirm(selfId, targetId)
    end
end

function p_recruit:OnEnumerate(caller)
    caller:AddNumTextWithTarget(self.script_id, self.g_Recruit["Name"], 6, -1)
end

function p_recruit:CheckAccept(selfId, targetId)
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
    if self:LuaFnGetLevel(tId) < 10 then
        self:MsgBox(selfId, targetId, self.g_msg["slv"])
        return 0
    end
    if self:LuaFnGetLevel(tId) > 44 then
        self:MsgBox(selfId, targetId, "#{STGZ_20080520_7}")
        return 0
    end
    if self:LuaFnGetLevel(selfId) < (self:LuaFnGetLevel(tId) + 10) then
        self:MsgBox(selfId, targetId, self.g_msg["mlv"])
        return 0
    end
    local MasterLevel = self:LuaFnGetmasterLevel(selfId)
    if MasterLevel <= 0 then
        self:MsgBox(selfId, targetId, self.g_msg["msl"])
        return 0
    end
    if self:LuaFnIsBrother(selfId, tId) then
        self:MsgBox(selfId, targetId, self.g_msg["sib"])
        return 0
    end
    if self:LuaFnIsSpouses(selfId, tId) then
        self:MsgBox(selfId, targetId, self.g_msg["mar"])
        return 0
    end
    local PrenticeNum = 2
    if MasterLevel == 1 then
        PrenticeNum = 2
    elseif MasterLevel == 2 then
        PrenticeNum = 3
    elseif MasterLevel == 3 then
        PrenticeNum = 5
    elseif MasterLevel == 4 then
        PrenticeNum = 8
    end
    if self:LuaFnGetPrenticeCount(selfId) >= PrenticeNum then
        self:MsgBox(selfId, targetId, self.g_msg["rec_2"])
        return 0
    end
    if self:LuaFnHaveMaster(tId) then
        self:MsgBox(selfId, targetId, self.g_msg["rec_1"])
        return 0
    end
    if not self:LuaFnIsFriend(selfId, tId) or not self:LuaFnIsFriend(tId, selfId) then
        self:MsgBox(selfId, targetId, self.g_msg["frp"])
        return 0
    end
    if self:LuaFnIsMaster(selfId, tId) or self:LuaFnIsMaster(tId, selfId) then
        self:MsgBox(selfId, targetId, self.g_msg["ts"])
        return 0
    end
    return tId
end

function p_recruit:OnAccept(selfId, targetId)
    self:OnConfirm(selfId, targetId)
end

function p_recruit:OnSubmit(selfId, targetId, tId)
    local MasterName = self:LuaFnGetName(tId)
    local SelfName = self:LuaFnGetName(selfId)
    self:AwardShiTuTitle(selfId, MasterName .. "的弟子")
    self:DispatchAllTitle(selfId)
    self:LuaFnAprentice(selfId, tId)
    self:MsgBox(tId, targetId, "  恭喜收徒成功！")
    self:Msg2Player(tId, "恭喜收徒成功！", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:Msg2Player(tId, "师傅要努力教好你的徒儿。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    local str =
        string.format(
        "恭喜您收%s为徒，收徒之后杀怪获得的经验将会额外增加5％。和徒弟一起组队，能够获得的善恶值将会增加为原来的160％。徒弟达到一定等级后，还会根据你们之间的友好度给与您额外的经验奖励，此经验需用善恶值兑换。",
        SelfName
    )
    self:LuaFnSendSystemMail(MasterName, str)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "PlaySoundEffect", tId, 66)
    self:LuaFnSendSpecificImpactToUnit(tId, tId, tId, 18, 1000)
    self:MsgBox(selfId, targetId, "  恭喜拜师成功！")
    self:Msg2Player(selfId, "恭喜拜师成功！", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    str = string.format("恭喜您拜%s为师，拜师之后杀怪获得的经验值将会额外增加10％，如果和师傅一起组队杀怪将会额外增加20％。40级以后经验额外奖励将会取消。", MasterName)
    self:LuaFnSendSystemMail(SelfName, str)
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "PlaySoundEffect", selfId, 66)
    self:LuaFnSendSpecificImpactToUnit(selfId, selfId, selfId, 18, 1000)
end

function p_recruit:OnConfirm(selfId, targetId)
    local tId
    if not self:LuaFnHasTeam(selfId) then
        return
    end
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        return
    end
    if self:LuaFnGetTeamSceneMemberCount(selfId) ~= 1 then
        return
    end
    tId = self:LuaFnGetTeamSceneMember(selfId, 1)
    self:MsgBox(selfId, targetId, "  你同意了拜对方为师。")
    self:Msg2Player(selfId, "你同意了拜对方为师。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:MsgBox(tId, targetId, "  对方同意拜你为师。")
    self:Msg2Player(tId, "对方同意拜你为师。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    if self:CheckAccept(tId, targetId) > 0 then
        self:OnSubmit(selfId, targetId, tId)
    end
end

function p_recruit:OnCancel(selfId, targetId)
    local tId
    if not  self:LuaFnHasTeam(selfId) then
        return
    end
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        return
    end
    if self:LuaFnGetTeamSceneMemberCount(selfId) ~= 1 then
        return
    end
    tId = self:LuaFnGetTeamSceneMember(selfId, 1)
    self:MsgBox(selfId, targetId, "  你拒绝了拜对方为师。")
    self:Msg2Player(selfId, "你拒绝了拜对方为师。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
    self:MsgBox(tId, targetId, "  对方拒绝拜你为师。")
    self:Msg2Player(tId, "对方拒绝拜你为师。", define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
end

function p_recruit:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function p_recruit:MsgTip(selfId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return p_recruit
