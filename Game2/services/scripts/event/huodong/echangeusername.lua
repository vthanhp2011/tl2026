local class = require "class"
local define = require "define"
local script_base = require "script_base"
local echangeusername = class("echangeusername", script_base)
echangeusername.script_id = 808008
echangeusername.g_Key = { ["ChgU"] = 100, ["ChgU_Y"] = 101, ["TitP"] = 110, ["TitP_Y"] = 111, ["TitS"] = 120,
    ["TitS_Y"] = 121, ["TitG"] = 130, ["TitG_Y"] = 131 }
function echangeusername:OnDefaultEvent(selfId, targetId,arg,index)
    if not self:LuaFnIsCanDoScriptLogic(selfId) then
        return 0
    end
    local key = index
    if key == self.g_Key["ChgU"] then
        self:BeginEvent(self.script_id)
        self:AddText("改名需要【更名贴】/合区后名字带*号")
        self:AddNumText("确定", 6, self.g_Key["ChgU_Y"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["TitP"] then
        self:BeginEvent(self.script_id)
        self:AddText("#{ChangeName_TitP}")
        self:AddNumText("确定", 6, self.g_Key["TitP_Y"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["TitS"] then
        self:BeginEvent(self.script_id)
        self:AddText("#{ChangeName_TitS}")
        self:AddNumText("确定", 6, self.g_Key["TitS_Y"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["TitG"] then
        self:BeginEvent(self.script_id)
        self:AddText("#{BHJW_090217_1}")
        self:AddNumText("确定", 6, self.g_Key["TitG_Y"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["ChgU_Y"] then
        if self:IsCanChangeUserName(selfId) then
            self:BeginUICommand()
            self:UICommand_AddInt(targetId)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 5423)
        end
    elseif key == self.g_Key["TitP_Y"] then
        self:OnRefreshPrenticeTitle(selfId, targetId)
    elseif key == self.g_Key["TitS_Y"] then
        self:OnRefreshSpouseTitle(selfId, targetId)
    elseif key == self.g_Key["TitG_Y"] then
        self:OnRefreshGuildContriTitle(selfId, targetId)
    end
end

function echangeusername:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id,"我要改名字", 6, self.g_Key["ChgU"])
    caller:AddNumTextWithTarget(self.script_id,"我要更新师徒称号", 6, self.g_Key["TitP"])
    caller:AddNumTextWithTarget(self.script_id,"我要更新夫妻称号", 6, self.g_Key["TitS"])
    caller:AddNumTextWithTarget(self.script_id,"#{CHANGENAME_JW}", 6, self.g_Key["TitG"])
end

function echangeusername:OnRefreshSpouseTitle(selfId, targetId)
    if self:LuaFnIsMarried(selfId) == 0 then
        self:MsgBox(selfId, "您还没有结婚")
        return
    end
    if self:LuaFnHasTeam(selfId) == 0 then
        self:MsgBox(selfId, "您需要与伴侣一起组队前来")
        return
    end
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        self:MsgBox(selfId, "该队伍应该由你们夫妻二人组成")
        return
    end
    if self:GetNearTeamCount(selfId) ~= 2 then
        self:MsgBox(selfId, "您的伴侣不在附近")
        return
    end
    local ObjID0 = self:GetNearTeamMember(selfId, 0)
    local ObjID1 = self:GetNearTeamMember(selfId, 1)
    local SelfGUID = self:LuaFnObjId2Guid(ObjID0)
    local SpouGUID = self:LuaFnGetSpouseGUID(ObjID1)
    if not self:LuaFnIsMarried(ObjID0) or self:LuaFnIsMarried(ObjID1) == 0 or SelfGUID ~= SpouGUID then
        self:MsgBox(selfId, "您的伴侣不在队伍中")
        return
    end
    local Name0 = self:GetName(ObjID0)
    local Name1 = self:GetName(ObjID1)
    if self:LuaFnGetSex(ObjID0) == 0 then
        self:LuaFnAwardSpouseTitle(ObjID1, Name0 .. "的夫君")
    else
        self:LuaFnAwardSpouseTitle(ObjID1, Name0 .. "的娘子")
    end
    self:DispatchAllTitle(ObjID1)
    if self:LuaFnGetSex(ObjID1) == 0 then
        self:LuaFnAwardSpouseTitle(ObjID0, Name1 .. "的夫君")
    else
        self:LuaFnAwardSpouseTitle(ObjID0, Name1 .. "的娘子")
    end
    self:DispatchAllTitle(ObjID0)
    self:BeginEvent(self.script_id)
    self:AddText("  恭喜您，您的夫妻称号已经更新了！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function echangeusername:OnRefreshPrenticeTitle(selfId, targetId)
    if self:LuaFnHaveMaster(selfId) == 0 then
        self:MsgBox(selfId, "您还没有师傅")
        return
    end
    if self:LuaFnHasTeam(selfId) == 0 then
        self:MsgBox(selfId, "您需要与师傅一起组队前来")
        return
    end
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        self:MsgBox(selfId, "该队伍应该由你们师徒二人组成")
        return
    end
    if self:GetNearTeamCount(selfId) ~= 2 then
        self:MsgBox(selfId, "您的师傅不在附近")
        return
    end
    local ObjID0 = self:GetNearTeamMember(selfId, 0)
    local ObjID1 = self:GetNearTeamMember(selfId, 1)
    local ObjIDM
    if self:LuaFnIsMaster(selfId, ObjID0) == 1 then
        ObjIDM = ObjID0
    elseif self:LuaFnIsMaster(selfId, ObjID1) == 1 then
        ObjIDM = ObjID1
    else
        self:MsgBox(selfId, "您的师傅不在队伍中")
        return
    end
    local NameM = self:GetName(ObjIDM)
    self:AwardShiTuTitle(selfId, NameM .. "的弟子")
    self:DispatchAllTitle(selfId)
    self:BeginEvent(self.script_id)
    self:AddText("  恭喜您，您的师徒称号已经更新了！")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function echangeusername:OnRefreshGuildContriTitle(selfId, targetId)
    if self:LuaFnIsCanDoScriptLogic(selfId) ~= 1 then
        return 0
    end
    if self:GetGuildLevel(selfId) < 0 then
        self:MsgBox(selfId, "#{BHJW_090217_2}")
        return 0
    end
    local GuildName = self:LuaFnGetGuildName(selfId)
    local i, _ = string.find(GuildName, "*")
    if i ~= nil then
        self:MsgBox(selfId, "#{BHJW_090217_3}")
        return 0
    end
    local currGuildContriTitle = self:GetGuildContriTitle(selfId)
    if currGuildContriTitle == "" then
        self:MsgBox(selfId, "#{BHJW_090217_4}")
        return 0
    end
    local i, _ = string.find(currGuildContriTitle, GuildName)
    if i ~= nil then
        self:MsgBox(selfId, "#{BHJW_090217_5}")
        return 0
    else
        local i, _ = string.find(currGuildContriTitle, "★")
        local str = string.sub(currGuildContriTitle,i)
        local newGuildContriTitle = GuildName .. str
        self:AwardGuildContriTitle(selfId, newGuildContriTitle)
        self:DispatchAllTitle(selfId)
        self:BeginEvent(self.script_id)
        self:AddText("#{BHJW_090217_6}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function echangeusername:IsCanChangeUserName(selfId)
    if not self:LuaFnIsCanDoScriptLogic(selfId) then
        return 0
    end
    local name = self:GetName(selfId)
    if string.find(name, "*") then
        return 1
    end
    local count = self:LuaFnGetAvailableItemCount(selfId, 30008105)
    if count < 1 then
        self:MsgBox(selfId, "缺少更名贴")
        return 0
    end
    return 1
end

function echangeusername:CallBackChangeUserNameBefore(selfId)
    local name = self:GetName(selfId)
    if string.find(name, "*") then
        return 1
    end
    local count = self:LuaFnGetAvailableItemCount(selfId, 30008105)
    if count < 1 then
        self:MsgBox(selfId, "缺少更名贴")
        return 0
    end
    if self:IsCanChangeUserName(selfId) == 0 then
        return 0
    end
    return 1
end

function echangeusername:CallBackChangeUserNameAfter(selfId, nRetType, old_name)
    if not self:LuaFnIsCanDoScriptLogic(selfId) then
        return 0
    end
    if string.find(old_name, "*") then
        self:MsgBox(selfId, "恭喜您，您的名字修改成功！")
        return 1
    else
        local ret = self:LuaFnDelAvailableItem(selfId, 30008105, 1)
        if not ret then
            return 0
        end
        if nRetType == 1 then
            self:MsgBox(selfId, "更名失败")
        elseif nRetType == 2 then
            self:MsgBox(selfId, "DB压力过大，请重新尝试")
        elseif nRetType == 3 then
            self:MsgBox(selfId, "不可接受的新名称")
        elseif nRetType == 4 then
            self:MsgBox(selfId, "名称重复")
        else
            self:MsgBox(selfId, "恭喜您，您的名字修改成功！")
        end
        return 1
    end
end

function echangeusername:MsgBox(selfId, str)
    if str == nil then
        return
    end
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return echangeusername
