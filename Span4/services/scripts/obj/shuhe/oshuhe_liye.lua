local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oshuhe_liye = class("oshuhe_liye", script_base)
oshuhe_liye.g_SceneData = 
{
    --下列数组含义1和2是本同盟复活点坐标
    --3是阵营数据 4和5是copysceneparam的占用 4是记录抢夺水晶积分记录 5是夺旗记录
    [1] = {66,35},
    [2] = {252,28},
    [3] = {288,62},
    [4] = {292,250},
    [5] = {261,291},
    [6] = {68,291},
    [7] = {28,239},
    [8] = {34,60}
}
oshuhe_liye.ScenePosData = {32,33,34,35,36,37,38,39}
oshuhe_liye.script_id = 001218
oshuhe_liye.member_info = {
    {["name"] = "", ["levelReq"] = "#G满足", ["xinfaReq"] = "#G满足", ["taskCount"] = "#G满足"},
    {["name"] = "", ["levelReq"] = "#G满足", ["xinfaReq"] = "#G满足", ["taskCount"] = "#G满足"},
    {["name"] = "", ["levelReq"] = "#G满足", ["xinfaReq"] = "#G满足", ["taskCount"] = "#G满足"},
    {["name"] = "", ["levelReq"] = "#G满足", ["xinfaReq"] = "#G满足", ["taskCount"] = "#G满足"},
    {["name"] = "", ["levelReq"] = "#G满足", ["xinfaReq"] = "#G满足", ["taskCount"] = "#G满足"},
    {["name"] = "", ["levelReq"] = "#G满足", ["xinfaReq"] = "#G满足", ["taskCount"] = "#G满足"}
}
function oshuhe_liye:OnDefaultEvent(selfId, targetId)
    for i = 0,47 do
        self:LuaFnSetSceneData_Param(191,i,0)
    end
    self:BeginEvent(self.script_id)
    self:AddText("#{FHZD_090708_37}")
    self:AddNumText("#{FHZD_XML_13}", 6, 101)
    self:AddNumText("#{FHZD_XML_33}", 11, 102)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshuhe_liye:OnEventRequest(selfId, targetId, arg, index)
    local LeagueId = self:LuaFnGetHumanGuildLeagueID(selfId)
    if index == 101 then
        local IsId
        for i = 1, 8 do
            if (LeagueId + 100) == self:LuaFnGetSceneData_Param(191,self.ScenePosData[i]) then
                IsId = i
                break
            end
        end
        if IsId == nil then
            for i = 1, 8 do
                local value = self:LuaFnGetCopySceneData_Param(191,self.ScenePosData[i])
                if value == 0 then
                    IsId = i
                    break
                end
            end
            if IsId then
                self:LuaFnSetCopySceneData_Param(191,self.ScenePosData[IsId], (LeagueId + 100))
            end
        end
        if IsId == nil then
            self:MsgBox(selfId,targetId, "场景中已存在8个同盟，你无法再参加")
            --self:NewWorld(selfId,0,nil,89,180)
            return
        end
        print("IsIdData = ",IsId)
        self:NewWorld(selfId, 191, nil,self.g_SceneData[IsId][1],self.g_SceneData[IsId][2])
    elseif index == 102 then
        self:BeginEvent(self.script_id)
        self:AddText("#{FHZD_090708_86}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oshuhe_liye:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oshuhe_liye:CheckMemberInfo(selfId, targetId)
    local bSucc = 1
    local teamSize = self:GetTeamSize(selfId)
    local msg = ""

    if teamSize < 1 then
        local level = self:LuaFnGetLevel(selfId)
        local bXinfaOK = self:CheckXinfaLevel(selfId, 45)
        local guildLevel = self:GetGuildLevel(selfId)
        self.member_info[1]["name"] = self:GetName(selfId)
        if level < 75 then
            self.member_info[1]["levelReq"] = "#cff0000不满足"
            bSucc = 0
        end
        if guildLevel < 3 then
            self.member_info[1]["taskCount"] = "#cff0000不满足"
            bSucc = 0
        end
        if bXinfaOK == 0 then
            self.member_info[1]["xinfaReq"] = "#cff0000不满足"
            bSucc = 0
        end
        if bSucc == 0 then
            self:BeginEvent(self.script_id, selfId)
            self:AddText("  队伍成员资讯：")
            msg = string.format("  #B队员%s：", self.member_info[1]["name"])
            if self.member_info[1]["levelReq"] == "#cff0000不满足" then
                msg = msg .. "#r  #cff0000任务等级75             不满足"
            else
                msg = msg .. "#r  #G任务等级75             满足"
            end
            if self.member_info[1]["xinfaReq"] == "#cff0000不满足" then
                msg = msg .. "#r  #cff0000心法等级40             不满足"
            else
                msg = msg .. "#r  #G心法等级40             满足"
            end
            if self.member_info[1]["taskCount"] == "#cff0000不满足" then
                msg = msg .. "#r  #cff0000帮会等级3              不满足"
            else
                msg = msg .. "#r  #G帮会等级3              满足"
            end
            self:AddText(msg)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return 0
        end
    else
        for i = 1, teamSize do
            local objId = self:GetNearTeamMember(selfId, i)
            local level = self:LuaFnGetLevel(objId)
            local guildLevel = self:GetGuildLevel(objId)
            local bXinfaOK = self:CheckXinfaLevel(objId, 45)
            self.member_info[i]["name"] = self:GetName(objId)
            if level < 75 then
                self.member_info[i]["levelReq"] = "#cff0000不满足"
                bSucc = 0
            end
            if bXinfaOK == 0 then
                self.member_info[i]["xinfaReq"] = "#cff0000不满足"
                bSucc = 0
            end
            if guildLevel < 3 then
                self.member_info[i]["taskCount"] = "#cff0000不满足"
                bSucc = 0
            end
        end
        if bSucc == 0 then
            self:BeginEvent(self.script_id, selfId)
            self:AddText("  队伍成员资讯：")
            for i, mem in pairs(self.member_info) do
                if i > teamSize then
                    break
                end
                msg = string.format("  #B队员%s：", mem["name"])
                if self.member_info[i]["levelReq"] == "#cff0000不满足" then
                    msg = msg .. "#r  #cff0000任务等级75             不满足"
                else
                    msg = msg .. "#r  #G任务等级75             满足"
                end
                if self.member_info[i]["xinfaReq"] == "#cff0000不满足" then
                    msg = msg .. "#r  #cff0000心法等级40             不满足"
                else
                    msg = msg .. "#r  #G心法等级40             满足"
                end
                if self.member_info[i]["taskCount"] == "#cff0000不满足" then
                    msg = msg .. "#r  #cff0000帮会等级3              不满足"
                else
                    msg = msg .. "#r  #G帮会等级3              满足"
                end
                self:AddText(msg)
            end
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return 0
        end
    end
    return 1
end

function oshuhe_liye:CheckXinfaLevel(selfId, level)
    local nMenpai = self:GetMenPai(selfId)
    if nMenpai == 9 then
        return 0
    end
    for i = 1, 6 do
        local nXinfaLevel = self:LuaFnGetXinFaLevel(selfId, nMenpai * 6 + i)
        if nXinfaLevel < level then
            return 0
        end
    end
    return 1
end

return oshuhe_liye
