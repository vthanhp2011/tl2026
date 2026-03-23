local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshuhe_xuxiake = class("oshuhe_xuxiake", script_base)
oshuhe_xuxiake.script_id = 001171
oshuhe_xuxiake.g_Yinpiao = 40002000
oshuhe_xuxiake.g_Impact_NotTransportList = {5929, 5944}
oshuhe_xuxiake.g_TalkInfo_NotTransportList = {"#{GodFire_Info_062}", "#{XSHCD_20080418_099}"}
oshuhe_xuxiake.g_mpInfo = {}
oshuhe_xuxiake.g_mpInfo[0] = {"星宿", 16, 96, 152, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU}
oshuhe_xuxiake.g_mpInfo[1] = {"逍遥", 14, 67, 145, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO}
oshuhe_xuxiake.g_mpInfo[2] = {"少林", 9, 96, 127, define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN}
oshuhe_xuxiake.g_mpInfo[3] = {"天山", 17, 95, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN}
oshuhe_xuxiake.g_mpInfo[4] = {"天龙", 13, 96, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI}
oshuhe_xuxiake.g_mpInfo[5] = {"峨嵋", 15, 89, 139, define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI}
oshuhe_xuxiake.g_mpInfo[6] = {"武当", 12, 103, 140, define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG}
oshuhe_xuxiake.g_mpInfo[7] = {"明教", 11, 98, 167, define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO}
oshuhe_xuxiake.g_mpInfo[8] = {"丐帮", 10, 91, 116, define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG}
oshuhe_xuxiake.g_MsgInfo = {"#{SHGZ_001}", "#{SHGZ_0620_01}", "#{SHGZ_0620_02}", "#{SHGZ_0620_03}"}

function oshuhe_xuxiake:OnDefaultEvent(selfId, targetId)
    if self:GetItemCount(selfId, self.g_Yinpiao) >= 1 then
        self:BeginEvent(self.script_id)
        self:AddText("  你身上有银票，正在跑商！我不能帮助你。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    self:BeginEvent(self.script_id)
    local msgidx = math.random(#(self.g_MsgInfo))
    self:AddText(self.g_MsgInfo[msgidx])
    self:AddNumText("返回门派", 9, 1000)
    self:AddNumText("城市 - 洛阳", 9, 1001)
    self:AddNumText("城市 - 苏州", 9, 1002)
    self:AddNumText("城市 - 大理", 9, 1003)
    self:AddNumText("城市 - 洛阳 - 九州商会", 9, 1006)
    self:AddNumText("城市 - 苏州 - 铁匠铺", 9, 1007)
    self:AddNumText("城市 - 楼兰", 9, 1008)
    self:AddNumText("带我去其它门派", 9, 1011)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshuhe_xuxiake:OnEventRequest(selfId, targetId, arg, index)
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
    for i, ImpactId in pairs(self.g_Impact_NotTransportList) do
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, ImpactId) then
            self:MsgBox(selfId, targetId, self.g_TalkInfo_NotTransportList[i])
            return 0
        end
    end
    local id = self:LuaFnGetMenPai(selfId)
    if index == 1000 then
        if id < 0 or id >= 9 then
            self:MsgBox(selfId, targetId, "  你还没有加入任何门派！")
        else
            local mp = self:GetMPInfo(id)
            if mp ~= nil then
                self:CallScriptFunction((400900), "TransferFunc", selfId, mp[2], mp[3], mp[4], 10)
            end
        end
        return
    end
    if index == 1001 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 132, 183, 20)
        return
    end
    if index == 1002 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 114, 162, 20)
        return
    end
    if index == 1003 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 2, 241, 141, 20)
        return
    end
    if index == 1006 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 0, 234, 132, 20)
        return
    end
    if index == 1007 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 1, 235, 132, 20)
        return
    end
    if index == 1008 then
        self:CallScriptFunction((400900), "TransferFunc", selfId, 186, 288, 136, 75)
        return
    end
    if index == 1011 then
        self:BeginEvent(self.script_id)
        for i, mp in pairs(self.g_mpInfo) do
            self:AddNumText("门派 - " .. mp[1], 9, i)
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    for i, mp in pairs(self.g_mpInfo) do
        if index == i then
            self:CallScriptFunction((400900), "TransferFunc", selfId, mp[2], mp[3], mp[4])
            return
        end
    end
end

function oshuhe_xuxiake:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshuhe_xuxiake:GetMPInfo(mpID)
    for _, mp in pairs(self.g_mpInfo) do
        if mp[5] == mpID then
            return mp
        end
    end
end

return oshuhe_xuxiake
