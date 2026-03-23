local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ePetSoulActivity = class("ePetSoulActivity", script_base)
ePetSoulActivity.DataValidator = 0
ePetSoulActivity.script_id = 893342
ePetSoulActivity.g_TimeTickIndex = 2
ePetSoulActivity.g_BossData = {
    {
        ["ID"] = 50614,
        ["BaseAI"] = 22,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50615,
        ["BaseAI"] = 22,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50616,
        ["BaseAI"] = 22,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50617,
        ["BaseAI"] = 22,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
    {
        ["ID"] = 50618,
        ["BaseAI"] = 22,
        ["ExtAIScript"] = -1,
        ["ScriptID"] = -1,
        ["NeedCreate"] = 1
    },
}
ePetSoulActivity.BossPos = {
    {
        ["PosX"] = 193,
        ["PosY"] = 65,
    },
    {
        ["PosX"] = 236,
        ["PosY"] = 158,
    },
    {
        ["PosX"] = 68,
        ["PosY"] = 119,
    },
    {
        ["PosX"] = 187,
        ["PosY"] = 226,
    },
    {
        ["PosX"] = 250,
        ["PosY"] = 96,
    }
}

function ePetSoulActivity:OnDefaultEvent(actId, iNoticeType, param2, param3, param4, param5, param6)
	if param6 ~= ePetSoulActivity.DataValidator then
		return
	elseif not iNoticeType or not param2 or not param3 or not param4 or not param5 then
		return
	end
    self:StartOneActivity(actId, 30 * 60 * 1000, iNoticeType)
    self:SetActivityParam(actId, 1, 0)
    self:SetActivityParam(actId, self.g_TimeTickIndex, 0)
    self:CreateMonsters_893342("shouhun",actId, 1)
end
function ePetSoulActivity:GetDataValidator(param1,param2)
	ePetSoulActivity.DataValidator = math.random(1,2100000000)
	return ePetSoulActivity.DataValidator
end
function ePetSoulActivity:CreateMonsters_893342(flag_name,actId, add_value)
	if flag_name ~= "shouhun" then
		return
	end
    for _, data in ipairs(self.g_BossData) do
        data.NeedCreate = 1
    end
    local empty_Poss = table.clone(self.BossPos)
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum  do
        local MonsterId = self:GetMonsterObjID(i)
		local obj = self:get_scene():get_obj_by_id(MonsterId)
		if obj then
			local MosDataID = self:GetMonsterDataID(MonsterId)
			for _,data in ipairs(self.g_BossData) do
				if data.ID == MosDataID and obj:is_alive() then
					data.NeedCreate = 0
					local posx = obj:get_scene_params(define.MONSTER_CREATE_POSX)
					local posz = obj:get_scene_params(define.MONSTER_CREATE_POSZ)
					for n,poss in ipairs(empty_Poss) do
						if poss.PosX == posx and poss.PosY == posz then
							table.remove(empty_Poss,n)
							break
						end
					end
					break
				end
			end
		end
	end
    if #empty_Poss > 0 then
        for _, BossData in ipairs(self.g_BossData) do
            if #empty_Poss > 0 then
                local pos = table.remove(empty_Poss, math.random(#empty_Poss))
                if BossData["NeedCreate"] == 1 then
					local MonsterId = self:LuaFnCreateMonster(
                        BossData["ID"],
                        pos["PosX"],
                        pos["PosY"],
                        BossData["BaseAI"],
                        BossData["ExtAIScript"],
                        BossData["ScriptID"]
                    )
					if MonsterId and MonsterId ~= -1 then
						local obj = self:get_scene():get_obj_by_id(MonsterId)
						if obj then
							obj:set_scene_params(define.MONSTER_CREATE_POSX,pos["PosX"])
							obj:set_scene_params(define.MONSTER_CREATE_POSZ,pos["PosY"])
						end
					end
                end
            end
        end
    end
    self:SetActivityParam(actId, 1, add_value)
end

function ePetSoulActivity:OnTimer(actId, uTime, param1)
	if not uTime or uTime ~= param1 then
		return
	end
    if not self:CheckActiviyValidity(actId) then
        self:StopOneActivity(actId)
        return
    end
    local TickTime = self:GetActivityParam(actId, self.g_TimeTickIndex)
	TickTime = TickTime + uTime
    if TickTime >= 60000 then
        TickTime = TickTime - 60000
        local value = self:GetActivityParam(actId, 1)
        self:CreateMonsters_893342("shouhun",actId, value + 1)
        self:BroadCastMonsterTaps_893342()
    end
    self:SetActivityParam(actId, self.g_TimeTickIndex, TickTime)
end

function ePetSoulActivity:BroadCastMonsterTaps_893342()
    local packet_def = require "game.packet"
    local msg = packet_def.GCShowMonsterTaps.new()
    local monster_count = self:GetMonsterCount()
    for i = 1, monster_count do
        local obj_id = self:GetMonsterObjID(i)
        local data_id = self:GetMonsterDataID(obj_id)
        local x, y = self:GetWorldPos(obj_id)
        msg.taps[i] = { id = data_id, pos = { x = x, y = y} }
    end
    self:get_scene():broadcastall(msg)
end


return ePetSoulActivity
