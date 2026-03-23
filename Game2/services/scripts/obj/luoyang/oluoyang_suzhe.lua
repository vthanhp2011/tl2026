local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_suzhe = class("oluoyang_suzhe", script_base)
oluoyang_suzhe.script_id = 000000
function oluoyang_suzhe:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText(
        "端王是当今圣上的御弟，皇储亲王之尊。虽然今年只有一十五岁，却自有一番不凡的气度。")
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_suzhe:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        self:BeginEvent(self.script_id)
        self:AddText("#{PS_OPEN_SHOP_NOTICE}")
        self:EndEvent()
        self:DispatchMissionDemandInfo(selfId, targetId, self.g_scriptId, 0, 1)
    elseif index == 1 then
        local strShop0Name = self:LuaFnGetShopName(selfId, 0)
        local strShop1Name = self:LuaFnGetShopName(selfId, 1)
        if ((strShop0Name == "") and (strShop1Name == "")) then
            self:BeginEvent(self.script_id)
            local strText = "对不起，你好象并没有店铺。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        else
            if ((strShop0Name ~= "") and (strShop1Name ~= "")) then
                self:BeginEvent(self.script_id)
                self:AddText(
                    "哦哦，原来是掌柜的到了，请问您要去哪间店看看？")
                self:AddNumText("店铺1  " .. strShop0Name, -1, 4)
                self:AddNumText("店铺2  " .. strShop1Name, -1, 5)
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            elseif (strShop0Name ~= "") then
                self:LuaFnOpenPlayerShop(selfId, targetId, 0)
            elseif (strShop1Name ~= "") then
                self:LuaFnOpenPlayerShop(selfId, targetId, 1)
            end
        end
    elseif index == 2 then
        self:DispatchPlayerShopList(selfId, targetId)
    elseif index == 3 then
        self:DispatchPlayerShopSaleOutList(selfId, targetId)
    elseif index == 4 then
        self:LuaFnOpenPlayerShop(selfId, targetId, 0)
    elseif index == 5 then
        self:LuaFnOpenPlayerShop(selfId, targetId, 1)
    end
    if index == 6 then
        self:CityApply(selfId)
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 101)
    elseif index == 7 then
        self:CityDelete(selfId, 205, 0)
    elseif index == 8 then
        self:CityMoveTo(selfId)
    end
end

function oluoyang_suzhe:OnMissionContinue(selfId, targetId, missionScriptId)
    self:ApplyPlayerShop(selfId, targetId)
end

return oluoyang_suzhe
