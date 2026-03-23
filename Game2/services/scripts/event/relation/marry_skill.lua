local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local marry_skill = class("marry_skill", script_base)
marry_skill.script_id = 806016
marry_skill.g_skillList_XXXY = {
    {["id"] = 133, ["name"] = "心心相印(1级)", ["firendPt"] = 1000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 0},
    {["id"] = 134, ["name"] = "心心相印(2级)", ["firendPt"] = 2000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 442},
    {["id"] = 135, ["name"] = "心心相印(3级)", ["firendPt"] = 3000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 967},
    {["id"] = 136, ["name"] = "心心相印(4级)", ["firendPt"] = 4000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 1800},
    {["id"] = 137, ["name"] = "心心相印(5级)", ["firendPt"] = 5000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 3009},
    {["id"] = 138, ["name"] = "心心相印(6级)", ["firendPt"] = 6000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 4660},
    {["id"] = 139, ["name"] = "心心相印(7级)", ["firendPt"] = 7000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 6825},
    {["id"] = 140, ["name"] = "心心相印(8级)", ["firendPt"] = 8000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 13322},
    {["id"] = 141, ["name"] = "心心相印(9级)", ["firendPt"] = 9000, ["lvM"] = 0, ["lvF"] = 0, ["exp"] = 0, ["money"] = 23449}
}

marry_skill.g_skillList_TQLZ = {
    {
        ["id"] = 123,
        ["name"] = "同气连枝(1级)",
        ["firendPt"] = 1000,
        ["lvM"] = 35,
        ["lvF"] = 20,
        ["exp"] = 24739,
        ["money"] = 10000
    },
    {
        ["id"] = 124,
        ["name"] = "同气连枝(2级)",
        ["firendPt"] = 3000,
        ["lvM"] = 45,
        ["lvF"] = 30,
        ["exp"] = 53745,
        ["money"] = 40000
    },
    {
        ["id"] = 125,
        ["name"] = "同气连枝(3级)",
        ["firendPt"] = 5000,
        ["lvM"] = 55,
        ["lvF"] = 40,
        ["exp"] = 116762,
        ["money"] = 100000
    },
    {
        ["id"] = 126,
        ["name"] = "同气连枝(4级)",
        ["firendPt"] = 7000,
        ["lvM"] = 65,
        ["lvF"] = 50,
        ["exp"] = 253665,
        ["money"] = 200000
    },
    {
        ["id"] = 127,
        ["name"] = "同气连枝(5级)",
        ["firendPt"] = 9999,
        ["lvM"] = 75,
        ["lvF"] = 60,
        ["exp"] = 551086,
        ["money"] = 500000
    }
}

marry_skill.g_skillList_TCDJ = {
    {
        ["id"] = 128,
        ["name"] = "天长地久(1级)",
        ["firendPt"] = 1000,
        ["lvM"] = 35,
        ["lvF"] = 20,
        ["exp"] = 24739,
        ["money"] = 10000
    },
    {
        ["id"] = 129,
        ["name"] = "天长地久(2级)",
        ["firendPt"] = 3000,
        ["lvM"] = 45,
        ["lvF"] = 30,
        ["exp"] = 53745,
        ["money"] = 40000
    },
    {
        ["id"] = 130,
        ["name"] = "天长地久(3级)",
        ["firendPt"] = 5000,
        ["lvM"] = 55,
        ["lvF"] = 40,
        ["exp"] = 116762,
        ["money"] = 100000
    },
    {
        ["id"] = 131,
        ["name"] = "天长地久(4级)",
        ["firendPt"] = 7000,
        ["lvM"] = 65,
        ["lvF"] = 50,
        ["exp"] = 253665,
        ["money"] = 200000
    },
    {
        ["id"] = 132,
        ["name"] = "天长地久(5级)",
        ["firendPt"] = 9999,
        ["lvM"] = 75,
        ["lvF"] = 60,
        ["exp"] = 551086,
        ["money"] = 500000
    }
}

marry_skill.g_skillList_XYBL = {
    {
        ["id"] = 142,
        ["name"] = "形影不离(1级)",
        ["firendPt"] = 1000,
        ["lvM"] = 35,
        ["lvF"] = 20,
        ["exp"] = 24739,
        ["money"] = 10000
    },
    {
        ["id"] = 143,
        ["name"] = "形影不离(2级)",
        ["firendPt"] = 3000,
        ["lvM"] = 45,
        ["lvF"] = 30,
        ["exp"] = 53745,
        ["money"] = 40000
    },
    {
        ["id"] = 144,
        ["name"] = "形影不离(3级)",
        ["firendPt"] = 5000,
        ["lvM"] = 55,
        ["lvF"] = 40,
        ["exp"] = 116762,
        ["money"] = 100000
    },
    {
        ["id"] = 145,
        ["name"] = "形影不离(4级)",
        ["firendPt"] = 7000,
        ["lvM"] = 65,
        ["lvF"] = 50,
        ["exp"] = 253665,
        ["money"] = 200000
    },
    {
        ["id"] = 146,
        ["name"] = "形影不离(5级)",
        ["firendPt"] = 9999,
        ["lvM"] = 75,
        ["lvF"] = 60,
        ["exp"] = 551086,
        ["money"] = 500000
    }
}

marry_skill.g_xybl_SkillID = 269
marry_skill.g_xybl_ItemID = 30308059
marry_skill.g_MaxMarrySkill_T = {141, 126, 127, 131, 132, 145, 146}

function marry_skill:OnDefaultEvent(selfId, targetId, index)
    local selectEventId = index
    if selectEventId == 0 then
        self:BeginEvent(self.script_id)
        self:AddNumText("学习心心相印", 12, 11)
        self:AddNumText("学习同气连枝", 12, 12)
        self:AddNumText("学习天长地久", 12, 13)
        self:AddNumText("学习形影不离", 12, 14)
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif selectEventId == 11 then
        local ret, nextLevel, maleId, femaleId = self:CheckStudySkill(selfId, targetId, self.g_skillList_XXXY)
        if ret > 0 then
            local skill = self.g_skillList_XXXY[nextLevel + 1]
            self:BeginEvent(self.script_id)
            self:AddText("  心心相印可以增加配偶的体力，技能等级越高增加的体力越多。")
            if skill["money"] > 0 then
                self:AddText("  男方需要花费#{_EXCHG" .. skill["money"] .. "}学习" .. skill["name"] .. "。")
            end
            if nextLevel > 0 then
                self:AddNumText("升级技能", 12, 21)
            else
                self:AddNumText("学习技能", 12, 21)
            end
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif selectEventId == 12 then
        local ret, nextLevel, maleId, femaleId = self:CheckStudySkill(selfId, targetId, self.g_skillList_TQLZ)
        if ret > 0 then
            local skill = self.g_skillList_TQLZ[nextLevel + 1]
            self:BeginEvent(self.script_id)
            self:AddText("  同气连枝能够恢复配偶的血，技能等级越高，恢复的血越多。")
            self:AddText("  学习" .. skill["name"] .. "需要男方花费" .. skill["exp"] .. "经验和#{_EXCHG" .. skill["money"] .. "}。")
            self:AddText(
                "  同时需要夫妻的好感度达到#G" ..
                    skill["firendPt"] .. "#W，男方等级达到" .. skill["lvM"] .. "级，女方等级达到" .. skill["lvF"] .. "级。"
            )
            if nextLevel > 0 then
                self:AddNumText("升级技能", 12, 22)
            else
                self:AddNumText("学习技能", 12, 22)
            end
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif selectEventId == 13 then
        local ret, nextLevel = self:CheckStudySkill(selfId, targetId, self.g_skillList_TCDJ)
        if ret > 0 then
            local skill = self.g_skillList_TCDJ[nextLevel + 1]
            self:BeginEvent(self.script_id)
            self:AddText("  天长地久可以复活配偶并回复一定比例的血气，技能等级越高，技能冷却时间越少。")
            self:AddText("  学习" .. skill["name"] .. "需要男方花费" .. skill["exp"] .. "经验和#{_EXCHG" .. skill["money"] .. "}。")
            self:AddText(
                "  同时需要夫妻的好感度达到#G" ..
                    skill["firendPt"] .. "#W，男方等级达到" .. skill["lvM"] .. "级，女方等级达到" .. skill["lvF"] .. "级。"
            )
            if nextLevel > 0 then
                self:AddNumText("升级技能", 12, 23)
            else
                self:AddNumText("学习技能", 12, 23)
            end
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif selectEventId == 14 then
        local ret, nextLevel = self:CheckStudySkill(selfId, targetId, self.g_skillList_XYBL)
        if ret > 0 then
            local skill = self.g_skillList_XYBL[nextLevel + 1]
            self:BeginEvent(self.script_id)
            self:AddText("  形影不离可以同场景瞬间移动到配偶所在点，技能等级越高，技能冷却时间越少。")
            if skill["id"] == self.g_xybl_SkillID then
                self:AddText(
                    "  学习" .. skill["name"] .. "需要男方持有#G#{_ITEM" .. tostring(self.g_xybl_ItemID) .. "}#W。"
                )
            else
                self:AddText(
                    "  学习" .. skill["name"] .. "需要男方花费" .. skill["exp"] .. "经验和#{_EXCHG" .. skill["money"] .. "}。"
                )
            end
            self:AddText(
                "  同时需要夫妻的好感度达到#G" ..
                    skill["firendPt"] .. "#W，男方等级达到" .. skill["lvM"] .. "级，女方等级达到" .. skill["lvF"] .. "级。"
            )
            if nextLevel > 0 then
                self:AddNumText("升级技能", 12, 24)
            else
                self:AddNumText("学习技能", 12, 24)
            end
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif selectEventId == 21 then
        self:StudySkill(selfId, targetId, self.g_skillList_XXXY)
    elseif selectEventId == 22 then
        self:StudySkill(selfId, targetId, self.g_skillList_TQLZ)
    elseif selectEventId == 23 then
        self:StudySkill(selfId, targetId, self.g_skillList_TCDJ)
    elseif selectEventId == 24 then
        self:StudySkill(selfId, targetId, self.g_skillList_XYBL)
    end
end

function marry_skill:OnEnumerate(caller, selfId, targetId, arg, index)
    local isMarried = self:LuaFnIsMarried(selfId)
    if isMarried then
        caller:AddNumTextWithTarget(self.script_id, "学习夫妻技能", 12, 0)
    end
end

function marry_skill:CheckStudySkill(selfId, targetId, SkillList)
    local szMsg = "如果想学习夫妻技能，请男女双方2人组成一队再来找我。"
    if not self:LuaFnHasTeam(selfId) then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "队伍必须只能由夫妻双方组成，队伍中不能有其他人员。"
    if self:LuaFnGetTeamSize(selfId) ~= 2 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "只有2人都走到我身边才可以学习技能。"
    local nearNum = self:GetNearTeamCount(selfId)
    if nearNum ~= 2 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    szMsg = "不是夫妻不能学习夫妻技能。"
    local maleId = -1
    local femaleId = -1
    for nearIndex = 1, nearNum do
        local memId = self:GetNearTeamMember(selfId, nearIndex)
        local sexType = self:LuaFnGetSex(memId)
        if sexType == 1 then
            maleId = memId
        else
            femaleId = memId
        end
    end
    if maleId == -1 or femaleId == -1 then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    local isSpouses = self:LuaFnIsSpouses(maleId, femaleId)
    if isSpouses then
    else
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    if not self:LuaFnIsCanDoScriptLogic(maleId) then
        return 0
    end
    if not self:LuaFnIsCanDoScriptLogic(femaleId) then
        return 0
    end
    szMsg = "双方必须互为好友才能学习夫妻技能。"
    local maleIsFirend, femaleIsFirend
    maleIsFirend = self:LuaFnIsFriend(maleId, femaleId)
    femaleIsFirend = self:LuaFnIsFriend(femaleId, maleId)
    if maleIsFirend and femaleIsFirend then
    else
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    local maleSkillLevel
    maleSkillLevel = -1
    local skillLevel = 0
    for _, skill in pairs(SkillList) do
        local maleHaveSkill = self:HaveSkill(maleId, skill["id"])
        if maleHaveSkill and maleHaveSkill > 0 then
            maleSkillLevel = skillLevel
        end
        skillLevel = skillLevel + 1
    end
    local maxSkillLevel = skillLevel - 1
    szMsg = "您此技能已经升级到最高，无法继续升级。"
    if maleSkillLevel >= maxSkillLevel then
        self:MessageBox(selfId, targetId, szMsg)
        return 0
    end
    return 1
end

function marry_skill:StudySkill(selfId, targetId, SkillList)
    local ret, nextLevel, maleId, femaleId = self:CheckStudySkill(selfId, targetId, SkillList)
    if ret == 0 then
        return
    end
    local skill = SkillList[nextLevel + 1]
    local szMsg = "双方的友好度必须达到%d才可以学会下一项夫妻技能。"
    local maleFirendPt, femaleFirendPt, needFirendPt
    maleFirendPt = self:LuaFnGetFriendPoint(maleId, femaleId)
    femaleFirendPt = self:LuaFnGetFriendPoint(femaleId, maleId)
    needFirendPt = skill["firendPt"]
    if maleFirendPt >= needFirendPt and femaleFirendPt >= needFirendPt then
    else
        szMsg = string.format(szMsg, needFirendPt)
        self:MessageBox(selfId, targetId, szMsg)
        return
    end
    szMsg = "男方等级必须达到%d才可以学会下一项夫妻技能。"
    if self:GetLevel(maleId) < skill["lvM"] then
        szMsg = string.format(szMsg, skill["lvM"])
        self:MessageBox(selfId, targetId, szMsg)
        return
    end
    szMsg = "女方等级必须达到%d才可以学会下一项夫妻技能。"
    if self:GetLevel(femaleId) < skill["lvF"] then
        szMsg = string.format(szMsg, skill["lvF"])
        self:MessageBox(selfId, targetId, szMsg)
        return
    end
    if skill["id"] == self.g_xybl_SkillID then
        if not self:HaveItemInBag(maleId, self.g_xybl_ItemID) then
            self:MessageBox(selfId, targetId, "男方需要持有#G#{_ITEM" .. tostring(self.g_xybl_ItemID) .. "}#W才能学习该技能！")
            return
        end
        if self:LuaFnGetAvailableItemCount(maleId, self.g_xybl_ItemID) <= 0 then
            self:MessageBox(selfId, targetId, "需求物品#G#{_ITEM" .. tostring(self.g_xybl_ItemID) .. "}#W已加锁，请解锁后再学习！")
            return
        end
        self:LuaFnDelAvailableItem(maleId, self.g_xybl_ItemID, 1)
    else
        szMsg = "男方经验必须达到%d才可以学会下一项夫妻技能。"
        if self:GetExp(maleId) < skill["exp"] then
            szMsg = string.format(szMsg, skill["exp"])
            self:MessageBox(selfId, targetId, szMsg)
            return
        end
        szMsg = "男方需要携带#{_EXCHG%d}才能学习技能。"
        local maleMoney, needMoney
        maleMoney = self:LuaFnGetMoney(maleId)
        needMoney = skill["money"]
        if maleMoney and maleMoney + self:GetMoneyJZ(maleId) >= needMoney then
        else
            szMsg = string.format(szMsg, needMoney)
            self:MessageBox(selfId, targetId, szMsg)
            return
        end
        self:LuaFnCostMoneyWithPriority(maleId, needMoney)
        if skill["exp"] > 0 then
            self:LuaFnAddExp(maleId, -skill["exp"])
        end
    end
    self:MyAddSkill(maleId, SkillList, nextLevel)
    self:MyAddSkill(femaleId, SkillList, nextLevel)
    self:SendWorldMsg(maleId, femaleId, SkillList, nextLevel)
    self:LogCoupleAction(maleId, femaleId, SkillList, nextLevel)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
    return
end

function marry_skill:MyAddSkill(selfId, SkillList, nextLevel)
    for _, tempSkill in pairs(SkillList) do
        local haveSkill = self:HaveSkill(selfId, tempSkill["id"])
        if haveSkill and haveSkill > 0 then
            self:DelSkill(selfId, tempSkill["id"])
        end
    end
    local skill = SkillList[nextLevel + 1]
    self:AddSkill(selfId, skill["id"])
    if skill["id"] == self.g_xybl_SkillID then
        self:SendSkillMsg_XYBL(selfId, skill["name"])
    else
        self:SendSkillMsg(selfId, skill["exp"], skill["money"], skill["name"])
    end
end

function marry_skill:MessageBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function marry_skill:SendSkillMsg_XYBL(selfId, skname)
    if skname then
        local str =
            string.format(
            "#I贵夫妇同心协力，排除万难，在男方耗费了#Y#{_ITEM" .. tostring(self.g_xybl_ItemID) .. "}#I之后，终于学会了夫妻技能#Y%s。",
            skname
        )
        self:BeginEvent(self.script_id)
        self:AddText(str)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    end
end

function marry_skill:SendSkillMsg(selfId, exp, money, skname)
    if exp and money and skname then
        local moneyt = string.format("#{_EXCHG%d}", money)
        local str = string.format("#I贵夫妇同心协力，排除万难，在男方耗费了#Y%d经验和%s金钱#I之后，终于学会了夫妻技能#Y%s。", exp, moneyt, skname)
        self:BeginEvent(self.script_id)
        self:AddText(str)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
    end
end

function marry_skill:SendWorldMsg(maleId, femaleId, SkillList, nextLevel)
    local skill = SkillList[nextLevel + 1]
    if maleId and femaleId and skill then
        for _, tempId in pairs(self.g_MaxMarrySkill_T) do
            if tempId == skill["id"] then
                local uname = string.format("#{_INFOUSR%s}", self:GetName(maleId))
                local oname = string.format("#{_INFOUSR%s}", self:GetName(femaleId))
                local str =
                    string.format("#W%s#I与#W%s#I夫妻同心，终于苦尽甘来，学会了#cff66cc%s#I，不愧是所有夫妻的楷模。", uname, oname, skill["name"])
                self:BroadMsgByChatPipe(maleId, str, 4)
                return
            end
        end
    end
end

function marry_skill:LogCoupleAction(tid1, tid2, SkillList, nextLevel)
    local skill = SkillList[nextLevel + 1]
    local logid = ScriptGlobal.COUPLE_LOG_LEVELUPSKILL
    if nextLevel == 0 then
        logid = ScriptGlobal.COUPLE_LOG_LEARNSKILL
    end
    if skill and logid and ScriptGlobal.COUPLE_LOG_DETAIL[logid] then
        local logstr =
            string.format(
            "CPL:%d,%s,0x%X,0x%X,%d,%s",
            logid,
            ScriptGlobal.COUPLE_LOG_DETAIL[logid],
            self:LuaFnGetGUID(tid1),
            self:LuaFnGetGUID(tid2),
            skill["id"],
            skill["name"]
        )
        self:LogCouple(logstr)
    end
end

return marry_skill
