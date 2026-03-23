local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_CorpseMonster = class("odali_CorpseMonster", script_base)
function odali_CorpseMonster:OnDefaultEvent(selfId, targetId)
    local npcLevel = self:GetCharacterLevel(targetId)
    local teamCount = self:GetTeamMemberCount(selfId)
    local teamLeaderID = self:GetTeamLeader(selfId)
    local teamLeaderLevel = self:GetCharacterLevel(teamLeaderID)
    if teamCount < 2 then
        self:BeginEvent(self.script_id)
        self:AddText("胆敢小看我，必须得3人组队才行噢, 哈哈")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif teamLeaderLevel < npcLevel then
        self:BeginEvent(self.script_id)
        self:AddText("胆敢小看我，等级再高些就知道我的厉害了")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    else
        local PosX, PosZ = self:LuaFnGetWorldPos(targetId)
        PosX = math.floor(PosX)
        PosZ = math.floor(PosZ)
        self:LuaFnDeleteMonster(targetId)
        local aifile = math.random(10)
        self:LuaFnCreateMonster(1551, PosX, PosZ, 0, aifile, -1)
    end
end

return odali_CorpseMonster
