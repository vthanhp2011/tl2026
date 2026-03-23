local class = require "class"
local define = require "define"
local script_base = require "script_base"
local event_fenghuangNwcrystal = class("event_fenghuangNwcrystal", script_base)
local gbk = require "gbk"
event_fenghuangNwcrystal.script_id = 403008

event_fenghuangNwcrystal.g_BigBox = 
{
    ["Name"] = "黄色生命水晶",
    ["MonsterID"] = 14007,
    ["PosX"] = 92,
    ["PosY"] = 90,
    ["ScriptID"] = 403005
}



function event_fenghuangNwcrystal:OnTimer(actId,uTime)
    local is_open = self:LuaFnGetCopySceneData_Param(21) or 0
    if is_open < 1 then
        return
    end
    local nMonsterNum = self:GetMonsterCount()
    for i = 1,nMonsterNum do
        local MonsterId = self:GetMonsterObjID(i)
        local MosDataID = self:GetMonsterDataID(MonsterId)
        if MosDataID == self.g_BigBox["MonsterID"]  then
            return
        end
    end

    if self:LuaFnGetCopySceneData_Param(15) > 0 then
        return
    end

    local MstId = self:LuaFnCreateMonster(self.g_BigBox["MonsterID"] ,self.g_BigBox["PosX"] ,self.g_BigBox["PosY"] ,7,0,self.g_BigBox["ScriptID"] )
    local LeagueName = self:LuaFnGetCopySceneData_Param(19)
    if MstId > 0 then
        if LeagueName ~= 0 then
            self:SetCharacterTitle(MstId,LeagueName.."所属")
            self:HumanTips(LeagueName.."占领了西北据点的水晶")
        end
        if self:LuaFnGetCopySceneData_Param(10) > 0 then
            self:SetUnitCampID(MstId,self:LuaFnGetCopySceneData_Param(10))
        else
            self:SetUnitCampID(MstId,600)
        end
        self:SetCharacterName(MstId,self.g_BigBox["Name"] )
        self:HumanTips("西北据点水晶已刷新。")
    end
end



function event_fenghuangNwcrystal:OnDefaultEvent(actId,param1,param2,param3,param4,param5)
    self:StartOneActivity(actId,100*10,param1)
end



function event_fenghuangNwcrystal:HumanTips(str)
    local nHumanCount = self:LuaFnGetCopyScene_HumanCount()
    for i = 1,nHumanCount do
        local nHumanId = self:LuaFnGetCopyScene_HumanObjId(i)
        if self:LuaFnIsObjValid(nHumanId)
        and self:LuaFnIsCanDoScriptLogic(nHumanId)
        and self:LuaFnIsCharacterLiving(nHumanId) then
            self:BeginEvent(self.script_id)
            self:AddText(str)
            self:EndEvent()
            self:DispatchMissionTips(nHumanId)
        end
    end
end
return event_fenghuangNwcrystal