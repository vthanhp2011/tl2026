local class = require "class"
local define = require "define"
local script_base = require "script_base"
local city0_building0 = class("city0_building0", script_base)
city0_building0.script_id = 805007
city0_building0.g_BuildingID15 = 6

function city0_building0:OnDefaultEvent(selfId, targetId)
    local guildid = self:GetHumanGuildID(selfId)
    local cityguildid = self:GetCityGuildID(selfId)
    local strText
    if (guildid ~= cityguildid) then
        self:BeginEvent(self.script_id)
        strText = "    非我帮众，一切神兵利刃恕不外卖。"
        self:AddText(strText)
        self:EndEvent()
        self:DispatchMissionTips(selfId)
        return
    end
    self:BeginEvent(self.script_id)
    strText = "    我是武器店掌柜，宝剑配英雄，天下名兵诸事，都可以找我，自己人嘛。"
    self:AddText(strText)
    self:AddNumText("神秘商店", 7, 8)
    self:AddNumText("委托打造", 6, 9)
    self:AddNumText("武具坊介绍", 11, 7)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function city0_building0:OnEventRequest(selfId, targetId, arg, index)
    if index == 1 then
        self:CityBuildingChange(selfId, self.g_BuildingID15, 0)
    elseif index == 2 then
        self:CityBuildingChange(selfId, self.g_BuildingID15, 1)
    elseif index == 3 then
        self:CityBuildingChange(selfId, self.g_BuildingID15, 2)
    elseif index == 4 then
        self:CityBuildingChange(selfId, self.g_BuildingID15, 3)
    elseif index == 5 then
        self:CityBuildingChange(selfId, self.g_BuildingID15, 4)
    elseif index == 6 then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(self.g_BuildingID15)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 104)
    elseif index == 7 then
        self:BeginEvent(self.script_id)
        self:AddText("#{City_Intro_WuJuFang}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 8 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 9 then
        self:BeginEvent(self.script_id)
        self:AddText("这个功能即将开放")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

return city0_building0
