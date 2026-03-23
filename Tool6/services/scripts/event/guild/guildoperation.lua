local class = require "class"
local define = require "define"
local script_base = require "script_base"
local guildoperation = class("guildoperation", script_base)
guildoperation.script_id = 600000
guildoperation.g_Yinpiao = 40002000
function guildoperation:OnEnumerate(caller, selfId, targetId, arg, index)
    if (index == 1) then
        self:GuildCreate(selfId, targetId)
    elseif (index == 2) then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 103)
        self:CityApply(selfId)
        self:GuildList(selfId, targetId)
    elseif (index == 3) then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 30)
    elseif (index == 4) then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 31)
    elseif (index == 5) then
        local ret = self:CheckPlayerCanApplyCity(selfId)
        if ret then
            self:BeginUICommand()
            self:UICommand_AddInt(targetId)
            self:EndUICommand()
            self:DispatchUICommand(selfId, 101)
            self:CityApply(selfId)
        elseif ret == -1 then
            self:BeginEvent(self.script_id)
            self:AddText("您的帮会已经占有城市了！")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        end
    elseif (index == 6) then
        local haveImpact = self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 113)
        if haveImpact then
            self:BeginEvent(self.script_id)
            local strText = "对不起,您现在处于运输状态。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
        if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
            self:BeginEvent(self.script_id)
            self:AddText("  你身上有银票，正在跑商！我不能帮助你。")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        self:CityMoveTo(selfId)
    end
end

return guildoperation
