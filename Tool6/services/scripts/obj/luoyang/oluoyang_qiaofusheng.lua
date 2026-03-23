local class = require "class"
local define = require "define"
local script_base = require "script_base"
local oluoyang_qiaofusheng = class("oluoyang_qiaofusheng", script_base)
oluoyang_qiaofusheng.script_id = 000109
function oluoyang_qiaofusheng:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{SHCK_090522_1}11#{SHCK_090522_2}")
    self:AddNumText("#{RCYH_180606_102}", 6, 2)
    if not self:IsShutout(selfId,3) then
        self:AddNumText("#{RCYH_180606_103}", 6, 0)
    else
        self:AddNumText("#{RCYH_180606_104}", 6, 7)
    end
    self:AddNumText("#{RCYH_180606_105}", 6, 1)
    self:AddNumText("#{RCYH_180606_106}", 6, 3)
    self:AddNumText("#{RCYH_180522_22}", 11, 6)
    self:AddNumText("#{RCYH_180522_25}", 11, 10)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function oluoyang_qiaofusheng:OnEventRequest(selfId, targetId, arg, index)
    if index == 0 then
        if self:get_scene_id() == 0 then
            self:BeginEvent(self.script_id)
            self:AddText("#{PS_OPEN_SHOP_NOTICE}")
            self:EndEvent()
            self:DispatchMissionDemandInfo(selfId, targetId, self.script_id, 0, 1)
        else
            self:BeginEvent(self.script_id)
            self:AddText("请前往洛阳主城使用九州商会建店功能")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif index == 1 then
        local strShop0Name = self:LuaFnGetShopName(selfId, 1)
        local strShop1Name = self:LuaFnGetShopName(selfId, 2)
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
                if self:GetPlayerShopFrezeType(selfId, 0) == 1 then
                    self:AddNumText("#cCCCCCC店铺1  " .. strShop0Name, -1, 4)
                else
                    self:AddNumText("店铺1  " .. strShop0Name, -1, 4)
                end
                if self:GetPlayerShopFrezeType(selfId, 1) == 1 then
                    self:AddNumText("#cCCCCCC店铺2  " .. strShop1Name, -1, 5)
                else
                    self:AddNumText("店铺2  " .. strShop1Name, -1, 5)
                end
                self:EndEvent()
                self:DispatchEventList(selfId, targetId)
            elseif (strShop0Name ~= "") then
                self:LuaFnOpenPlayerShop(selfId, targetId, 1)
            elseif (strShop1Name ~= "") then
                self:LuaFnOpenPlayerShop(selfId, targetId, 2)
            end
        end
    elseif index == 2 then
        self:DispatchPlayerShopList(selfId, targetId)
    elseif index == 3 then
        self:DispatchPlayerShopSaleOutList(selfId, targetId)
    elseif index == 4 then
        self:LuaFnOpenPlayerShop(selfId, targetId, 1)
    elseif index == 5 then
        self:LuaFnOpenPlayerShop(selfId, targetId, 2)
    elseif index == 6 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_048}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    elseif index == 7 then
        local strShop0Name = self:LuaFnGetShopName(selfId, 1)
        local strShop1Name = self:LuaFnGetShopName(selfId, 2)
        if ((strShop0Name == "") and (strShop1Name == "")) then
            self:BeginEvent(self.script_id)
            local strText = "您至少需要拥有一家店铺。"
            self:AddText(strText)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        else
            self:BeginEvent(self.script_id)
            self:AddText("#{UnregisterShopHelp}")
            self:AddNumText("确定", 6, 8)
            self:AddNumText("离开", 6, 9)
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
        end
    elseif index == 8 then
        local canErase = self:CanErasePlayerShop(selfId)
        if (canErase) then
            self:BeginUICommand()
            self:EndUICommand()
            self:DispatchUICommand(selfId, 1000)
            self:ErasePlayerShop(selfId)
            local msg = string.format(
                            "恭喜您注销成功，店铺中的本金已经返回给您，请注意查收。")
            self:BeginEvent(self.script_id)
            self:AddText(msg)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            msg = string.format("您已成功注销个人商店")
            self:BeginEvent(self.script_id)
            self:AddText(msg)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
            self:BeginUICommand()
            self:EndUICommand()
            self:DispatchUICommand(selfId, 19810222)
        elseif canErase == -1 then
            local msg = string.format("您的商店已被冻结。")
            self:BeginEvent(self.script_id)
            self:AddText(msg)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        else
            local msg = string.format(
                            "您的店内还有出售资讯或收购资讯正在发布，请清空后再来。")
            self:BeginEvent(self.script_id)
            self:AddText(msg)
            self:EndEvent()
            self:DispatchMissionTips(selfId)
        end
    elseif index == 9 then
        self:BeginUICommand()
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    elseif index == 10 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_101}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
end

function oluoyang_qiaofusheng:OnMissionContinue(selfId, targetId,missionScriptId)
    self:BeginUICommand()
    self:EndUICommand()
    self:DispatchUICommand(selfId, 1000)
    self:ApplyPlayerShop(selfId, targetId)
end

return oluoyang_qiaofusheng
