local class = require "class"
local define = require "define"
local script_base = require "script_base"
local huodong_yezhu_2 = class("huodong_yezhu_2", script_base)
huodong_yezhu_2.g_NpcPos = {["x"] = 137, ["y"] = 107}

huodong_yezhu_2.g_NpcId = 163
function huodong_yezhu_2:OnDefaultEvent(actId, param1, param2, param3, param4, param5)
    self:StartOneActivity(actId, 1)
    local MonsterId = self:LuaFnCreateMonster(self.g_NpcId, self.g_NpcPos["x"], self.g_NpcPos["y"], 3, -1, 402104)
    self:SetCharacterName(MonsterId, "云飘飘")
    self:SetCharacterTitle(MonsterId, "虫鸟坊坊主")
    self:SetCharacterDieTime(MonsterId, 2 * 1000 * 60 * 60)
end

function huodong_yezhu_2:OnTimer(actId, uTime)
end

return huodong_yezhu_2
