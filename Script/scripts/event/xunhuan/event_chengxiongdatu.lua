-- 惩凶打图任务
-- 寻物
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local event_chengxiongdatu = class("event_chengxiongdatu", script_base)
event_chengxiongdatu.script_id = 229020
event_chengxiongdatu.g_MissionId = 1200
event_chengxiongdatu.g_Name = "吴玠"
event_chengxiongdatu.g_MissionKind = 1
event_chengxiongdatu.g_MissionLevel = 10000
event_chengxiongdatu.g_IfMissionElite = 0
event_chengxiongdatu.g_IsMissionOkFail = 0
event_chengxiongdatu.g_DemandKill = {{["id"] = 3500, ["num"] = 1}}

event_chengxiongdatu.g_DemandTrueKill = {{["name"] = "恶棍", ["num"] = 1}}

event_chengxiongdatu.g_MissionName = "#{CXDT_090304_01}"
event_chengxiongdatu.g_MissionInfo = "#{CXDT_090304_02}"
event_chengxiongdatu.g_MissionTarget = "#{CXDT_090304_03}"
event_chengxiongdatu.g_ContinueInfo = "#{CXDT_090304_04}"
event_chengxiongdatu.g_MissionComplete = "#{CXDT_090304_05}"
event_chengxiongdatu.g_MissionItem = {{["id"] = 40004000, ["num"] = 1}}

event_chengxiongdatu.g_NeedItemId = 30000000
event_chengxiongdatu.g_scenePosInfoList = {
	{
        sceneId = 28,
        sceneName = "南诏",
        minL = 86,
        maxL = 100,
        posList = {
            {x = 89.97, z = 49.88, r = 10}, {x = 84.48, z = 48.99, r = 10},
            {x = 82.22, z = 60.08, r = 10}, {x = 71.64, z = 70.7, r = 10},
            {x = 159.65, z = 120.50, r = 10}, {x = 186.25, z = 118.28, r = 10},
            {x = 195.76, z = 107.61, r = 10}, {x = 195.23, z = 79.65, r = 10},
            {x = 160.14, z = 130.37, r = 10}, {x = 192.81, z = 148.7, r = 10},
            {x = 204.54, z = 155.54, r = 10}, {x = 269.54, z = 183.4, r = 10},
            {x = 277.49, z = 190.83, r = 10}, {x = 242.8, z = 128.19, r = 10},
            {x = 272.04, z = 136.37, r = 10}, {x = 232.56, z = 70, r = 10},
            {x = 275.18, z = 74.66, r = 10}, {x = 66.6, z = 167.95, r = 10},
            {x = 61.25, z = 178.62, r = 10}, {x = 59.15, z = 191.19, r = 10},
            {x = 49.71, z = 220.67, r = 10}, {x = 50.1, z = 230.64, r = 10},
            {x = 60.11, z = 230.16, r = 10}, {x = 69.92, z = 235.77, r = 10},
            {x = 80.19, z = 240.89, r = 10}, {x = 109.93, z = 200.39, r = 10},
            {x = 129.91, z = 199.8, r = 10}, {x = 149.99, z = 200.15, r = 10},
            {x = 170, z = 200, r = 10}, {x = 150, z = 180, r = 10},
            {x = 190, z = 200, r = 10}, {x = 100, z = 220, r = 10},
            {x = 120, z = 220, r = 10}, {x = 210, z = 220, r = 10},
            {x = 240, z = 220, r = 10}, {x = 100, z = 240, r = 10},
            {x = 120, z = 240, r = 10}, {x = 140, z = 240, r = 10},
            {x = 210, z = 240, r = 10}, {x = 50, z = 260, r = 10},
            {x = 70, z = 260, r = 10}, {x = 90, z = 260, r = 10},
            {x = 110, z = 260, r = 10}, {x = 130, z = 260, r = 10},
            {x = 150, z = 260, r = 10}, {x = 170, z = 260, r = 10},
            {x = 190, z = 260, r = 10}
        }
    }, 
}

event_chengxiongdatu.g_MonsterConfigTable = {
    {level = 11, id = 3500}, {level = 21, id = 3501}, {level = 31, id = 3502},
    {level = 41, id = 3503}, {level = 51, id = 3504}, {level = 61, id = 3505},
    {level = 71, id = 3506}, {level = 81, id = 3507}, {level = 91, id = 3508},
    {level = 101, id = 3509}, -- add by zchw for chengxiong
    {level = 111, id = 33500}, {level = 121, id = 33501},
    {level = 131, id = 33502}, {level = 141, id = 33503},
    {level = 151, id = 33504}, {level = 161, id = 33505},
    {level = 171, id = 33506}, {level = 181, id = 33507},
    {level = 191, id = 33508}, {level = 201, id = 33509}
}

event_chengxiongdatu.g_TitleTableOfMonster = {
    {part1 = "劫财", part2 = "凶徒"}, {part1 = "逃狱", part2 = "恶人"},
    {part1 = "重案", part2 = "强盗"}, {part1 = "害命", part2 = "歹人"},
    {part1 = "毒手", part2 = "恶贼"}, {part1 = "煞心", part2 = "刺客"},
    {part1 = "劫镖", part2 = "恶霸"}
}

event_chengxiongdatu.g_NameTableOfMonster = {
    {part1 = "赵", part2 = "文", part3 = "霸"},
    {part1 = "钱", part2 = "元", part3 = "泰"},
    {part1 = "孙", part2 = "成", part3 = "烈"},
    {part1 = "李", part2 = "之", part3 = "赫"},
    {part1 = "周", part2 = "伯", part3 = "虎"},
    {part1 = "吴", part2 = "曾", part3 = "亮"},
    {part1 = "郑", part2 = "仁", part3 = "朗"},
    {part1 = "王", part2 = "恩", part3 = "古"}
}

function event_chengxiongdatu:GetScenePosTab(selfId,selectSceneId)
	for i, v in pairs(self.g_scenePosInfoList) do
		if v.sceneId == selectSceneId then
			return v.posList
		end
	end
	return false
end
function event_chengxiongdatu:GetScenePosInfo(selectSceneId)
    local index = math.random(#(self.g_scenePosInfoList))
    local subIndex = math.random(#(
                                     self.g_scenePosInfoList[index].posList))

    local sceneId = self.g_scenePosInfoList[index].sceneId
    local sceneName = self.g_scenePosInfoList[index].sceneName
    local x = self.g_scenePosInfoList[index].posList[subIndex].x
    local z = self.g_scenePosInfoList[index].posList[subIndex].z
    local r = self.g_scenePosInfoList[index].posList[subIndex].r

    if selectSceneId >= 0 and selectSceneId ~= -1 then
        for i, v in pairs(self.g_scenePosInfoList) do
            if v.sceneId == selectSceneId then
                local index = math.random(#(v.posList))
                sceneId, sceneName, x, z, r = v.sceneId, v.sceneName,
                                              v.posList[index].x,
                                              v.posList[index].z,
                                              v.posList[index].r
            end
        end
    end
    return sceneId, sceneName, x, z, r
end

function event_chengxiongdatu:ProduceItemParamData(selfId, BagPos)
    local index = math.random(#(self.g_scenePosInfoList))
    local sId = self.g_scenePosInfoList[index].sceneId
    local scene, sceneName, x, z, r = self:GetScenePosInfo(sId)
    if nil == BagPos or BagPos < 0 then return end
    if scene == nil or sceneName == nil or x == nil or z == nil or r == nil then
        return
    end
    self:SetBagItemParam(selfId, BagPos, 0, 1, "uchar")
    self:SetBagItemParam(selfId, BagPos, 1, scene, "uchar")
    self:SetBagItemParam(selfId, BagPos, 3, x, "ushort")
    self:SetBagItemParam(selfId, BagPos, 5, z, "ushort")
    self:SetBagItemParam(selfId, BagPos, 7, r, "ushort")
end

function event_chengxiongdatu:GetSceneName(selfId, sceneId)
    for i, v in pairs(self.g_scenePosInfoList) do
        if v.sceneId == sceneId then return v.sceneName end
    end
end

function event_chengxiongdatu:GetSceneNameById(sceneId)
    for i, v in pairs(self.g_scenePosInfoList) do
        if v["sceneId"] == sceneId then return v["sceneName"] end
    end
end

function event_chengxiongdatu:GetSceneIdByPlayerLevel(playerLevel)
    if playerLevel >= 100 then
        local index = math.random(#(self.g_scenePosInfoList))
        return self.g_scenePosInfoList[index]["sceneId"]
    else
        local j = 1
        local sceneTable = {}

        for i, v in pairs(self.g_scenePosInfoList) do
            if playerLevel >= v["minL"] and playerLevel <= v["maxL"] then
                sceneTable[j] = v["sceneId"]
                j = j + 1
            end
        end
        local index = math.random(#(sceneTable))
        return sceneTable[index]
    end
end

function event_chengxiongdatu:CreateTitleAndName(selfId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local ct = #(self.g_TitleTableOfMonster)
    local ret = math.random(ct)
    local part1 = self.g_TitleTableOfMonster[ret]["part1"]
    ret = math.random(ct)
    local part2 = self.g_TitleTableOfMonster[ret]["part2"]
    local strTitle = string.format("%s%s", part1, part2)
    ct = #(self.g_NameTableOfMonster)
    ret = math.random(ct)
    part1 = self.g_NameTableOfMonster[ret]["part1"]
    self:SetMissionByIndex(selfId, misIndex, 5, ret)
    ret = math.random(ct)
    part2 = self.g_NameTableOfMonster[ret]["part2"]
    self:SetMissionByIndex(selfId, misIndex, 6, ret)
    ret = math.random(ct)
    local part3 = self.g_NameTableOfMonster[ret]["part3"]
    self:SetMissionByIndex(selfId, misIndex, 7, ret)
    local strName = string.format("%s%s%s", part1, part2, part3)
    return strTitle, strName
end
function event_chengxiongdatu:CreateTitleAndName_ForCangBaoTu(selfId)
    local ct = #(self.g_TitleTableOfMonster)
    local ret = math.random(ct)
    local part1 = self.g_TitleTableOfMonster[ret]["part1"]
    ret = math.random(ct)
    local part2 = self.g_TitleTableOfMonster[ret]["part2"]
    local strTitle = string.format("%s%s", part1, part2)
    return strTitle
end

function event_chengxiongdatu:OnDefaultEvent(selfId, targetId)
    if self:CheckBan(selfId) then
        return
    end
    if self:IsHaveMission(selfId, self.g_MissionId) then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionInfo)
        self:EndEvent()
        local bDone = self:CheckSubmit(selfId)
        self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, self.g_MissionId, bDone)
    elseif self:CheckAccept(selfId) > 0 then
        local sId = self:GetSceneIdByPlayerLevel(self:GetLevel(selfId))
        local scene, sceneName, x, z, r = self:GetScenePosInfo(sId)
        print(scene, x, z, r)
        self:ResetMissionCacheData(selfId)
        self:SetMissionCacheData(selfId, 0, scene)
        self:SetMissionCacheData(selfId, 1, x)
        self:SetMissionCacheData(selfId, 2, z)
        self:SetMissionCacheData(selfId, 3, r)
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionInfo)
        self:AddText("#{M_MUBIAO}#r")
        local strText = string.format("#{CXDT_090304_06}%s#{CXDT_090304_09}",
                                      sceneName)
        self:AddText(strText)
        self:AddText("#{CXDT_090304_07}")
        for i, item in pairs(self.g_MissionItem) do
            self:AddItemBonus(item["id"], item["num"])
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        self:OnAccept(selfId)
    end
end

function event_chengxiongdatu:CheckBan(selfId)
    --[[
    local level = self:GetLevel(selfId)
    local obj = self:get_scene():get_obj_by_id(selfId)
    if obj.week_active.week_get == 0 and obj:get_guild_id() == define.INVAILD_ID then
        local skynet = require "skynet"
        local guid = obj:get_guid()
        local query = {["char_list"] = { ["$in"] = { guid }}}
        local response = skynet.call(".char_db", "lua", "findOne",  {collection = "account",query = query, selector = {uid = 1}})
        local uid = response.uid
        skynet.send(".gamed", "lua", "ban_user", uid)
        self:LOGI("event_chengxiongdatu CheckBan uid =", uid)
        return true
    end]]
    return false
end

function event_chengxiongdatu:OnEnumerate(caller, selfId, targetId, arg, index)
    if self:IsMissionHaveDone(selfId, self.g_MissionId) then
        return
    elseif self:IsHaveMission(selfId, self.g_MissionId) then
        caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 4, -1)
        return
    elseif self:CheckAccept(selfId) > 0 then
        if self:GetName(targetId) == self.g_Name then
            caller:AddNumTextWithTarget(self.script_id, self.g_MissionName, 3,
                                        -1)
        end
    end
end

function event_chengxiongdatu:CheckAccept(selfId)
    local nLevel = self:LuaFnGetLevel(selfId)
    if nLevel < 30 then
        return 0
    else
        return 1
    end
end

function event_chengxiongdatu:OnAccept(selfId)
    if self:CheckAccept_Necessary(selfId) <= 0 then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText("#{CXDT_090304_08}")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    local DayTimes, oldDate, nowDate, takenTimes
    DayTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYCOUNT)
    oldDate = DayTimes % 100000
    takenTimes = math.floor(DayTimes / 100000)
    nowDate = self:GetDayTime()
    if nowDate ~= oldDate then
        takenTimes = 0
        self:SetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYCOUNT, nowDate)
    end
    if takenTimes >= 50 then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText("#{CXDY_090114_01}")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    if self:GetMoney(selfId) + self:GetMoneyJZ(selfId) < 1000 then
        self:BeginEvent(self.script_id)
        self:AddText("金钱不足")
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    else
        self:LuaFnCostMoneyWithPriority(selfId, 1000)
    end
    self:BeginAddItem()
    self:AddItem(self.g_MissionItem[1]["id"], 1)
    local canAdd = self:EndAddItem(selfId)
    if not canAdd then return end
    local ret = self:AddMission(selfId, self.g_MissionId, self.script_id, 0,0,0)
    if not ret then return 0 end
    self:AddItemListToHuman(selfId)
    local scene = self:GetMissionCacheData(selfId, 0)
    local x = self:GetMissionCacheData(selfId, 1)
    local z = self:GetMissionCacheData(selfId, 2)
    local r = self:GetMissionCacheData(selfId, 3)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    self:SetMissionByIndex(selfId, misIndex, 0, 0)
    self:SetMissionByIndex(selfId, misIndex, 1, 0)
    self:SetMissionByIndex(selfId, misIndex, 2, scene)
    self:SetMissionByIndex(selfId, misIndex, 3, x)
    self:SetMissionByIndex(selfId, misIndex, 4, z)
    self:SetMissionByIndex(selfId, misIndex, 5, r)
    self:SetMissionByIndex(selfId, misIndex, 7, -1)
    self:notify_tips(selfId, "接受任务：惩凶打图")
    self:CallScriptFunction(define.SCENE_SCRIPT_ID, "AskTheWay", selfId, scene,x, z, "惩凶打图")
    local DayTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYCOUNT)
    local takenTimes = math.floor(DayTimes / 100000)
    DayTimes = (takenTimes + 1) * 100000 + self:GetDayTime()
    self:SetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYCOUNT,DayTimes)

end

function event_chengxiongdatu:OnAbandon(selfId)
    if self:LuaFnGetAvailableItemCount(selfId, self.g_MissionItem[1]["id"]) > 0 then
        if self:LuaFnGetAvailableItemCount(selfId, self.g_MissionItem[1]["id"]) >= 1 then
            self:DelItem(selfId, self.g_MissionItem[1]["id"], 1)
            self:DelMission(selfId, self.g_MissionId)
            self:Abandon_Necessary(selfId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("您的物品现在不可用或已被锁定。")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
    else
        self:DelMission(selfId, self.g_MissionId)
        self:Abandon_Necessary(selfId)
    end
end

function event_chengxiongdatu:OnContinue(selfId, targetId)
    if self:CheckAccept(selfId) > 0 then
        self:BeginEvent(self.script_id)
        self:AddText(self.g_MissionName)
        self:AddText(self.g_MissionComplete)
        local moneyBonus = 4000
        self:AddText("#Y固定奖励:")
        self:AddText("#{_EXCHG" .. moneyBonus .. "}")
        self:ResetMissionCacheData(selfId)
        self:SetMissionCacheData(selfId, 0, moneyBonus)
        self:EndEvent()
        self:DispatchMissionContinueInfo(selfId, targetId, self.script_id,
                                         self.g_MissionId)
    end
end

function event_chengxiongdatu:CheckSubmit(selfId)
    if not self:IsHaveMission(selfId, self.g_MissionId) then return 0 end
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    if self:GetMissionParam(selfId, misIndex, 0) > 0 then return 1 end
    return 0
end

function event_chengxiongdatu:OnSubmit(selfId, targetId, selectRadioId)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    if self:CheckSubmit(selfId) >= 1 then
        self:DelMission(selfId, self.g_MissionId)
        local moneyBonus = 5000
        self:AddMoneyJZ(selfId, moneyBonus)
        self:BeginEvent(self.script_id)
        local strText = string.format("#Y你获得了#{_EXCHG" .. moneyBonus ..
                                          "}。")
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        self:Msg2Player(selfId,
                        "你获得了#{_EXCHG" .. tostring(moneyBonus) .. "}。",
                        define.ENUM_CHAT_TYPE.MSG2PLAYER_PARA)
        self:LuaFnAddSalaryPoint(selfId, 6, 1)
    end
end

function event_chengxiongdatu:OnKillObject(selfId, objdataId, objId)
    print("event_chengxiongdatu:OnKillObject")
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local part1Index = self:GetMissionParam(selfId, misIndex, 5)
    local part2Index = self:GetMissionParam(selfId, misIndex, 6)
    local part3Index = self:GetMissionParam(selfId, misIndex, 7)
    print("OnKillObject", part1Index, part2Index, part3Index)
    if part1Index <= 0 or part2Index <= 0 or part3Index <= 0 then return end
    local npcName = string.format("%s%s%s",
                                  self.g_NameTableOfMonster[part1Index]["part1"],
                                  self.g_NameTableOfMonster[part2Index]["part2"],
                                  self.g_NameTableOfMonster[part3Index]["part3"])
    local targetName = self:GetName(objId)
	print("OnKillObject targetName =", targetName, ";npcName =", npcName)
    if targetName == npcName then
        local num = self:GetMissionParam(selfId, misIndex, 1)
        if num < self.g_DemandTrueKill[1]["num"] then
            if num == self.g_DemandTrueKill[1]["num"] - 1 then
                local OwnerCount = self:GetMonsterOwnerCount(objId)
                for i = 1, OwnerCount do
                    local humanObjId = self:GetMonsterOwnerID(objId, i)
                    if self:IsHaveMission(humanObjId, self.g_MissionId) and
                        humanObjId == selfId then
                        local BonusMoney =
                            57 + (self:LuaFnGetLevel(objId) - 20) * 8
                        self:AddMoney(selfId, BonusMoney)
                        local DropRate = 25 + self:LuaFnGetLevel(selfId) * 0.2
                        local DayTimes, oldDate, nowDate, takenTimes
                        DayTimes = self:GetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYCOUNT)
                        oldDate = DayTimes % 100000
                        takenTimes = math.floor(DayTimes / 100000)
                        nowDate = self:GetDayTime()
                        if nowDate ~= oldDate then
                            takenTimes = 0
                            self:SetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYCOUNT, nowDate)
                        end
                        local iDayHuan = takenTimes
                        if iDayHuan <= 5 then
                            DropRate = DropRate * 3
                        end
                        local nRandomRet = math.random(100)
                        if nRandomRet < DropRate then
                            self:AddMonsterDropItem(objId, humanObjId,
                                                    self.g_NeedItemId)
                        end
                        break
                    end
                end
            end
            self:SetMissionByIndex(selfId, misIndex, 1, num + 1)
            self:BeginEvent(self.script_id)
            self:AddText("已杀死恶棍")
            self:SetMissionByIndex(selfId, misIndex, 0, 1)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            self:ResetMissionEvent(selfId, misIndex, 0)
            self:LuaFnAuditDaTu(selfId)
            self:LuaFnSendGuajiQuestion(selfId)
        end
    end
end

function event_chengxiongdatu:OnEnterArea(selfId, zoneId) end

function event_chengxiongdatu:CreateMonsterbyHumanLevel(selfId, x, z)
    local humanLevel = self:LuaFnGetLevel(selfId)
    local dataId = self.g_MonsterConfigTable[1]["id"]
    local ct = #(self.g_MonsterConfigTable)
    for i = 1, ct do
        if humanLevel >= self.g_MonsterConfigTable[i]["level"] then
            if i + 1 <= ct then
                if humanLevel < self.g_MonsterConfigTable[i + 1]["level"] then
                    dataId = self.g_MonsterConfigTable[i]["id"]
                    break
                end
            end
        end
    end
    local aifile = math.random(10)
    local MonsterId = self:LuaFnCreateMonster(dataId, x, z, 0, aifile, -1)
    self:SetLevel(MonsterId, humanLevel + (math.random(2) - math.random(2)))
    self:SetCharacterDieTime(MonsterId, 20 * 60000)
    local strTitle, strName = self:CreateTitleAndName(selfId)
    self:SetCharacterTitle(MonsterId, strTitle)
    self:SetCharacterName(MonsterId, strName)
end

function event_chengxiongdatu:OnUseItem(selfId, bagIndex)
    local misIndex = self:GetMissionIndexByID(selfId, self.g_MissionId)
    local scene = self:GetMissionParam(selfId, misIndex, 2)
    local treasureX = self:GetMissionParam(selfId, misIndex, 3)
    local treasureZ = self:GetMissionParam(selfId, misIndex, 4)
    local r = self:GetMissionParam(selfId, misIndex, 5)
    local PlayerX = self:GetHumanWorldX(selfId)
    local PlayerZ = self:GetHumanWorldZ(selfId)
    local Distance = math.floor(math.sqrt(
                                    (treasureX - PlayerX) *
                                        (treasureX - PlayerX) +
                                        (treasureZ - PlayerZ) *
                                        (treasureZ - PlayerZ)))
    local str = self:ContactArgs("#{DTZDXL_210319_01", self:GetSceneNameById(scene), treasureX, treasureZ, scene)
    local sceneId = self:get_scene_id()
    if sceneId ~= scene then
        self:BeginEvent(self.script_id)
        self:AddText(str .. "}")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
        return
    end
    if Distance > r then
        self:BeginEvent(self.script_id)
        self:AddText(str .. "}")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
    elseif Distance <= r then
        if self:LuaFnGetAvailableItemCount(selfId, self.g_MissionItem[1]["id"]) >= 1 then
            self:DelItem(selfId, self.g_MissionItem[1]["id"])
            self:BeginEvent(self.script_id)
            self:AddText("施放惩恶令成功, 你要小心喽!")
            self:CreateMonsterbyHumanLevel(selfId, PlayerX, PlayerZ - 2)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            self:SetMissionEvent(selfId, self.g_MissionId, 0)
        else
            self:BeginEvent(self.script_id)
            self:AddText("您的物品现在不可用或已被锁定。")
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            return
        end
    end
end

function event_chengxiongdatu:OnItemChanged(selfId, itemdataId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "您的惩凶打图任务数据已经很旧了，请放弃该任务后重新领取。如果重新领取后还会出现本提示资讯请向客服人员反映此问题。")
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function event_chengxiongdatu:Abandon_Necessary(selfId)
    local iCurTime = self:GetQuarterTime()
    self:SetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYTIME,iCurTime)
end

function event_chengxiongdatu:CheckAccept_Necessary(selfId)
    local iTime = self:GetMissionData(selfId, define.MD_ENUM.MD_CHENGXIONGDATU_DAYTIME)
    local CurTime = self:GetQuarterTime()
    if iTime == CurTime then
        return -1
    end
    return 1
end

return event_chengxiongdatu
