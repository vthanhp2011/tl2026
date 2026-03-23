local class = require "class"
local define = require "define"
local script_base = require "script_base"
local opetisland_guijia = class("opetisland_guijia", script_base)
opetisland_guijia.script_id = 112001
opetisland_guijia.g_mpInfo = {}
opetisland_guijia.g_mpInfo[0] = {"星宿", 16, 96, 152, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU}
opetisland_guijia.g_mpInfo[1] = {"逍遥", 14, 67, 145, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO}
opetisland_guijia.g_mpInfo[2] = {"少林", 9, 96, 127, define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN}
opetisland_guijia.g_mpInfo[3] = {"天山", 17, 95, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN}
opetisland_guijia.g_mpInfo[4] = {"天龙", 13, 96, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI}
opetisland_guijia.g_mpInfo[5] = {"峨嵋", 15, 89, 139, define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI}
opetisland_guijia.g_mpInfo[6] = {"武当", 12, 103, 140, define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG}
opetisland_guijia.g_mpInfo[7] = {"明教", 11, 98, 167, define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO}
opetisland_guijia.g_mpInfo[8] = {"丐帮", 10, 91, 116, define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG}
opetisland_guijia.g_mpInfo[10] = { "曼陀山庄", 184, 139, 162, define.MENPAI_ATTRIBUTE.MATTRIBUTE_MANTUOSHANZHUANG}
opetisland_guijia.g_Yinpiao = 40002000
function opetisland_guijia:OnDefaultEvent(selfId, targetId)
    if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText("  你身上有银票，正在跑商！我不能帮助你。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:BeginEvent(self.script_id)
    self:AddText("    欢迎来到玄武岛!")
    self:AddNumText("返回门派", 9, 1000)
    self:AddNumText("城市 - 洛阳", 9, 1003)
    self:AddNumText("城市 - 苏州", 9, 1001)
    self:AddNumText("城市 - 大理", 9, 1002)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function opetisland_guijia:OnEventRequest(selfId, targetId, arg, index)
    if self:GetTeamId(selfId) >= 0 and self:IsTeamFollow(selfId) and self:LuaFnIsTeamLeader(selfId) then
        local num = self:LuaFnGetFollowedMembersCount(selfId)
        local mems = {}
        for i = 1, num do
            mems[i] = self:GetFollowedMember(selfId, i)
            if mems[i] == -1 then
                return
            end
            if self:IsHaveMission(mems[i], 4021) then
                self:MsgBox(selfId, targetId, "  你队伍成员中有人有漕运货舱在身，我们驿站不能为你提供传送服务。")
                return
            end
        end
    end
    if self:IsHaveMission(selfId, 4021) then
        self:MsgBox(selfId, targetId, "  你有漕运货舱在身，我们驿站不能为你提供传送服务。")
        return
    end
    local id = self:LuaFnGetMenPai(selfId)
    if index == 1000 then
        if id < 0 or id == 9 or id > 10 then
            self:MsgBox(selfId, targetId, "  你还没有加入任何门派！")
        else
            local mp = self:GetMPInfo(id)
            if mp ~= nil then
                self:CallScriptFunction((400900), "TransferFunc", selfId, mp[2], mp[3], mp[4])
            end
        end
        return
    end
    if index == 1001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 89, 143)
        return
    end
    if index == 1002 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 263, 129)
        return
    end
    if index == 1003 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 183, 156)
        return
    end
    for i, mp in pairs(self.g_mpInfo) do
        if index == i then
            self:CallScriptFunction((400900), "TransferFunc", selfId, mp[2], mp[3], mp[4])
            return
        end
    end
    if index == 2000 then
        self:BeginEvent(self.script_id)
        self:AddText("#{GOTO_DUNHUANF_SONGSHAN}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function opetisland_guijia:GetMPInfo(mpID)
    for _, mp in pairs(self.g_mpInfo) do
        if mp[5] == mpID then
            return mp
        end
    end
    return nil
end

function opetisland_guijia:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return opetisland_guijia
