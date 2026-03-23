local class = require "class"
local define = require "define"
local script_base = require "script_base"
local ejinghu_Boss = class("ejinghu_Boss", script_base)
ejinghu_Boss.g_PreTimeHour_1 = 0
ejinghu_Boss.g_PreTimeHour_2 = 0
ejinghu_Boss.g_PreTimeHour_3 = 0
ejinghu_Boss.g_Boss = {
    {
        ["x"] = 141,
        ["z"] = 96,
        ["b1"] = 885,
        ["b2"] = 887,
        ["b3"] = 889,
        ["n1"] = "北海混江小龙",
        ["n2"] = "北海出洞小蛟",
        ["n3"] = "北海翻江小蜃"
    }
    , {
    ["x"] = 250,
    ["z"] = 98,
    ["b1"] = 885,
    ["b2"] = 887,
    ["b3"] = 889,
    ["n1"] = "东海混江小龙",
    ["n2"] = "东海出洞小蛟",
    ["n3"] = "东海翻江小蜃"
}
, {
    ["x"] = 206,
    ["z"] = 253,
    ["b1"] = 885,
    ["b2"] = 887,
    ["b3"] = 889,
    ["n1"] = "南海混江小龙",
    ["n2"] = "南海出洞小蛟",
    ["n3"] = "南海翻江小蜃"
}
, {
    ["x"] = 101,
    ["z"] = 256,
    ["b1"] = 885,
    ["b2"] = 887,
    ["b3"] = 889,
    ["n1"] = "西海混江小龙",
    ["n2"] = "西海出洞小蛟",
    ["n3"] = "西海翻江小蜃"
}
, {
    ["x"] = 139,
    ["z"] = 133,
    ["b1"] = 884,
    ["b2"] = 886,
    ["b3"] = 888,
    ["n1"] = "混江龙",
    ["n2"] = "出洞蛟",
    ["n3"] = "翻江蜃"
}
}
function ejinghu_Boss:OnSceneTimer()
    local nHour = self:GetQuarterTime()
    if nHour > 16 and nHour < 40 then
        return
    end
    if self:GetMinute() >= 45 and self:GetMinute() < 55 then
        if nHour == self.g_PreTimeHour_1 then
            return
        end
        self.g_PreTimeHour_1 = nHour
        if self:IsHaveMonster("北海混江小龙") == 0 then
            self:UpDateMonster(1, 10)
        end
        if self:IsHaveMonster("东海混江小龙") == 0 then
            self:UpDateMonster(2, 11)
        end
        if self:IsHaveMonster("南海混江小龙") == 0 then
            self:UpDateMonster(3, 12)
        end
        if self:IsHaveMonster("西海混江小龙") == 0 then
            self:UpDateMonster(4, 13)
        end
    end
    if self:GetMinute() >= 55 then
        if nHour == self.g_PreTimeHour_3 then
            return
        end
        self.g_PreTimeHour_3 = nHour
        if self:IsHaveMonster("混江龙") == 0 then
            self:UpDateMonster(5, 14)
        end
    end
end

function ejinghu_Boss:IsHaveMonster(MonsterName)
    local nMonsterNum = self:GetMonsterCount()
    local bHaveMonster = 0
    for i = 1, nMonsterNum do
        local nMonsterId = self:GetMonsterObjID(i)
        if self:GetName(nMonsterId) == MonsterName then
            bHaveMonster = 1
        end
    end
    return bHaveMonster
end

function ejinghu_Boss:UpDateMonster(nIndex, nGroupId)
    local nMonsterNum = self:GetMonsterCount()
    for i = 1, nMonsterNum do
        local nMonsterId = self:GetMonsterObjID(i)
        if self:GetName(nMonsterId) == self.g_Boss[nIndex]["n1"] then
            self:LuaFnDeleteMonster(nMonsterId)
        end
        if self:GetName(nMonsterId) == self.g_Boss[nIndex]["n2"] then
            self:LuaFnDeleteMonster(nMonsterId)
        end
        if self:GetName(nMonsterId) == self.g_Boss[nIndex]["n3"] then
            self:LuaFnDeleteMonster(nMonsterId)
        end
    end
    local nMonId
    nMonId = self:LuaFnCreateMonster(self.g_Boss[nIndex]["b1"], self.g_Boss[nIndex]["x"], self.g_Boss[nIndex]["z"], 19,
        197, 005117)
    self:SetCharacterName(nMonId, self.g_Boss[nIndex]["n1"])
    self:SetMonsterGroupID(nMonId, nGroupId)
    self:SetCharacterTitle(nMonId, "镜湖六霸")
    nMonId = self:LuaFnCreateMonster(self.g_Boss[nIndex]["b2"], self.g_Boss[nIndex]["x"] + 2, self.g_Boss[nIndex]["z"],
        19, 198, 005118)
    self:SetCharacterName(nMonId, self.g_Boss[nIndex]["n2"])
    self:SetMonsterGroupID(nMonId, nGroupId)
    self:SetCharacterTitle(nMonId, "镜湖六霸")
    nMonId = self:LuaFnCreateMonster(self.g_Boss[nIndex]["b3"], self.g_Boss[nIndex]["x"] - 2, self.g_Boss[nIndex]["z"],
        19, 199, 005119)
    self:SetCharacterName(nMonId, self.g_Boss[nIndex]["n3"])
    self:SetMonsterGroupID(nMonId, nGroupId)
    self:SetCharacterTitle(nMonId, "镜湖六霸")
    if nIndex == 5 then
        local str = "#P当年横行浔阳江的水贼#{_BOSS14}#P已经带领部下出现在#G镜湖#P！请天下英雄速去剿灭！"
        self:AddGlobalCountNews(str)
    end
end

return ejinghu_Boss
