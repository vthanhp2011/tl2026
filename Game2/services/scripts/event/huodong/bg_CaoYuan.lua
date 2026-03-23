local class = require "class"
local define = require "define"
local script_base = require "script_base"
local bg_CaoYuan = class("bg_CaoYuan", script_base)
bg_CaoYuan.script_id = 810003
bg_CaoYuan.g_BossData = {
    {
        ["ID"] = 9130,
        ["Title"] = "妙手空空",
        ["PosX"] = 77,
        ["PosY"] = 124,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9131,
        ["Title"] = "妙手走卒",
        ["PosX"] = 44,
        ["PosY"] = 72,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9132,
        ["Title"] = "妙手走卒",
        ["PosX"] = 83,
        ["PosY"] = 66,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9133,
        ["Title"] = "妙手走卒",
        ["PosX"] = 100,
        ["PosY"] = 90,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9134,
        ["Title"] = "妙手走卒",
        ["PosX"] = 58,
        ["PosY"] = 121,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9135,
        ["Title"] = "妙手走卒",
        ["PosX"] = 167,
        ["PosY"] = 63,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9136,
        ["Title"] = "妙手走卒",
        ["PosX"] = 280,
        ["PosY"] = 284,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9137,
        ["Title"] = "妙手走卒",
        ["PosX"] = 64,
        ["PosY"] = 253,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9138,
        ["Title"] = "妙手走卒",
        ["PosX"] = 190,
        ["PosY"] = 49,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 9139,
        ["Title"] = "妙手走卒",
        ["PosX"] = 276,
        ["PosY"] = 127,
        ["BaseAI"] = 29,
        ["ExtAIScript"] = 256,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    }
}

function bg_CaoYuan:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5)
    local nTime = self:GetQuarterTime();
    local sceneId = self:GetSceneID()
	if nTime ~= 6 and nTime ~= 54 and nTime ~= 74 and nTime ~= 90 then
		return
	end
	if sceneId ~= 20 then
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
            local MstId =
                self:LuaFnCreateMonster(
                BossData["ID"],
                BossData["PosX"],
                BossData["PosY"],
                BossData["BaseAI"],
                BossData["ExtAIScript"],
                BossData["ScriptID"]
            )
            self:SetCharacterTitle(MstId, BossData["Title"])
        end
    end
end

function bg_CaoYuan:OnTimer(actId, uTime)
    if not self:CheckActiviyValidity(actId) then
        self:StopOneActivity(actId)
    end
end

function bg_CaoYuan:CurSceneHaveMonster(DataID)
    for i, Data in pairs(self.g_BossData) do
        if DataID == Data["ID"] then
            self.g_BossData[i]["NeedCreate"] = 0
            break
        end
    end
end

return bg_CaoYuan
