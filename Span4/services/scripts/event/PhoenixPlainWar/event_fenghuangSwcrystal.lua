local class = require "class"
local define = require "define"
local script_base = require "script_base"
local event_fenghuangSwcrystal = class("event_fenghuangSwcrystal", script_base)
local gbk = require "gbk"
event_fenghuangSwcrystal.script_id = 403010

event_fenghuangSwcrystal.g_BigBox = 
{
    ["Name"] = "紫色生命水晶",
    ["MonsterID"] = 14003,
    ["PosX"] = 91,
    ["PosY"] = 229,
    ["ScriptID"] = 403005
}

function event_fenghuangSwcrystal:OnTimer(actId,uTime)
    --判断凤凰古城争夺战是否进行中
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


    if self:LuaFnGetCopySceneData_Param(13) > 0 then
        return
    end
    local MstId = self:LuaFnCreateMonster(self.g_BigBox["MonsterID"] ,self.g_BigBox["PosX"] ,self.g_BigBox["PosY"] ,7,0,self.g_BigBox["ScriptID"] )
    local LeagueName = self:LuaFnGetCopySceneData_Param(17)
    if MstId > 0 then
        if LeagueName ~= 0 then
            self:SetCharacterTitle(MstId,LeagueName.."所属")
            self:HumanTips(LeagueName.."占领了东南据点的水晶")
        end
        if self:LuaFnGetCopySceneData_Param(8) > 0 then
            self:SetUnitCampID(MstId,self:LuaFnGetCopySceneData_Param(8))
            else
            self:SetUnitCampID(MstId,600)
        end
        self:SetCharacterName(MstId,self.g_BigBox["Name"] )
        self:HumanTips("东南据点水晶已刷新。")
    end
end

function event_fenghuangSwcrystal:OnDefaultEvent(actId,param1,param2,param3,param4,param5)
    self:StartOneActivity(actId,100*10,param1)
end

function event_fenghuangSwcrystal:HumanTips(str)
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

return event_fenghuangSwcrystal