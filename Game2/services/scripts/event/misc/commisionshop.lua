local gbk = require "gbk"
local class = require "class"
local define = require "define"
local ScriptGlobal = require "scripts.ScriptGlobal"
local script_base = require "script_base"
local commisionshop = class("commisionshop", script_base)
commisionshop.script_id = 800116
commisionshop.g_CShopInfo = {
    [0] = {
        ["name"] = "#G洛阳（160，181）#R汀汀",
        ["type"] = {
            [0] = {
                ["name"] = "元宝",
                ["sellFmtValueStr"] = "#G%d点元宝#l",
                ["sellFmtPriceStr"] = "#G#{_MONEY%d}#l",
                ["sellInfo"] = "#G我要购买元宝#l",
                ["buyFmtValueStr"] = "%d点元宝",
                ["buyFmtPriceStr"] = "#{_MONEY%d}"
            },
            [1] = {
                ["name"] = "金币",
                ["sellFmtValueStr"] = "#G#{_MONEY%d}#l",
                ["sellFmtPriceStr"] = "#G%d点元宝#l",
                ["sellInfo"] = "#G我要购买金币#l",
                ["buyFmtValueStr"] = "#{_MONEY%d}",
                ["buyFmtPriceStr"] = "%d点元宝"
            }
        }
    },
    [1] = {
        ["name"] = "#G洛阳（158，181）#R冬冬",
        ["type"] = {
            [0] = {
                ["name"] = "元宝",
                ["sellFmtValueStr"] = "#G%d点元宝#l",
                ["sellFmtPriceStr"] = "#G#{_MONEY%d}#l",
                ["sellInfo"] = "#G我要购买元宝#l",
                ["buyFmtValueStr"] = "%d点元宝",
                ["buyFmtPriceStr"] = "#{_MONEY%d}"
            },
            [1] = {
                ["name"] = "金币",
                ["sellFmtValueStr"] = "#G#{_MONEY%d}#l",
                ["sellFmtPriceStr"] = "#G%d点元宝#l",
                ["sellInfo"] = "#G我要购买金币#l",
                ["buyFmtValueStr"] = "#{_MONEY%d}",
                ["buyFmtPriceStr"] = "%d点元宝"
            }
        }
    }
}

function commisionshop:OnEnumerate(caller, selfId, targetId, arg, index)
    caller:AddNumTextWithTarget(self.script_id, "我想购买元宝", 5, 2)
    if not self:IsShutout(selfId, ScriptGlobal.ONOFF_T_CSHOP) then
        if not self:GetConfigInfo("IsCloseYuanBaoSell") then
            caller:AddNumTextWithTarget(self.script_id, "我想寄售元宝", 5, 3)
        end
    end
    caller:AddNumTextWithTarget(self.script_id, "收取元宝或金币", 5, 6)
    caller:AddNumTextWithTarget(self.script_id, "收取介绍", 11, 7)
    caller:AddNumTextWithTarget(self.script_id, "寄售介绍", 11, 5)
end

function commisionshop:OnDefaultEvent(selfId, targetId, arg, eventId)
    local opt = eventId
    if opt == 1 then
        self:OpenShop(selfId, targetId, 3)
        return
    elseif opt == 2 then
        self:OpenShop(selfId, targetId, 0)
        return
    elseif opt == 3 or opt == 4 then
        local _yes = self:LuaFnOpenPWBox(selfId)
        if (_yes == 1) then
            return
        end
    elseif opt == 5 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_095}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    elseif opt == 6 then
        self:LuaFnAskNpcScriptMail(selfId, ScriptGlobal.MAIL_COMMISIONSHOP)
        return
    elseif opt == 7 then
        self:BeginEvent(self.script_id)
        self:AddText("#{function_help_099}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    local UserName = self:GetName(selfId)
    local i = string.find(UserName, "*")
    if i == nil then
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:UICommand_AddInt(opt)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 19850424)
    else
        self:BeginEvent(self.script_id)
        self:AddText("您的名字中含有“*”，需要先改名才能正常使用寄售功能。")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
    end
    return
end

function commisionshop:OpenShop(selfId, targetId, Grade)
    self:GetCommisionShop(selfId, targetId, Grade)
end

function commisionshop:Buy(selfId, targetId, Grade, SerialNumber)
    local ret, shopId, type, value, price, seller = self:CommisionShopBuy(selfId, targetId, Grade, SerialNumber)
    if ret then
        if self.g_CShopInfo[shopId] and self.g_CShopInfo[shopId]["type"][type] and self.g_CShopInfo[shopId]["name"] then
            local typeInfo = self.g_CShopInfo[shopId]["type"][type]
            local nameInfo = self.g_CShopInfo[shopId]["name"]
            local strGUID = self:LuaFnGetGUID(selfId)
            local len = string.len(strGUID)
            strGUID = string.sub(strGUID, len - 3)
            local str = string.format("#I某人[ID:****%s]在#R%s#I处花费了#Y%s#I购买了#Y%s#I。", strGUID,
                nameInfo, typeInfo["buyFmtPriceStr"], typeInfo["buyFmtValueStr"])
            str = string.format(str, price, value)
            str = gbk.fromutf8(str)
            self:BroadMsgByChatPipe(selfId, str, 4)
            local sellstr = string.format(
                "您寄售的%s已#Y成功售出#W，请找到寄售NPC选择“收取元宝或金币”即可获得您的元宝或金币。#r#G注意：为了保障您的财产安全，请尽量在一周内领取您的元宝和金币，如果您一周后仍没有领取的话，元宝或金币可能会丢失。",
                typeInfo["buyFmtValueStr"])
            sellstr = string.format(sellstr, value)
            self:LuaFnSendSystemMail(seller, sellstr)
            self:GetCommisionShop(selfId, targetId, Grade)
        end
    end
end

function commisionshop:Sell(selfId, targetId, Grade, Price)
    if true then
        self:notify_tips(selfId, "寄售功能暂时关闭")
        return
    end
    local ret, shopId, type, value, price = self:CommisionShopSell(selfId, targetId, Grade, Price)
    if ret then
        if self.g_CShopInfo[shopId] and self.g_CShopInfo[shopId]["type"][type] and self.g_CShopInfo[shopId]["name"] then
            local typeInfo = self.g_CShopInfo[shopId]["type"][type]
            local nameInfo = self.g_CShopInfo[shopId]["name"]
            local strGUID = self:LuaFnGetGUID(selfId)
            local len = string.len(strGUID)
            strGUID = string.sub(strGUID, len - 3)
            local str = string.format(
                "#I某人[ID:****%s]在#R%s#I处寄售了#Y%s，#I售价#Y%s，#I有意购买的玩家请赶回#G洛阳#I吧。",
                strGUID, nameInfo, typeInfo["buyFmtValueStr"], typeInfo["buyFmtPriceStr"], typeInfo["sellInfo"],
                typeInfo["name"])
            str = string.format(str, value, price)
            str = gbk.fromutf8(str)
            self:BroadMsgByChatPipe(selfId, str, 4)
        end
    end
end

function commisionshop:TimeOutCommission(shopId, itemserial)
    local ret, type, value, price, seller = self:GetCommisionShopItem(shopId, itemserial)
    if ret then
        if self.g_CShopInfo[shopId] and self.g_CShopInfo[shopId]["type"][type] then
            local typeInfo = self.g_CShopInfo[shopId]["type"][type]
            local sellstr = string.format(
                "您寄售的%s#Y没有售出#W，请找到寄售NPC选择“收取元宝或金币”即可获得您的元宝或金币。#r#G注意：为了保障您的财产安全，请尽量在一周内领取您的元宝和金币，如果您一周后仍没有领取的话，元宝或金币可能会丢失。",
                typeInfo["buyFmtValueStr"])
            sellstr = string.format(sellstr, value)
            self:LuaFnSendSystemMail(seller, sellstr)
        end
    end
end

return commisionshop
