local class = require "class"
local define = require "define"
local script_base = require "script_base"
local bg_CangShan = class("bg_CangShan", script_base)
bg_CangShan.script_id = 810001
bg_CangShan.g_BossData = {
    {
        ["ID"] = 9110,
        ["PosX"] = 40,
        ["PosY"] = 263,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9111,
        ["PosX"] = 51,
        ["PosY"] = 223,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9112,
        ["PosX"] = 98,
        ["PosY"] = 246,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9113,
        ["PosX"] = 108,
        ["PosY"] = 285,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9114,
        ["PosX"] = 264,
        ["PosY"] = 263,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9115,
        ["PosX"] = 145,
        ["PosY"] = 59,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9116,
        ["PosX"] = 130,
        ["PosY"] = 50,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9117,
        ["PosX"] = 37,
        ["PosY"] = 47,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9118,
        ["PosX"] = 195,
        ["PosY"] = 271,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9119,
        ["PosX"] = 211,
        ["PosY"] = 144,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 254,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    }
}

function bg_CangShan:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5)
    local nTime = self:GetQuarterTime();
    local sceneId = self:GetSceneID()
	if nTime ~= 10 and nTime ~= 46 and nTime ~= 72 and nTime ~= 94 then
		return
	end
	if sceneId ~= 25 then
		return
	end
    self:StartOneActivity(actId, 180 * 1000, iNoticeType)
    if #(self.g_BossData) < 1 then
        return
    end
    for _, Data in pairs(self.g_BossData) do
        Data["NeedCreate"] = 1
    end
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum  do
        local MonsterId = self:GetMonsterObjID(i)
        local MosDataID = self:GetMonsterDataID(MonsterId)
        self:CurSceneHaveMonster(MosDataID)
    end
    for _, BossData in pairs(self.g_BossData) do
        if BossData["NeedCreate"] == 1 then
            local MonsterID =
                self:LuaFnCreateMonster(
                BossData["ID"],
                BossData["PosX"],
                BossData["PosY"],
                BossData["BaseAI"],
                BossData["ExtAIScript"],
                BossData["ScriptID"]
            )
            self:SetCharacterTitle(MonsterID, "苍山狂徒")
        end
    end
end

function bg_CangShan:OnTimer(actId, uTime)
    if not self:CheckActiviyValidity(actId) then
        self:StopOneActivity(actId)
    end
end

function bg_CangShan:CurSceneHaveMonster(DataID)
    for i, Data in pairs(self.g_BossData) do
        if DataID == Data["ID"] then
            self.g_BossData[i]["NeedCreate"] = 0
            break
        end
    end
end

return bg_CangShan
