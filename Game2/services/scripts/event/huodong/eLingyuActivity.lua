local class = require "class"
local define = require "define"
local script_base = require "script_base"
local eLingyuActivity = class("eLingyuActivity", script_base)
eLingyuActivity.script_id = 808000
eLingyuActivity.g_BossData = {
    {
        ["ID"] = 50947,
        ["PosX"] = 45,
        ["PosY"] = 45,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 102,
        ["PosY"] = 82,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 65,
        ["PosY"] = 98,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 39,
        ["PosY"] = 145,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 75,
        ["PosY"] = 198,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 57,
        ["PosY"] = 237,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 160,
        ["PosY"] = 210,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 279,
        ["PosY"] = 76,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 260,
        ["PosY"] = 119,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 254.5,
        ["PosY"] = 184.5,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 256,
        ["PosY"] = 239,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50947,
        ["PosX"] = 215,
        ["PosY"] = 232,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },

    {
        ["ID"] = 50949,
        ["PosX"] = 160,
        ["PosY"] = 90,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50949,
        ["PosX"] = 131.5,
        ["PosY"] = 189.5,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50949,
        ["PosX"] = 160,
        ["PosY"] = 160,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50949,
        ["PosX"] = 188,
        ["PosY"] = 136,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50949,
        ["PosX"] = 188,
        ["PosY"] = 191,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50949,
        ["PosX"] = 132,
        ["PosY"] = 136,
        ["BaseAI"] = 3,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    }
}
eLingyuActivity.MonsterGroup = {
    { ID = 50940, Num = 8},
    { ID = 50942, Num = 4},
    { ID = 50944, Num = 2},
}
function eLingyuActivity:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5)
    if self:get_scene():get_id() ~= 1297 then
        return
    end
    self:StartOneActivity(actId, 60 * 60 * 1000, iNoticeType)
    self:SetActivityParam(actId, 1, 0)
    self:CreatePlatform(actId)
    self:CreateMonsters()
end

function eLingyuActivity:CreatePlatform(actId, i)
    for _, Data in pairs(self.g_BossData) do
        Data["NeedCreate"] = 1
    end
    for _, BossData in pairs(self.g_BossData) do
        if BossData["NeedCreate"] == 1 then
                local monsterId = self:LuaFnCreateMonster(
                BossData["ID"],
                BossData["PosX"],
                BossData["PosY"],
                BossData["BaseAI"],
                BossData["ExtAIScript"],
                BossData["ScriptID"]
            )
            self:SetCharacterDieTime(monsterId, 60 * 60 * 1000)
        end
    end
end

function eLingyuActivity:OnTimer(actId, uTime)
    if not self:CheckActiviyValidity(actId) then
        self:StopOneActivity(actId)
        return
    end
    if self:GetActivityTickTime() < 30 * 60 * 1000 then
        local value = self:GetActivityParam(actId, 1)
        value = value + uTime
        if value > 3 * 60 * 1000 then
            self:CreateMonsters(actId)
            self:SetActivityParam(actId, 1, 0)
        else
            self:SetActivityParam(actId, 1, value)
        end
    end
end

function eLingyuActivity:CreateMonsters()
    for _, boss in ipairs(self.g_BossData) do
        local x = boss["PosX"]
        local y = boss["PosY"]
        self:CreateMonsterGroup(x, y)
    end
end

function eLingyuActivity:CreateMonsterGroup(x, y)
    for _, g in ipairs(self.MonsterGroup) do
        for i = 1, g.Num do
            x = x + math.random(4, 6)
            y = y + math.random(4, 6)
            local monsterid = self:LuaFnCreateMonster(g.ID, x, y, 4, define.INVAILD_ID, define.INVAILD_ID)
            self:SetCharacterDieTime(monsterid, 30 * 60 * 1000)
        end
    end
end

return eLingyuActivity
