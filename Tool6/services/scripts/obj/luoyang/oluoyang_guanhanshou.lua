local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_guanhanshou = class("oluoyang_guanhanshou", script_base)
oluoyang_guanhanshou.script_id = 125
oluoyang_guanhanshou.g_Key = {
    ["do"] = 100,
    ["undo"] = 101,
    ["del"] = 103,
    ["hlp"] = 104
}

function oluoyang_guanhanshou:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "  我专门为江湖英雄主持金盆洗手的仪式。如果你想要删除角色，退出江湖，就可以来找我。")
    self:AddNumText("我想删除角色", -1, self.g_Key["do"])
    self:AddNumText("关于删除角色", 11, self.g_Key["hlp"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_guanhanshou:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    if key == self.g_Key["do"] then
        self:BeginEvent(self.script_id)
        if 9 == 9 then
            self:AddText(
                "  为了游戏的公平和公正，暂不开放角色删除功能。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local result = self:QueryDeleteCharState(selfId)
        if result == 1 then
            self:AddText("  金盆洗手，退出江湖。")
            self:AddNumText("我决定退出江湖", 6, self.g_Key["del"])
        end
        if result == 2 then
            self:AddText("  你还在帮派中，不可以退隐江湖。")
        end
        if result == 3 then
            self:AddText("  你还在结婚状态，不可以退隐江湖。")
        end
        if result == 4 then
            self:AddText("  你有物品已经上锁，不可以退隐江湖。")
        end
        if result == 5 then
            self:AddText("  你拥有玩家商店，不可以退隐江湖。")
        end
        if result == 6 then
            self:AddText("  你拥有结拜兄弟，不可以退隐江湖。")
        end
        if result == 7 then
            self:AddText("  你拥有师徒关系，不可以退隐江湖。")
        end
        if result == 8 then
            local lefttime = self:GetLeftDeleteTime(selfId) - 11
            if lefttime > 0 then
                self:AddText("  你退隐江湖的时间未到，还差" ..
                                 lefttime .. "天。")
            else
                self:AddText("  你还没有申请退隐江湖！")
            end
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif key == self.g_Key["del"] then
        self:OpenClientAcceptUI(selfId, targetId, arg)
    elseif key == self.g_Key["hlp"] then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_089}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function oluoyang_guanhanshou:OpenClientAcceptUI(selfId, targetId, eventId)
    self:BeginUICommand()
    self:UICommand_AddInt(self.script_id)
    self:UICommand_AddInt(targetId)
    self:UICommand_AddInt(eventId)
    self:UICommand_AddStr("OnMsgAccept")
    local str = string.format("你确定要删除角色吗？")
    self:UICommand_AddStr(str)
    self:EndUICommand()
    self:DispatchUICommand(selfId, 24)
end

function oluoyang_guanhanshou:OnMsgAccept(selfId, targetId, eventId)
    local result = self:QueryDeleteCharState(selfId)
    if (1 == result) then self:ExecuteDeleteChar(selfId) end
end

return oluoyang_guanhanshou
