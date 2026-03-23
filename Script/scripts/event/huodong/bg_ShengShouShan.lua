local class = require "class"
local define = require "define"
local script_base = require "script_base"
local bg_ShengShouShan = class("bg_ShengShouShan", script_base)
bg_ShengShouShan.script_id = 810110
bg_ShengShouShan.DataValidator = 0
bg_ShengShouShan.g_BossData = {
    {
        ["ID"] = 11353,
        ["PosX"] = 172,
        ["PosY"] = 34,
        ["BaseAI"] = 22,
        ["ExtAIScript"] = 259,
        ["ScriptID"] = 501000,
        ["NeedCreate"] = 1
    }
}

function bg_ShengShouShan:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5, param6)
	if param6 ~= bg_ShengShouShan.DataValidator then
		return
	elseif not iNoticeType or not param2 or not param3 or not param4 or not param5 then
		return
	end
	local nTime = self:GetQuarterTime();
    local sceneId = self:GetSceneID()
	if nTime ~= 44 and nTime ~= 63 and nTime ~= 78 and nTime ~= 92 then
		return
	end
	if sceneId ~= 158 then
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
			
            -- self:LuaFnSetNpcIntParameter(MonsterId, 1, bg_ShengShouShan_Scriptid)
			-- self:LuaFnSetNpcIntParameter(MonsterID, 2, sceneId)
			-- self:LuaFnSetNpcIntParameter(MonsterID, 3, actId + 1)
            self:SetCharacterTitle(MonsterID, "千年天圣兽")
        end
    end
end

function bg_ShengShouShan:OnTimer(actId, uTime, param1)
	if not uTime or uTime ~= param1 then
		return
	end
    if not self:CheckActiviyValidity(actId) then
        self:StopOneActivity(actId)
    end
end

function bg_ShengShouShan:CurSceneHaveMonster(DataID)
    for i, Data in pairs(self.g_BossData) do
        if DataID == Data["ID"] then
            self.g_BossData[i]["NeedCreate"] = 0
            break
        end
    end
end

function bg_ShengShouShan:GetDataValidator(param1,param2)
	bg_ShengShouShan.DataValidator = math.random(1,2100000000)
	return bg_ShengShouShan.DataValidator
end


return bg_ShengShouShan
