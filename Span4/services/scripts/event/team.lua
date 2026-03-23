local skynet = require "skynet"
local class = require "class"
local define = require "define"
local script_base = require "script_base"
local team = class("team", script_base)
team.script_id = 400900
team.g_Impact_No_ChangeScene = 38
team.g_Yinpiao = 40002000
function team:TransferFunc(selfId, newSceneId, posX, posY, minLevel, maxLevel)
    --minLevel = nil
    --maxLevel = nil
    print("TransferFunc =", selfId, newSceneId, posX, posY, minLevel, maxLevel)
    if self:LuaFnGetDestSceneHumanCount(newSceneId) > 500 then
        self:notify_tips(selfId, "目标场景人数已满")
        return
    end
    if newSceneId == 2 then
        minLevel = 1
    end
    if minLevel == nil then
        minLevel = 10
    end
    local humanList = {}
    local humanCount = 0
    local selfHasDRideFlag = self:LuaFnGetDRideFlag(selfId)
    if selfHasDRideFlag then
        local selfIsDRideMountOwner = self:LuaFnIsDRideMountOwner(selfId)
        if not selfIsDRideMountOwner then
            return
        end
    end
    local selfHasTeamFlag = self:LuaFnHasTeam(selfId)
    if selfHasTeamFlag then
        local teamFollowFlag = self:IsTeamFollow(selfId)
        local teamLeaderFlag = self:LuaFnIsTeamLeader(selfId)
        if not teamLeaderFlag and teamFollowFlag then
            return
        end
        if teamLeaderFlag then
            if teamFollowFlag then
                local followMemberCount = self:LuaFnGetFollowedMembersCount(selfId)
                local followMembers = {}
                for i = 1, followMemberCount do
                    followMembers[i] = self:GetFollowedMember(selfId, i)
                    if followMembers[i] and followMembers[i] ~= -1 then
                        if followMembers[i] ~= selfId and self:IsHaveMission(followMembers[i], 4021) then
                            self:NotifyFailTips(selfId, "您还有跟随的队友处于漕运状态中，无法传送。")
                            return
                        end
                        if followMembers[i] ~= selfId and self:GetItemCount(followMembers[i], self.g_Yinpiao) >= 1 then
                            self:NotifyFailTips(selfId, "您还有跟随的队友处于跑商状态中，无法传送。")
                            return
                        end
                        local memberHasDRideFlag = self:LuaFnGetDRideFlag(followMembers[i])
                        if memberHasDRideFlag then
                            local memberIsDRideMountOwner = self:LuaFnIsDRideMountOwner(followMembers[i])
                            if memberIsDRideMountOwner then
                            else
                                self:NotifyFailTips(selfId, "双人骑乘不能与组队跟随并存。")
                                return
                            end
                        end
                        humanCount = humanCount + 1
                        humanList[humanCount] = followMembers[i]
                    else
                        self:NotifyFailTips(selfId, "您还有跟随的队友没有到达本场景，暂时不能离开。")
                        return
                    end
                end
            else
                humanCount = humanCount + 1
                humanList[humanCount] = selfId
            end
        else
            if teamFollowFlag then
                assert(false)
                return
            end
            humanCount = humanCount + 1
            humanList[humanCount] = selfId
        end
    else
        humanCount = humanCount + 1
        humanList[humanCount] = selfId
    end
    local saveHumanCount = humanCount
    for i = 1, saveHumanCount do
        local tempHumanId = humanList[i]
        local drideFlag = self:LuaFnGetDRideFlag(tempHumanId)
        if drideFlag then
            local isDRideMountOwner = self:LuaFnIsDRideMountOwner(tempHumanId)
            if isDRideMountOwner then
                local drideTargetID = self:LuaFnGetDRideTargetID(tempHumanId)
                if drideTargetID and drideTargetID ~= -1 then
                    if drideTargetID ~= selfId and self:IsHaveMission(drideTargetID, 4021) then
                        self:NotifyFailTips(selfId, "您或您的跟随队伍中有双人骑乘的对方处于漕运状态中，无法传送。")
                        return
                    end
                    if drideTargetID ~= selfId and self:GetItemCount(drideTargetID, self.g_Yinpiao) >= 1 then
                        self:NotifyFailTips(selfId, "您或您的跟随队伍中有双人骑乘的对方处于跑商状态中，无法传送。")
                        return
                    end
                    humanCount = humanCount + 1
                    humanList[humanCount] = drideTargetID
                end
            else
                return
            end
        end
    end
    for _, checkHumanId in pairs(humanList) do
        local checkRet, errorTips, errorSelfTips =
            self:CheckChangeScene(checkHumanId, newSceneId, posX, posY, minLevel, maxLevel)
        if checkRet and checkRet == 1 then
        else
            if errorTips then
                self:NotifyFailTips(checkHumanId, errorTips)
            end
            if checkHumanId ~= selfId and errorSelfTips then
                self:NotifyFailTips(selfId, errorSelfTips)
            end
            assert(false)
            return
        end
    end
    local sceneId = self:get_scene_id()
    if sceneId ~= newSceneId then
        for _, checkHumanId in pairs(humanList) do
            self:NewWorld(checkHumanId, newSceneId, nil, posX, posY)
        end
    else
        for _, checkHumanId in pairs(humanList) do
            self:SetPos(checkHumanId, posX, posY)
        end
    end
end

function team:TransferFuncFromNpc(selfId, newSceneId, posX, posY, minLevel, maxLevel)
    if self:IsHaveMission(selfId, 4021) then
        self:BeginEvent(self.script_id)
        local strText = "您处于漕运状态中，不可以使用传送的功能。"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    elseif self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 113) then
        self:BeginEvent(self.script_id)
        local strText = "您处于跑商状态中，不可以使用传送的功能。"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    else
        self:TransferFunc(selfId, newSceneId, posX, posY, minLevel, maxLevel)
    end
end

function team:NotifyFailTips(selfId, Tip)
    self:BeginEvent(self.script_id)
    self:AddText(Tip)
    self:EndEvent()
    self:DispatchMissionTips(selfId)
end

function team:CheckChangeScene(selfId, newSceneId, posX, posY, minLevel, maxLevel)
    if newSceneId ~= 2 then
        if minLevel == nil then
            minLevel = 10
        end
    end
    if not selfId or not newSceneId or not posX or not posY then
        return 0, "无效传送请求，无法传送。", "无效传送请求，无法传送。"
    end
    local selfLevel = self:LuaFnGetLevel(selfId)
    if not selfLevel then
        return 0, "无效传送请求，无法传送。", "无效传送请求，无法传送。"
    end
    local livingFlag = self:LuaFnIsCharacterLiving(selfId)
    if not livingFlag then
        return 0, "你已经死亡，无法传送。", self:GetName(selfId).."已经死亡，无法传送。"
    end
    if minLevel and selfLevel < minLevel then
        return 0,  "你的级别不足"..tostring(minLevel).."，无法传送。", self:GetName(selfId).."的级别不足"..tostring(minLevel).."，无法传送。"
    end
    if maxLevel and selfLevel >= maxLevel then
        return 0, "你的级别必需小于"..tostring(maxLevel).."，才能传送。", self:GetName(selfId).."的级别必需小于"..tostring(maxLevel).."，才能传送。"
    end
    local changeSceneImpactCheck = self:LuaFnHaveImpactOfSpecificDataIndex(selfId, self.g_Impact_No_ChangeScene)
    if changeSceneImpactCheck then
        return 0, "你现在还不能离开。", self:GetName(selfId).."现在还不能离开。"
    end
    return 1
end

return team
