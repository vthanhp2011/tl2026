local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oloulan_ainiwaer = class("oloulan_ainiwaer", script_base)
oloulan_ainiwaer.script_id = 001100
oloulan_ainiwaer.g_mpInfo = {}

oloulan_ainiwaer.g_mpInfo[0] = {
    "星宿", 16, 96, 152, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU
}

oloulan_ainiwaer.g_mpInfo[1] = {
    "逍遥", 14, 67, 145, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO
}

oloulan_ainiwaer.g_mpInfo[2] = {
    "少林", 9, 96, 127, define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN
}

oloulan_ainiwaer.g_mpInfo[3] = {
    "天山", 17, 95, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN
}

oloulan_ainiwaer.g_mpInfo[4] = {
    "天龙", 13, 96, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI
}

oloulan_ainiwaer.g_mpInfo[5] = {
    "峨嵋", 15, 89, 139, define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI
}

oloulan_ainiwaer.g_mpInfo[6] = {
    "武当", 12, 103, 140, define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG
}

oloulan_ainiwaer.g_mpInfo[7] = {
    "明教", 11, 98, 167, define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO
}

oloulan_ainiwaer.g_mpInfo[8] = {
    "丐帮", 10, 91, 116, define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG
}

oloulan_ainiwaer.g_Yinpiao = 40002000
oloulan_ainiwaer.g_Impact_NotTransportList = {5929, 5944}

oloulan_ainiwaer.g_TalkInfo_NotTransportList = {
    "#{GodFire_Info_062}", "#{XSHCD_20080418_099}"
}

function oloulan_ainiwaer:OnDefaultEvent(selfId, targetId)
    if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText(
            "  你身上有银票，正在跑商！我不能帮助你。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local mp
    local i = 0
    self:BeginEvent(self.script_id)
    self:AddText("#{loulan_yizhan_20080329}")
    self:AddNumText("返回门派", 9, 1000)
    self:AddNumText("城市 - 洛阳", 9, 1001)
    self:AddNumText("城市 - 洛阳 - 九州商会", 9, 1002)
    self:AddNumText("城市 - 苏州", 9, 1003)
    self:AddNumText("城市 - 苏州 - 铁匠铺", 9, 1004)
    self:AddNumText("城市 - 大理", 9, 1005)
    self:AddNumText("城市 - 束河古镇", 9, 1016)
    self:AddNumText("带我去其它门派", 9, 1011)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oloulan_ainiwaer:OnEventRequest(selfId, targetId, arg, index)
    if self:GetTeamId(selfId) >= 0 and self:IsTeamFollow(selfId) and
        self:LuaFnIsTeamLeader(selfId) then
        local num = self:LuaFnGetFollowedMembersCount(selfId)
        local mems = {}

        for i = 1, num do
            mems[i] = self:GetFollowedMember(selfId, i)
            if mems[i] == -1 then return end
            if self:IsHaveMission(mems[i], 4021) then
                self:MsgBox(selfId, targetId,
                            "  你队伍成员中有人有漕运货舱在身，我们驿站不能为你提供传送服务。")
                return
            end
        end
    end
    if self:IsHaveMission(selfId, 4021) then
        self:MsgBox(selfId, targetId,
                    "  你有漕运货舱在身，我们驿站不能为你提供传送服务。")
        return
    end
    for i, ImpactId in pairs(self.g_Impact_NotTransportList) do
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, ImpactId) then
            self:MsgBox(selfId, targetId, self.g_TalkInfo_NotTransportList[i])
            return 0
        end
    end
    local arg = index
    local mp
    local i = 0
    local id = self:LuaFnGetMenPai(selfId)
    if arg == 1000 then
        if id < 0 or id >= 9 then
            self:MsgBox(selfId, targetId, "  你还没有加入任何门派！")
        else
            mp = self:GetMPInfo(id)
            if mp ~= nil then
                self:CallScriptFunction((400900), "TransferFunc", selfId, mp[2],
                                        mp[3], mp[4])
            end
        end
        return
    end
    if arg == 1001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 132, 183)
        return
    end
    if arg == 1002 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 234, 132)
        return
    end
    if arg == 1003 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 114, 162)
        return
    end
    if arg == 1004 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 235, 132)
        return
    end
    if arg == 1005 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 241, 141)
        return
    end
    if arg == 1011 then
        self:BeginEvent(self.script_id)
        for i, mp in pairs(self.g_mpInfo) do
            self:AddNumText("门派 - " .. mp[1], 9, i)
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if arg == 1016 then
        self:BeginUICommand()
        self:UICommand_AddInt(self.script_id)
        self:UICommand_AddInt(targetId)
        self:UICommand_AddStr("GotoShuHeGuZhen")
        self:UICommand_AddStr(
            "束河古镇为不加杀气场景，请注意安全。你确认要进入吗？")
        self:EndUICommand()
        self:DispatchUICommand(selfId, 24)
        return
    end
    for i, mp in pairs(self.g_mpInfo) do
        if arg == i then
            self:CallScriptFunction((400900), "TransferFunc", selfId, mp[2],
                                    mp[3], mp[4])
            return
        end
    end
end

function oloulan_ainiwaer:GotoShuHeGuZhen(selfId, targetId)
    self:CallScriptFunction((400900), "TransferFunc", selfId, 420, 200, 211, 20)
    return
end

function oloulan_ainiwaer:GetMPInfo(mpID)
    local mp
    local i = 0
    for i, mp in pairs(self.g_mpInfo) do if mp[5] == mpID then return mp end end
    return nil
end

function oloulan_ainiwaer:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return oloulan_ainiwaer
