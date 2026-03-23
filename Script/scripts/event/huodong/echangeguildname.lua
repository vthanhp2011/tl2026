local class = require "class"
local define = require "define"
local script_base = require "script_base"
local echangeguildname = class("echangeguildname", script_base)
echangeguildname.script_id = 808009
echangeguildname.g_Key = { ["ChgG"] = 200, ["ChgG_Y"] = 201 }
function echangeguildname:OnDefaultEvent(selfId, targetId,arg,index)
    if self:LuaFnIsCanDoScriptLogic(selfId) ~= 1 then
        return 0
    end
    local key = index
    if key == self.g_Key["ChgG"] then
        self:BeginEvent(self.script_id)
        self:AddText("#{ChangeName_ChgG}")
        self:AddNumText("确定", 6, self.g_Key["ChgG_Y"])
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["ChgG_Y"] then
        if self:IsCanChangeGuildName(selfId) == 1 then
            self:BeginUICommand()
            self:UICommand_AddInt(targetId)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 5424)
        end
    end
end

function echangeguildname:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id,"我要改帮会名字", 6, self.g_Key["ChgG"])
end

function echangeguildname:IsCanChangeGuildName(selfId)
    if self:LuaFnIsCanDoScriptLogic(selfId) ~= 1 then
        return 0
    end
    if self:GetGuildLevel(selfId) < 0 then
        self:MsgBox(selfId, "您还没有申请帮会")
        return 0
    end
    if self:GetGuildPos(selfId) ~= 9 then
        self:MsgBox(selfId, "需要帮主才可以修改帮会名字")
        return 0
    end
    local GuildName = self:LuaFnGetGuildName(selfId)
    local i, _ = string.find(GuildName, "*")
    if i == nil then
        self:MsgBox(selfId, "您不是移民玩家，或者您已经修改过名字了")
        return 0
    end
    return 1
end

function echangeguildname:CallBackChangeGuildNameBefore(selfId)
    if self:IsCanChangeGuildName(selfId) == 0 then
        return 0
    end
    return 1
end

function echangeguildname:CallBackChangeGuildNameAfter(selfId, nRetType)
    if self:LuaFnIsCanDoScriptLogic(selfId) ~= 1 then
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
        self:MsgBox(selfId, "恭喜您，您的帮会名字修改成功！")
    end
    return 1
end

function echangeguildname:MsgBox(selfId, str)
    if str == nil then
        return
    end
    self:BeginEvent(self.script_id)
    self:AddText(str)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

return echangeguildname
