local class = require "class"
local define = require "define"
local script_base = require "script_base"
local Char_DataBase = class("Char_DataBase", script_base)
local ScriptGlobal = require "scripts.ScriptGlobal"
Char_DataBase.script_id = 999994

function Char_DataBase:GetNewDayRestData(selfId)
    local nLastDayTime = self:GetMissionData(selfId, define.MD_ENUM.MD_SERVER_TIME)
    local nLastWeekTime = self:GetMissionData(selfId, define.MD_ENUM.MD_SERVER_WEEK_TIME)
    local nTadayTime = self:GetTime2Day()
    if nLastDayTime ~= nTadayTime then
        self:SetMissionData(selfId, define.MD_ENUM.MD_SERVER_TIME, nTadayTime)
        self:SetGongLi(selfId, 100)
        self:LuaFnResetWeekActiveDay(selfId)
        self:ResetKillMonsterCount(selfId)

        self:ResetCampaignCount(selfId)
        self:SetMissionFlag(selfId, ScriptGlobal.MF_SWEEP_ALL_DAY_CARD, 0)
        self:SetMissionData(selfId, ScriptGlobal.MD_SweepAll_SeckillTequanDayCount, 0)

        self:LuaFnRestMysteryShopInfo(selfId)
        self:LuaFnCheckResetWanShiGeData(selfId)
    end
    local nToWeekTime = self:GetTime2Week()
    if nLastWeekTime ~= nToWeekTime then
        self:SetMissionData(selfId, define.MD_ENUM.MD_SERVER_WEEK_TIME, nToWeekTime)
        self:LuaFnResetWeekActiveWeek(selfId)
        self:LuaFnCheckResetJiYuanShop(selfId)
    end
    self:LuaFnAddMissionHuoYueZhi(selfId, 1)
end

return Char_DataBase
