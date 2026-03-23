local class = require "class"
local define = require "define"
local script_base = require "script_base"
local emenpaiboss = class("emenpaiboss", script_base)
emenpaiboss.script_id = 808001
emenpaiboss.g_BossLayout = {
    ["xiaoyao"] = {144, 876, 141, 43, 119},
    ["tianlong"] = {143, 877, 95, 36, 120},
    ["tianshan"] = {147, 874, 94, 39, 117},
    ["emei"] = {145, 870, 45, 34, 113},
    ["gaibang"] = {140, 869, 48, 36, 112},
    ["shaolin"] = {139, 872, 46, 40, 115},
    ["mingjiao"] = {141, 871, 98, 58, 114},
    ["xingxiu"] = {146, 873, 142, 51, 116},
    ["wudang"] = {142, 875, 89, 51, 118}
}

function emenpaiboss:OnDefaultEvent(actId, param1, param2, param3, param4, param5)
    local unt = self:CallLayoutUnit()
    if unt == nil then
        return
    end
    local numMon = self:GetMonsterCount()
    local objMon
    for i = 1, numMon do
        objMon = self:GetMonsterObjID(i)
        if self:GetMonsterDataID(objMon) == unt[2] then
            self:LuaFnDeleteMonster(objMon)
        end
    end
    self:LuaFnCreateMonster(unt[2], unt[3], unt[4], 17, unt[5], -1)
end

function emenpaiboss:CallLayoutUnit()
    local unt = nil
    local sceneId = self:get_scene_id()
    for _, unt in pairs(self.g_BossLayout) do
        if unt[1] == sceneId then
            return unt
        end
    end
    return unt
end

return emenpaiboss
